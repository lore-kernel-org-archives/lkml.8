Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21ABC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA97A2469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582874035;
	bh=o/o+rN5J4FJ4IIagYXkFJQhrIf0lltnoDOw1DAcmzdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iDilP00uRVjGgOqWHopAU3lycccx8/mRYPCRTNDxndLX3e4jQxmxB8oUPgv/sujd4
	 Iz9NlsEuTD/a5zsaxCS6NH2BbYT+9ILuzui3JSxdU8EFt4smwQr8jBdRSCc3i6NZ5Z
	 2qBYZAfLfQMvpY14fbWjHeITN+uRg9mDsA5p2y2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgB1HNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:13:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgB1HNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:13:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0D332469D;
        Fri, 28 Feb 2020 07:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582874033;
        bh=o/o+rN5J4FJ4IIagYXkFJQhrIf0lltnoDOw1DAcmzdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/D6XxShaZ6ro8TQKYSlFcK+uJdQpeFMGyE0Etro7zuB96L+kaGikISoBbeCWmd2K
         /E01jygjTXEc6tSAggWq79ABUUb6+CJEOZZM6tjKsj7TPIW41h0Gd/3LRr7uGR3sZH
         qdpelqE5y7tU5B2DmSQAInXsKLg0xGqJQrfzcU7U=
Date:   Fri, 28 Feb 2020 08:12:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 111/237] tty: synclinkmp: Adjust indentation in
 several functions
Message-ID: <20200228071239.GC2895159@kroah.com>
References: <20200227132255.285644406@linuxfoundation.org>
 <20200227132305.054909944@linuxfoundation.org>
 <11c17de7c525997ddddab995223828bdec8e8e93.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11c17de7c525997ddddab995223828bdec8e8e93.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:55:49PM -0800, Joe Perches wrote:
> On Thu, 2020-02-27 at 14:35 +0100, Greg Kroah-Hartman wrote:
> > From: Nathan Chancellor <natechancellor@gmail.com>
> 
> I believe these sorts of whitespace only changes should
> not be applied to a stable branch unless it's useful for
> porting other actual defect fixes.

I want to get clang build warnings down to the same level that gcc build
warnings are, so that they become useful in detecting new issues.  That
is why I add these types of patches to the stable trees.

thanks,

greg k-h
