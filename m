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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2740D21655
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu2e714s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgFQQ1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgFQQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:38 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A46C06174E;
        Wed, 17 Jun 2020 09:26:38 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id b8so2315271oic.1;
        Wed, 17 Jun 2020 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=naIBWtFWSG448zP0V4TFY2wwlYvOJWt7QTzQ4V+d18c=;
        b=Eu2e714sEdi6Ki9f4cdIAT2Bi3lLIUvNLMBydRztk24iRwQ9N+SgTWAnplstaiLfAx
         lr6jSuNbUh40N4JaJwv5VBl268yuPBsUoqYKq/OCvNTKvL8k50hO28Ui5ByFeQu+hEhz
         7hS+rrwh4uqRc3ElPVTG/kzqVvkmfZB1h8QMMrVrlOo3rwof7yGphXWFr+NTjQBG63SY
         6yt9BO/8a1Ne/w+hd1UmdYCbW/jY1I22PJloM15nEDU78St6sC2AsHoCMPjOcgVItaPw
         FYHVwZq99W4VBBok5jByOSXy5Zhw7KIEQZgavM4ASWsY9oyzXYks4A+l+a969/Zukur3
         0y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=naIBWtFWSG448zP0V4TFY2wwlYvOJWt7QTzQ4V+d18c=;
        b=ZGXuPd85UWmR7VpbxVWIUr0STQJ7M5kZKSKGk+zQvPGPAHV+sFZyKRV+cViHaUL7hl
         q0Q9Msm9/QQugD6E7HJVpUmRfZimMk5wlsYnUiy1GrMl5dAZpAY99NU++NhL7Q7HOkKt
         tTKKYPpS210a3qWT43D6wRvjIeziHWa/wGjN2NBH9xSnVntVGZ0ib2jeYZTo+xshbqzt
         VkVjGyhhmIYVaHjt/8aGyJTyZ4IfVPpveZz5vUhR5/dloy77wGe0Le2xHmMj1HJjTdNM
         RCjFr54UayAG80TVfDzmVThDjLCwamIlpVMSQ+L92QSOs0Qp1uZasBsidTzFgzqXJU/L
         AP/Q==
X-Gm-Message-State: AOAM530UulH+AwuuAc3nuR53y+mP9V3y+pljllFyenxlSIcHAvDKkjje
        z+S443yrrbq6SwJRO2CDeUY=
X-Google-Smtp-Source: ABdhPJzLOQjoNT87qyfUu/kkXcSSrw+y/lYr87O05aBRMB3IWNy0TaoQL3mR/Q4HIsEtdEeR8i9anQ==
X-Received: by 2002:a05:6808:ab0:: with SMTP id r16mr8091168oij.24.1592411197632;
        Wed, 17 Jun 2020 09:26:37 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:37 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org
Subject: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and filtering on flags
Date:   Wed, 17 Jun 2020 10:25:35 -0600
Message-Id: <20200617162536.611386-23-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
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

The u-flag & filter flags

The 'u' flag lets the user assemble an arbitary set of callsites.
Then using filter flags, user can activate the 'u' callsite set.

  #> echo 'file foo.c +u; file bar.c +u' > control   # and repeat
  #> echo 'u+p' > control

Of course, you can continue to just activate your set without ever
marking it 1st, but you could trivially add the markup as you go, then
be able to use it as a constraint later, to undo or modify your set.

  #> echo 'file foo.c +up' >control
  .. monitor, debug, finish ..
  #> echo 'u-p' >control

  # then later resume
  #> echo 'u+p' >control

  # disable some cluttering messages, and remove from u-set
  #> echo 'file noisy.c function:jabber_* u-pu' >control

  # for doc, recollection
  grep =pu control > my-favorite-callsites

Note:

Your flagstate after boot is generally not all =_. -DDEBUG will arm
compiled callsites by default, $builtinmod.dyndbg=+p bootargs can
enable them early, and $module.dyndbg=+p bootargs will arm them when
the module is loaded.  But you could manage them with u-flags:

  #> echo '-t' >control		# clear t-flag to use it as 2ndary markup
  #> echo 'p+ut' >control	# mark the boot-enabled set of callsites
  #> echo '-p' >control		# clean your dmesg -w stream

  ... monitor, debug ..
  #> echo 'module of_interest $qterms +pu' >control	# build your set of useful debugs
  #> echo 'module of_interest $qterms UT+pu' >control	# same, but dont alter ut marked set

The user flag isn't strictly needed, but with it you can avoid using
[fmlt] flags for marking, which would alter logging when enabled.

Negating-flags:

Using negating-flags in your filter-flags, you can completely specify
the matching flagstate; not just required flags, but also prohibited
flags.

So if you want to avoid altering your u-set, prohibit the flag with U,
and all marked callsites will be skipped, for whatever change.

    #> echo U-pt >control

At the outer limits, you could use many flag patterns to form separate
subgroups of callsites, then enable those groups by filtering on just
their flagstates, or you could add further constraints on callsite
selection.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 31 ++++++++++++++++---
 include/linux/dynamic_debug.h                 |  1 +
 lib/dynamic_debug.c                           | 29 ++++++++++++-----
 3 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index e1ea0c307fcf..e910865b2edc 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -239,16 +239,39 @@ The flags are::
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
index cf3379b40483..a302a7d8a722 100644
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
 
 			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
@@ -440,12 +448,19 @@ static int ddebug_read_flags(const char *str, struct flag_settings *modifiers)
 			if (*str == opt_array[i].opt_char) {
 				modifiers->flags |= opt_array[i].flag;
 				break;
+			} else if (*str == opt_array[i].not_char) {
+				modifiers->mask |= opt_array[i].flag;
+				break;
 			}
 		}
 		if (i < 0) {
 			pr_err("unknown flag '%c'\n", *str);
 			return -EINVAL;
 		}
+		if (modifiers->flags & modifiers->mask) {
+			pr_err("flag '%c' conflicts with previous\n", *str);
+			return -EINVAL;
+		}
 	}
 	vpr_info("flags=0x%x\n", modifiers->flags);
 	return 0;
-- 
2.26.2

