Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB6FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4566F208A7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8GghHbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgFEQ2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgFEQ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:28:10 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9460C08C5C2;
        Fri,  5 Jun 2020 09:28:09 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v17so8090797ote.0;
        Fri, 05 Jun 2020 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PgeKZicaAAcFCU8vOGCrkdV6kskck/MCatzZXUFR2Ow=;
        b=a8GghHbX3HKW/WPLW5e2787BuST6oAIuhvdBzc5DShgXgWPkTpV0KW9/jBtnI4P92R
         N3nhNG6K5Tsi+qLyMJ24H3JNEkHafYk88pw9vSB5pQgICp7IqtR0Oxu4iJxD43nsXahF
         4lQwRDDHyTvlHx0bjaDl03CvVgDVznLCIRljNcfE3rREdsvIi7bQ1leihSU54YQYBp6f
         XnB4FC8UfU+IGnBUTrOGxrLsli2wQCiHRyeORG6nMYaNK9outQVIUYUgQ+f79kQZug5v
         5pXiLyYR6YmbNnMZALqRkZhbb8qaaISqfvjU20Hs606P1rdEKQTnbSkDACzqY0NwGA/9
         k60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PgeKZicaAAcFCU8vOGCrkdV6kskck/MCatzZXUFR2Ow=;
        b=NG1TE0GB9RkZVL5rU0MfjUYZCtvfGS4NbnM+elzVLmmSZq2M02S1Pox85qqqhwAOtW
         t5u7T+n77BXKwzFwcuKKyS/hRyt/eUVo45tpfL8Zl5mUqDJ7Puu8y0w9fByn5SS/pgeV
         pFSA8gdTHEQdbhtzDJs9Xfc3+RTQjWh6/EZmac8Kpx1I8TRDbb8GjQzW/a3PEFZFwX87
         i+Bg/P4OR2apaC38BuK+4TBKnS8FJyHEPSptTaojh77hS8HU+iUEJpmagzdrbG1gsDqk
         Yn/8cpLcY7bGK8Nw3w/05ejMySxt8jrUJpqHpU8XMd6KOR+f9gvnr7iOczJRUeVSf6th
         kmaQ==
X-Gm-Message-State: AOAM531Zsw8wPsMjkGwsj1Nr8Y5kpnceRgOnKVCwiHHzPccl81semRzx
        TGdJq+/VMgN+XrKwKIJb69g=
X-Google-Smtp-Source: ABdhPJwEszlzeuWUKFyvbzZeD5OBR2SgU+byFlG9gnPBADRG9daA0Hc7HEsJ9cxmZrIab0GyDtBnew==
X-Received: by 2002:a05:6830:54:: with SMTP id d20mr8624037otp.281.1591374489194;
        Fri, 05 Jun 2020 09:28:09 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:28:08 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH 15/16] dyndbg: add user-flag, negating-flags, and filtering on flags
Date:   Fri,  5 Jun 2020 10:26:44 -0600
Message-Id: <20200605162645.289174-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add a user-flag [u] which works like the [pfmlt] flags, but has no
effect on callsite behavior; it allows incremental marking of
arbitrary sets of callsites.

2. Add [PFMLTU] flags, which negate their counterparts; P===!p etc.
And in ddebug_read_flags():
   current code does:	[pfmltu_] -> flags
   copy it to:		[PFMLTU_] -> mask

also disallow both of a pair: ie no 'pP', no true & false.

3. Add filtering ops into ddebug_change(), right after all the
callsite-property selections are complete.  These filter on the
callsite's current flagstate before applying modflags.

Why ?

The new user flag facilitates batching of changes.  By marking
individual callsites with 'u', a user can compose an arbitrary set of
changes, then activate them together by filtering on 'u':

  #> echo 'file foo.c +u; file bar.c +u' > control
  #> echo 'u+p' > control

The user flag isn't strictly needed, but with it you can avoid using
[fmlt] flags for marking, which would alter logging when enabled.

The negating flags allow filtering on either 0/1 for each flag.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 31 ++++++++++++++++---
 include/linux/dynamic_debug.h                 |  1 +
 lib/dynamic_debug.c                           | 31 ++++++++++++++-----
 3 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 250ab30e2080..26a19f511afa 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -233,16 +233,39 @@ The flags are::
   l    Include line number in the printed message
   m    Include module name in the printed message
   t    Include thread ID in messages not generated from interrupt context
+  u    user flag, to mark callsites into a group
   _    No flags are set. (Or'd with others on input)
 
-For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only ``p`` flag
-have meaning, other flags ignored.
+Additionally, the flag-chars ``[pflmtu]`` have negating flag-chars
+``[PFMLTU]``, which invert the meanings above.  Their use follows.
+
+Using Filters::
+
+Filter-flags specify an optional additional selector on pr_debug
+callsites; with them you can compose an arbitrary set of callsites, by
+iteratively marking them with ``+u``, then enabling them all with
+``u+p``.  You can also use ``fmlt`` flags for this, unless the format
+changes are inconvenient.
+
+Filters can also contain the negating flags, like ``UF``, which select
+only callsites with ``u`` and ``f`` cleared.
+
+Flagsets cannot contain ``pP`` etc, a flag cannot be true and false.
+
+modflags containing upper-case flags is reserved/undefined for now.
+inverted-flags are currently ignored, usage gets trickier if given
+``-pXy``, it should leave x set.
+
+Notes::
+
+For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
+``p`` flag has meaning, other flags are ignored.
 
 For display, the flags are preceded by ``=``
 (mnemonic: what the flags are currently equal to).
 
-Note the regexp ``^[-+=][flmpt_]+$`` matches a flags specification.
-To clear all flags at once, use ``=_`` or ``-flmpt``.
+Note the regexp ``^[-+=][flmptu_]+$`` matches a flags specification.
+To clear all flags at once, use ``=_`` or ``-flmptu``.
 
 
 Debug messages during Boot Process
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 802480ea8708..a5d76f8f6b40 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,6 +32,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_USR		(1<<5)
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f0c0c31e91ea..ee92e93cf23d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -83,13 +83,14 @@ static inline const char *trim_prefix(const char *path)
 	return path + skip;
 }
 
-static struct { unsigned flag:8; char opt_char; } opt_array[] = {
-	{ _DPRINTK_FLAGS_PRINT, 'p' },
-	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
-	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
-	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
-	{ _DPRINTK_FLAGS_INCL_TID, 't' },
-	{ _DPRINTK_FLAGS_NONE, '_' },
+static struct { unsigned flag:8; char opt_char, not_char; } opt_array[] = {
+	{ _DPRINTK_FLAGS_PRINT,		'p', 'P' },
+	{ _DPRINTK_FLAGS_INCL_MODNAME,	'm', 'M' },
+	{ _DPRINTK_FLAGS_INCL_FUNCNAME,	'f', 'F' },
+	{ _DPRINTK_FLAGS_INCL_LINENO,	'l', 'L' },
+	{ _DPRINTK_FLAGS_INCL_TID,	't', 'T' },
+	{ _DPRINTK_FLAGS_NONE,		'_', '_' },
+	{ _DPRINTK_FLAGS_USR,		'u', 'U' },
 };
 
 struct flagsbuf { char buf[ARRAY_SIZE(opt_array)+1]; };
@@ -194,6 +195,13 @@ static int ddebug_change(const struct ddebug_query *query,
 			    dp->lineno > query->last_lineno)
 				continue;
 
+			/* filter for required flags */
+			if ((dp->flags & filter->flags) != filter->flags)
+				continue;
+			/* filter on prohibited bits */
+			if ((~dp->flags & filter->mask) != filter->mask)
+				continue;
+
 			nfound++;
 
 			newflags = (dp->flags & mods->mask) | mods->flags;
@@ -427,10 +435,17 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
 			if (*str == opt_array[i].opt_char) {
 				f->flags |= opt_array[i].flag;
 				break;
+			} else if (*str == opt_array[i].not_char) {
+				f->mask |= opt_array[i].flag;
+				break;
 			}
 		}
 		if (i < 0) {
-			pr_err("unknown flag '%c' in \"%s\"\n", *str, str);
+			pr_err("unknown flag '%c'", *str);
+			return -EINVAL;
+		}
+		if (f->flags & f->mask) {
+			pr_err("flag '%c' conflicts with previous\n", *str);
 			return -EINVAL;
 		}
 	}
-- 
2.26.2

