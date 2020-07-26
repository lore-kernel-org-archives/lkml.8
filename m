Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9F1C433EA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E79020759
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVo97B/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgGZPgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgGZPgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:36:16 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5D1C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 08:36:16 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id kq25so1633104ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=HDG9/ek9z1S16A5dtxmL+5qh96r+OR3wdAt2UD99xf8=;
        b=AVo97B/a29T3cdG3nvRjJyvoj8+TvYxwL1F/zxvwaO6TPdrBJ32G2Su/QH8mD4pdP8
         pA2xucxxTNYt2Y3YO3ew8gufRBE6xApEZM5JMV/fHqkcZTgoPHhfkcPEeSRojG8LikZr
         NNqOzQEcVFEm8gMTEWvgpdi4t5O13Pfq0cZ5S7jLckrltiI2+QxqkzpLlxd4sUvHksr8
         kF6jA3C+oTJ5HshEHpFDBvdPzxaeOMrM6lTwczN8daJtagRzw9ONBpLqTOsv9ynDlpqu
         bUDKQn7Ofr+6yjhk+tuPU2JX00+9bDcdEZ3Cbbt+aG/MHpuVCNBB8KpSpUnlU6dNFjxj
         MrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=HDG9/ek9z1S16A5dtxmL+5qh96r+OR3wdAt2UD99xf8=;
        b=hVHKBMFU/P1lMag6UdfmpEN5GPDDVochocyvLuzxE4lZCebYC+3n1Q/vDH0TmYGSRN
         Ex+y3DjeJ9xhAaVqaVb54+OGDT3JMZtfEwF2zPKdNA2WokqrPmgRfOrIOYG/VWAhbeBl
         Lq1sHne3nDZwfWJsqQxR1mJ99ZF0bmn7NG1EP811QmFLhXksBnoLqBYQOzsfw6hRQnPS
         U9uK5ATpy2/lYeJqvX9W7pVtuEKeOs9SSt42ejvfXrq54OWXdaGa058/DmkhtvUr/X+d
         R24X1/FBnT9Pt+t6B5RJN253DOMzMlePMzvZTe0ldls1vDGu67sIrM1AcMpk9e5bBOk/
         zTwg==
X-Gm-Message-State: AOAM532W3rCgT3HJgP5NGscsiC9mfG+BuLenycaJYo+i3vWghiJJ3Lj1
        2BDIitYnfposmZnkI0/GHe8=
X-Google-Smtp-Source: ABdhPJwEgeKfyyUieqmI040WhoQwsBIN3eS5wUk9qFfv04NNZuV0nFb5faTuEXAbBlauQoWYSbAA/Q==
X-Received: by 2002:a17:906:3e4f:: with SMTP id t15mr3529388eji.368.1595777775095;
        Sun, 26 Jul 2020 08:36:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:60d3:6c2f:f9ba:e713])
        by smtp.gmail.com with ESMTPSA id ay5sm216386edb.2.2020.07.26.08.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 08:36:14 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        colin.king@canonical.com, jslaby@suse.cz, pavel@ucw.cz,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: Re: Re: Re: checkpatch: support deprecated terms checking
Date:   Sun, 26 Jul 2020 17:36:01 +0200
Message-Id: <20200726153601.13855-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <dae471a789ee6e0bda5e641eb8e376fd03667415.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 07:50:54 -0700 Joe Perches <joe@perches.com> wrote:

> On Sun, 2020-07-26 at 09:45 +0200, SeongJae Park wrote:
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -721,6 +721,7 @@ sub read_word_corrections {
> >  my %deprecated_terms_fix;
> >  read_word_corrections($deprecated_terms_file, \%deprecated_terms_fix);
> >  my $deprecated_terms = join("|", sort keys %deprecated_terms_fix) if keys %deprecated_terms_fix;
> > +my %deprecated_terms_reported = map { $_ => 1 }
> 
> overly verbose naming and this doesn't need initialization here.
> 
> > @@ -2975,13 +2976,16 @@ sub process {
> >  		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> >  			while ($rawline =~ /(?:^|[^a-z@])($deprecated_terms)(?:\b|$|[^a-z@])/gi) { 
> >  				my $deprecated_term = $1;
> > +				last if (exists($deprecated_terms_reported{$deprecated_term}));
> 
> next if (...) to check if multiple terms exists on the same line

Agreed on these comments, thanks!

> 
> > +				$deprecated_terms_reported{$deprecated_term} = 1;
> > +
> 
> But this does need to be reset to empty when checking the next file

Hmm... I though you mean reporting same term multiple times too verbose... Did
I misunderstand your point?

> 
> >  				my $suggested = $deprecated_terms_fix{lc($deprecated_term)};
> >  				$suggested = ucfirst($suggested) if ($deprecated_term=~ /^[A-Z]/);
> >  				$suggested = uc($suggested) if ($deprecated_term =~ /^[A-Z]+$/);
> >  				my $msg_level = \&WARN;
> >  				$msg_level = \&CHK if ($file);
> >  				if (&{$msg_level}("DEPRECATED_TERM",
> > -						  "Use of '$deprecated_term' is deprecated, please '$suggested', instead.\n" . $herecurr) &&
> > +						  "Use of '$deprecated_term' is controversial - if not required by specification, perhaps '$suggested' instead.  See: scripts/deprecated_terms.txt\n" . $herecurr) &&
> >  				    $fix) {
> >  					$fixed[$fixlinenr] =~ s/(^|[^A-Za-z@])($deprecated_term)($|[^A-Za-z@])/$1$suggested$3/;
> 
> I think it simpler to avoid emitting this on existing files.

Agreed, it's much simpler.  However, my concerns on excluding existing file
checks are:

1. Avoiding existing file checks will still not stop warning patches mentioning
existing deprecated terms.
2. If the term mistakenly comes in newly, it would be hard to check it later.
3. Some future deprecations of terms might be applied to existing uses, as
's/fuck/hug' did.

> 
> I do not want to encourage relatively inexperienced people
> to run checkpatch and submit inappropriate patches.

Me, neither.  But, I think providing more warnings and references is better for
that.  Experienced people would be able to easily ignore the false positives.
Simply limiting checks could allow people submitting inappropriate patches
intorducing new uses of deprecated terms.


Thanks,
SeongJae Park
