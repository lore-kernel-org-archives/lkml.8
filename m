Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5D6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8122E2415E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVrJSweq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgFTSIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:50 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:37575 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgFTSIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:15 -0400
Received: by mail-oo1-f68.google.com with SMTP id q188so2552755ooq.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HhcAoXPW7ZRiM/8Q3ygWBvgF6djv95EaVmKQGesqI94=;
        b=LVrJSweqFDE8nI+TCoqMv9kLa+tcLbhtQxp9cpuM5sSKIuS/ORD16ikAeTQp3tnhlP
         ekwqizkOPVv9tsyXEspw0yhlTJGVnCYQERSK8uRfiJUe6YtAObMFNB/hUIubPfk1yJHS
         qkjG6JeAVHBJUdMtePJcb3oTWEtbjZQKYzpACjSf/8Wte0DmDXJ3T6/hYOO7bZYGWIaS
         iGxc1AIBA9X9JpglXXOUmagUBXFfEbBS4jMG62qX7a8k5M88+3qWW6lqzolDKdgEw6px
         mLNPOrwHhutG2aWargqukVxyEBWerzwfCkSguTX79zf50FIZDzXG8fRTms+jBt4aGKWb
         LCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HhcAoXPW7ZRiM/8Q3ygWBvgF6djv95EaVmKQGesqI94=;
        b=aWpKs7Zrsm/BOy9rCeNdCo5oPYWh7/abvYRpZJxlJgv0bwYUG6JUA96CAL/QHhWh9U
         8LWV4PBRgf8x/T8lz0GcomEmsSQcSqYLULGeSavdKTlMBrcB+wEZCuSoRAzxmB/URj6c
         WuKmc6IQRdxQSmja5PEVsRs1l7YOjWXLebE2PbuC1D0zOHfGd4SunHNzwiL6VCf9fbt1
         PPnpaSeD2PO6JrqC0G1XHiteSvwJ5KnfFiKmsz6AGBVQUVaf/s7hWHemnmKddZvPqKBC
         AQOiPeiRNI5zJrPf3EbEonAxEb6T6U8uxcUnYwUFVOUudhdE5Rvr4hDFu+q5sjhpRkqf
         qqsw==
X-Gm-Message-State: AOAM532EoqjcpvfuQs3IqonJe1oB0ROUpxtOUU7Clc3no3+SmRJBgVtu
        JD/fwVdNslww1DevZxDa/Wo=
X-Google-Smtp-Source: ABdhPJzyhUEl7GPRmbzS+I6gOYWSEzdeDD6My8DDJmlm5CM3e4WF/jiciwOXIk6vNS0OH7qHM9HZ+g==
X-Received: by 2002:a4a:e6d2:: with SMTP id v18mr8270234oot.34.1592676432998;
        Sat, 20 Jun 2020 11:07:12 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:12 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 10/17] dyndbg: make ddebug_tables list LIFO for add/remove_module
Date:   Sat, 20 Jun 2020 12:06:36 -0600
Message-Id: <20200620180643.887546-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loadable modules are the last in on this list, and are the only
modules that could be removed.  ddebug_remove_module() searches from
head, but ddebug_add_module() uses list_add_tail().  Change it to
list_add() for a micro-optimization.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index da3ed54a6521..e879af4e66e0 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -895,7 +895,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->ddebugs = tab;
 
 	mutex_lock(&ddebug_lock);
-	list_add_tail(&dt->link, &ddebug_tables);
+	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
 	v2pr_info("%u debug prints in module %s\n", n, dt->mod_name);
-- 
2.26.2

