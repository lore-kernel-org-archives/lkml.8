Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F9BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137302068F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TAZz7skh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgGOFYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgGOFYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:24:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4737C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jatY69qSBEdSfoP6T/nc+TThcdoyEXqNhA+mZsMH4ko=; b=TAZz7skhHTyLYoWE5V1RZqv5bD
        9SOCQlYXsEjRpoeASre0wUlSlYgjzj0NiDshHbR2q5LB9REvaaJRtbehC3FgNBOiPXSPfPe7LUzRO
        xEuiAKK+EtQNKE7Sgy/LdW75yhw3YNiCHZxBVCOJ3beb0k7yT1dwRUo/3yZTN5C+M3aIdItbuREGW
        n0u9/vETQLJ1mDVZHak3UD7pSYImtXXUt2zUcdDNIn6V8y/kgmvjVdbsIQjFNVA8V+jn2Mhxp8J/Z
        sc/IxmOg3sPGdJS+JiM6e/OyMarg5lpacfy5rqMTNBTHmhpdw+RtToFmWmRi99nveHwmkmezPVQ0/
        fXgZfzBA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvZtg-0006Vd-Rp; Wed, 15 Jul 2020 05:24:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 6/7] drm: msm_drm.h: delete duplicated words in comments
Date:   Tue, 14 Jul 2020 22:23:48 -0700
Message-Id: <20200715052349.23319-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715052349.23319-1-rdunlap@infradead.org>
References: <20200715052349.23319-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "to" in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 include/uapi/drm/msm_drm.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200714.orig/include/uapi/drm/msm_drm.h
+++ linux-next-20200714/include/uapi/drm/msm_drm.h
@@ -252,8 +252,8 @@ struct drm_msm_gem_submit {
 	__u64 cmds;           /* in, ptr to array of submit_cmd's */
 	__s32 fence_fd;       /* in/out fence fd (see MSM_SUBMIT_FENCE_FD_IN/OUT) */
 	__u32 queueid;        /* in, submitqueue id */
-	__u64 in_syncobjs;    /* in, ptr to to array of drm_msm_gem_submit_syncobj */
-	__u64 out_syncobjs;   /* in, ptr to to array of drm_msm_gem_submit_syncobj */
+	__u64 in_syncobjs;    /* in, ptr to array of drm_msm_gem_submit_syncobj */
+	__u64 out_syncobjs;   /* in, ptr to array of drm_msm_gem_submit_syncobj */
 	__u32 nr_in_syncobjs; /* in, number of entries in in_syncobj */
 	__u32 nr_out_syncobjs; /* in, number of entries in out_syncobj. */
 	__u32 syncobj_stride; /* in, stride of syncobj arrays. */
