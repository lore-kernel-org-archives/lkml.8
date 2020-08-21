Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF809C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8391D207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597995420;
	bh=e8JwT0VRcoKwsR/TVC266dRGaNa6Q2/f0HDTOtDQugY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yTBQxn/TVTe/LBigJVaRWCh4OQ6IClsQ1+jGdCSuepQ3YqIPW1uG43bY3b/zQ+dTz
	 tHpST6/sHqeigU8LYKdZ4DrysFf7R/NdGuP5iZ+p5SA7W0lGgwQvkWQfJIAxUthrMt
	 UApdEWTIgEPT1G2r7zPXffGM2BimRrZHl+Sr03d8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgHUHg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbgHUHg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:36:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D38207DF;
        Fri, 21 Aug 2020 07:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597995416;
        bh=e8JwT0VRcoKwsR/TVC266dRGaNa6Q2/f0HDTOtDQugY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WYVkQoqUxQY1AB4L8ETC/Cg4c4zO52C2eZZ5LKV1csdbv8N51eHSZOJsP4Hdw1GY0
         K4p7scjECHd78K3U6W3BIYpNT362B3Jjf+jnkeYG2yx8+LHtcrDTymFpYmPbRBRI3n
         PVAOFSOIodr/gMkMieaghVqjJRjlGWcG9yBaVbIQ=
Date:   Fri, 21 Aug 2020 09:37:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Denis Efremov <efremov@linux.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 4.19 90/92] drm/radeon: fix fb_div check in
 ni_init_smc_spll_table()
Message-ID: <20200821073715.GC1681156@kroah.com>
References: <20200820091537.490965042@linuxfoundation.org>
 <20200820091542.324851351@linuxfoundation.org>
 <20200821072718.GD23823@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821072718.GD23823@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:27:18AM +0200, Pavel Machek wrote:
> Hi!
> 
> > From: Denis Efremov <efremov@linux.com>
> > 
> > commit f29aa08852e1953e461f2d47ab13c34e14bc08b3 upstream.
> > 
> > clk_s is checked twice in a row in ni_init_smc_spll_table().
> > fb_div should be checked instead.
> > 
> > Fixes: 69e0b57a91ad ("drm/radeon/kms: add dpm support for cayman (v5)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> No, this is wrong.
> 
> We already have the fix in -stable, as:
> 
> commit a083deda0b4179fb6780bc53d900794c4952339f
> Author: Denis Efremov <efremov@linux.com>
> Date:   Mon Jun 22 23:31:22 2020 +0300
> 
>     drm/radeon: fix fb_div check in ni_init_smc_spll_table()
> 
>     commit 35f760b44b1b9cb16a306bdcc7220fbbf78c4789 upstream.
> 
> Result is that we now convert _second_ copy clk_s check, and check
> fb_div twice. This introduces error, rather than fixing one.

I hate the drm patchflow, it causes this type of issue to happen every
release.  It's their fault, they give me no way of detecting this type
of crap and seem to ignore my complaints :(

ugh.

greg k-h
