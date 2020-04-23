Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BEBC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45FF2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587653116;
	bh=gn4S2cIXD4EhQqMk78SD+kjGqXBlgVeK+yPOptx2JwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KVSKc5ECNZ/Iq3lLrN4WTl6V8vGJM/pUiVUmiHYtCGCjiJsSSO9WxU4wKjTbr1Rm7
	 NUFEVdZz97CkbOEdoegcgf4ue1Qz1+3zXlb6kkddYJc/O6UmsX4b1hLiPzeObhtIzy
	 zeLx3vQ3I+Nrp2KWKsVBMfsczXn+uBcNALun7c8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgDWOpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDWOpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:45:15 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F00732074F;
        Thu, 23 Apr 2020 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587653115;
        bh=gn4S2cIXD4EhQqMk78SD+kjGqXBlgVeK+yPOptx2JwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SueLIX1lbRUdWKDgvwqFGjRkuwLcgWjB/EHlONPKjdLDhEHE6zVEOazhev78w0f47
         sBvHXYZQSqhhG30Bd5lO2LW2E0mOA/lTDCjfmfB4sLkbkgICknvxr4PrtnoArcBo1e
         p+SthAprWj1QYzVWFD+YMhmSEPYlrAzJXDe6KiBg=
Date:   Thu, 23 Apr 2020 22:45:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] ARM: vf610: report soc info via soc device
Message-ID: <20200423144508.GD9391@dragon>
References: <20200326174232.23365-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326174232.23365-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:42:32AM -0700, Andrey Smirnov wrote:
> The patch adds plumbing to soc device info code necessary to support
> Vybrid devices. Use case in mind for this is CAAM driver, which
> utilizes said API.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-imx@nxp.com

Applied, thanks.
