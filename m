Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBCDC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1A520789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2TJdnrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgFMP6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgFMP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:26 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF47C08C5C1;
        Sat, 13 Jun 2020 08:58:26 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t6so9746100otk.9;
        Sat, 13 Jun 2020 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AU7c+PgpMF6te0CQ1BmL/sHbcOGozgQf6DVP7H/JO0k=;
        b=M2TJdnrsf/njaeRrcI4jZj6OY+iKoxU0C/stcsR/jmUotSBI0b3yye24DFEO7s+iwd
         g+yrADzZwV9qSS+3rX3MqwuffjEeXa+Vl0sfdrg2Cp63vwGB+AR5W/c7YNz1Lu58ipEP
         Of0fSm6rGWMIol++gAy3cB4aWju/pwAasE8zCH1xKyUURsaEZh4wIGblIaJvoPqivhTh
         fhLPLyOSXoMP4w3GtPhQiuTr+gBy9w1w4TXYe+JlYIeEspwplGpThW7x6gRLt44Ofkoe
         GHD27yXsV/PREs3+j2PfSbDVrHfl7DrZqtuz0TEfKR3D/Thb+rzSSlytmk6WEsz+qruK
         aw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AU7c+PgpMF6te0CQ1BmL/sHbcOGozgQf6DVP7H/JO0k=;
        b=e+NQpmWn2r2+rhI3/N+2LWS9ZJZvl4XmQDo2JwlVleinh7LJE2j6h3sGhVfMnvuWbe
         6UjCkqDT5gMf/y8YtE2A+8HgCpFwdtxfmQfAbDuh5NtYs5npyes7cRUe287NRj8fnHIL
         UllSzxADaj7laWGEhz0GQp50uebxoFxsPpdHeQSOkCKpG1CSgiqm0HY8BHbKT6e5xFjy
         zybMPCGh6U5IAjEVcYb4/LvVkUEltBRYHvNoFCic/L2xNMvzUFPtGLNbV4mqMdaKzV7t
         BGO/jOKUzRk2FL0qW6b+mog/giggryifAiXVs6D3NthZ0D8aesYyR7UDFVSCkbZkO5yn
         6xIA==
X-Gm-Message-State: AOAM5338SwX7Or1ubFydjiSlxsZQfAFqytM7FtObs7wgKpibGsCt/vJH
        gb3yAAWuKf4WV/WrkjRMGfY=
X-Google-Smtp-Source: ABdhPJwEiBOkJ7LJx5no1mEA38zAePPgCNACVbNpbKBzFmhlcBoRcUwVhttivOQMs+5m39qEqsQZ4w==
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr15390105ots.192.1592063905453;
        Sat, 13 Jun 2020 08:58:25 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:24 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org
Subject: [PATCH v2 17/24] dyndbg: add user-flag, negating-flags, and filtering on flags
Date:   Sat, 13 Jun 2020 09:57:31 -0600
Message-Id: <20200613155738.2249399-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
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

The 'u' flag lets the user assemble an arbitary set of callsites.
Then using filter flags, user can activate the 'u' set.

  #> echo 'file foo.c +u; file bar.c +u' > control   # and repeat
  #> echo 'u+p' > control

Using negating-flags in your filter-flags, you can completely specify
the matching flagstate; not just required flags, but also prohibited
flags.

The user flag isn't strictly needed, but with it you can avoid using
[fmlt] flags for marking, which would alter logging when enabled.
---
 .../admin-guide/dynamic-debug-howto.rst       | 31 ++++++++++++++++---
 include/linux/dynamic_debug.h                 |  1 +
 lib/dynamic_debug.c                           | 31 ++++++++++++++-----
 3 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4f343e6036f5..45d3adf889ba 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -238,16 +238,39 @@ The flags are::
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
index aa9ff9e1c0b3..59960a8dd9f9 100644
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
index b3c262c009d2..b02cde1cfc2f 100644
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
@@ -195,6 +196,13 @@ static int ddebug_change(const struct ddebug_query *query,
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
@@ -428,10 +436,17 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
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

