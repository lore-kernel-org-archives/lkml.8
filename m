Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7253C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 04:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7942082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 04:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+MdPoPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgAaEol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 23:44:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33070 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgAaEok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 23:44:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so7085136wrq.0;
        Thu, 30 Jan 2020 20:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=VULHDYUly2KzREKC7TNfPB9rI92l+6xsU3JPnd4HSgU=;
        b=K+MdPoPiES36gTA8+5iUoDTlzexY4IPCYNjL1NycmDpZlehQV94qURDB/wpg+9SICc
         NMueYDE0kI6I7H1a0nsu3rXKmrNm27AfpztwWq7AFdtzGoERM2eYWORFLxOG07dptmGs
         HyxKW3cWGFme+4v4GEN2J2GtzlXHudEgJB8tGjKGuVFjkKhVJsJ7tW/h3oy87z+9RU22
         0+1Ne7lYUJbi6lAyVyEfOX6OfJcThAGA3X+YU5kNRR3SRDW2tUxHtmsixKo+kvNspHfi
         gdNq+FNIRUdd5Y4AAT541ybMNrvCLN8ukvY4FzluhlCrGkiSbA4rWdy2wTOfF6XU8/VJ
         5+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=VULHDYUly2KzREKC7TNfPB9rI92l+6xsU3JPnd4HSgU=;
        b=YHchFgJUzGZFe9DsPKGVAZY0eX8Zw8gio7980FoGiA29fnn8ck6ub9FZ9g4KkOYg9d
         ZaLALLGbPDfALsmjyBOVlI6sdCx3glZe/+iYMyldR43ECG8un1nl6uYvJfZRBeIfV7Va
         h5luXfSa4ZVcdseDNkQcv7KXZjklUp/b17ge+kSbPrxfYJdu0+O34PACOIk5TEN2S7pw
         psrLNDi2Q40xw5iOgy1olZrC8lH97Pr1LoBvm/9k4dwSo7e36MPCeK2jxHkRP32Wny8j
         X91IGjKkiyIU0DK5bwTsJuXmOtQRHxsrKVZWl3xahPsFu1e3VBGreotxjot68KKhXSHM
         YafA==
X-Gm-Message-State: APjAAAWrlUtJTPVbz4Mo43lVkuM9HSc+Ihl1gX71ES92iXOAYjb+7btf
        MMKpzArTR6g+EbNk7d1Jf34=
X-Google-Smtp-Source: APXvYqxF+UPTlhZ+bdpD8gbUVnU+lheA4MxvAYJqA4Fn5xRurz/OIOSaBJauo7RvAefH/hllM99cvA==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr9364827wrr.82.1580445877702;
        Thu, 30 Jan 2020 20:44:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:9e5:a83e:83e7:3809])
        by smtp.gmail.com with ESMTPSA id n28sm10379935wra.48.2020.01.30.20.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 20:44:37 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        SeongJae Park <sj38.park@gmail.com>, acme@kernel.org,
        amit@kernel.org, brendan.d.gregg@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, dwmw@amazon.com,
        mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>,
        kirill@shutemov.name, colin.king@canonical.com, minchan@kernel.org,
        vdavydov.dev@gmail.com, vdavydov@parallels.com, linux-mm@kvack.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v2 6/9] mm/damon: Add minimal user-space tools
Date:   Fri, 31 Jan 2020 05:44:27 +0100
Message-Id: <20200131044427.29930-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g45yXr-dNtgwUytVxwOGS5vfktZORNQ-p050cpN6W37bJQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 16:02:26 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:

> On Tue, Jan 28, 2020 at 1:00 AM <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit adds a shallow wrapper python script, ``/tools/damon/damo``
> > that provides more convenient interface.  Note that it is only aimed to
> > be used for minimal reference of the DAMON's raw interfaces and for
> > debugging of the DAMON itself.  Based on the debugfs interface, you can
> > create another cool and more convenient user space tools.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  MAINTAINERS               |   1 +
> >  tools/damon/.gitignore    |   1 +
> >  tools/damon/_dist.py      |  35 ++++
> >  tools/damon/bin2txt.py    |  64 +++++++
> >  tools/damon/damo          |  37 ++++
> >  tools/damon/heats.py      | 358 ++++++++++++++++++++++++++++++++++++++
> >  tools/damon/nr_regions.py |  88 ++++++++++
> >  tools/damon/record.py     | 194 +++++++++++++++++++++
> >  tools/damon/report.py     |  45 +++++
> >  tools/damon/wss.py        |  94 ++++++++++
> >  10 files changed, 917 insertions(+)
> >  create mode 100644 tools/damon/.gitignore
> >  create mode 100644 tools/damon/_dist.py
> >  create mode 100644 tools/damon/bin2txt.py
> >  create mode 100755 tools/damon/damo
> >  create mode 100644 tools/damon/heats.py
> >  create mode 100644 tools/damon/nr_regions.py
> >  create mode 100644 tools/damon/record.py
> >  create mode 100644 tools/damon/report.py
> >  create mode 100644 tools/damon/wss.py
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5a4db07cad33..95729c138d34 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4616,6 +4616,7 @@ M:        SeongJae Park <sjpark@amazon.de>
> >  L:     linux-mm@kvack.org
> >  S:     Maintained
> >  F:     mm/damon.c
> > +F:     tools/damon/*
> >
> >  DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
> >  L:     netdev@vger.kernel.org
> 
> Another reason to put the MAINTAINERS update at the end; that way you
> don't have multiple edits sprinkled around your patchset.

I made this change here due to the warning from 'checkpatch.pl' (WARNING:
added, moved or deleted file(s), does MAINTAINERS need updating?).  But, as it
is just a warning, I think simply ignore it and and make this change at the end
of the patchset would not be a problem, anyway.  What would you prefer?


Thanks,
SeongJae Park
