Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2BEC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 04:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B113214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 04:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxzusM+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgAaEif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 23:38:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50951 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgAaEif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 23:38:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so6397777wmb.0;
        Thu, 30 Jan 2020 20:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=oDOB3tFtxj93DPnWxh56XAU2jSpH1dQDUMEBGyeor6c=;
        b=GxzusM+/gJ+zoUm50WLt80RLK+0W13QNdONS+Q+Cag8tnKIUiWGimJOU5mD1/3qXY1
         CQhIOpp5JOUZx5wgEbUnRFAQSGWU+Ex92U0W8NhhchXtUEHO2Eh8yZdMqdVWGxq+U0i9
         EXX2Eb682Urdq7R2y14x20p9VhFNCdMv7MUDCol6zZt27G4+Gwg+vnfcZJ5uAaXiB1yE
         jib4FqzlNMo77f/YWu7ooGyri3HJyLPUFccHx4fKRbMh8JAtw6rTetblFeNcxEkn0phG
         71wskTwxnTXaQ1gWX4mu415r14P3TywQpyYH/Zbj253cjFycJmAkR71A2GwW8KmqBS8z
         y3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=oDOB3tFtxj93DPnWxh56XAU2jSpH1dQDUMEBGyeor6c=;
        b=jx2mtmi07Pn1dHZQx4zqjNZuSGSfiF6CwhIGFgze+ixyH2khgUCikbLdsjVhjg7FHy
         60gxhVKg/M8QjZN1oR9xgT2Ezz1zzjWFLuMTe2p8BQNnihFVswmPnMmStbKXf4yHFzZC
         stEOXxWwJNTWJb0u03umIyvQ8pAd2KgUvT7YnDWW9twByJEsgUI/+Qsht+LH3FkzAPvT
         GDKiHSq3NMOeiL9RiOd0KYyrjiqH99pNqeGhYfdVGtBJUd00WgHuer3cm2SdTmumbYMF
         4LDqWMyMAWfHMBPue0kG4Ua8AIanNjLUYnzJeQRRXii3+OouQ0E6p06roKbRMj9NirN9
         hkpw==
X-Gm-Message-State: APjAAAVHJrDlbVnVGr56IirkkcXPaFY5W1B3lAjHmEPlBsSIkv/r4fZB
        gkyo3P+SWUd/vIChDqGTFeuwl8dqTlk=
X-Google-Smtp-Source: APXvYqz4DSy66qBxdWTDkBBiOyTeHW8HYH6P3Dc6EFMqTcHcTGp5ZLTgvPuDrZ18og+5x85+vbwR7Q==
X-Received: by 2002:a05:600c:22c8:: with SMTP id 8mr9430647wmg.178.1580445513443;
        Thu, 30 Jan 2020 20:38:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:9e5:a83e:83e7:3809])
        by smtp.gmail.com with ESMTPSA id s139sm9525679wme.35.2020.01.30.20.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 20:38:32 -0800 (PST)
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
Subject: Re: Re: [PATCH v2 1/9] mm: Introduce Data Access MONitor (DAMON)
Date:   Fri, 31 Jan 2020 05:38:23 +0100
Message-Id: <20200131043823.29654-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g46fnZBiBYdBDmd=wJctoshbS2Q2JFGVBpoiPbis41Jw_Q@mail.gmail.com> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 15:58:44 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:

> On Tue, Jan 28, 2020 at 12:58 AM <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> [...]
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 56765f542244..5a4db07cad33 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4611,6 +4611,12 @@ F:       net/ax25/ax25_out.c
> >  F:     net/ax25/ax25_timer.c
> >  F:     net/ax25/sysctl_net_ax25.c
> >
> > +DATA ACCESS MONITOR
> > +M:     SeongJae Park <sjpark@amazon.de>
> > +L:     linux-mm@kvack.org
> > +S:     Maintained
> > +F:     mm/damon.c
> > +
> 
> No one else has complained, so don't feel like you need to do it on my
> account, but I have had maintainers tell me that the MAINTAINERS
> update should be in its own patch and come at the end of the patchset.
> Up to you, but you might want to do it now if you are going to send
> another revision for other reasons.

I got warned from 'checkpatch.pl' and thus made the change here:

    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

If anyone has differenct opinion, please don't hesitate to yell at me!


Thanks,
SeongJae Park

> 
> >  DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
> >  L:     netdev@vger.kernel.org
> >  S:     Orphan
> [...]
