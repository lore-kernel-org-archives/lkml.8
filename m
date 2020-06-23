Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD6EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE83D21582
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945295;
	bh=uDoUTuSweY20y+WCC77CPMHgMs54YCGcByNkS1bu3bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZYh9ju64T7g7m5xsjbB9s9MQAfhww8Xqk0JD49qYPTipmseiNejPqHZ0L2sKZnD93
	 ejRqt8rEZ9Ti55u3hHmtiABoh8BfS2jKn0CIsp9gpvnHBYGbCqOeuE+Ks9dlpPagDc
	 N0FNnz5DfyDKIrw5leK1EtF1jbu1mGUp5qP/2ALM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404106AbgFWUsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404097AbgFWUsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:48:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EE8221548;
        Tue, 23 Jun 2020 20:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945290;
        bh=uDoUTuSweY20y+WCC77CPMHgMs54YCGcByNkS1bu3bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4iaoOxoghO24Jk54nX4jZW8Ur0QxzrUf82Zsfzqh8rHjqkA+qFjrPXbyle94Yf63
         DNrMNWFsYTr8QpBeibpWCH3xJBOwM0VLcQHszn5WH9eX8WMZVDYigWVr6w/5Sr5P9j
         eto0p2BvWaDy55Jw5wgaKJTHZpkJ0w1QjYEgG4qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.14 114/136] selinux: fix double free
Date:   Tue, 23 Jun 2020 21:59:30 +0200
Message-Id: <20200623195309.411856720@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

commit 65de50969a77509452ae590e9449b70a22b923bb upstream.

Clang's static analysis tool reports these double free memory errors.

security/selinux/ss/services.c:2987:4: warning: Attempt to free released memory [unix.Malloc]
                        kfree(bnames[i]);
                        ^~~~~~~~~~~~~~~~
security/selinux/ss/services.c:2990:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(bvalues);
        ^~~~~~~~~~~~~~

So improve the security_get_bools error handling by freeing these variables
and setting their return pointers to NULL and the return len to 0

Cc: stable@vger.kernel.org
Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/services.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2736,8 +2736,12 @@ err:
 	if (*names) {
 		for (i = 0; i < *len; i++)
 			kfree((*names)[i]);
+		kfree(*names);
 	}
 	kfree(*values);
+	*len = 0;
+	*names = NULL;
+	*values = NULL;
 	goto out;
 }
 


