Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273DFC54FEE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B4824656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813317;
	bh=8dJc3VjqGnWWFG3e8ysCnj4VZcKV3ZJX84/9oq8ZYP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kPKekY1AEwVPISjQzBUjZIsEpo6FlVy7k97ZMmwypHrWO6oZNQO6xLsWpRsCRprdf
	 0gSs1wJBrlWioxnVMm1g83bEu/9S9mJnMyERGtvjjddQnB6oBL/wnt7bSF8QerZpwo
	 lxZTHR43u6d+NztteGOovsTQ6rLgGvISopAJK9Eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbgB0OQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:16:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389446AbgB0OQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:16:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF802468F;
        Thu, 27 Feb 2020 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812971;
        bh=8dJc3VjqGnWWFG3e8ysCnj4VZcKV3ZJX84/9oq8ZYP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLuz1sE3haEaIvcnw+y+V1safsUnRWq8HGVjjlpptr/snF6IKcmHlYc98FRENsP1L
         MKlQK4IMEXZxZmOeJKwLtKLQVZv9M6VI7Zl4Ni2NC8wNFkvhbyUZUJ0E2ZOIIldbVT
         CxJshZJv1FeW4sKtTguP4sURl6o3XWRhoOPqcbV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 5.5 086/150] sched/psi: Fix OOB write when writing 0 bytes to PSI files
Date:   Thu, 27 Feb 2020 14:37:03 +0100
Message-Id: <20200227132245.564108676@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suren Baghdasaryan <surenb@google.com>

commit 6fcca0fa48118e6d63733eb4644c6cd880c15b8f upstream.

Issuing write() with count parameter set to 0 on any file under
/proc/pressure/ will cause an OOB write because of the access to
buf[buf_size-1] when NUL-termination is performed. Fix this by checking
for buf_size to be non-zero.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/20200203212216.7076-1-surenb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/psi.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1199,6 +1199,9 @@ static ssize_t psi_write(struct file *fi
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
 
+	if (!nbytes)
+		return -EINVAL;
+
 	buf_size = min(nbytes, sizeof(buf));
 	if (copy_from_user(buf, user_buf, buf_size))
 		return -EFAULT;


