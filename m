Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F07C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6BB2074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzuq7h4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgFEQ2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgFEQ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:28:14 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34726C08C5C2;
        Fri,  5 Jun 2020 09:28:14 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id n31so2080323ooi.10;
        Fri, 05 Jun 2020 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KeJadA9027ISMttgEN7K8Lz7VH9h6QGa7xPQcosVw0=;
        b=Vzuq7h4JynCAkub4hVq16vIWFPh8C7Q64F7iEdIzqr8Mp5qvUjM+xgb8OmLYY4Jtbo
         7VE9sZ5iT3KeKBzFrmdpLmm3MkXv+lHeekx1y74tj0WTihXGHxMOUnxWfqEhaV9G6kg8
         YHQb/yFDpkxkd5pl7KBaAPIVf77Ex8lOI5nII1hrcz2ha/lbdzuxo68XHBgDWAmHEOCk
         WtFSsAtEcZWNSOZzaUHtakpNOg14BdnhO/UeacYM07cdeN+7pchTFjWuXeZ5kMyXwSN4
         wvGwIaLROkym70jrNSOqg3Qk4A4VDjYc48aIcsm9Iq+9fNEkD8E4Ue/tKsOSmpV3szuB
         7FCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KeJadA9027ISMttgEN7K8Lz7VH9h6QGa7xPQcosVw0=;
        b=J9f6pF800QC+l7VGuhmMX+6+ByKKYH+qfSouHHTv9bbmwH2YQc2ZpBun9+DcOl+Z44
         um8zB8w3PFRW12jm32mtAFSVWVxBA4sawemiTtqYeClXqqVROn3ojojrUG5Nyv3K3crB
         CDE7FPl6sy6chqMZTc8Mxamfz4fA//CeXylHj0nu1WlHS/hbwrtBTHRH7xj7GlYdV/dp
         63XYDtQBOux5LcE8r2iPUyQJX2Iu5iKTfQ5WiRmlRCKQe1TEAcGXZQ4NNRZfwQfDo6Qh
         2++ihJ0EB8Kj5SoGJP+1hcsXVr/5cuhVzYD1Xl1WrrmkW1XnA8kh0jAHimuWGuCXnUzu
         7nCw==
X-Gm-Message-State: AOAM533J7lBTveIqiyIScjM4YJR2y51SawmsR5VRH1f1Rvk86otZ5tZM
        sgE90ofCTxRYMIDd83uJoLs=
X-Google-Smtp-Source: ABdhPJyUzxCAbI9mYxQseWEijvdo9MPv389api0Ozmnya6gUrG0FrtMvmCtHgu9tFZxnAMN66osLNg==
X-Received: by 2002:a4a:d149:: with SMTP id o9mr8445844oor.77.1591374493451;
        Fri, 05 Jun 2020 09:28:13 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:28:12 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH 16/16] dyndbg: allow negating flag-chars in modflags
Date:   Fri,  5 Jun 2020 10:26:45 -0600
Message-Id: <20200605162645.289174-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend flags modifications to allow [PFMLTU] negating flags.
This allows control-queries like:

  #> Q () { echo file inode.c $* > control } # to type less
  #> Q -P	# same as +p
  #> Q +U	# same as -u
  #> Q u-P	# same as u+p

This allows flags in a callsite to be simultaneously set and cleared,
while still starting with the current flagstate (with +- ops).
Generally, you chose -p or +p 1st, then set or clear flags
accordingly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 ++++++----
 lib/dynamic_debug.c                               |  6 ++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 26a19f511afa..45470c9f0dad 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -252,9 +252,11 @@ only callsites with ``u`` and ``f`` cleared.
 
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
 
@@ -264,7 +266,7 @@ For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
 For display, the flags are preceded by ``=``
 (mnemonic: what the flags are currently equal to).
 
-Note the regexp ``^[-+=][flmptu_]+$`` matches a flags specification.
+Note the regexp ``/^[-+=][flmptu_]+$/i`` matches a flags specification.
 To clear all flags at once, use ``=_`` or ``-flmptu``.
 
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ee92e93cf23d..63ae6f77a0e4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -485,15 +485,17 @@ static int ddebug_parse_flags(const char *str,
 
 	/* calculate final mods: flags, mask based upon op */
 	switch (op) {
+		unsigned int tmp;
 	case '=':
 		mods->mask = 0;
 		break;
 	case '+':
-		mods->mask = ~0U;
+		mods->mask = ~mods->mask;
 		break;
 	case '-':
+		tmp = mods->mask;
 		mods->mask = ~mods->flags;
-		mods->flags = 0;
+		mods->flags = tmp;
 		break;
 	}
 
-- 
2.26.2

