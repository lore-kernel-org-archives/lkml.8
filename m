Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEABC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D98E208A7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590541299;
	bh=o0/TOG6oW3yBaVEVR9CoubyCUTGosJGv3gELN+vEj5M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=eyshEda7yl4wH+1bLM1gazSEL9+vO7kRqIxInnV0WcvB4SooCuKCGPXvCUV0JpuTA
	 2y4wVBhWwy9XYsdb0U6FQl+nVWADkMn4nKGCKTxefxxglouP08zu2MfT68sDjgUYWg
	 OugHnCIqx4ZN29ZxiBkIoHFWbNMDWjoojuRA7hac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgE0BBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgE0BBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:01:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45B02088E;
        Wed, 27 May 2020 01:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590541297;
        bh=o0/TOG6oW3yBaVEVR9CoubyCUTGosJGv3gELN+vEj5M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RtK4ETeX2KggNyabvO98kR2UHMQFg4+BDgyW4Fg/H6PvtA+QVogXLyF5/OxMpv+HZ
         br4dojoe95QhzXv5NacgnP6t3zXu2CoWXsalFynj1hBE10Ok+IPBbcpwqZoMvDm+kr
         eulvfPQePWt/OaloC3as/9pi4vIPuAhWBPN4KiNM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584048699-24186-2-git-send-email-jolly.shah@xilinx.com>
References: <1584048699-24186-1-git-send-email-jolly.shah@xilinx.com> <1584048699-24186-2-git-send-email-jolly.shah@xilinx.com>
Subject: Re: [PATCH v2 1/2] drivers: clk: zynqmp: Add support for custom type flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
To:     Jolly Shah <jolly.shah@xilinx.com>, arm@kernel.org,
        linux-clk@vger.kernel.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, olof@lixom.net
Date:   Tue, 26 May 2020 18:01:37 -0700
Message-ID: <159054129710.88029.4208597093378843339@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2020-03-12 14:31:38)
> From: Rajan Vaja <rajan.vaja@xilinx.com>
>=20
> Store extra custom type flags received from firmware.
>=20
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---

Applied to clk-next
