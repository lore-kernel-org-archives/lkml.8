Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87376C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641E32078D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598069170;
	bh=mPEv/6y3AMgIB7szosqUrMWbVCwkMmv+t0rAvPfsARQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CpeNyow5Tdn5zN74sI9N1z1f2Ydn0hfU2uKVp02kAwXnT8waD+MunK29H0f63yK6y
	 w46xHFz2neOuJO28d7K7kZ+MGjA5nlCmV9jQNyHTuORXQPHpyorU2NOsOcXCLA+xTK
	 I5NgM6cfxY1mbB8V9Oahl1tHGYaWT3YuiAJvdX2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgHVEGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgHVEGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:06:07 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F31220732;
        Sat, 22 Aug 2020 04:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598069167;
        bh=mPEv/6y3AMgIB7szosqUrMWbVCwkMmv+t0rAvPfsARQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iq5hULRIdu5cmNiCJSF9Ml2XGsQrGU1DdHGifctsBEsyE7sGcu08Y+9aZb1yGALHP
         OQtkPcIsr0b3rVxY5NKiDmTr/hASMo59zVdL0lUROF+uKTH9SIojxPt8vjax88nLLU
         2wtIbgZ74/GXKpNq4vfOzEmu4y6LKiNDWbYUOwCw=
Date:   Sat, 22 Aug 2020 12:05:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm: dts: imx7: add QSPI
Message-ID: <20200822040553.GD27575@dragon>
References: <20200729082554.29282-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729082554.29282-1-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 10:25:54AM +0200, Matthias Schiffer wrote:
> In preparation for an update of the TQ-Systems TQMa7x/MBa7x DTS, add the
> QSPI controller to imx7s.dtsi.
> 
> Based-on-patch-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Changed subject prefix to 'ARM: ...' and applied the patch.

Shawn
