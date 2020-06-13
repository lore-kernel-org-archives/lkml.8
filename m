Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88770C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6353420789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0woNcU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgFMP6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgFMP6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:30 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F869C03E96F;
        Sat, 13 Jun 2020 08:58:30 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id b18so9740019oti.1;
        Sat, 13 Jun 2020 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fxzelwdDz29Q+H/iQtV1kYP71GBSr15ktvkIuRajfug=;
        b=W0woNcU1YHp+9kUoS8+uxvC82NYj26uFyyVl0/0Pm5H5ClLy+nXaOQ7dYBjqex2T6k
         3586wIOzpkkyR+S5fzBmy4XsnfXJ6JjAx/sZheFZyp3No25Ri1NOE/Oz8SkTh6vFs/Wo
         D4oweemBCkx1yDoMsXLcnQR4FCrNrsHqoV/yS8uDEcjztqIUvGaqzjiFofSx5cQuBPuP
         65X9orl8Vb9vMLY7h85tDC7mhAXl8MlFlS5H+Fb5T/FywmLIAEqWs3KFqUZ0IcSmUCSg
         Gs1NTCiY0tJuA8EFHusaWEQLj1nIj3B3bMwZPD2+iIVoZcxNCRPuZj0dZWzl1JZVcMmH
         wcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fxzelwdDz29Q+H/iQtV1kYP71GBSr15ktvkIuRajfug=;
        b=CGt4o5mv7YUpw8jP8w5pwTur+emZo6emuD/u2SDag7UtSZxnlc2EqSCM/z8EkQe095
         EFEJTeyGwYm6ip0aZNP1T7KR64W7Z7EDOgXpNMfYZNV/WVH2ObPTY8h78AVoEzw2vQYO
         bicuUVYeQfVTlSs48KtDZER6+iUSIBBWzIHuliTHUS/r7a1HRrhob5CFnTBCMxyb/6Q/
         lVyLJCyUp2TsHS97tzcuJzuOQ3gleh0f8chYz+4NpRj76GGy+JkVstbZsNEua7Tc889v
         u2tNbfl7cklLZ6BXchC12zsj8M8yjx20a8UQzopIc6AbaZa1XAX4raGQ0kaa2BoxsrBx
         CsoQ==
X-Gm-Message-State: AOAM533paWgyfhXaAR9tczlx+26u53vK3KsQJlBtdwxgy8QCNHat4exZ
        4GRV536795rPf3CG5kjJQDk=
X-Google-Smtp-Source: ABdhPJz8h6j47ENzqjl2vvxRLum9ifrzoIiSrinI0tYVACeQohe1A2pWXZgvjWnECv9vf8F6D+ZSCQ==
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr15165265otr.58.1592063909921;
        Sat, 13 Jun 2020 08:58:29 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 18/24] dyndbg: allow negating flag-chars in modflags
Date:   Sat, 13 Jun 2020 09:57:32 -0600
Message-Id: <20200613155738.2249399-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
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

Using filter-flags with negating-flags, you can select exactly the
flagstates you want, both required and prohibited.

Then with negating-flags in modflags, you can set and clear every flag

  #> Q umfLT-Pmf  # select sites with u,m,f only. enable print, turn off m,f leave u

Its not an important feature, but it does fill out the logic.
and the patch is tiny, and feels more symmetrical.
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 ++++++----
 lib/dynamic_debug.c                               |  6 ++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 45d3adf889ba..10e514237e83 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -257,9 +257,11 @@ only callsites with ``u`` and ``f`` cleared.
 
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
 
@@ -269,7 +271,7 @@ For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
 For display, the flags are preceded by ``=``
 (mnemonic: what the flags are currently equal to).
 
-Note the regexp ``^[-+=][flmptu_]+$`` matches a flags specification.
+Note the regexp ``/^[-+=][flmptu_]+$/i`` matches a flags specification.
 To clear all flags at once, use ``=_`` or ``-flmptu``.
 
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b02cde1cfc2f..d67fbbc5317f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -486,15 +486,17 @@ static int ddebug_parse_flags(const char *str,
 
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

