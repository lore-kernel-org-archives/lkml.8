Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995612088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv187/Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGBXLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgGBXLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:09 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6788EC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:09 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e15so25780773edr.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLDxotR4LWJLM1++xc/ZIF1iQIELRIcRP3vM3vOzBKE=;
        b=Dv187/RuHleKkr5APMsWqrEflOj9aPbTlz4yGZosr2exGhwUm3q5nvpatWBlF+BQth
         nhIh1ixk1BPGuTCapo9uw1FFGkRoELKC8BgCkKU4Dfv0oWqPMFzFcZ6qIk1aVGJ/cd9I
         cJ4bUID8oQeQS8QR68/fOLU+1rBxpHrfFq3/Bs+WezCipQj8Ht6Z+B915EMljQpU0v53
         lvEpkpjuCPlSiUlP+9MB1XCUx5jbF/n225eFiniuqYqMyTc5FGURKuFgT+qi0ae21eto
         erGZpMBy4gudtGkz5Glva5SFhr4gCNhYbyh0gF5XoBpiHIwtBeIMRZ/6wy8Ui86ILZOx
         hSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLDxotR4LWJLM1++xc/ZIF1iQIELRIcRP3vM3vOzBKE=;
        b=XqLisP05eo4MBCijQgpWTQb6yD/WuNu7w2nYzy36LTt4YvouPQM3V6lT+vmqhTgp9u
         pxZ+8kWOaUyvV+H1kgy0+NwtCZkanT0Oyz5g/pkx/+7M3Tzo3qFGzLhc01KoQ3kHZLpG
         ZaJOEgnjCkslynbrMJz8VAIg+Iqb+g/wtSZal89AFkOjap7MoVuSg8fyJ3Q/e6bTgYrM
         OZMXC+1AZXmOS4lOH/GlU0+7YIOhQL7XvpCCk1rF2vkLDKegjZVgyMr6Yfvu5fiUs0ia
         DUfMvms4vysdbYa33j43WvLpGUgK6RUK80mZQPIqyJcRRfb4pVNfKAMZFZCwJnn1KKfQ
         o2/g==
X-Gm-Message-State: AOAM5310nBoGG7R7PJz6HCuGBsfLP0KlzuQ0gUzRa/LpgwjZf33lU6kS
        SIHCK+8iQdORMjC00DlMh0cYjHCC
X-Google-Smtp-Source: ABdhPJxekSHh5Q/IjZP9w2UsymdEK7UgXJqWJu2XqaTJFU9Z3K96pGdCqL6RZ0CyPvLUju0GzDV8wQ==
X-Received: by 2002:a05:6402:202e:: with SMTP id ay14mr37355385edb.233.1593731467967;
        Thu, 02 Jul 2020 16:11:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:07 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/15] options: move on top the definition of warning type enums
Date:   Fri,  3 Jul 2020 01:10:27 +0200
Message-Id: <20200702231039.55015-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to reuse these enums in earlier helpers.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib.c b/lib.c
index 5128a5b64e9e..43d55a0648ee 100644
--- a/lib.c
+++ b/lib.c
@@ -250,6 +250,12 @@ void die(const char *fmt, ...)
 static struct token *pre_buffer_begin = NULL;
 static struct token *pre_buffer_end = NULL;
 
+enum warning_type {
+	WARNING_OFF,
+	WARNING_ON,
+	WARNING_FORCE_OFF
+};
+
 int Waddress = 0;
 int Waddress_space = 1;
 int Wbitwise = 1;
@@ -523,12 +529,6 @@ static int opt_##NAME(const char *arg, const char *opt, TYPE *ptr, int flag)	\
 OPT_NUMERIC(ullong, unsigned long long, strtoull)
 OPT_NUMERIC(uint, unsigned int, strtoul)
 
-enum {
-	WARNING_OFF,
-	WARNING_ON,
-	WARNING_FORCE_OFF
-};
-
 static char **handle_onoff_switch(char *arg, char **next, const struct flag warnings[])
 {
 	int flag = WARNING_ON;
-- 
2.27.0

