Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31964C35246
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8A7214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TgtQby4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgBAABN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 19:01:13 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:53731 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgBAABN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 19:01:13 -0500
Received: by mail-ua1-f73.google.com with SMTP id 35so2193242uaq.20
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 16:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xCsmu4aj8EN/ECCHKtP+kWyAhx9ybdR5E/pP0+fGVsg=;
        b=TgtQby4eRqpgOeGBlTU4dTD9h1ULNYnndcMLety++EJ4HQjpz37LvWy5bzeabDJald
         un27UOLZ+XU1TkH8XBnm61cmDpNZ0vd7CIuKCla88JAqJUDjBYc768VJ9Ej3fM09iwIo
         2eIu8RVWOLsNMFvgBfBJn403Fb0kpJhMdD/MymRVosVO0fYldLhc9+kpv2Et0I5J4XNF
         QQLDhJRoZI08J6f7Ejp32X6v0T40f92d3OCkfw+OzB2vtpocZbBZdC52jfBH7gYU4CSj
         RCdQzPXpp/cL2UbtO1M77KJglkXTizVM32CBPRw14l09uchxQqiE2ibVw59vA+ltW+b2
         iB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xCsmu4aj8EN/ECCHKtP+kWyAhx9ybdR5E/pP0+fGVsg=;
        b=gdoVp7LkRJE+kD+AF6eOoETSg+jmJvNCTlqJOKqFkgL9qmNTNyq+C6QYH1OSrxah+G
         LzWvrXCzuMz1T+WsG0O06YCeWdIQs55Kjov9DsLu+RqQ96zIbiREPmFT/3Gjun/AfolL
         gAhRE3OkehRg5TIEjtBAv+si8ftc9EiAXZgjY7qUgkmpaZJshh/HwIFBxjM7tYZ6Gyn1
         azSL6d9qfCnh5a5Y0MQ9vmNyj7S6lAdDlcF6WiNVI80Hc40TZjeQBjfCsuve/61RIqlv
         rmF6TO7MMta40WgDQsaqBbMewat6DUYzxclL2XebZaSsmMYBoM0MojTboHaUBkY2zRXp
         Kwrg==
X-Gm-Message-State: APjAAAUuHF59Bih9si+nSUntthZJ71hkp8B1Eq8dHIWXIk9cqJ1eD6sP
        jtguCZzeWUsB06tDJmv4yTIkaG3S7o3GuSKpYTEnUA==
X-Google-Smtp-Source: APXvYqxlrR68AJPQzIEvwHccod9/5UKO3hKIkgEkI9aMx1JBOe57PrDtQ41vCE3bZBQcm1E2nsuDWstTBUfbyFdGvDNwUw==
X-Received: by 2002:a1f:d5c5:: with SMTP id m188mr8311853vkg.7.1580515271831;
 Fri, 31 Jan 2020 16:01:11 -0800 (PST)
Date:   Fri, 31 Jan 2020 16:01:02 -0800
Message-Id: <20200201000102.69272-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1] Documentation: kunit: fixed sphinx error in code block
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, davidgow@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a missing newline in a code block that was causing a warning:

Documentation/dev-tools/kunit/usage.rst:553: WARNING: Error in "code-block" directive:
maximum 1 argument(s) allowed, 3 supplied.

.. code-block:: bash
        modprobe example-test

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 7cd56a1993b14..607758a66a99c 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -551,6 +551,7 @@ options to your ``.config``:
 Once the kernel is built and installed, a simple
 
 .. code-block:: bash
+
 	modprobe example-test
 
 ...will run the tests.
-- 
2.25.0.341.g760bfbb309-goog

