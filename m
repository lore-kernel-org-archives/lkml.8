Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C49FC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 00:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 284E52177B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 00:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kt62KGic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgGTAOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 20:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgGTAOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 20:14:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2CEC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 17:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Z+gYR5esdBMAGv34Rn3ZmXqEpEkmqBZwfvapW368RN8=; b=Kt62KGicHaUasKA2Y8zxnKYpm+
        RqD3n4VYeMBn4ltJasVeZu9zjiW4EKrPFD8rD7X8arA+zDmmywH0MGVAnlOGAveYRCY18zL5IxvXs
        VqvP4SEW7TNquFPUnAO9YflOtPko0WHqZzFAlhfExoVxP5bWBdkJDr4nzIKR77QL8tzoGCDT9Ptxi
        4JqZSEEr8/6QGvzCHwQib+7btwVBR4JF/qXgoePQk7ZPcAW+cIYKdNL3m3Quv/5yxXzm8Fdydrcz3
        JeoP81+2+n8Z4IJTonAbLtKPSG0Uo67q3ky7026fGd23zmJ3JlI71Lk0pI0LVASn2XIk5hXzxCHh7
        FOmWqLoQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxJRf-0003zN-Ri; Mon, 20 Jul 2020 00:14:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH] ntfs: layout.h: delete duplicated words
Date:   Sun, 19 Jul 2020 17:14:12 -0700
Message-Id: <20200720001412.27815-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated words "the" and "in" in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
---
 fs/ntfs/layout.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200717.orig/fs/ntfs/layout.h
+++ linux-next-20200717/fs/ntfs/layout.h
@@ -703,7 +703,7 @@ typedef struct {
 /* 14*/	le16 instance;		/* The instance of this attribute record. This
 				   number is unique within this mft record (see
 				   MFT_RECORD/next_attribute_instance notes in
-				   in mft.h for more details). */
+				   mft.h for more details). */
 /* 16*/	union {
 		/* Resident attributes. */
 		struct {
@@ -1838,7 +1838,7 @@ typedef struct {
  * Also, each security descriptor is stored twice in the $SDS stream with a
  * fixed offset of 0x40000 bytes (256kib, the Windows cache manager's max size)
  * between them; i.e. if a SDS_ENTRY specifies an offset of 0x51d0, then the
- * the first copy of the security descriptor will be at offset 0x51d0 in the
+ * first copy of the security descriptor will be at offset 0x51d0 in the
  * $SDS data stream and the second copy will be at offset 0x451d0.
  */
 typedef struct {
