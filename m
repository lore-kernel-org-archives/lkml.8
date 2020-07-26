Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061D1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57892065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loD5ec1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGZHpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 03:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGZHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:45:22 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D3C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 00:45:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g7so5698774ejw.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 00:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=nCCYGPpnUcsKc3bltKWUjh1ZZs0fdH6SpF66gG9KHx8=;
        b=loD5ec1nLKOmZlOuMAdxs7+f8R9demqGSG5nOZgBQhJwTcZoPzrVXCjs/BV92AsZyj
         2MrIi4bYi4Y9DZSokqk2RX6DZS9D8Jjs6B+Um2EiW95H3tSWKjIPN9+xRSFrcC5c1PiH
         WJoqtTw2/dtcm+c9mdgXoCbx+SKBmv3OUCwBAROVB1Oonoyff6wa6LfAYvgF7sOj8yfb
         KekWBOJzkCkojMpaVOeoOqnWh9n6cXokZCzrrcxUVPblsTCWHD72qK/I/ICzTF1DoA0q
         SRlTb9Fy4BZOD3AQLtdA5wizHNzz7kQPsS+pupx39gP48+n2fWZFjtHtgvOWc37DFhZg
         dlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=nCCYGPpnUcsKc3bltKWUjh1ZZs0fdH6SpF66gG9KHx8=;
        b=ugjeC9az4R7PxKDEUdKMprfAEHM8M8dk+TYH76LCVz0IJC5L9odIwb8Oi4xCQ3iIlf
         TSCfdC3NTAcenI64TnJtVsQPrKCWD8u2E8FPKrEnGPI08nQlzeFUpFHDLX5Ln5AH8fGo
         w/H2Vx2ilq3nQDdIz2gh8lf5Md5Z3P8eHy5eOGvvgKwsVLT5rEnR/sNPLasL8B6j/vDG
         oSX4BsvWyRgvvEIzcETHVUosTj6jW54TeTfocFkmtliQo2rAvU8m7Ez0QocqRAZaxlvc
         NnhtVTQoXwdQUeJpHZhNKabHmQMfj6aNOuy7E8qGZ/oEjoyQucob1rVBIHCqHGkIBe/6
         5Dbw==
X-Gm-Message-State: AOAM531FDU2fh/G0onUu6IMR8FDlh/Y5QXw/X2xCgmfCN2bEFgWwua1N
        uP1on1EMQh3yoNv8Q1i4kRI=
X-Google-Smtp-Source: ABdhPJx3zR3qQ4I5ruomm8O0HGkU2dgx5D6KpXtdKSNC2w296PMCKmXjrP3VjsPoE/te8kZ1vmh1+A==
X-Received: by 2002:a17:906:280c:: with SMTP id r12mr16020580ejc.105.1595749520298;
        Sun, 26 Jul 2020 00:45:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:60d3:6c2f:f9ba:e713])
        by smtp.gmail.com with ESMTPSA id 6sm3070782ede.84.2020.07.26.00.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 00:45:19 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        "SeongJae Park" <sjpark@amazon.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        colin.king@canonical.com, jslaby@suse.cz, pavel@ucw.cz,
        "SeongJae Park" <sjpark@amazon.de>
Subject: Re: Re: Re: Re: checkpatch: support deprecated terms checking
Date:   Sun, 26 Jul 2020 09:45:11 +0200
Message-Id: <20200726074511.26189-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <beabe887ee1b761781f5d980a96f2c28b088c56b.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 00:29:05 -0700 Joe Perches <joe@perches.com> wrote:

> On Sun, 2020-07-26 at 09:18 +0200, SeongJae Park wrote:
> > On Sat, 25 Jul 2020 21:27:07 -0700 Joe Perches <joe@perches.com> wrote:
> > 
> > > On Sun, 2020-07-26 at 01:35 +0200, SeongJae Park wrote:
> > > > On Sat, 25 Jul 2020 10:29:23 -0700 Joe Perches <joe@perches.com> wrote:
> > > > 
> > > > > On Sat, 2020-07-25 at 15:02 +0200, Michał Mirosław wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > I see that this patch went into next and is already inciting people to
> > > > > > do wrong things [1]. Can you please fix it to require '--subjective'
> > > > > > switch or otherwise mark it clearly as suggestion-only?
> > > > > > 
> > > > > > The coding-style as in Linus' master says about *NEW* uses of the words
> > > > > > listed (those introductions I expect to be actually rare) and not about
> > > > > > existing use in the code or industry. Making a noise about all uses
> > > > > > found surely will generate a lot more irrelevant patches.
> > > > > > 
> > > > > > [1] https://www.spinics.net/lists/linux-tegra/msg51849.html
> > > > > 
> > > > > And if not reverted, perhaps do not check existing files
> > > > > at all but only check patches and change the message to
> > > > > show only suggestions not from a specification.
> > > > 
> > > > Agreed for this case.  However, excluding existing file check doesn't fully
> > > > avoid this problem.  Also, more terms having different deprecation rules might
> > > > be added in future.  How about allowing file check but show reference in the
> > > > suggestion message as below?
> > > 
> > > The general problem is that drivers/staging, net/ and drivers/net
> > > all have --strict on by default.
> > > 
> > > Emitting these deprecated terms messages with -f --file uses for
> > > files in those directories isn't a great idea.
> > 
> > Thank you for kindly explaining your concenrs in detail.  However, I think it's
> > ok to do this check even without '--strict' for files if we explicitly says
> > it's suggestion only, as Michal said.  My patch does so.
> > 
> > > > diff --git a/scripts/deprecated_terms.txt b/scripts/deprecated_terms.txt
> > > []
> > > > @@ -3,8 +3,10 @@
> > > >  # The format of each line is:
> > > >  # deprecated||suggested
> > > >  #
> > > > +# If special rules are applied on the terms, please comment those.
> > > 
> > > Disagree.  Comments about these existing uses aren't helpful.
> > 
> > Sorry, I don't understand your point here.  Why do you think it's not helpful?
> > If 'checkpatch' finds the deprecated terms, it will ask people to read this
> > file, which explains special rules for each of the deprecations if exists.  The
> > rule is, in the case of 'slave', 'applies to new uses only'.  Therefore, people
> > could stop sending the noisy unnecessary patches to the maintainers.
> 
> Because it will describe this for _every_ instance
> of any deprecated word in the file.

Thank you for kindly explaining your concern.  I personally thought the verbose
warning is not a real problem.  Anyway, how about below patch, then?  It will
show only one warning or check for each of the terms.

================================= >8 ==========================================

From 6c606c62ea25933db8bb0afec083b5b4b8b3f11f Mon Sep 17 00:00:00 2001
From: SeongJae Park <sjpark@amazon.de>
Date: Sun, 26 Jul 2020 01:14:48 +0200
Subject: [PATCH] scripts/deprecatd_terms: provide references

Deprecation of terms could have special rules.  For example, 'slave' is
ok for existing usages.  Same to 'master', but it's also ok unless it's
used with 'slave'.  This commit provides the references for such rules.

Also, because the report became more verbose a little, this commit makes
the report to be made for only one instance of each deprecated term.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 scripts/checkpatch.pl        | 6 +++++-
 scripts/deprecated_terms.txt | 6 ++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e9fde28eb0de..227e088bfe56 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -721,6 +721,7 @@ sub read_word_corrections {
 my %deprecated_terms_fix;
 read_word_corrections($deprecated_terms_file, \%deprecated_terms_fix);
 my $deprecated_terms = join("|", sort keys %deprecated_terms_fix) if keys %deprecated_terms_fix;
+my %deprecated_terms_reported = map { $_ => 1 }
 
 # Load common spelling mistakes and build regular expression list.
 my $misspellings;
@@ -2975,13 +2976,16 @@ sub process {
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
 			while ($rawline =~ /(?:^|[^a-z@])($deprecated_terms)(?:\b|$|[^a-z@])/gi) {
 				my $deprecated_term = $1;
+				last if (exists($deprecated_terms_reported{$deprecated_term}));
+				$deprecated_terms_reported{$deprecated_term} = 1;
+
 				my $suggested = $deprecated_terms_fix{lc($deprecated_term)};
 				$suggested = ucfirst($suggested) if ($deprecated_term=~ /^[A-Z]/);
 				$suggested = uc($suggested) if ($deprecated_term =~ /^[A-Z]+$/);
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


