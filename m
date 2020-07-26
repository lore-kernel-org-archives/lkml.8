Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A576C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B18F2065C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edp7OWEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGZSIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGZSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:07:59 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6429CC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:07:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id kq25so1859518ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=2M1elyjIsh1RH9XtmhfvtASaVeMWTT/sz6S1xmpP4GM=;
        b=edp7OWEmG9tfeMg8I77+sKCI3lGSevdMWrcIvJVWZUTroTpmfHYHBeovpNFW7/eIAg
         TdGC5cIKCIVRYia+aTC3WP8a5+TRao836l3inNTXy6vy787dSRyWya+fx29gbiODpygl
         uPGokuvfRWcdkjzqA8LZO2N1yvtO/84J1IiIX9cuOqUABJL4aMistiehLkewdjJ+m10X
         7MBU4/TOnV7wAtEW0df79n07htUI5onhsLAiI9ku6ET2W9VZfZYSX1Ew7vSA3YITz3O1
         B50V2uTH5TYgTn99aCFiij0/RpVOfv26s8RzjKhceVKQorEAH8Hj05Oz8nVCryYYuUwL
         Zl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=2M1elyjIsh1RH9XtmhfvtASaVeMWTT/sz6S1xmpP4GM=;
        b=VvgtOik2HLjQ13lfEAO1J11xmjJW/0JX0L9hW2dedwSqOUdVhoxK5Z00VKf/Ez2aqP
         PSaLhG0LbR3FBE5TtfGll0LGQWEcd/wd+HZ100FEtCFReMC+UFygfr262VNEMHcGig7M
         33VuKT2j/3/CUtLtdIhiCvAH9r1Xyk0AYFW2B4bhWIcy2cZ8sZObC501De6USDBd/s4H
         AhQtpQd63sAB+qzpikLdVKqUKhEsxclU3xkM4HlDHjM7q84cADWpZSskpTKcJcI3lSdP
         f6BzXdNENHnCOyok3qDxKM66/eGzb5hP2rW8Q+LvbIeQfze2xZ1fw2oqKG7lN+HZ4z6t
         HZIA==
X-Gm-Message-State: AOAM530DIM9Ddcj5kU36dY3ThB6gbvNlo03Nkpa1+7GOfkOTtzMtYBTJ
        xwaE+EyXyF/4SSdrqUDnbWfQAtI6
X-Google-Smtp-Source: ABdhPJzjR0ydGuruBA7IaSGo9LqYRVpMCTxENug6M71E6KQ9QFEBSkeJL9IJKChBqm6W3FCRfE+/Dg==
X-Received: by 2002:a17:906:7a16:: with SMTP id d22mr4132827ejo.478.1595786878105;
        Sun, 26 Jul 2020 11:07:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:60d3:6c2f:f9ba:e713])
        by smtp.gmail.com with ESMTPSA id a18sm1117186ejt.69.2020.07.26.11.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 11:07:57 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        "SeongJae Park" <sjpark@amazon.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        colin.king@canonical.com, jslaby@suse.cz, pavel@ucw.cz,
        "SeongJae Park" <sjpark@amazon.de>
Subject: Re: Re: Re: Re: Re: checkpatch: support deprecated terms checking
Date:   Sun, 26 Jul 2020 20:07:48 +0200
Message-Id: <20200726180748.29924-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <5f5679b4c76bf0e16064f3a45319bc35938ad96b.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 09:42:06 -0700 Joe Perches <joe@perches.com> wrote:

> On Sun, 2020-07-26 at 17:36 +0200, SeongJae Park wrote:
> > On Sun, 26 Jul 2020 07:50:54 -0700 Joe Perches <joe@perches.com> wrote:
> []
> > > I do not want to encourage relatively inexperienced people
> > > to run checkpatch and submit inappropriate patches.
> > 
> > Me, neither.  But, I think providing more warnings and references is better for
> > that.
> 
> Unfortunately, the inexperienced _do_ in fact run
> checkpatch on files and submit inappropriate patches.
> 
> It's generally a time sink for the experienced
> maintainers to reply.
> 
> > Simply limiting checks could allow people submitting inappropriate patches
> > intorducing new uses of deprecated terms.
> 
> Tradeoffs...
> 
> I expect that patches being reviewed by maintainers
> are preferred over files being inappropriately changed
> by the inexperienced.
> 
> Those inappropriate changes should not be encouraged
> by tools placed in the hands of the inexperienced.

Right, many things are tradeoff.  Seems we arrived in the point, though we
still have different opinions.  To summarize the pros and cons of my patch from
my perspective:

Pros 1: Handle future terms deprecated with different reasons and coverages.
Pros 2: Inappropriate patches are avoided if the submitters carefully read the
warning messages.
Cons: Careless people could still bother maintainers by not carefully reading
the message and sending inappropriate patches.

To me, the pros still seems larger than the cons.  I would like to also again
mention that the maintainer who first reported the problem, Michal, told it's
ok with the explicit messaging.  Nonethelss, this is just my opinion.

Attaching the patch addressing your comments for the previous version.  The
changes from the previous version are:

 - Make the name of reported terms not too verbose
 - Avoid unnecessary initialization of the reported terms hash
 - Warn multiple deprecated terms in same line


Thanks,
SeongJae Park


p.s I modified my mail formatter to skip adding 'Re:' in the subject.  I
thought it's usual behavior of the mailers, but seems it made you only
annoying, sorry.  I will not add more 'Re:' for you.


=================================== >8 ========================================
From 169939e24ae98125efcf3af024e6e09cf5cd85f0 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sjpark@amazon.de>
Date: Sun, 26 Jul 2020 01:14:48 +0200
Subject: [PATCH v3] scripts/deprecatd_terms: provide references

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
index e9fde28eb0de..abed47647fb0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -721,6 +721,7 @@ sub read_word_corrections {
 my %deprecated_terms_fix;
 read_word_corrections($deprecated_terms_file, \%deprecated_terms_fix);
 my $deprecated_terms = join("|", sort keys %deprecated_terms_fix) if keys %deprecated_terms_fix;
+my %deprecates_reported = map
 
 # Load common spelling mistakes and build regular expression list.
 my $misspellings;
@@ -2975,13 +2976,16 @@ sub process {
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
 			while ($rawline =~ /(?:^|[^a-z@])($deprecated_terms)(?:\b|$|[^a-z@])/gi) {
 				my $deprecated_term = $1;
+				next if (exists($deprecates_reported{$deprecated_term}));
+				$deprecates_reported{$deprecated_term} = 1;
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


