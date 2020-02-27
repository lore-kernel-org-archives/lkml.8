Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0000C54FE9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A952468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813644;
	bh=jyVEhKbOvfiFnc9zwlVMqvuOOZFN6caQIquxtfzfJEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hDow6z37Kla/sIleOUzS8H9h3CfC6iWW7gPhdxMzQdm7bieVCSi1E8DuxsDgb744R
	 Xa5XC10+8lb/k0Qe/ReTRYPohOGAFXzGSqu5DWK2Yk6WPAMt9eWNOViygMq9kVKK5X
	 HwsdT9BO371Kg8IBdj7VXGEDMMuHrWnOpD3ACJm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbgB0OI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:08:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387620AbgB0OIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:08:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E62824697;
        Thu, 27 Feb 2020 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812531;
        bh=jyVEhKbOvfiFnc9zwlVMqvuOOZFN6caQIquxtfzfJEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkbBrHnj7U88qOZUGezrm6iGccI41woIOWsuU6h08zhE8GYIZ7KD8CHfDCUm5nre8
         iKqcO/aH3MPIIW+zCLjjQTQgzysh2EzRYdQgJc+K/sls9NRp+OIsNTOclQ6gQ+CRdW
         OeACo7Lb0+VZOCjVPSh7gpVe0ULt1f5j7f4S5z8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saar Amar <Saar.Amar@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.4 052/135] x86/mce/amd: Publish the bank pointer only after setup has succeeded
Date:   Thu, 27 Feb 2020 14:36:32 +0100
Message-Id: <20200227132236.967222687@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
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
 arch/x86/kernel/cpu/mce/amd.c |   33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1196,8 +1196,9 @@ static const char *get_name(unsigned int
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
@@ -1241,16 +1242,12 @@ static int allocate_threshold_blocks(uns
 
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
@@ -1258,7 +1255,7 @@ recurse:
 	if (!address)
 		return 0;
 
-	err = allocate_threshold_blocks(cpu, bank, block, address);
+	err = allocate_threshold_blocks(cpu, tb, bank, block, address);
 	if (err)
 		goto out_free;
 
@@ -1343,8 +1340,6 @@ static int threshold_create_bank(unsigne
 		goto out_free;
 	}
 
-	per_cpu(threshold_banks, cpu)[bank] = b;
-
 	if (is_shared_bank(bank)) {
 		refcount_set(&b->cpus, 1);
 
@@ -1355,9 +1350,13 @@ static int threshold_create_bank(unsigne
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


