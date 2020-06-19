Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C932C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CE621707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583462;
	bh=gIfZMGZem2W05Cjy5nXcdrpBntSc1KU60HG6biDtdV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nXCjj+q7pl6pQzBcuYSYgEQkYsX4+rpG46Q/31MUN1DwrPOWS75hCh486x4pXrkER
	 JT7sKlrSkJlshnEcj8tGvUf2thj3ATqQQIZmuPieQQsXc0Sq4qAAEp8e1iyiTIbPVG
	 TtEddk+0utC2UdCFKHybteKQfLcqM3qaMUpVFOkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390808AbgFSPCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390715AbgFSPBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:01:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FBB620734;
        Fri, 19 Jun 2020 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578890;
        bh=gIfZMGZem2W05Cjy5nXcdrpBntSc1KU60HG6biDtdV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6/esZGrkf94+7OSnV2dLoQVtxFGoW3JKhwNoa5vZKqv52sA+gfaAXs31k9Ehpj7k
         Mf0kKc0AUL72vnT92+XocMpKhA+cKjSwXE1nkeUlHizPfRoXZVl5mBVL+6OWSWf24a
         POvIOSOLysLHpJR3GPk10N+gGKiLhpkwt668bmZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.19 196/267] ext4: fix EXT_MAX_EXTENT/INDEX to check for zeroed eh_max
Date:   Fri, 19 Jun 2020 16:33:01 +0200
Message-Id: <20200619141658.156666851@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

commit c36a71b4e35ab35340facdd6964a00956b9fef0a upstream.

If eh->eh_max is 0, EXT_MAX_EXTENT/INDEX would evaluate to unsigned
(-1) resulting in illegal memory accesses. Although there is no
consistent repro, we see that generic/019 sometimes crashes because of
this bug.

Ran gce-xfstests smoke and verified that there were no regressions.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Link: https://lore.kernel.org/r/20200421023959.20879-2-harshadshirwadkar@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ext4_extents.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/fs/ext4/ext4_extents.h
+++ b/fs/ext4/ext4_extents.h
@@ -157,10 +157,13 @@ struct ext4_ext_path {
 	(EXT_FIRST_EXTENT((__hdr__)) + le16_to_cpu((__hdr__)->eh_entries) - 1)
 #define EXT_LAST_INDEX(__hdr__) \
 	(EXT_FIRST_INDEX((__hdr__)) + le16_to_cpu((__hdr__)->eh_entries) - 1)
-#define EXT_MAX_EXTENT(__hdr__) \
-	(EXT_FIRST_EXTENT((__hdr__)) + le16_to_cpu((__hdr__)->eh_max) - 1)
+#define EXT_MAX_EXTENT(__hdr__)	\
+	((le16_to_cpu((__hdr__)->eh_max)) ? \
+	((EXT_FIRST_EXTENT((__hdr__)) + le16_to_cpu((__hdr__)->eh_max) - 1)) \
+					: 0)
 #define EXT_MAX_INDEX(__hdr__) \
-	(EXT_FIRST_INDEX((__hdr__)) + le16_to_cpu((__hdr__)->eh_max) - 1)
+	((le16_to_cpu((__hdr__)->eh_max)) ? \
+	((EXT_FIRST_INDEX((__hdr__)) + le16_to_cpu((__hdr__)->eh_max) - 1)) : 0)
 
 static inline struct ext4_extent_header *ext_inode_hdr(struct inode *inode)
 {


