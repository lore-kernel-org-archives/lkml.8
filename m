Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D853C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C5D20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592914311;
	bh=6BN7g5jJCssRGX2S9z3ev/5v0Y37/NR5A61wQAxoP+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=joIWXAmZ0YebQctVprCIiIHYCoK6VKxkc06FqG+C/a9wq4miaPFu9/SlK/3C93TdZ
	 kWtqA6bBw8aLauuBvESQhprvDO3Vj86gFGEm+BosoWhSAHXhLKYAVrS14cgL3lhGIT
	 UB6Y8QPDNp42EqYsbO0XpCdNkxV1uP27i4+Cx7fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbgFWMLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732436AbgFWMLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:11:48 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF22020707;
        Tue, 23 Jun 2020 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592914308;
        bh=6BN7g5jJCssRGX2S9z3ev/5v0Y37/NR5A61wQAxoP+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=udpYUjIrumm28qJ7y3GLHBglJEcaJ9F9+3X1aHuIEAP61Th/Ck+vLGddXpI9Lx4Rh
         r2eDWO9hlh5iEKH0TfKcBN6WVLth0zyQL/H7bk2YZL2knjIVLtF/TIU/ACk6fJlf4J
         t6F0pFB0ZFPHzcw/+OCXo/P+q51Bi8bMJDwCRTLs=
Date:   Tue, 23 Jun 2020 20:11:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] ARM: imx6: add missing put_device() call in
 imx6q_suspend_init()
Message-ID: <20200623121143.GF30139@dragon>
References: <20200604125449.3917164-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604125449.3917164-1-yukuai3@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 08:54:49PM +0800, yu kuai wrote:
> if of_find_device_by_node() succeed, imx6q_suspend_init() doesn't have a
> corresponding put_device(). Thus add a jump target to fix the exception
> handling for this function implementation.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Applied, thanks.
