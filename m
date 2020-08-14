Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5126CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1672078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/8PGz1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgHNQIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgHNQIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:08:14 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55856C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:08:14 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b22so8543889oic.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ozzh4PLPN245u92lvl7XjkUwm2Bo37ddHW9zGpTVuMY=;
        b=G/8PGz1IhMp8mDwV/gMXAXoeG3jgEhSNc8QKj9Xvvzhk5X7jGb5WKZtaHZErm9IxmE
         gjn57F0TsICdU9Buo+nysg2b+O5pkYlkWmwFRUPr4QnX2zK4x6iSYeEBysTnRyG0aps+
         1JZQMDxlXNyv1cRghkUVc+ODOXO+7+lNgoM8FlySZWf/qLDsgINdO5+kqPldY/AclZYi
         hWvmgMuhVtjUe1Szt9kBfXeB95crFf4cQD81LHXJriK6v8R0uqNSelPqIKIBn4798Y/3
         8I3bALnAeLe7KDVvi9WwHCLolAf1HivV8RwBfU7LxvAZmyVl4vAgQObKpgI93zkQn3xK
         QFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ozzh4PLPN245u92lvl7XjkUwm2Bo37ddHW9zGpTVuMY=;
        b=gf3ZhKnRpl17iQkKiqkljgcUs5kc6JCR0KWkC94wQCOJXsg0nfU0KLzNVP2kTlVxZc
         iB96w4hB1gca936tsWD47VSKjfsj+bL/Q2yGgAdz1GykAm3dHTabUZjyQAmHc2Xw0PpM
         /Pu/v1rRwk3q6ZnDJMvA0d7WxenEgpBO4ETtN6i7lF839Iantnohq11eh5dRUqmPGfTo
         zlGVKKAtkRmdxJmqLbv7CLJTQhD9gctAKpulp67Xe7UhGXE6BoaV8u3ich6z7111OPll
         Uwv3xDH7q94wZZLCbDlrjpt+Engg/W4FLE43YjqB6rN/WL/WfxpMlnNcmMaijrqxeW92
         s2uw==
X-Gm-Message-State: AOAM530xQVUzXD3Qx4QRVmh+9dFQaqNMn6wWpAmYUbkLo/TNpB0DjmxS
        JD7xWMqvLhRSQSe8FQjlkHU=
X-Google-Smtp-Source: ABdhPJzqfS2RfjQj3Tt2uYxOE+d0kSNpMqHtnmV6LdQRQhuqs2cto6Hhs1HVfw8VDyHKXSv8AyCbug==
X-Received: by 2002:aca:4cce:: with SMTP id z197mr1862644oia.118.1597421293754;
        Fri, 14 Aug 2020 09:08:13 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id 143sm1900648oie.11.2020.08.14.09.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 09:08:12 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/2] dyndbg: add decl for exported ddebug_exec_queries()
Date:   Fri, 14 Aug 2020 10:07:59 -0600
Message-Id: <20200814160800.3298765-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814160800.3298765-1-jim.cromie@gmail.com>
References: <20200814160800.3298765-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

59cf47e7df31 dyndbg: export ddebug_exec_queries

elicited a sparse complaint.  Add declaration to header file.

I skipped the kerneldoc for now, unsure where it should go.
Ive seen it in .c files, Im leaning that way.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index aa9ff9e1c0b3..61eb80c726bf 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -6,6 +6,9 @@
 #include <linux/jump_label.h>
 #endif
 
+/* exported for module authors to exercise >control */
+int ddebug_exec_queries(char *query, const char *modname);
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
-- 
2.26.2

