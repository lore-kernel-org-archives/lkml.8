Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD97CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963E02074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaFNontj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgFMP70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgFMP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:08 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ADCC08C5C1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:08 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id q188so2536896ooq.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5FIpXR5Tp04u3sUycsKL8GMRm8w9TasYjP/WjFsAa4=;
        b=NaFNontjF888fpgzGYek6Fwbe0PJCf2sDH1G4AaHWqeIcfMiRnTsgHh3Mb+/aXTtcB
         OULHzrhlkZUDjNYKgKeJuBB8j5St6c/+HvGyNUM/swfHOC8KyJXo/HJVp7WEJZcoE5Xw
         PFMGh2sEHVvVWGJ0MurjX5Cgriz7viqOogHoKyCUmDCfMQnomqnD5ZM/w2ZKWlZRULBW
         vlkB7oR0ASJpKKDoZChVV25vrzfRL0yRY55pemUcji9xVpbIRR1djALcyYFj8aO9v7i+
         a394TwzvnWyq2M9W5GB6zLHRL4uyP+c9q5Cu0Zhhu9KZIUqcY1FXH+rU8CHK8zN4LxNE
         s41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5FIpXR5Tp04u3sUycsKL8GMRm8w9TasYjP/WjFsAa4=;
        b=Sp3KUKH9BLWDht076hw2vCIBERDetG0OJxS+c5cqJRwoss3NPOj+pvc9QJHzIqhnCm
         4xWKbtenNpTr6yU7eSrf8SPOCZTeWdCqcgHxWT4Ccqw+I68iEzV9z7ZXrIl6uLeuH1+S
         KxFi2HFNR287AyoIE9nfjln/fwn3fRSUZNSK1jFKSDS1z3x/hya8/avdU+/VUVeQrRtg
         JT7RboF32BAhx4C/tq8OmgThsdaq+/ID5Pf0OsKdFF4S9Ms7xHaJ/QHDthpLzf0grJ2Q
         tBmT8IQ5+MzxMkZ48oVOBQzjcxHgcXWvhcQONZWTWpdZ+miu6TawNkR/U+pUTiujtDt6
         +Taw==
X-Gm-Message-State: AOAM533sDvILnCq8gGMNZlMw9t9RXkDptjc4J97DdIjZl5plKIYy7wn3
        IitLFWl7JuSeh+LHJCYnPaE=
X-Google-Smtp-Source: ABdhPJyQm3ah+5uMAfdgY7l045JOQIxSnPqOwOkBkRuuFcviP7HT2VmzT6xZbvHfkO9EgLCPmbejHw==
X-Received: by 2002:a4a:8d01:: with SMTP id o1mr14813886ook.61.1592063887760;
        Sat, 13 Jun 2020 08:58:07 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:07 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 08/24] dyndbg: make ddebug_tables list LIFO for add/remove_module
Date:   Sat, 13 Jun 2020 09:57:22 -0600
Message-Id: <20200613155738.2249399-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
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
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index aaace13d7536..31d3be30776e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -896,7 +896,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->ddebugs = tab;
 
 	mutex_lock(&ddebug_lock);
-	list_add_tail(&dt->link, &ddebug_tables);
+	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
 	v2pr_info("%u debug prints in module %s\n", n, dt->mod_name);
-- 
2.26.2

