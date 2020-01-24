Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A15C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C592077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="VobvKElH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgAXJSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:18:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37806 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbgAXJSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:18:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so800568pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 01:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uoir3FU1IATnUXQrOYdmalxomb8X20fURMYPZxBipaY=;
        b=VobvKElHW8c+ugq9B4n68RMGbkRbcC2SFUIltlHzEGYSmtLvBQZgPl2fpMg56byHPW
         N9xK2GXsqQqaRxpqwZmmQwVYBEofacH9Tc/tt0wzwaFaxHJzauZhEmtHJS8M78rBOWNf
         lNfgCbTXGrW5xE/pjDZ8PilqiD5xawxRBNVVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uoir3FU1IATnUXQrOYdmalxomb8X20fURMYPZxBipaY=;
        b=pQHQrPogCJknBdiVaYbtaOKzktKsU3mMLqxQdL9lciYKnwxOexBrim/U0nzu72a6dw
         kj3EzJLLdaplQ1QoI/7+N2WpjTtvY9oHWL+UNpCEr0OUBq7A8e6MzP2nQJCoz+zxTdjN
         vdXHrBTdJmpxyWFDQIM+o1CZF8kRtOyLypv+YKFaKKjjnC3FLmQu1bAYAOG1FFFO/bxu
         Rs3p7ACdD38+djh9LUkhFrIfxEP3x8gaF+himk7gcxLN9rcAZrLG9DutgoATMrXLYeQJ
         jFXSRpuK9ZgmDMcYof5H46E9VA0g7a6ZDbMqYTlf7tgdJQWdxEXSucgiQ7ItkIa3vx4r
         qPoQ==
X-Gm-Message-State: APjAAAW/2LhcBCHx6zh/6ffN6DdnfWElRxobEDxV48x+7ZX0Z31danF8
        Khop0xiYIqctx66XFbpGtvG4l7XrW6D2dQ==
X-Google-Smtp-Source: APXvYqydz/Qdpb5HbTAO2x2OE/gDtHDX0c3YRX9HY+7ZkT0Y8bfZkdkkGtEh723330PPVQixxzaq3Q==
X-Received: by 2002:a63:215f:: with SMTP id s31mr2880124pgm.27.1579857480743;
        Fri, 24 Jan 2020 01:18:00 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id y14sm5459507pfe.147.2020.01.24.01.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 01:18:00 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        christian.brauner@ubuntu.com
Subject: [PATCH 2/4] fork: Use newly created pidfd_create_file helper
Date:   Fri, 24 Jan 2020 01:17:41 -0800
Message-Id: <20200124091743.3357-3-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124091743.3357-1-sargun@sargun.me>
References: <20200124091743.3357-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than duplicating the code to create a pidfd_file in kernel/fork.c,
use the helper in kernel/pid.c.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 kernel/fork.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 080809560072..181ab2958cad 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2106,14 +2106,12 @@ static __latent_entropy struct task_struct *copy_process(
 
 		pidfd = retval;
 
-		pidfile = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
-					      O_RDWR | O_CLOEXEC);
+		pidfile = pidfd_create_file(pid);
 		if (IS_ERR(pidfile)) {
 			put_unused_fd(pidfd);
 			retval = PTR_ERR(pidfile);
 			goto bad_fork_free_pid;
 		}
-		get_pid(pid);	/* held by pidfile now */
 
 		retval = put_user(pidfd, args->pidfd);
 		if (retval)
-- 
2.20.1

