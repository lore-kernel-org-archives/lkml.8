Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ABEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DC0206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoqUB1SW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgHXSyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXSy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:54:29 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10DBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:54:29 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k4so9245509oik.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5taqwMO9fu02Eq/oSradLpdwhpBHOZ6HATVQFj48PwQ=;
        b=CoqUB1SWL/QucznPZlWHZjjd9hcZtJ+Hamb7WrhXy/euCrExBh8g4P8OMo7RbEDkct
         j/1Jh8vV6/kxb86IQe68VnpzI2lEFkIxX3pPIdeDruDZzt/QGOvoshm5eGmdM+lLKzOh
         6mFR5CEFOa5/n3GcHwrasXwx5Pb1CixpiYoI30HX18pBG3Et0EimO+EU30M3LT3JkiwP
         WogbpUxnLh7AnixJVOMMC+w4RAsdiiiFX8cU5iKH5D8pg+4TYDUPisJgZXY+CgsZ5wou
         g7d9pQX4N/aoCVDEqx6hbxgrHdSUODsX2QllFgOFfefOwiDkgjYo/X0GS28cnAs5nxMa
         zKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5taqwMO9fu02Eq/oSradLpdwhpBHOZ6HATVQFj48PwQ=;
        b=DP6cTjRu0VI1ucguq7jHgkv8WTeKlGxF7rRit+rmQulHjtaYBNrwtwsb15zL8ifMkc
         XnwTobwO+iMT62ZnJMiO6FSqkYeEFVRR0xEZR0m/pTaE8FJCy4CFRW9edF1EY3tzkf8/
         6edWdgBvup19uZ8b8VUoRtJvcuI+Q3BPCgYe2epN016yyfhZ02bn59XqowwMtsvk4POe
         zS7kzxanB3OPYBXUP0PbjbJtuNPcbKPUv/gpx3Op5efcbC9EedYiS9xo0XdRrZB4nZQG
         PePfm6mj3gv13ebdcb6SRFmBrM6I5GzWVGcKupwzlWC4c3CrpSbo1IVeXb75ykUgTyQB
         6jiA==
X-Gm-Message-State: AOAM530b5vEOiIEycPHmjWZj3utmWVjd8nOsAGitQ3tEHfKVnSPtK0Fh
        NIBfjqaxEdrp+X3bRxX1bgH63bEEJUwbOw==
X-Google-Smtp-Source: ABdhPJxoc7j/v0P1UW6PWlJkoWGb37SomTJQ0HPCfz64FMSjkwK28/qzf+vFRBgjWo64pHD+VhhIBg==
X-Received: by 2002:aca:b705:: with SMTP id h5mr463983oif.31.1598295269132;
        Mon, 24 Aug 2020 11:54:29 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::b30e])
        by smtp.googlemail.com with ESMTPSA id b188sm2112414oif.19.2020.08.24.11.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:54:28 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/3] dyndbg: give %3u width in pr-format, cosmetic only
Date:   Mon, 24 Aug 2020 12:54:10 -0600
Message-Id: <20200824185412.1617174-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824185412.1617174-1-jim.cromie@gmail.com>
References: <20200824185412.1617174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the print-width so log entries line up nicely.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1d012e597cc3..01b7d0210412 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -947,7 +947,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	v2pr_info("%u debug prints in module %s\n", n, dt->mod_name);
+	v2pr_info("%3u debug prints in module %s\n", n, dt->mod_name);
 	return 0;
 }
 
-- 
2.26.2

