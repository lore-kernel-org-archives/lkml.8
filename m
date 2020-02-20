Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EBCC761A6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D6E24654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgBTFKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:10:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33243 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgBTFK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:10:29 -0500
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <matthew.ruffell@canonical.com>)
        id 1j4e6V-0001mr-JZ
        for linux-kernel@vger.kernel.org; Thu, 20 Feb 2020 05:10:28 +0000
Received: by mail-pl1-f199.google.com with SMTP id p19so1561537plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIhfPa7SsfRzn7vx0Oc8RqKMPZYqickShTkap1QavL4=;
        b=KDY10qxju1OCIX8RjNT9NgW6ZKa6qVHznonNOxiTDgxJQySiC7HSGF2gZXU//QL8wN
         LdjanGlvfNWHZCsa3mh8OrgSdYjs0OMOh5mmiWcv8I/E5Tylc0c/PAXA8x15EWrKmj6e
         bVMTrZA6SmirMgTEtr+4bQADLv00gPPhDpQslrxswo8Tjpquu4Yi9kcI/hb3pOy+8X+t
         1tTc2gaVbc6uSmAcH0Jm8+INwe10IDi3C1/l7auHOjQBhoqmfuK5QXhDkE3X8p3MAoX/
         9vL9P2FJJsWp3hrD4FELTNJj5xF6ySBhlaBbkRqY8F2QqZc3JWNrYtPTg5GL3/5wp3Nf
         5OPA==
X-Gm-Message-State: APjAAAVywiRRnGMTocQX8goCclEFnC0lrRMhriQhoA5h0/baxuxRWWji
        xrQ4VVQz5IjN1HdwEYZbLxpttARnMmrRcg+c5mASF6dOwKnGqp5m5Qb/Y5GYGJ8uv0eAfK2lJXC
        qLw/gOF9jbxc9R6wuXTXov7eKVUfPfE4V5Sf+uH+dRA==
X-Received: by 2002:a17:902:aa45:: with SMTP id c5mr28782369plr.113.1582175426238;
        Wed, 19 Feb 2020 21:10:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqzd1RYHnc2H+TbYIhh7aaMIbahh+S85LBctIlAD5hV6MW5gQodhvbs9eIVwtEbFUXX7FxfknQ==
X-Received: by 2002:a17:902:aa45:: with SMTP id c5mr28782355plr.113.1582175425973;
        Wed, 19 Feb 2020 21:10:25 -0800 (PST)
Received: from localhost.localdomain (222-154-99-146-fibre.sparkbb.co.nz. [222.154.99.146])
        by smtp.gmail.com with ESMTPSA id p3sm1409714pfg.184.2020.02.19.21.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:10:25 -0800 (PST)
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pabs3@bonedaddy.net
Subject: [PATCH 1/1] coredump: Fix null pointer dereference when kernel.core_pattern is "|"
Date:   Thu, 20 Feb 2020 18:10:15 +1300
Message-Id: <20200220051015.14971-2-matthew.ruffell@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220051015.14971-1-matthew.ruffell@canonical.com>
References: <20200220051015.14971-1-matthew.ruffell@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 315c692, a null pointer dereference can be triggered when the
kernel.core_pattern string is set to "|", and a user executes a program which
crashes.

This is caused by a subtle change in parameters sent to
call_usermodehelper_exec(), as sub_info->path will be set to cn.corename, which
has not changed from its initial value of '\0'. call_usermodehelper_exec()
will return 0 upon strlen() finding that sub_info->path has zero length.

The fix is to add a length check for cn.corename when we check the return code
from call_usermodehelper_exec(). This restores the expected semantics as seen
before 315c692, with the message "Core dump to | pipe failed" output to dmesg
and the coredump being aborted.

Fixes: 315c692 ("coredump: split pipe command whitespace before expanding template")
Signed-off-by: Matthew Ruffell <matthew.ruffell@canonical.com>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index b1ea7dfbd149..ca5976e81d8a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -686,7 +686,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 							  UMH_WAIT_EXEC);
 
 		kfree(helper_argv);
-		if (retval) {
+		if (retval || strlen(cn.corename) == 0) {
 			printk(KERN_INFO "Core dump to |%s pipe failed\n",
 			       cn.corename);
 			goto close_fail;
-- 
2.20.1

