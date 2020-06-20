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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A45C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8772417C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYltxMsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgFTSI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41641 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbgFTSIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id k15so9839285otp.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YvqTkcYAAN78pjSZwwNFeimQiSa/Q3KK8WoooVV/y3U=;
        b=PYltxMsGAgvI/vD/oqJzAkm5smvWLJ64aCdWLGvjxktBnj4XmKm9GlBDiURZOA4XM/
         eN4R9DnKirURibR+keUEh5BdY5pIVV9SIR7JvsoV1hJ/eSst8n0JyExxKD9FHjR9071G
         xgafLBwT80CD6ptphAJqtEnTTVFjIA/ZTtz8cdtRmfaXTohYM1jv6FHDYrbYaiGRqNEn
         6/s7E4udamJKdFfIJewdjI2VEtDtKMWlaw1RRlJWveXRm3ohoaYM0AUQNC0V/GbIwAby
         uNxECNSTm2tePRIMK1xYZrr/xWRhUhC0nyJ0hgkvISPcrmwnfJHJXzyjC866FI9op0sE
         iZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YvqTkcYAAN78pjSZwwNFeimQiSa/Q3KK8WoooVV/y3U=;
        b=miyuTk/Tqc1hn/w77A1iKgFpn9ggK8z9nq2umkk7OUVu5Wy/tDfUG5HZT3PYe3bgpo
         EH0K5vyHCz+iJI2kQIoY0j2phykHrbDW/uhnh3XZT7rSmTEmp8vULOV9G8aZETLlvkbi
         sL6Jgh5K5IAanGFFs2j3S/53MeibBlzVWPhsJW54ZwzkIkbvDCkIX6lfwjRiPkKk4Ont
         M8ghZ6w9dJ5S/x1dPLr6jrHiNcXvZbrs9qEy2VfRK9KjROIO/eC+55PLuGduSpm4DiHP
         3I6VMtXjMWbFicDHcRsszaItcgK94vOjqB9cMOlaV4nVR5vp3EJFGD/7WkVukG5uSVZK
         drBg==
X-Gm-Message-State: AOAM5323DfhMstXT+EDzgbywk+bhoCVcfU97X0XO4A9/cLHOUji8Iaru
        r/Vdssi4mexquiQXCxS49uM=
X-Google-Smtp-Source: ABdhPJx0Qik2PYOM1hpQz7sN9BDV2yqDZcR3HbrgjLNbotAVz4ED9rJxu10Dnwd1H06mxbh4gFGu+w==
X-Received: by 2002:a9d:2668:: with SMTP id a95mr7917558otb.284.1592676428020;
        Sat, 20 Jun 2020 11:07:08 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:07 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 06/17] dyndbg: fix overcounting of ram used by dyndbg
Date:   Sat, 20 Jun 2020 12:06:32 -0600
Message-Id: <20200620180643.887546-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

during dyndbg init, verbose logging prints its ram overhead.  It
counted strlens of struct _ddebug's 4 string members, in all callsite
entries, which would be approximately correct if each had been
mallocd.  But they are pointers into shared .rodata; for example, all
10 kobject callsites have identical filename, module values.

Its best not to count that memory at all, since we cannot know they
were linked in because of CONFIG_DYNAMIC_DEBUG=y, and we want to
report a number that reflects what ram is saved by deconfiguring it.

Also fix wording and size under-reporting of the __dyndbg section.

Heres my overhead, on a virtme-run VM on a fedora-31 laptop:

  dynamic_debug:dynamic_debug_init: 260 modules, 2479 entries \
    and 10400 bytes in ddebug tables, 138824 bytes in __dyndbg section

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 66c0bdf06ce7..9b2445507988 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1017,7 +1017,6 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 	int ret = 0;
 	int n = 0, entries = 0, modct = 0;
-	int verbose_bytes = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1033,9 +1032,6 @@ static int __init dynamic_debug_init(void)
 	iter_start = iter;
 	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
-		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
-			+ strlen(iter->filename) + strlen(iter->format);
-
 		if (strcmp(modname, iter->modname)) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
@@ -1052,9 +1048,9 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
+		 (int)(entries * sizeof(struct _ddebug)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.26.2

