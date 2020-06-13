Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D80EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E241E2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6JHOiis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgFMP6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgFMP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:01 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8718C08C5C1;
        Sat, 13 Jun 2020 08:57:59 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id d67so11702120oig.6;
        Sat, 13 Jun 2020 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3fkRWuLq6+3r3FRM5BKr4ZrcbUi86ZtMrjt9QL9MxE=;
        b=f6JHOiis/ShOrmQ2Kgk7Im+vIkR7a6/pbjbIOKI0NRFK/FiSwa5vRnU5t+AfoUdwy1
         H7QBxMNAwrdLP9FD/B1X51cgjbsWk20zhVURc37htRApbG/OpJkVP2EkM1gQR/iOSm1Z
         YxXLUt7jwBFa0JZlG2J2IKRMH94r7wsEJJ8ShVC13ORty/nCuuOqmsxrQGoQyqstBOFX
         xfdS/A2vakOcinpFgR4hwY3rZDxgkOcj4B13ju8uK5gYbOz8bwpFkfnMOdI2ux3htzc4
         87GqYclQJVnf4R9wXi3MvbZHeEjNsU6DRrb9bSbJ0xBAYlz+Um378fqhk6W126xAWIiG
         rMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3fkRWuLq6+3r3FRM5BKr4ZrcbUi86ZtMrjt9QL9MxE=;
        b=PFIF4l+N4W8XjrBEltTa3dtxFPWBkRsZsU2N6NcXSnbWllq95Sq4E1iH9fHqT0IQuw
         w9w3DoxN0q+25B/CIMd87s3jrnYHxvmDQWDiyM717ZdZIqQJNMO6NTsJAXwWTVA6t1sV
         8ZkLKkaI9TEzKvKMZqFXW401ioSRhefryuCOzFxHJcKVQQ7H/d9Vt+NE1N27pbLeIOlI
         9XJFvzbaF9oQYcGMi+lGIKqT9b9wnL+XItXSKemAdhHpC7j+BYV2v7wWl8Pmi7o9x0hR
         EmWIJEIgKkCb2uBz4MmovCc+OfesMgpdIAz74OVpUVDY3MhrJ7sWRGhnS1Xs/xxze/wt
         22mQ==
X-Gm-Message-State: AOAM531cz05ZkOnGI6PUrVFbWT5dgua0EpfhRacq357TDI+mvfypq22Y
        9zcgEQiFtDKQM2qJ9gyBujTVefnwKEQ=
X-Google-Smtp-Source: ABdhPJzY53wnKlmp4zsI8uk/OAJYuSsQ+Qo7XUn74cWjjXL3GXsy+2JCwhI0OPz38k13v+MPZIinAQ==
X-Received: by 2002:aca:5496:: with SMTP id i144mr3002917oib.111.1592063879263;
        Sat, 13 Jun 2020 08:57:59 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:57:58 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Petr Mladek <pmladek@suse.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org
Subject: [PATCH v2 02/24] dyndbg-docs: initialization is done early, not arch
Date:   Sat, 13 Jun 2020 09:57:16 -0600
Message-Id: <20200613155738.2249399-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since cf964976484 in 2012, initialization is done with early_initcall,
update the Docs, which still say arch_initcall.
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 57108f64afc8..1423af580bed 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -250,8 +250,8 @@ the syntax described above, but must not exceed 1023 characters.  Your
 bootloader may impose lower limits.
 
 These ``dyndbg`` params are processed just after the ddebug tables are
-processed, as part of the arch_initcall.  Thus you can enable debug
-messages in all code run after this arch_initcall via this boot
+processed, as part of the early_initcall.  Thus you can enable debug
+messages in all code run after this early_initcall via this boot
 parameter.
 
 On an x86 system for example ACPI enablement is a subsys_initcall and::
-- 
2.26.2

