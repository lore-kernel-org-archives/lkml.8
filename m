Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA9EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827DD2100A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592962517;
	bh=+0IMWoLpUbRuRbVf5D/mZM7pi+csF164DDVQ5/21ijc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dmVE8QhQA38zuWB3khZq/yMnR8mVneSv33FHd7eBVKEIvVVyjB6epUBc9jkSE2XC+
	 L/yS/Prs1sZYCDNQs5n1rxinudWTqG+tCTsZtVULac7Uhr0aINIxdHDRhyplntzV7i
	 1pMwpyYMTXlxD2fDtp+Z0PalopQHJQPawusteqao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388417AbgFXBfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387804AbgFXBfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:35:16 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199EA20B80;
        Wed, 24 Jun 2020 01:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592962515;
        bh=+0IMWoLpUbRuRbVf5D/mZM7pi+csF164DDVQ5/21ijc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Je25Ck+IVbWhGA5rgeBNGfNTjsElY9C0utY+XA2gGxRjEgnwcKt5gxcn2bU8kh+9s
         m05zfSDHQ7P4+IUF34P1Rgc+Hju2E2OQFY5Ym34cRhcgGW8/ZZ58rdtkSaJSAoa9EA
         7b21S+Oa8BSmqfETGe2mNHDx2ZrE0j92T8Vw3268=
Date:   Wed, 24 Jun 2020 09:35:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: Re: linux-next: build warnings after merge of the imx-mxs tree
Message-ID: <20200624011800.GA31961@dragon>
References: <20200624095007.141f0357@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624095007.141f0357@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 09:50:07AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the imx-mxs tree, today's linux-next build (arm
> multi_v7_defconfig) produced these warnings:

...

> Introduced by commits
> 
>   26d7c769d460 ("ARM: dts: imx6qdl-gw53xx: allow boot firmware to set eth1 MAC")
>   48d799918adf ("ARM: dts: imx6qdl-gw54xx: allow boot firmware to set eth1 MAC")

Sorry, Stephen.  I have just taken them out.

Shawn
