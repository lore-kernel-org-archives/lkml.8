Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920C3C8300B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722392173E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgD2Njg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:39:36 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:52230 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgD2Nje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:39:34 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 49B6580507;
        Wed, 29 Apr 2020 15:39:29 +0200 (CEST)
Date:   Wed, 29 Apr 2020 15:39:23 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild test robot <lkp@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] video: fbdev: controlfb: fix build for COMPILE_TEST=y
 && PPC_PMAC=y && PPC32=n
Message-ID: <20200429133923.GA18115@ravnborg.org>
References: <CGME20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd@eucas1p1.samsung.com>
 <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
 <20200429125101.GA21275@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429125101.GA21275@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=_B__PoOuIxrDVYIAAIsA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On Wed, Apr 29, 2020 at 05:51:01AM -0700, Christoph Hellwig wrote:
> Why do we even bother allocing the driver to compile for !ppc32
> given that it clearly needs ppc-specific infrastructure?  The whole
> idea of needing magic stubs for the COMPILE_TEST case seems rather
> counterproduction.

All the usual good arguments.
If this driver only builds for 32bit powerpc then we will seldom
build it and every time we do some refactoring we risk introducing
build errros in this driver that is triggered much later.

So a few hacks are preferred to actually make it build.
But hacks should not paper over missing abstractions
in the general ioremap handlign and such.

I recall someone said the other day that drm folks had a tendency to
workaround rather than fixing this.
So this is "drm folks" reaching out and asking if this is a
case where we have a workaround and need a fix?

I will - after some testing - apply the fix from Bartlomiej.
But would like to know if this is a workarond or a fix.
Dropping COMPILE_TEST is not an option as explained above.

	Sam

