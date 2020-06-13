Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B77C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BEB2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ9xdhob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgFMP6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgFMP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:35 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83CEC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:34 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id n6so9789587otl.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=On9x8U6BadMsH1Q4D0HNQM4K9MGExTx1lOtQM+fe6Ts=;
        b=VZ9xdhobG94BzWwaEhzZ/jBYnpzXsFyfTeW1VAFncAltn5buWrt29ELQYpfFV2++5g
         OIL6m6gWgXgyVOgnD99EIC3eYuU188nCAj4hSB8uwPyC7mcxtNQjGmleKdf8IZzf55zv
         MVjLZwmmx/QC1yRIOxqc2H+gPAKs2H972MpGixdrf1N5+wA6CG63a9Ai5mhpEJbpyjgC
         YzGbMlLUNMSq+thI3hMMw088wKjfo+1vKKq9v740ytiFiisguUYe8fHKz5R8s2++0gTM
         gtfh3X87Ty4rKZ7OlYfMP/t3e6Lc3jLZKkpk+N6NRVTNEyEMbml563GeIjP1iU7DZu4a
         KBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=On9x8U6BadMsH1Q4D0HNQM4K9MGExTx1lOtQM+fe6Ts=;
        b=hiPbLfvsDMW6CIo+SlxsyZuGAXQ0ctDL3NMggPe29ve8HV0ilFxxKC0j36glRabO8a
         Sf8Ipy10Os/nIGoJDq5QdoRIAu98ifewngEAOia0ZF5LrY0NXv0Gqd46lvbe+RZldQXc
         CWgUr5A9mtQAum+SR+cSRGv4EZacTM8dJsFT/F/9PjzmKeJcW4WbpMwdR6jtwHvef/a2
         iZ74ca7imJvZULEq3D7MEa/zUgVHFNGZVfna4ZgwJnqpws1nCAZ5I0Aje6TvPcGQhqk1
         J+Y9l3ye8ElrdEEJtiKnLIYzqV2GHsWOfyBAQH4y1t99Bi5NBkeLUfW05AN6P+8SCiz8
         6K9Q==
X-Gm-Message-State: AOAM531IZItf2FlGCb2bm6MARTVnxx+1GQZlX68BLfy0iQuirnYDDW2q
        BigdIEZAkdMTeRYqPw2sGZzO3Mf3cQY=
X-Google-Smtp-Source: ABdhPJxweipRp+OQq6t7sphzrz0BgzkhpgmI3LPxgTfZ3UWZQ/xKXwCfyhO3QkkWSXoRLHQ1YPkKkQ==
X-Received: by 2002:a9d:560d:: with SMTP id e13mr15024943oti.55.1592063913824;
        Sat, 13 Jun 2020 08:58:33 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:33 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 20/24] dyndbg: WIP towards debug-print-class based callsite controls
Date:   Sat, 13 Jun 2020 09:57:34 -0600
Message-Id: <20200613155738.2249399-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are *lots* of ad-hoc debug printing solutions in kernel,
this is a 1st attempt at providing a common mechanism for many of them.

Basically, there are 2 styles of debug printing:
- levels, with increasing verbosity, 1-10 forex
- bits/flags, independently controlling separate groups of dprints

This patch does bits/flags only.

proposed API:

Usage model is for a module developer to create N exclusive subsets of
pr_debug()s by changing some of them to pr_debug_n(1,) .. pr_debug_n(N,).
Each callsite must be a single print-class, with 0 default.

No multi-type classification ala pr_debug_M(1|2, ...) is contemplated.

- change pr_debug(...)  -->  pr_debug_n(pr_class=0, ...)
- all existing uses have pr_class=0
- developer creates exclusive types of log messages with pr_class>0
  1, 2, 3 are disjoint groups, for example: hi, mid, low
  0 is reserved for existing uses.

- adds query term: "mflags $arg"
  rename keyword to prcls ?

  Qfoo() { echo module foo $* >/proc/dynamic_debug/control }
  Qfoo +p  		# all groups, including default 0
  Qfoo mflags 1 +p	# only group 1
  Qfoo mflags 12 +p	# TBD[1]: groups 1 or 2
  Qfoo mflags 0 +p	# ignored atm TBD[2]
  Qfoo mflags af +p	# TBD[3]: groups a or f (10 or 15)

so patch does:

- add unsigned int pr_classes into struct ddebug_query
  this is a bit-vector
  bit positions select which print-classes to filter callsites for

- add unsigned int pr_class:5 to struct _ddebug
  picks a single debugflag bit.  No subclass or multitype nonsense.
  nice and dense, packs with other members.
  if adoption is good, kernel will have a lot of struct _ddebugs.

- in ddebug_change()
  IFF query->module is given, and matches dt->mod_name
  print-classes are defined on a module, so we require one.
  this is fooled by "module *"
  simple fix is to exclude any wildcard when mflags given

- in parse_query()
  accept new query term: mflags $arg
  populate query->mflags
  arg-type needs some attention, but basic plumbing is there

WIP: not included:

- pr_debug_n( pr_class=0, ....)
  aka: pr_debug_class() or pr_debug_id()
  bikeshedding welcome.
  the bitpos is 1<<shift, allowing a single type. no ISA relations.
  this covers OP's high,mid,low case, many others

- no way to exersize new code in ddebug_change
  need pr_debug_n() to make a (not-null) typed callsite.
  yet - done in subsequent patches

- mflags arg-parse is primitive, placeholder

- module.debug vars
  I think this can be sanely handled with a callback to handle updates.
  Perhaps several to handle different debug/verbose flavors
  maybe we export ddebug_exec_queries.

Notes:

1- A query ANDs all its query terms together, so Qfoo() above
requires both "module foo" AND all additional query terms given in $*

But since callsite pr_class creates disjoint groups, "mflags 12" is
nonsense if it means groups 1 AND 2.  Here, 1 OR 2 is meaningful, if
its not judged to be too confusing.

2- im not sure what this does atm, or should do
   Qfoo mflags 0 +p 	 # select only untyped ? or no flags check at all ?

3- pr_class:5 gives 32 print-classes
   we can map [1-9a-w] to select any pr_class with 1 char
   then "12", "af" work as noted.
   it is succinct, but arcane.
   but it does allow mnemonic choices of pr_class
   - l,m,h	low, mid, hi
   - l,r	left right
   it also allows us to treat 1-9 as levels
   - by auto-setting 1-7 when 7 is enabled.
     ie: "mflags 7 +pu" in effect does "mflags 1234567 +pu"
     note that even if this is done,
     individual callsites or sets of them can be undone.
     you can even use 'u' as above to mark them for easier grepping
---
 include/linux/dynamic_debug.h |  1 +
 lib/dynamic_debug.c           | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 59960a8dd9f9..7ac822d6be87 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -20,6 +20,7 @@ struct _ddebug {
 	const char *function;
 	const char *filename;
 	const char *format;
+	unsigned int pr_class:5;	/* >0 for distinct developer groups */
 	unsigned int lineno:18;
 	/*
 	 * The flags field controls the behaviour at the callsite.
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cb5c7480e026..0035218d7059 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -55,6 +55,7 @@ struct ddebug_query {
 	const char *function;
 	const char *format;
 	unsigned int first_lineno, last_lineno;
+	unsigned int pr_classes;
 };
 
 struct ddebug_iter {
@@ -132,13 +133,14 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 			fmtlen--;
 	}
 
-	vpr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
+	vpr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u prcls=0x%x\n",
 		 msg,
 		 maybe(query->function, ""),
 		 maybe(query->filename, ""),
 		 maybe(query->module, ""),
 		 fmtlen, maybe(query->format, ""),
-		 query->first_lineno, query->last_lineno);
+		 query->first_lineno, query->last_lineno,
+		 query->pr_classes);
 }
 
 /*
@@ -203,6 +205,27 @@ static int ddebug_change(const struct ddebug_query *query,
 			if ((~dp->flags & filter->mask) != filter->mask)
 				continue;
 
+			/* filter on non-zero print-classes */
+			if (query->pr_classes) {
+				if (!query->module) {
+					pr_err("using prcls requires module too");
+					return -EINVAL;
+				}
+				/* since print-classes are module
+				 * specific, require a module query
+				 * too.  For 'module kvm* mflags 1'
+				 * >control, this will enable
+				 * pr_class=1 in several matching modules
+				 */
+				if ((query->pr_classes & (1<<(dp->pr_class-1)))
+				    != (1<<(dp->pr_class-1))) {
+					v2pr_info("%s ~ %s mflags:0x%x !~ %d\n",
+						  dt->mod_name, query->module,
+						  query->pr_classes, dp->pr_class);
+					continue;
+				}
+			}
+
 			nfound++;
 
 			newflags = (dp->flags & mods->mask) | mods->flags;
@@ -427,6 +450,12 @@ static int ddebug_parse_query(char *words[], int nwords,
 		} else if (!strcmp(keyword, "line")) {
 			if (parse_linerange(query, arg))
 				return -EINVAL;
+		} else if (!strcmp(keyword, "mflags")) {
+			pr_info("handle mflags arg: %s\n", arg);
+			if (kstrtouint(arg, 4, &query->pr_classes) < 0) {
+				pr_err("bad arg for mflags: %s\n", arg);
+				return -EINVAL;
+			}
 		} else {
 			pr_err("unknown keyword \"%s\"\n", keyword);
 			return -EINVAL;
-- 
2.26.2

