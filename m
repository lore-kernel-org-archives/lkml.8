Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD677C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 23:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82179206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 23:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGSUM9p9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGYXgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 19:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGYXgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 19:36:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520A6C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 16:36:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d18so9545163edv.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 16:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=doXVHUSSwIEzy3XFrwVIRI6UzDTWsnmmK2wPZPpqcWk=;
        b=iGSUM9p9+cOH9t7rNP0IqsPIPR/Eg+JN8fe5IrmGwNF7i2Ujnrvft7s6vBNyK7H6fq
         Mys3RcDgNVTe4U8kpMehFh61WJfU2m6SyTwATSE4n6DZGT1ZVWVF05rkkFmfBIlRY5Iw
         jmlD064tQY6APF8rYECHVPaHZhRGjBhfuyaj5yvm+bBIxNDKKwLY2pLzBZySVc0yBQ3S
         YDw3VFX/Mmf/x3fRk6iecl7EiZjPivyfdSks6oNUp/KI/QegIfFWs27WrczKoV4uE+78
         e1A+DPXBJEUs4YEDBJZIEzmuGfePrrWWWi/7GoXG+GCbcSbJb5770yDDXzPa4fLxGQ2L
         NRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=doXVHUSSwIEzy3XFrwVIRI6UzDTWsnmmK2wPZPpqcWk=;
        b=oLqwV93YsZbbwuTnpllKGkppcN7z0K7DDJH7tB/15GmBphVE6t6F3Zm8TqzQnJPfx6
         MMI7S7zK7L1iuvNI8UAfI09c00lwaU08a7eyMlWOH/hiDcRUaxzgSlX112s+te4q93v/
         Ts4+p+rAGxUb50h8dhfRDfdUsHhHpNAhwGCA0y97jnGM44pzbvWEQdawIK/vKvgcApaP
         VzR6k7TSLltUwDQfj2Iyx1hOIje6seXIC2+qOy72hn9GrtjXTCE1Gp2yX4ry994Mx9Bl
         YI+8d20g4ZJpYpNMkD6ADw6dR0kiZ8xnjJm0x1A1f4rw6daCIt2JIXtCa79ONf6pBrLr
         Y1eg==
X-Gm-Message-State: AOAM532z5Wu00yOT+1LQjqdwDz0XV76Rr1Uk5hT/Dcq2v6XpN692P+DX
        lGcn/m3axb0wN5+aeariXW4=
X-Google-Smtp-Source: ABdhPJz5LXehCen61pBi3geOOZ8wp99wypWI2SNdnMt6btYQQpa/qyjdIjpHSMpI4rOPr6RGkxoy2g==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr14966329edr.219.1595720169834;
        Sat, 25 Jul 2020 16:36:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:60d3:6c2f:f9ba:e713])
        by smtp.gmail.com with ESMTPSA id rv14sm3722348ejb.33.2020.07.25.16.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 16:36:08 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        colin.king@canonical.com, sj38.park@gmail.com, jslaby@suse.cz,
        pavel@ucw.cz, SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: checkpatch: support deprecated terms checking
Date:   Sun, 26 Jul 2020 01:35:57 +0200
Message-Id: <20200725233557.8154-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <58ed7006138bb256ad1821d5f4f892f3c3e031a8.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 10:29:23 -0700 Joe Perches <joe@perches.com> wrote:

> On Sat, 2020-07-25 at 15:02 +0200, Michał Mirosław wrote:
> > Hello,
> > 
> > I see that this patch went into next and is already inciting people to
> > do wrong things [1]. Can you please fix it to require '--subjective'
> > switch or otherwise mark it clearly as suggestion-only?
> > 
> > The coding-style as in Linus' master says about *NEW* uses of the words
> > listed (those introductions I expect to be actually rare) and not about
> > existing use in the code or industry. Making a noise about all uses
> > found surely will generate a lot more irrelevant patches.
> > 
> > [1] https://www.spinics.net/lists/linux-tegra/msg51849.html
> 
> And if not reverted, perhaps do not check existing files
> at all but only check patches and change the message to
> show only suggestions not from a specification.

Agreed for this case.  However, excluding existing file check doesn't fully
avoid this problem.  Also, more terms having different deprecation rules might
be added in future.  How about allowing file check but show reference in the
suggestion message as below?

> ---
[...]


Thanks,
SeongJae Park


================================ >8 ===========================================
From aeb852296bc40ca1de8a6a11f4d5368b02d2e417 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sjpark@amazon.de>
Date: Sun, 26 Jul 2020 01:14:48 +0200
Subject: [PATCH] scripts/deprecatd_terms: provide references

Deprecation of terms could have special rules.  For example, 'slave' is
ok for existing usages.  Same to 'master', but it's also ok unless it's
used with 'slave'.  This commit provides the references for such rules.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 scripts/checkpatch.pl        | 2 +-
 scripts/deprecated_terms.txt | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e9fde28eb0de..77f5f777b053 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2981,7 +2981,7 @@ sub process {
 				my $msg_level = \&WARN;
 				$msg_level = \&CHK if ($file);
 				if (&{$msg_level}("DEPRECATED_TERM",
-						  "Use of '$deprecated_term' is deprecated, please '$suggested', instead.\n" . $herecurr) &&
+						  "Use of '$deprecated_term' is controversial - if not required by specification, perhaps '$suggested' instead.  See: scripts/deprecated_terms.txt\n" . $herecurr) &&
 				    $fix) {
 					$fixed[$fixlinenr] =~ s/(^|[^A-Za-z@])($deprecated_term)($|[^A-Za-z@])/$1$suggested$3/;
 				}
diff --git a/scripts/deprecated_terms.txt b/scripts/deprecated_terms.txt
index 1be27a24187b..d92b9c896fce 100644
--- a/scripts/deprecated_terms.txt
+++ b/scripts/deprecated_terms.txt
@@ -3,8 +3,10 @@
 # The format of each line is:
 # deprecated||suggested
 #
+# If special rules are applied on the terms, please comment those.
+#
+# Refer to "4) Naming" section of Documentation/process/coding-style.rst for
+# below three terms.
 blacklist||(denylist|blocklist)
-# For other alternatives of 'slave', Please refer to
-# Documentation/process/coding-style.rst
 slave||(secondary|target|...)
 whitelist||(allowlist|passlist)
-- 
2.17.1

