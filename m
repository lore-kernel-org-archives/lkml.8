Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FBAC3F358
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9BA20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811532;
	bh=wrU3ea9/TGo7Ex9gJ6sYgelucHAoTWTgbTJ3elt/NWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iA+3s8dJmRwRjvH2Hgpj7I5CxWe2ff+a9pj+vIQkYb2ROTasi/JswswkjbpbnSxXx
	 nsj9NTSaclh/ffCsPUH8mj4aft0yLvg7pd/x84p8tMSagucoFVcELY9xtUUMKByyxF
	 KupbDf/jVUto5KNrGqF5C+eurvcnCxIEFbCqhZMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgB0NwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:52:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbgB0NwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:52:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5326A2084E;
        Thu, 27 Feb 2020 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811525;
        bh=wrU3ea9/TGo7Ex9gJ6sYgelucHAoTWTgbTJ3elt/NWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/ubvbUofzl0bMI1+XR9/IjCS6RSTrJSnTGej/yPH3+6gQcSw9SmnKs9toctyiiuo
         xOVPSxMhzTUiHSYIgICGauURp6VFQ4LIEEZaWyUW/ZW140q1HvrMY0ZZdov71oqnY4
         zzVG9cm53qxgwjQgUWHILn/E8eep6gpEnq79PMA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saar Amar <Saar.Amar@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.9 129/165] x86/mce/amd: Publish the bank pointer only after setup has succeeded
Date:   Thu, 27 Feb 2020 14:36:43 +0100
Message-Id: <20200227132249.887243780@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

commit 6e5cf31fbe651bed7ba1df768f2e123531132417 upstream.

threshold_create_bank() creates a bank descriptor per MCA error
thresholding counter which can be controlled over sysfs. It publishes
the pointer to that bank in a per-CPU variable and then goes on to
create additional thresholding blocks if the bank has such.

However, that creation of additional blocks in
allocate_threshold_blocks() can fail, leading to a use-after-free
through the per-CPU pointer.

Therefore, publish that pointer only after all blocks have been setup
successfully.

Fixes: 019f34fccfd5 ("x86, MCE, AMD: Move shared bank to node descriptor")
Reported-by: Saar Amar <Saar.Amar@microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200128140846.phctkvx5btiexvbx@kili.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce_amd.c |   33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -879,8 +879,9 @@ static const char *get_name(unsigned int
 	return buf_mcatype;
 }
 
-static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
-				     unsigned int block, u32 address)
+static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb,
+				     unsigned int bank, unsigned int block,
+				     u32 address)
 {
 	struct threshold_block *b = NULL;
 	u32 low, high;
@@ -924,16 +925,12 @@ static int allocate_threshold_blocks(uns
 
 	INIT_LIST_HEAD(&b->miscj);
 
-	if (per_cpu(threshold_banks, cpu)[bank]->blocks) {
-		list_add(&b->miscj,
-			 &per_cpu(threshold_banks, cpu)[bank]->blocks->miscj);
-	} else {
-		per_cpu(threshold_banks, cpu)[bank]->blocks = b;
-	}
+	if (tb->blocks)
+		list_add(&b->miscj, &tb->blocks->miscj);
+	else
+		tb->blocks = b;
 
-	err = kobject_init_and_add(&b->kobj, &threshold_ktype,
-				   per_cpu(threshold_banks, cpu)[bank]->kobj,
-				   get_name(bank, b));
+	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(bank, b));
 	if (err)
 		goto out_free;
 recurse:
@@ -941,7 +938,7 @@ recurse:
 	if (!address)
 		return 0;
 
-	err = allocate_threshold_blocks(cpu, bank, block, address);
+	err = allocate_threshold_blocks(cpu, tb, bank, block, address);
 	if (err)
 		goto out_free;
 
@@ -1026,8 +1023,6 @@ static int threshold_create_bank(unsigne
 		goto out_free;
 	}
 
-	per_cpu(threshold_banks, cpu)[bank] = b;
-
 	if (is_shared_bank(bank)) {
 		atomic_set(&b->cpus, 1);
 
@@ -1038,9 +1033,13 @@ static int threshold_create_bank(unsigne
 		}
 	}
 
-	err = allocate_threshold_blocks(cpu, bank, 0, msr_ops.misc(bank));
-	if (!err)
-		goto out;
+	err = allocate_threshold_blocks(cpu, b, bank, 0, msr_ops.misc(bank));
+	if (err)
+		goto out_free;
+
+	per_cpu(threshold_banks, cpu)[bank] = b;
+
+	return 0;
 
  out_free:
 	kfree(b);


