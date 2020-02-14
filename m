Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712CFC352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACF5218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581648360;
	bh=b6eY0omPiK9NtrDQWKKdHLgqQLvFeuFG7e+VjpYfmrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B1XeORhFL2MezJp/TzP5CnNZxLqWVSjJcOfwpWvH2lfTXrAOUJ2+RheSwcCoJMf9I
	 ItINypyaHm+Uy7f5T7MD1PfKj0KQ40ZRBVJQiBlUTe5n6syruv4t8Vef0f9ytsjwFO
	 2UueAVTnhTVlwPXOu6jevQXiTtzXR+3PWcwoLIH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgBNCp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgBNCp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:45:59 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93FBE20848;
        Fri, 14 Feb 2020 02:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581648358;
        bh=b6eY0omPiK9NtrDQWKKdHLgqQLvFeuFG7e+VjpYfmrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nukh9AKV6wEXxVK6H+l10mFvYMjf6GGkB2ynajqXnbkx2yXoNbi5ZxwzHvg8DEv0Q
         hlKd6UQmGDQyMt2ZBscja0ilDIQZc737/b0bWbZ81uhcm6SCdq82bOyQKTj0s8Y+UF
         7FFyj1N4gwTM8VBNqpohwLcW86iHvrpmTY04CNBQ=
Date:   Fri, 14 Feb 2020 10:45:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Sebastien Fagard <sebastien.fagard@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 0/2] Add more power domains
Message-ID: <20200214024551.GH22842@dragon>
References: <20200127142717.27570-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127142717.27570-1-daniel.baluta@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 02:27:30PM +0000, Daniel Baluta (OSS) wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> This patch series adds some missing audio PD domain and enlarges
> the power domain range for MU side B.
> 
> Daniel Baluta (1):
>   firmware: imx: scu-pd: Add missing audio PD ranges
> 
> Sebastien Fagard (1):
>   firmware: imx: scu-pd: enlarge PD range for mu_b

Applied both, thanks.
