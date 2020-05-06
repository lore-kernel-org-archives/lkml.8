Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEF1C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409DF20708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vt3ASJY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbgEFQhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729514AbgEFQhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:37:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1426CC061A0F;
        Wed,  6 May 2020 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rD5kS9fKOCFC5Wrv4OGxJ1wjPJROIVfPC4SxXU+3cYs=; b=Vt3ASJY+yV3QAMC4zN9BfriIrZ
        /hX/eabvHCoMFDNPuW8o0LWC8DK6WRhA3d3giUGhzjBXZQZKKuCrVhhUmlvEvcrWLXahzwmApNUpC
        wnH+5hXBxikXz28hlv2b418kP88+gc3+FV0+ag5a0wYvksy4WWDGjnoU9a/miSA+RUHS2Wt1NInLT
        iQLf01QOFKF++Ecle60ouWj+DjDH2r5/2mpvsUc6EYPWgVmq66VoYnBcv+jxVq4sbIaNKKshRtv0N
        XXB1v1msuPxXcBIBgqiu0KFelYK5p6UmPlTGI7zyPVR9vm5kr5FNHyEKM553Uo249YqxTuRBwOkWz
        u6pWVcXA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWN2p-0005iO-4z; Wed, 06 May 2020 16:37:15 +0000
Date:   Wed, 6 May 2020 09:37:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc: Fix some errors in ras.rst
Message-ID: <20200506163715.GM16070@bombadil.infradead.org>
References: <20200506162217.16633-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506162217.16633-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:22:17PM -0400, Waiman Long wrote:
> Make some miscellaneous fixes to the first paragraph of "ECC memory":
>  - Change the incorrect "74 bits" to "72 bits".
>  - Change "mentioned on" to "mentioned in".
>  - Remove the extra "extra".
>  - Rephrase some sentences as suggested by Matthew Wilcox.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
