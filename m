Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1C7C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC51208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hkvx/Wix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgBTPR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:17:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53681 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728079AbgBTPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582211875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H6BruQnFBwNb5cCVI9YyRz/YJpU0LA0uIbUnirbUfIk=;
        b=Hkvx/Wixz4i+zYpRIukWhWkjkLZ/5RG/IeXjZn8j1ksLMy6BAAzP1t9tUCmQ58k1yCK1sA
        3PH55uwFkt2ULSOK6+WfIfpT4zgENNpnnjL7JJ9aoV7t7MJsjzeiiTdfFUUofKpfANMr0K
        l6zklVyg0OtWvuSabadF+P8Yhxk8W6c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-vBsGY5L6O4-Gy83Mp8AEbg-1; Thu, 20 Feb 2020 10:17:53 -0500
X-MC-Unique: vBsGY5L6O4-Gy83Mp8AEbg-1
Received: by mail-qv1-f72.google.com with SMTP id s5so2746832qvr.15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6BruQnFBwNb5cCVI9YyRz/YJpU0LA0uIbUnirbUfIk=;
        b=MrkMQsMnVuiVKQ6TycuSHvejXsPwLf+fkAkmZ2JLKaqOYKOkM8dq86vxJG5SJFz8Cj
         iJYHrYq3GnIvmi7NzfKbSDbzMJlFaN6qdAYAIknmlo+p1sZnAGbYEha1TudlntKrrFvq
         S8XV4LsQiVtJGEkvt12HUxyFlZIBf2VmdV2+6CANvb50CfFnNpMloyLsJG2Tjxmw7k7R
         AyxJHU3K9n1A4z3PDfKownXcyAXPzwznyuM0rry6fO2CJRrGz8NTgag5OTj7PfT+eWUB
         zQ1wibHgBZBVp99o8TphJXqAfBNYvS0CRM3DvbgRnaFYRvzaFlTym731mM2CpXL+QuRM
         kM3g==
X-Gm-Message-State: APjAAAUz3E7cvXuDpw4h7VclinCmXibnbhYsCef2ZM6e7aXA6g+Fn/VP
        RQgL0nFtpB/ESLxpO5EH7hwuXmFEaWmmieFJk5TP1yPVj5oXZpLladKrz2Go7ZVg7ie6UjyBFsO
        4P+y/1n2z/W6T2sKSxqhyLJJ5
X-Received: by 2002:a05:620a:125b:: with SMTP id a27mr26970116qkl.203.1582211872521;
        Thu, 20 Feb 2020 07:17:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwqO2G7dbzhE328n3HZ6pRhOEszZFVHUuOrAHv6gOJjkLe/pbKZn/TU4r4dFq5UbN7tw8l1/A==
X-Received: by 2002:a05:620a:125b:: with SMTP id a27mr26970077qkl.203.1582211872261;
        Thu, 20 Feb 2020 07:17:52 -0800 (PST)
Received: from dev.jcline.org ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id 82sm649897qkd.77.2020.02.20.07.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:17:51 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
        "Frank Ch . Eigler" <fche@redhat.com>
Subject: [PATCH] lockdown: Allow unprivileged users to see lockdown status
Date:   Thu, 20 Feb 2020 10:17:38 -0500
Message-Id: <20200220151738.1492852-1-jcline@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of userspace tools, such as systemtap, need a way to see the
current lockdown state so they can gracefully deal with the kernel being
locked down. The state is already exposed in
/sys/kernel/security/lockdown, but is only readable by root. Adjust the
permissions so unprivileged users can read the state.

Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
Cc: Frank Ch. Eigler <fche@redhat.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 security/lockdown/lockdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5a952617a0eb..87cbdc64d272 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -150,7 +150,7 @@ static int __init lockdown_secfs_init(void)
 {
 	struct dentry *dentry;
 
-	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
+	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
 					&lockdown_ops);
 	return PTR_ERR_OR_ZERO(dentry);
 }
-- 
2.24.1

