Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59101C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395C320809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXSzA+ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgG2SDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:03:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36105 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726336AbgG2SDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596045801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=yPxwBGHvqALkfsrQrrIYpsq7hoQPI6RVBDt+ux1gexE=;
        b=gXSzA+icinw85huwwXhH5wmcF2UHlzH/MTxoLCxAxxwNF4E3sL8FFHuB1+f1pHFYNcKL+d
        6uv4mBAwR02aaokNScqP9nGdkHoOllwl+LtikzyI3JgX70QQD+FFaMOSENhWKwHAmw5xat
        FQFb6brK7H+ieBakSUnBpGVDiBFV744=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-xT_nsobDNEGjE9sYtWEgrg-1; Wed, 29 Jul 2020 14:03:18 -0400
X-MC-Unique: xT_nsobDNEGjE9sYtWEgrg-1
Received: by mail-pf1-f198.google.com with SMTP id x2so9962284pfo.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yPxwBGHvqALkfsrQrrIYpsq7hoQPI6RVBDt+ux1gexE=;
        b=teb8xMEEDTZ2pPhqasSQy+uArz038Ej03GVXzS++87WQIbbnRPskx80Y1En16uFO8b
         5letRtjevrEt1HO256RUvltHEtffgQX/UWA3eHojeW/pZnyuvvyZipplGVXgGlO2SvwE
         g1W3htJ3yQghabdIggIl4k0sdMxQjdoDYiv/P/D681beUx2EVVfjdncTo8SC+4flc9MT
         yRmCElAuYE0nxUkJx7WCHNPFPzMqqCC3wKGOJdJw2lkrKYRGzXEvwbwd3pFweyCDe59/
         op3P8ld4u3wXnupPd46HgbiTQ09ikLPmeIXV4Z8e5syXcqfSQOvcmfjNVduobmh0hqiZ
         b1XA==
X-Gm-Message-State: AOAM530ciYZsp1RP9CjKzdNcVQE52WV0u7moru/38YCYEbHuJf+5aZgF
        kzOUkY9QIA04lB3BnjwAZnyp2sxRVormMhoISR7CzqvBSItQAbtaxw3pWcgEtX1XVOrQpgN7E2s
        Aw7attXm896RklVNk9ILlqSCq
X-Received: by 2002:a17:902:368:: with SMTP id 95mr29689636pld.279.1596045797407;
        Wed, 29 Jul 2020 11:03:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwohj6P24jrwHX9Quk18oF5SJeQ9c/MjqAOHHevveTR1FFq2T4bSXP++bEI6hqh7pTETbcoGA==
X-Received: by 2002:a17:902:368:: with SMTP id 95mr29689623pld.279.1596045797161;
        Wed, 29 Jul 2020 11:03:17 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id np4sm2311140pjb.4.2020.07.29.11.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 11:03:16 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH] erofs: fold in used-once helper erofs_workgroup_unfreeze_final()
Date:   Thu, 30 Jul 2020 02:02:35 +0800
Message-Id: <20200729180235.25443-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's expected that erofs_workgroup_unfreeze_final() won't
be used in other places. Let's fold it to simplify the code.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/utils.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 52d0be10f1aa..14485a621862 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -127,12 +127,6 @@ int erofs_workgroup_put(struct erofs_workgroup *grp)
 	return count;
 }
 
-static void erofs_workgroup_unfreeze_final(struct erofs_workgroup *grp)
-{
-	erofs_workgroup_unfreeze(grp, 0);
-	__erofs_workgroup_free(grp);
-}
-
 static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 					   struct erofs_workgroup *grp)
 {
@@ -162,11 +156,9 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	 */
 	DBG_BUGON(xa_erase(&sbi->managed_pslots, grp->index) != grp);
 
-	/*
-	 * If managed cache is on, last refcount should indicate
-	 * the related workstation.
-	 */
-	erofs_workgroup_unfreeze_final(grp);
+	/* last refcount should be connected with its managed pslot.  */
+	erofs_workgroup_unfreeze(grp, 0);
+	__erofs_workgroup_free(grp);
 	return true;
 }
 
-- 
2.18.1

