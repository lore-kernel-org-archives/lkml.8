Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E44C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C7C206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lczN2dwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgGFSBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgGFSBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:01:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF552C061755;
        Mon,  6 Jul 2020 11:01:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o22so12289905pjw.2;
        Mon, 06 Jul 2020 11:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djAl3AiMl95A7tE1GRS5XYxCZQGbUXsP2I8xEBywBB4=;
        b=lczN2dwKgjJqgmZU9M4XpXNMalpvtMpGu/Oi+D1cgovOrzX6O7YWltbYZIju6O5AHg
         47dxvpu8CtZ0ky7l60tSyFAWg2S5+iMWbyjAkjmPAIH8z+MgJVf0tO/3tdjytWc25YzI
         EoyXmUvx6GpacOgSmVoVt/uL9YycNV2FAPSy62YW7/zeF67f8iJ0uuLRPvp2wt6H00n4
         h8wxgdeS5OCktiFQunqnaLSfc9U7hHhmfvRcMArDwArp8dP07CNiwSo63cYHo8mRiI1n
         Qd9why3o5/6wsMkPDHMXqPecBi7TTxtYa/AlfgjceVXvAilJ2ERBdoCDJfne/qgeNAjL
         YQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djAl3AiMl95A7tE1GRS5XYxCZQGbUXsP2I8xEBywBB4=;
        b=HdHf8bI6q8QYyovNwn+WbmC5LMtTosVUS6G/owQlrFFuh9VGOgCmH+ONEczKKIwL16
         IfE5nILZYwThTwF0MGlHc+o+AyN23160lXeb26LVfcgFvD9Tvz9cOvg5O76/IzkSSs+f
         zBrCndGsYVw2c54UDy56qDZu07CDPi6mCC/A039Qqu6kcdfboU47PobaoURTJAvn7X8V
         rl6Pc3r2TbNhb0Qv9p6Txhg9ieaRrPzvv+PxUBLDwX8kxkhL2ur273xPhqf7YM9S3Df1
         TFuWJNKjnC/+VL48wKnhZRTTPuPnKqcDyL+M/TOM+vrTiqA8KQnpw0dFQRZK1GaW6/7J
         wKzQ==
X-Gm-Message-State: AOAM5317zZFWXqIdXeMa2jfQMdSeb8SmnaBk14AF+rHKYDzFf7UQSE6D
        KRFkJ9AoDyEFi2KB4uF/pdot4MIt
X-Google-Smtp-Source: ABdhPJwUceFmVA5F4c6ztnllLeBjbpj1RuvDse72uGenn1kyt+4hf6SjsfGLcs3Ft62WYWY2llzMwA==
X-Received: by 2002:a17:902:ab8e:: with SMTP id f14mr43782566plr.80.1594058468118;
        Mon, 06 Jul 2020 11:01:08 -0700 (PDT)
Received: from localhost.localdomain ([210.56.100.149])
        by smtp.googlemail.com with ESMTPSA id d18sm133046pjv.25.2020.07.06.11.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 11:01:07 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Security: Documentation: fix: `make htmldocs` warnings
Date:   Mon,  6 Jul 2020 23:30:10 +0530
Message-Id: <20200706180010.29032-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra ')' after function name to fix warnings.
It solves following warning :
WARNING: Unparseable C cross-reference: 'groups_sort)'
Invalid C declaration: Expected end of definition. [error at 11]

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 Documentation/security/credentials.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
index 282e79feee6a..d51e42b92395 100644
--- a/Documentation/security/credentials.rst
+++ b/Documentation/security/credentials.rst
@@ -455,7 +455,7 @@ When replacing the group list, the new list must be sorted before it
 is added to the credential, as a binary search is used to test for
 membership.  In practice, this means :c:func:`groups_sort` should be
 called before :c:func:`set_groups` or :c:func:`set_current_groups`.
-:c:func:`groups_sort)` must not be called on a ``struct group_list`` which
+:c:func:`groups_sort` must not be called on a ``struct group_list`` which
 is shared as it may permute elements as part of the sorting process
 even if the array is already sorted.
 
-- 
2.27.0

