Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75804C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593EA2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbgGTQXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:23:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35007 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387905AbgGTQXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:23:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id q4so20959929lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wuyYMorTCCTA+H9Rs20Q97XbYGdbTwxjgGpl65WNYw=;
        b=qetmZYaXoFQKnCswkBxDV/Q4hu+2x72N5BXjmFcBj2S1dOHIds4vBR5aEn1WAhIbp5
         NCw78JH73x/U9aTXCugUaHCDhuzJAR0JlsJGIdQV5fDayR5YvCpf/fjZOemDlIPyiQFf
         78dB1aHnG0+aijD5I/wokk0Vphl9rUyCGd+eAW6iIY8ZPh8paYts2IuFqnzwC10z+hci
         x2XZoLxPkUVm6joAk3BEdZeNi57VkogB2H4aaMuhNPTMNGuhzQTlNFD3TKoWzxulspb3
         uzYkW5WyH5Irw6PkEraCkywtvKIFLmNCiIgPDA3Jh0o7chTlavwwbDgc00auerQf8QEo
         O7Xw==
X-Gm-Message-State: AOAM532vl8ZMiNpSJxxyTiZxTlBi4rUtT4uiHh6Jmxaqk2i45ox1L4MJ
        PuExJ2rmX1L16r0UzcJt4OY=
X-Google-Smtp-Source: ABdhPJwtuvD0JnLUZ74IJSS/UopcAkQaN3dcV/vkq3tMTs874syqhMAmZqLdcLgbz57nt9UeIk+bUQ==
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr11527773ljc.141.1595262180283;
        Mon, 20 Jul 2020 09:23:00 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id a19sm925855lff.25.2020.07.20.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 09:22:59 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] coccinelle: api: extend memdup_user transformation with GFP_USER
Date:   Mon, 20 Jul 2020 19:22:14 +0300
Message-Id: <20200720162216.13248-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720162216.13248-1-efremov@linux.com>
References: <20200720162216.13248-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match GFP_USER and optional __GFP_NOWARN allocations with
memdup_user.cocci rule.
Commit 6c2c97a24f09 ("memdup_user(): switch to GFP_USER") switched
memdup_user() from GFP_KERNEL to GFP_USER. In almost all cases it
is still a good idea to recommend memdup_user() for GFP_KERNEL
allocations. The motivation behind altering memdup_user() to GFP_USER:
https://lkml.org/lkml/2018/1/6/333

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index c809ab10bbce..0e29d41ecab8 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -20,7 +20,9 @@ expression from,to,size;
 identifier l1,l2;
 @@
 
--  to = \(kmalloc\|kzalloc\)(size,GFP_KERNEL);
+-  to = \(kmalloc\|kzalloc\)
+-		(size,\(GFP_KERNEL\|GFP_USER\|
+-		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
 +  to = memdup_user(from,size);
    if (
 -      to==NULL
@@ -43,7 +45,9 @@ position p;
 statement S1,S2;
 @@
 
-*  to = \(kmalloc@p\|kzalloc@p\)(size,GFP_KERNEL);
+*  to = \(kmalloc@p\|kzalloc@p\)
+		(size,\(GFP_KERNEL\|GFP_USER\|
+		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
    if (to==NULL || ...) S1
    if (copy_from_user(to, from, size) != 0)
    S2
-- 
2.26.2

