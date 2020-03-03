Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C082C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDD72072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="daGqKylB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbgCCT3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:29:00 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46067 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgCCT27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:28:59 -0500
Received: by mail-qv1-f67.google.com with SMTP id r8so2204413qvs.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 11:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5sB0rUv2y/FHn+2J4ke7VwpHWKH7r4gCKIkGyO1umgw=;
        b=daGqKylBIlAi05SY9J399ZZ2Y08VyEwEoo9tk80ZrcKcKxqZMlCtGyiYiZZO7BqhuT
         r69j/D9J4NoIk9x++Ba4c3nWXvLHE1CqqYXFJAwY0LNWoUwutCpjEEvtWhmZApPNcSB2
         +vj+k2bNBUOvltMhLa4JkKJN89nFj/bopSPcetCwJE9kBjkGHYHi0t2m/fKFGfv4cIUf
         aktTqZjUm8o+5TSHHehGW1JANsTuhXMxv1wpv3Om+O87PS+uMIXh51l/nuKYg3Q5gb2z
         njXkMUxx4zFQMqjrlxwonYSv646HhRq/PdQEBz53X2RdFhelWAwYRSQ6S4Pz4Y3sy//w
         EWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5sB0rUv2y/FHn+2J4ke7VwpHWKH7r4gCKIkGyO1umgw=;
        b=T4VF5obKq7sTbyVOuwUbSYTEwupcCM9osZTMKC7y1PhxRT7i8wqgXIpxPy0xzp74F9
         9H3eW+V8mzDWxJWWUEhDyo1sHD83Qa4nd0lJIQhisasWpCTqES0ClyI7bD89sjvWPgKQ
         2wWnBNgFPkYhLNXnKkEuTId7qfWWWfrIuNbda7vfZ1NXWR6vqkoaKCwCifKxZZ2+X5IB
         aUncmok89sQJHtY7TMAKy5w5YZiw8/QoFJPN/cPwAlh7Vh4l6/2uhz0jc4auDeMkCX3F
         J9eyea7LMlo5Hu7ao0fGPcRjkRkVX2p7zUWfgcR/V/dbjCbdg94tI21Hz655N0phi99n
         +YSA==
X-Gm-Message-State: ANhLgQ2z7gqVXnIJ/85lzB9F/RDmOOzSrnSW3/jKfS6+RAwYQ9+36eF7
        wi/AaIPC7+O6upm/o968vB3eY8qysGU=
X-Google-Smtp-Source: ADFU+vsdN08+hzzkYgx52slbfyXtJEtnMWJ/t/Xpb46+aEucSVYgw91EmssD2oQy1FgomzbaEwvJnA==
X-Received: by 2002:ad4:4a6e:: with SMTP id cn14mr5364150qvb.21.1583263738513;
        Tue, 03 Mar 2020 11:28:58 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j7sm8872582qti.14.2020.03.03.11.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 11:28:58 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next 2/2] Revert "mm/kmemleak: annotate various data races obj->ptr"
Date:   Tue,  3 Mar 2020 14:28:36 -0500
Message-Id: <1583263716-25150-2-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583263716-25150-1-git-send-email-cai@lca.pw>
References: <1583263716-25150-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a03184297d546c6531cdd40878f1f50732d3bac9.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/kmemleak.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 788dc5509539..e362dc3d2028 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1169,12 +1169,7 @@ static bool update_checksum(struct kmemleak_object *object)
 	u32 old_csum = object->checksum;
 
 	kasan_disable_current();
-	/*
-	 * crc32() will dereference object->pointer. If an unstable value was
-	 * returned due to a data race, it will be corrected in the next scan.
-	 */
-	object->checksum = data_race(crc32(0, (void *)object->pointer,
-					   object->size));
+	object->checksum = crc32(0, (void *)object->pointer, object->size);
 	kasan_enable_current();
 
 	return object->checksum != old_csum;
@@ -1248,7 +1243,7 @@ static void scan_block(void *_start, void *_end,
 			break;
 
 		kasan_disable_current();
-		pointer = data_race(*ptr);
+		pointer = *ptr;
 		kasan_enable_current();
 
 		untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
-- 
1.8.3.1

