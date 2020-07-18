Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64061C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448692073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhuSdnho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgGRQwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 12:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGRQwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 12:52:05 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEA0C0619D2;
        Sat, 18 Jul 2020 09:52:05 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l23so3764976qkk.0;
        Sat, 18 Jul 2020 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XdEluW/746NqBXt9yMW4+jjqpUNSxP0XQYZLsKkqYqM=;
        b=AhuSdnhoLrYjgBKs+jjZX9Lj/G+27dP5I8edq2ddJVPW4kmegwlPo7N5kJ/opW9aZO
         DHuoYJNrY9V1v2wlhPwxA00Euuc+SUDpeWgU6PB4FPFpeVL7Uuz3fwhKQ0Hi90mo9QEh
         hUJt7ftHeR/QONe9OUBTzkfWup2OQppiQQ8MHtRQkUomfzFtpdM1VIQ3DI8oBPllvJDt
         jBBIIxrSiq9rRorR8kToPYok081sbARPC5UgrI8lpDaOM+2otxlS5gEHFJQMNt2aWSvo
         qQkYNahy8jViHwuyET/yYC0o8i6giPdt8He3+z5rAJELSniTcZDAr6E7yAIy9fQmec4Q
         CI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XdEluW/746NqBXt9yMW4+jjqpUNSxP0XQYZLsKkqYqM=;
        b=H1pUe+jUV38tJF2cxcoKbPUkCON43OsYnJ46UrPwFKR+gG3jo34dKiLdFXJMfxMOW1
         m/ISixK2iw3zXFQbDvWMaDJ6oglsTnUM/BxkZL7sW9DrWx9ag1YAu1NunlSs50tUjzCn
         wP42sx7m27+MW5vY6C8RV7JTUI1wg2PncWpGFzjdizPFI0E8Z03u7Eg8gm2DmkhOMee6
         sWJl+kwHGXSSO10DYi4qqs6CHFk85ktmNBFVO4Yv1H4M88oZQxs5Lm5zJtC7grLG8Tw4
         wz7CPCZrFh5QkU4VMorQN2NIGWUX/wFk1TpWsZa+5a1XZzNjqROSYaPiqoGuEF7QySol
         B1Aw==
X-Gm-Message-State: AOAM531i0m+z0dhvcdlVrwEw6KzAFj5AIdRPNaDTWc4O1C70B7Y7ahLE
        FA0vu90Ta/wbtnWSZOWKBD0=
X-Google-Smtp-Source: ABdhPJyknxrgAaOuaXy5QUEQQlacHPoArpNhy/nP0nz8Zovr4n10S/Zo3vJ8ynRqPsGP4D8z5DFxcg==
X-Received: by 2002:a37:b941:: with SMTP id j62mr13847107qkf.233.1595091124996;
        Sat, 18 Jul 2020 09:52:04 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:602d:16d:d038:1a92:190d:65d2])
        by smtp.gmail.com with ESMTPSA id q5sm15361801qtf.12.2020.07.18.09.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 09:52:04 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, mchehab+huawei@kernel.org,
        j.neuschaefer@gmx.net, shobhitkukreti@gmail.com,
        rostedt@goodmis.org, mhiramat@kernel.org
Cc:     "Daniel W . S . Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: admin-guide/index.rst: Add pstore-blk.rst
Date:   Sat, 18 Jul 2020 13:51:03 -0300
Message-Id: <20200718165107.625847-9-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718165107.625847-1-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Fix the following warning:

Documentation/admin-guide/pstore-blk.rst:
WARNING: document isn't included in any toctree

By adding 'pstore-blk.rst' to the index

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 58c7f9fc2396c..ed1cf94ea50c2 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -41,6 +41,7 @@ problems and bugs in particular.
    init
    kdump/index
    perf/index
+   pstore-blk
 
 This is the beginning of a section with information of interest to
 application developers.  Documents covering various aspects of the kernel
-- 
2.27.0

