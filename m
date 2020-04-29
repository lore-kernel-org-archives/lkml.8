Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A19C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B9F208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KWI8M1r0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgD2MvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgD2MvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:51:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B86C03C1AD;
        Wed, 29 Apr 2020 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sRCgO9neRwXg7E1Pg9BwAuwaIvQxv5KwGOu2dgYS/Cs=; b=KWI8M1r0PtDE6DshAvv8FXzjgq
        K8DyhGM2SK9tf/h/5ZsGeK8hrKsQbN3L+3M2DmfffsofsbVUUC//sOVYvmCZu6+qAecegP2EDSt3L
        4tVTf2+Su9Oat6P7YaOteD2E9G+e23Kxd4WGRsSOe+xqeyjUT48WWqtxFoC6ClHeSdJTJT07eIYQh
        b1H3TA2GFDAjcugmn/oklh3iE5L5dtHPSHLDL2ZKxazkqIGx/SODNvzGWOCt4DdosVwOaDDPGmfox
        j3gu6ngQxu4jAoq5mG/U664a6M9+Xkt6UG5b4U+dW7K1PI2rAd8PAUZddBrA5J1sBsFzDu+s0D5gn
        QyWSh/eQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmB3-0003dB-B6; Wed, 29 Apr 2020 12:51:01 +0000
Date:   Wed, 29 Apr 2020 05:51:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild test robot <lkp@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] video: fbdev: controlfb: fix build for COMPILE_TEST=y
 && PPC_PMAC=y && PPC32=n
Message-ID: <20200429125101.GA21275@infradead.org>
References: <CGME20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd@eucas1p1.samsung.com>
 <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why do we even bother allocing the driver to compile for !ppc32
given that it clearly needs ppc-specific infrastructure?  The whole
idea of needing magic stubs for the COMPILE_TEST case seems rather
counterproduction.
