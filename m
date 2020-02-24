Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD763C35641
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C6520828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582515564;
	bh=JkrEc2MaNepQNF9f/dnwBAADKS3nNGfp1NS3WsPz978=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fDGd9sG8zRTsHKkQsS/ZUG01IzPw90ScEH/hDRmC/9WsjE8Q27tZUioF6w5Z40vOf
	 MSVXzls2MlESlYH1JuYazO18W7/SM/J+zIlFa9FmhAXtLnVIAWU0UScQvf7m1h/ogf
	 QYHQ8NU3qIcLt5Didqnvpb4Qz9yYSJxaHZzKpx80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBXDjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 22:39:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbgBXDjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:39:23 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8711620658;
        Mon, 24 Feb 2020 03:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582515562;
        bh=JkrEc2MaNepQNF9f/dnwBAADKS3nNGfp1NS3WsPz978=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRRB/vVqLw+c4mdGgtuPTPGB088ciHEohbGC1mZe9LVWhf5auaqrw0Yw9DLW+eVNY
         azTqZg+KuarjySjwk3i8iVbDsApgXZNFWanZ2ISkdUfTdCEOSOPsT1cR1zd6O6FuLK
         hh9ISC3IqCMHsrWn+E+2dmI+qjOMk2TCgXgLMkog=
Date:   Mon, 24 Feb 2020 11:39:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     sboyd@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, leonard.crestez@nxp.com, kernel@pengutronix.de,
        linux-imx@nxp.com, aisheng.dong@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anson.huang@nxp.com, ping.bai@nxp.com, l.stach@pengutronix.de
Subject: Re: [PATCH RESEND v3 0/4] clk: imx: imx8m: fix a53 cpu clock
Message-ID: <20200224033911.GH27688@dragon>
References: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 06:17:05PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V3:
>  Rebased to Shawn's for-next branch
>  Typo fix
> 
> V2:
>  Fix i.MX8MP build
>  Update cover letter, i.MX7D not have this issue 
> 
> The A53 CCM clk root only accepts input up to 1GHz, CCM A53 root
> signoff timing is 1Ghz, however the A53 core which sources from CCM
> root could run above 1GHz which voilates the CCM.
> 
> There is a CORE_SEL slice before A53 core, we need configure the
> CORE_SEL slice source from ARM PLL, not A53 CCM clk root.
> 
> The A53 CCM clk root should only be used when need to change ARM PLL
> frequency.
> 
> Peng Fan (4):
>   clk: imx: imx8mq: fix a53 cpu clock
>   clk: imx: imx8mm: fix a53 cpu clock
>   clk: imx: imx8mn: fix a53 cpu clock
>   clk: imx: imx8mp: fix a53 cpu clock

Applied all, thanks.
