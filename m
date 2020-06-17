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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7D0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3852121556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCk35xGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgFQQ0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgFQQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:41 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9D3C06174E;
        Wed, 17 Jun 2020 09:26:41 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 97so2104235otg.3;
        Wed, 17 Jun 2020 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcutluLP+7Js3WRjnKBmD6q3bRgL5hNvRJ1jP16HZuA=;
        b=FCk35xGB/WfDsD0tb2+CCp+Dak+divhn+pb/Kn/3+RKa2pjp0Lxhz8vgR74/QvSih6
         65OoCaJwfWPKIBzVEIJ4jUkmUAWmgr/ybGlGsZJlU10ueXOyc2dhucE2qII6VnkQBtxe
         0z35UTUwrCg4qBN0JSEJyOLxGuRuqR6mVz+8AYqTMYM58Awzd3ZFs9c81jh3uXP1Zk2t
         a9mSs+Zz8Qs+pOcjAUkNnaa+76+HY9M9fdFDn+LwTBJQpjnea5N6xfN7DK+iqZmi2iV7
         7P6EGf42R4OME07KsAXGTAcFrYSKDs9eWZZL9+Och48k4YZLmxj+wkTklbfFcfh4B9Xk
         gL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcutluLP+7Js3WRjnKBmD6q3bRgL5hNvRJ1jP16HZuA=;
        b=Hqwvxxth7T/CREfTn8ilshDrMrE6wc5SATChB80+rwFXdbq6uKCxG47ANnSdq/tMuT
         MpLwGEV3t7wDaCQD/rHqB6qgW44CNlNn7NnFudUBWb6eBtOnPZJGsQkV4aeEAVTPZ4U9
         1i5PZkpy3y3XtgNam4belJFRv7bZCucvjQxgSADpFZBlT5dpDf/pKz/R5Iz24PbwuY9w
         38NtizzDyiK48DKS8NrXecDlEeMCCYMnKjnRNQTfyFIp8EeySSV5hWad4LQqHB/jAn7R
         nfQocJf5lZXM2ajEBwNPplxSD6mvPEzZhj4uK0waBHrSW5yVHoeLHRC+ryYf3XPHKLJq
         G+zQ==
X-Gm-Message-State: AOAM531R0T3uZeBIjcgxUD0mbw+rmkmxf0Bu/lXSge6QHWTvGBnEu/VP
        4ENWjsV/FnvXHrj+xtyVSCI=
X-Google-Smtp-Source: ABdhPJxf2pQKn/ztL5UPiTLt/eEv9oZU4kh58ajz+6j7rtMaEJudvUJwgoB3dnghu7mpegd3LGtamA==
X-Received: by 2002:a9d:d13:: with SMTP id 19mr5891869oti.83.1592411200517;
        Wed, 17 Jun 2020 09:26:40 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:39 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org
Subject: [PATCH v3 21/21] dyndbg: allow negating flag-chars in modifier flags
Date:   Wed, 17 Jun 2020 10:25:36 -0600
Message-Id: <20200617162536.611386-24-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows a user to set some flags and clear others at the same
time.  This will make it easier to use the flags for creation of
transient sets, by making it easier to change the markings on those
sets by one flag, or all flags.

Consider the 3 operators [+-=]
 = resets entire flag-set, no memory of before
 - clears flags only, but preserves otherwise
 + sets flags only, but preserves otherwise

It would be nice to be able to set or clear all bits, or any subset,
while preserving untouched bits.  Using -/+ and negating flags
together let you do so.

    echo -ft > control		# in all callsites, clear 2 bits, preserve others
    echo f-ft > control		# if f-bit is true, clear 2 bits, preserve others

using non-empty query terms gives another dimension of selectivity

    echo $qtrms -ft > control	# for a callsite subset, clear 2 bits, preserve others
    echo $qtrms f-ft > control	# for a callsite subset, if f-bit is true, clear 2 bits, preserve others

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 ++++++----
 lib/dynamic_debug.c                               |  6 ++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index e910865b2edc..4539793e39bf 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -258,9 +258,11 @@ only callsites with ``u`` and ``f`` cleared.
 
 Flagsets cannot contain ``pP`` etc, a flag cannot be true and false.
 
-modflags containing upper-case flags is reserved/undefined for now.
-inverted-flags are currently ignored, usage gets trickier if given
-``-pXy``, it should leave x set.
+modflags may contain upper-case flags also, using these lets you
+invert the flag setting implied by the OP; '-pU' means disable
+printing, and mark that callsite with the user-flag to create a group,
+for optional further manipulation.  Generally, '+p' and '-p' is your
+main choice, and use of negating flags in modflags is rare.
 
 Notes::
 
@@ -270,7 +272,7 @@ For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
 For display, the flags are preceded by ``=``
 (mnemonic: what the flags are currently equal to).
 
-Note the regexp ``^[-+=][flmptu_]+$`` matches a flags specification.
+Note the regexp ``/^[-+=][flmptu_]+$/i`` matches a flags specification.
 To clear all flags at once, use ``=_`` or ``-flmptu``.
 
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a302a7d8a722..c539bdd7fbe3 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -498,16 +498,18 @@ static int ddebug_parse_flags(const char *str,
 
 	/* calculate final mods: flags, mask based upon op */
 	switch (op) {
+		unsigned int tmp;
 	case '=':
 		/* modifiers->flags already set */
 		modifiers->mask = 0;
 		break;
 	case '+':
-		modifiers->mask = ~0U;
+		modifiers->mask = ~modifiers->mask;
 		break;
 	case '-':
+		tmp = modifiers->mask;
 		modifiers->mask = ~modifiers->flags;
-		modifiers->flags = 0;
+		modifiers->flags = tmp;
 		break;
 	}
 	vpr_info("mods:flags=0x%x,mask=0x%x filter:flags=0x%x,mask=0x%x\n",
-- 
2.26.2

