Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A0C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF3C206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqp1nXp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgBAIwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 03:52:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55917 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgBAIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 03:52:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so10540326wmj.5;
        Sat, 01 Feb 2020 00:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=hT5skZOoqWRhUjCWgtZzuttwtqGUoIahO4XcPPg+prc=;
        b=uqp1nXp+n9tdqX5SS1aOnwcnKko4AFGnDpzT6eiK98feiIuqWzntnolmtmBv8Y6UT3
         maM4lZwunqN/uKs64q1S+O1BNy/vUVKDKA4QqwMys3q4sGjIWdeNg5hQmw+A+/ejHzWz
         ZEsFLr3jzl+ssQws3qjN/SWz1E9HmK7YC3cvCFT5iw0NIfR9ixePgXus0yWOtfpFtqbw
         LcUcLSURvlt+2i7Ald0PCOhrLGzcrraRRB9/a8eKS2bULkBGL3nUAgVGRWi1LLS34eDB
         ZDJqgPKxiQbMLecKouqLV2bZkRLI1vCgSdtXODWxP2rgzE9Xf33vgAD93aIEcMNQLYta
         Ar6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=hT5skZOoqWRhUjCWgtZzuttwtqGUoIahO4XcPPg+prc=;
        b=cQlFn8hssR9UbnM05YKVPTxFVw32n//cgbigiSVzGZ7CVyXqS2KTqqQ5/jgsIqOa38
         gNuVugWVoxnpH8utZB45h8Xj2nNQlBH1ASTlRwqyagsFuqGJ6YE/J+/cfZtdKH0rG5GQ
         RxRdTheF+RrOuxYmRZFA3yGl4M8Ytpx0WElradMynMDROFBSvH3HgF6eVuyCKcFaAem7
         AZPM/7UT801xioHdyODegrWrMqXtuK1MSkBfrUA9LTjNl26vjYwp2NqTM1Ep1SeeC/LX
         yuPhWTFs74D0wE5RKobfJZ/JYtKedJqC6DMeIZnqu+spREEuWrlKpqNjvT7BGRivD3dh
         H0Bg==
X-Gm-Message-State: APjAAAWj0dKc5Sw/cNaAyhsOqYQ50qKIE8UaMpLhsRhVk6D08FnEi6AF
        4es/4jy4OG+vgraCWIHyZA4=
X-Google-Smtp-Source: APXvYqyEdp5zvKFhEc7Tx7bIrSUiB2nsiAZIU8kjNnxyC1HBl8ob35LAaitTvbxPLY03HEcdijhAjw==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr17709687wmc.165.1580547163232;
        Sat, 01 Feb 2020 00:52:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:bcd7:b36c:40fc:d163])
        by smtp.gmail.com with ESMTPSA id a1sm15419304wrr.80.2020.02.01.00.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 00:52:42 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, acme@kernel.org,
        amit@kernel.org, brendan.d.gregg@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, dwmw@amazon.com,
        mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>,
        kirill@shutemov.name, colin.king@canonical.com, minchan@kernel.org,
        vdavydov.dev@gmail.com, vdavydov@parallels.com, linux-mm@kvack.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH v2 6/9] mm/damon: Add minimal user-space tools
Date:   Sat,  1 Feb 2020 09:52:33 +0100
Message-Id: <20200201085233.28942-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131044427.29930-1-sj38.park@gmail.com> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 05:44:27 +0100 SeongJae Park <sj38.park@gmail.com> wrote:

> On Thu, 30 Jan 2020 16:02:26 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:
> 
> > On Tue, Jan 28, 2020 at 1:00 AM <sjpark@amazon.com> wrote:
> > >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > This commit adds a shallow wrapper python script, ``/tools/damon/damo``
> > > that provides more convenient interface.  Note that it is only aimed to
> > > be used for minimal reference of the DAMON's raw interfaces and for
> > > debugging of the DAMON itself.  Based on the debugfs interface, you can
> > > create another cool and more convenient user space tools.
> > >
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > ---
> > >  MAINTAINERS               |   1 +
> > >  tools/damon/.gitignore    |   1 +
> > >  tools/damon/_dist.py      |  35 ++++
> > >  tools/damon/bin2txt.py    |  64 +++++++
> > >  tools/damon/damo          |  37 ++++
> > >  tools/damon/heats.py      | 358 ++++++++++++++++++++++++++++++++++++++
> > >  tools/damon/nr_regions.py |  88 ++++++++++
> > >  tools/damon/record.py     | 194 +++++++++++++++++++++
> > >  tools/damon/report.py     |  45 +++++
> > >  tools/damon/wss.py        |  94 ++++++++++
> > >  10 files changed, 917 insertions(+)
> > >  create mode 100644 tools/damon/.gitignore
> > >  create mode 100644 tools/damon/_dist.py
> > >  create mode 100644 tools/damon/bin2txt.py
> > >  create mode 100755 tools/damon/damo
> > >  create mode 100644 tools/damon/heats.py
> > >  create mode 100644 tools/damon/nr_regions.py
> > >  create mode 100644 tools/damon/record.py
> > >  create mode 100644 tools/damon/report.py
> > >  create mode 100644 tools/damon/wss.py
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 5a4db07cad33..95729c138d34 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4616,6 +4616,7 @@ M:        SeongJae Park <sjpark@amazon.de>
> > >  L:     linux-mm@kvack.org
> > >  S:     Maintained
> > >  F:     mm/damon.c
> > > +F:     tools/damon/*
> > >
> > >  DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
> > >  L:     netdev@vger.kernel.org
> > 
> > Another reason to put the MAINTAINERS update at the end; that way you
> > don't have multiple edits sprinkled around your patchset.
> 
> I made this change here due to the warning from 'checkpatch.pl' (WARNING:
> added, moved or deleted file(s), does MAINTAINERS need updating?).  But, as it
> is just a warning, I think simply ignore it and and make this change at the end
> of the patchset would not be a problem, anyway.  What would you prefer?

I think I was too worrying for just warnings.  Will ignore the warnings and
move the MAINTAINERS changes to last patch, as you suggested.


Thanks,
SeongJae Park

> 
> 
> Thanks,
> SeongJae Park
> 
