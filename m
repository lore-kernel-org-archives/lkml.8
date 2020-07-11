Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284E4C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0717C20720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594464191;
	bh=M6Gv5LhVsekhAqlpYwpr7VAiiUfCVAtwfASULSjgwbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xI0rly8NhCqkOAJVe8NKIkYyAzFfI/OKhhv0F4bwRv1UPBSJxFx3vxAez660sj467
	 zf000w38m1Gref8OJsnub1/clbPerCHAO4VZjgGwFZlKbVWEGAALgOeUotrPpUJyuW
	 OjmdOwVwOkTCxtJIdeVoyLpdZByajb47XNzSLC44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgGKKnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 06:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGKKnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:43:06 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60FEF20720;
        Sat, 11 Jul 2020 10:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594464186;
        bh=M6Gv5LhVsekhAqlpYwpr7VAiiUfCVAtwfASULSjgwbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHDeCLrAtUjf3uj0kUTZhIXfPMGQeYrAK8yP76d668EbZ6BgV5TNwZNX+NwoiOsrU
         6kZNUWNyPb3351lbGF5rUlcMKvWtG9D5Kvpb8cEdJoQhbXtNBXxID0vPEr/DvUJc/H
         BLAS3fukVR8NWHp1NBO6WzaUAQH55qE1d357dWHA=
Date:   Sat, 11 Jul 2020 18:42:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: dts: imx6qdl-gw: add Gateworks System Controller
 support
Message-ID: <20200711104258.GB21277@dragon>
References: <1592497149-22526-1-git-send-email-tharvey@gateworks.com>
 <1592937347-12962-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592937347-12962-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:35:47AM -0700, Tim Harvey wrote:
> Add Gateworks System Controller support to Gateworks Ventana boards:
> - add dt bindings for GSC mfd driver and hwmon driver for ADC's and
>   fan controllers.
> - add dt bindings for gpio-keys driver for push-button and interrupt events
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
