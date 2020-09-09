Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689E1C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31906208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPXYrlW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgIIHuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:50:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45288 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729912AbgIIHur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599637843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Krdo7votp1a5I9aSySSzn4z1pSMbxKrCs0iSmNmlLoo=;
        b=LPXYrlW0AzGC7Lq+aSsFmYAbQfz00ZqarEB1qphfzijT2eTHMjhLYLO5geGr4/rZLZAuVs
        6VGeSGZt9xNq/B6Nmf2S3++dO5uk4HdRECC5ptNa4MfEW8XT1NDaTVppVc7sWSKLFUERB8
        rnDIzWQSr4kRpE/eHebXaLW8iKm7rJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-Qsjja7kzPD20P8uFwIisFA-1; Wed, 09 Sep 2020 03:50:42 -0400
X-MC-Unique: Qsjja7kzPD20P8uFwIisFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2A961009441;
        Wed,  9 Sep 2020 07:50:40 +0000 (UTC)
Received: from kasong-rh-laptop.redhat.com (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62C721002D53;
        Wed,  9 Sep 2020 07:50:37 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH 1/3] vmcore: simplify read_from_olemem
Date:   Wed,  9 Sep 2020 15:50:14 +0800
Message-Id: <20200909075016.104407-2-kasong@redhat.com>
In-Reply-To: <20200909075016.104407-1-kasong@redhat.com>
References: <20200909075016.104407-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code logic, also helps reduce object size and stack usage.

Stack usage:
  Before: fs/proc/vmcore.c:106:9:read_from_oldmem.part.0  80     static
          fs/proc/vmcore.c:106:9:read_from_oldmem         16     static
  After:  fs/proc/vmcore.c:106:9:read_from_oldmem         80     static

Size of vmcore.o:
          text    data     bss     dec     hex filename
  Before: 7677     109      88    7874    1ec2 fs/proc/vmcore.o
  After:  7669     109      88    7866    1eba fs/proc/vmcore.o

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 fs/proc/vmcore.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index c3a345c28a93..124c2066f3e5 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -108,25 +108,19 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 			 bool encrypted)
 {
 	unsigned long pfn, offset;
-	size_t nr_bytes;
-	ssize_t read = 0, tmp;
+	size_t nr_bytes, to_copy = count;
+	ssize_t tmp;
 
-	if (!count)
-		return 0;
-
-	offset = (unsigned long)(*ppos % PAGE_SIZE);
+	offset = (unsigned long)(*ppos & (PAGE_SIZE - 1));
 	pfn = (unsigned long)(*ppos / PAGE_SIZE);
 
-	do {
-		if (count > (PAGE_SIZE - offset))
-			nr_bytes = PAGE_SIZE - offset;
-		else
-			nr_bytes = count;
+	while (to_copy) {
+		nr_bytes = min(to_copy, PAGE_SIZE - offset);
 
 		/* If pfn is not ram, return zeros for sparse dump files */
-		if (pfn_is_ram(pfn) == 0)
+		if (pfn_is_ram(pfn) == 0) {
 			memset(buf, 0, nr_bytes);
-		else {
+		} else {
 			if (encrypted)
 				tmp = copy_oldmem_page_encrypted(pfn, buf,
 								 nr_bytes,
@@ -140,14 +134,13 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 				return tmp;
 		}
 		*ppos += nr_bytes;
-		count -= nr_bytes;
 		buf += nr_bytes;
-		read += nr_bytes;
+		to_copy -= nr_bytes;
 		++pfn;
 		offset = 0;
-	} while (count);
+	}
 
-	return read;
+	return count;
 }
 
 /*
-- 
2.26.2

