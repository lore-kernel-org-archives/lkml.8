Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E86C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 01:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8811C2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 01:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587604735;
	bh=5J7cR0szFxvJoNJ8P80jMKgqc3d3/p0yIBp4jdKWeYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SE+uz2re80sU3MxkcqirAtl+T3d195pLmQFRU07VN1Z+MhLhqj3NMcC092nkA3wc/
	 4sHE4OofC2R+b2VRGh+9xKHZsQjY4JlZSuZIQ3pbhe7bF4LjeNjz+Cn4n13t8J5Onx
	 o82+JBLSaqfP93IZ2ACXbkD92nVAxdm6y7+Np3Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgDWBSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 21:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgDWBSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 21:18:54 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B6A2075A;
        Thu, 23 Apr 2020 01:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587604734;
        bh=5J7cR0szFxvJoNJ8P80jMKgqc3d3/p0yIBp4jdKWeYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIx59UKndzfTh4wq2bvrFTQGolD30iYA5PEGQljltaIBRO7fHpu7TroWBiaoSDHiL
         zQzTb3TtBKYrMsVRxlHH0z/8IkrBtBN9md++fOaiM7ZrqN+MmQ0q4EHdlAIVhi7UEo
         DcjwZEgN++cnXQXTx8NmtR6QNwx8wcuUWELejeYo=
Date:   Thu, 23 Apr 2020 09:18:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: imx8mq-librem5-devkit: Use 0.9V for
 VDD_GPU
Message-ID: <20200423011846.GG8571@dragon>
References: <cover.1587480093.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1587480093.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 04:44:12PM +0200, Guido Günther wrote:
> According to the imx8mq data sheet running VDD_GPU at 0.9V is enough
> when not overclocking to 1GHz (which we currently don't do).
> 
> changes from v2:
>  - rebase aginst Shawn's tree
>  - fix a warning for the typec connector
> 
> Guido Günther (2):
>   arm64: dts: imx8mq-librem5-devkit: Use 0.9V for VDD_GPU
>   arm64: dts: Don't use underscore in node name

This one should also be prefixed like arm64: dts: imx8mq-librem5-devkit:

I fixed it up and applied both.

Shawn

> 
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.26.1
> 
