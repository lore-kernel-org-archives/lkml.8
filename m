Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD700C34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8802C2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0jj166N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBRJoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:44:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35192 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgBRJoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:44:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id y73so10391721pfg.2;
        Tue, 18 Feb 2020 01:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNw/4H6/vd73/BDz9NY7P3n/SYJkPQvMSu9pnjd4OI0=;
        b=T0jj166NyIIYsZWGkA6bw1qquWK4pwEH8zNZqOrz7gRJ+w0IOg8SHBoOfGUoeSC76j
         lfwAKNKWj/CUSESKN8/p9psXJ669A8U/IK6OIufFheKUBA4oTzN8lc9Ct+VrnVf2/fiy
         EQhAP0LT5FYmOLmZ6pY3T/0epMl9QN8wX/+nbnXMzxXWTBgCM0RYJTqubzNPy1wRv3vt
         mvcnyDXROkK3qHl2irsJHU02kG6sIsUgdfyu5VuwnWMSOxriPaqvagQeInOA5PKuiuC5
         oYZFV1g7W+ePVMB/I+oWcRTtozZRhUp3wJmDISk4gyLpOQ4IM8qVlBmoa69QSOP+Gwgm
         rDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNw/4H6/vd73/BDz9NY7P3n/SYJkPQvMSu9pnjd4OI0=;
        b=jwG42tgp5LUWN8lf1OcMIP6Nfkqo3VHUwQpI6FrfgzQO/xndf1uOMBaBkUj1lx7nzp
         jkE0u+KKsjLGe0FUGceTUCCr9d9Uuz6fKVbVl6gZy8Mx5Kmezdv1OPIxY4eMhke4t64y
         O0Z3INOKw4SXtqVoAm4erUlNf15gplgEU0FMjnaIE5Fkmne8i26vz7XKYIyQQIwVvJAX
         vSBaTBMqXhdowXbLQUNFc3GakwYrQ4C+TpBkeAZSMxlfZsMTAWv/3e2sDKbb7Sy3AJO+
         tAKbQf+Ijl8n5osflEQwcymlbX78YBpbV22JHXOPQWSf8NeUGJ8gj6paXNYpMwFDk2ZR
         8Rhg==
X-Gm-Message-State: APjAAAWkvT6lZr1jWWp3cBRkzDnYsINK5rTJJDFCz+0ppeCZV963lRX9
        Qam3VzQtrLIB1z1/H1zpkINyeCGQVDE=
X-Google-Smtp-Source: APXvYqwSQovdx0x/dBbrq78/Nk3rJpBtr4ZejkKk0cG28D2d6b4sV77mnRgoiOTrXIW2YD58v8XhfA==
X-Received: by 2002:a63:a741:: with SMTP id w1mr22532136pgo.131.1582019055042;
        Tue, 18 Feb 2020 01:44:15 -0800 (PST)
Received: from localhost.localdomain ([103.231.91.38])
        by smtp.gmail.com with ESMTPSA id l10sm2457419pjy.5.2020.02.18.01.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 01:44:14 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, federico.vaga@vaga.pv.it, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] Replace dead urls with active urls for Mutt
Date:   Tue, 18 Feb 2020 15:10:13 +0530
Message-Id: <20200218094013.29806-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace stale/dead urls with active urls for Mutt.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/process/email-clients.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
index 5273d06c8ff6..c4f9dc7a0889 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
@@ -237,9 +237,9 @@ using Mutt to send patches through Gmail::

 The Mutt docs have lots more information:

-    http://dev.mutt.org/trac/wiki/UseCases/Gmail
+    https://gitlab.com/muttmua/mutt/-/wikis/UseCases/Gmail

-    http://dev.mutt.org/doc/manual.html
+    http://www.mutt.org/doc/manual/

 Pine (TUI)
 **********
--
2.24.1

