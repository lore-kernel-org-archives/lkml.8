Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5727FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333342071A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rY7aGYuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgFQQ0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:00 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF59C06174E;
        Wed, 17 Jun 2020 09:26:00 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u23so2079978otq.10;
        Wed, 17 Jun 2020 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ps1bO1kQHItdDmcSsrlnZa+L4139j2nCHXNY+hwPMZE=;
        b=rY7aGYuyvGNoUcTS7ONAtIYM5RurX0RW/QQNDXRPImZ8Ns72rgQ+9lL89BY04XrgP8
         NNsTigo+RUdiNYGJ3DKTqgVKZWlUI1F6mARW2PfatGc5JfNaJyTdpgIlqVG4MfBSW4/3
         KYkPLhiJGh9qTplV+grMuX7YOwoVxqsE5xkw9Y2fE/G77K+JJKzFjqt9Xts7Q5JccKIG
         P2NJ+t7LS60oBQzECRupva66jKa2HFQUVaswXz4J+4Gu6a+u9ItOkBolT8izkaKMaW9k
         Mm3LhOtuS7tgqHnvQRYS5hJff6MAG+ihe+Nq8SkOi/RNVjPom0DaCE5ECGbigalUmueg
         s9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ps1bO1kQHItdDmcSsrlnZa+L4139j2nCHXNY+hwPMZE=;
        b=fWbUqSV+pOtjI3qyncvSEIuJX2zbKL2L4PfiXfuM+vQWirddp4X+MYkU0PjNige+8E
         4nh7uGLrOISqc/FAGQgBSOMpA6Wi/PLXcXDYX2ohwO29wR4hjuIuxOCNaGQmoLgpYrBU
         cxf9w+5a5XYMny0UEcEySPNR4+Dt6wjToSuFfsRj2OZvmondKlZuAh7Hiv+K6/Zh7IT4
         qQkDa7KXdp7SCbjmKzPkmSwh4DnUmBoxmKm602gbAiK9oEOMRfVthNZkNb4P6l3eHFHb
         tswDltOAbghvo7aIQ5Ed0Ygh8pzuOBtzyXp74/JuN8Tb/fXL3c2080+GWL1G5b4ujXyR
         A0QA==
X-Gm-Message-State: AOAM532eS150PFGj53ZomHOldHgPN7jgogt7VS7Ib9R0ptqjkmzHsnNP
        j8rJF1NYInqDa/iwW1GZgXY=
X-Google-Smtp-Source: ABdhPJx06rIE7+OLPegglj+QtfIReATt29iqjezv+3U/G3UzLsUWDwl0LUmNk6PX8CsR4sqcS4bEcw==
X-Received: by 2002:a9d:22aa:: with SMTP id y39mr7326189ota.76.1592411160154;
        Wed, 17 Jun 2020 09:26:00 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:25:59 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 02/21] dyndbg-docs: initialization is done early, not arch
Date:   Wed, 17 Jun 2020 10:25:15 -0600
Message-Id: <20200617162536.611386-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since cf964976484 in 2012, initialization is done with early_initcall,
update the Docs, which still say arch_initcall.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
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

