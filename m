Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4269BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1836A2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590541294;
	bh=IalWd4Xi90xxEr2sSVYq8Yz0kpu6R7Ec8NZfSol/dsg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=XtPnZb66hUrlqYcvEbBNK1uQD7DLRwGrxa0HAlnltGbgOBhEVmJr7ojSNn8uVpyNF
	 oR85uUgjgO+dKnkmsGV36CDdq8dMvOa+9tyGeY3gZcg/nWgg2k5wsTyukJlmyLZ5ei
	 wGP4VLUcKojZR/eWgQ0uWm9z3uITpXHEQs39+CA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgE0BBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgE0BBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:01:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3E9A2089D;
        Wed, 27 May 2020 01:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590541291;
        bh=IalWd4Xi90xxEr2sSVYq8Yz0kpu6R7Ec8NZfSol/dsg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rcIsDQwf/Nnau0w/608uHUWg4zVLqOjv4AZVYRMTTXk3yeGJTPOYmOXU3Mn42y8Lc
         AEzrWWzeZXS3QwZNIKN0Y2MYzkBHyQHyd2wysNJdVm7P5o4WbRPFhbX6tZh2ysuZ5d
         hH9EQK24Ajtv/FdDcKwbd4EYdEjzmOGprkdq3d8s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1583185843-20707-5-git-send-email-jolly.shah@xilinx.com>
References: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com> <1583185843-20707-5-git-send-email-jolly.shah@xilinx.com>
Subject: Re: [PATCH v2 4/4] drivers: clk: zynqmp: fix memory leak in zynqmp_register_clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
To:     Jolly Shah <jolly.shah@xilinx.com>, arm@kernel.org,
        linux-clk@vger.kernel.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, olof@lixom.net
Date:   Tue, 26 May 2020 18:01:31 -0700
Message-ID: <159054129103.88029.738005386305981615@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2020-03-02 13:50:43)
> From: Quanyang Wang <quanyang.wang@windriver.com>
>=20
> This is detected by kmemleak running on zcu102 board:
>=20
> unreferenced object 0xffffffc877e48180 (size 128):
> comm "swapper/0", pid 1, jiffies 4294892909 (age 315.436s)
> hex dump (first 32 bytes):
> 64 70 5f 76 69 64 65 6f 5f 72 65 66 5f 64 69 76 dp_video_ref_div
> 31 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1...............
> backtrace:
> [<00000000c9be883b>] __kmalloc_track_caller+0x200/0x380
> [<00000000f02c3809>] kvasprintf+0x7c/0x100
> [<00000000e51dde4d>] kasprintf+0x60/0x80
> [<0000000092298b05>] zynqmp_register_clocks+0x29c/0x398
> [<00000000faaff182>] zynqmp_clock_probe+0x3cc/0x4c0
> [<000000005f5986f0>] platform_drv_probe+0x58/0xa8
> [<00000000d5810136>] really_probe+0xd8/0x2a8
> [<00000000f5b671be>] driver_probe_device+0x5c/0x100
> [<0000000038f91fcf>] __device_attach_driver+0x98/0xb8
> [<000000008a3f2ac2>] bus_for_each_drv+0x74/0xd8
> [<000000001cb2783d>] __device_attach+0xe0/0x140
> [<00000000c268031b>] device_initial_probe+0x24/0x30
> [<000000006998de4b>] bus_probe_device+0x9c/0xa8
> [<00000000647ae6ff>] device_add+0x3c0/0x610
> [<0000000071c14bb8>] of_device_add+0x40/0x50
> [<000000004bb5d132>] of_platform_device_create_pdata+0xbc/0x138
>=20
> This is because that when num_nodes is larger than 1, clk_out is
> allocated using kasprintf for these nodes but only the last node's
> clk_out is freed.
>=20
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---

Applied to clk-next
