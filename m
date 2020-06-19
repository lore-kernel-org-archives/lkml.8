Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A126DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735A5206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581047;
	bh=YU3kO4xL3qaPihHEix2qNmzom9gZ1iPwN0l/h3Y3dOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jYe6oupKQSJmfwWB0xDXZrHFrKVBsPN57v3Ypu+hJof4KG4RPm93UJ5Jx1I4qOMCc
	 VLU7Oc/c+Iysh6PdsOLTfN0Qh1VGXwr+NV0tA28xCV4Ph7QIbjWh4yQOGVc6xnLNnQ
	 78y+nnISYgKTv2SrURagojaeDBaRjC3ha36iyYJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405130AbgFSPh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393565AbgFSPaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:30:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895FC21974;
        Fri, 19 Jun 2020 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580614;
        bh=YU3kO4xL3qaPihHEix2qNmzom9gZ1iPwN0l/h3Y3dOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kc9y7ABLqLWZ8EcfQ1o6qDNldvjhHg0beTtnmTNthJUCoAE+FcQ41PiBMreWCDNw+
         RDl6ek/6+WymIYIHIKWaP++CGRGQAxRs5je86zjcj6hINdQfa8fNpHO3tcOlat1Qwo
         IJWZ4kTPyZrwptg7+O3bBHCDsebFgQoD9JTyjPF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 5.7 276/376] ima: Directly assign the ima_default_policy pointer to ima_rules
Date:   Fri, 19 Jun 2020 16:33:14 +0200
Message-Id: <20200619141723.400024064@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

commit 067a436b1b0aafa593344fddd711a755a58afb3b upstream.

This patch prevents the following oops:

[   10.771813] BUG: kernel NULL pointer dereference, address: 0000000000000
[...]
[   10.779790] RIP: 0010:ima_match_policy+0xf7/0xb80
[...]
[   10.798576] Call Trace:
[   10.798993]  ? ima_lsm_policy_change+0x2b0/0x2b0
[   10.799753]  ? inode_init_owner+0x1a0/0x1a0
[   10.800484]  ? _raw_spin_lock+0x7a/0xd0
[   10.801592]  ima_must_appraise.part.0+0xb6/0xf0
[   10.802313]  ? ima_fix_xattr.isra.0+0xd0/0xd0
[   10.803167]  ima_must_appraise+0x4f/0x70
[   10.804004]  ima_post_path_mknod+0x2e/0x80
[   10.804800]  do_mknodat+0x396/0x3c0

It occurs when there is a failure during IMA initialization, and
ima_init_policy() is not called. IMA hooks still call ima_match_policy()
but ima_rules is NULL. This patch prevents the crash by directly assigning
the ima_default_policy pointer to ima_rules when ima_rules is defined. This
wouldn't alter the existing behavior, as ima_rules is always set at the end
of ima_init_policy().

Cc: stable@vger.kernel.org # 3.7.x
Fixes: 07f6a79415d7d ("ima: add appraise action keywords and default rules")
Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/integrity/ima/ima_policy.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -204,7 +204,7 @@ static struct ima_rule_entry *arch_polic
 static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
-static struct list_head *ima_rules;
+static struct list_head *ima_rules = &ima_default_rules;
 
 /* Pre-allocated buffer used for matching keyrings. */
 static char *ima_keyrings;
@@ -765,7 +765,6 @@ void __init ima_init_policy(void)
 			  ARRAY_SIZE(default_appraise_rules),
 			  IMA_DEFAULT_POLICY);
 
-	ima_rules = &ima_default_rules;
 	ima_update_policy_flag();
 }
 


