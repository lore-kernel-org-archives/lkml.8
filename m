Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD49C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381D820708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594288727;
	bh=NJVaWQFK6qtOZCjhReNU5i7irwKEUX/ZygyTaNXQZg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aorVBzkp0dggZzVNZnVAflfJAsxKJ/Fcm5Zp1xQbAW64+dOuWgdcLo2Y3Z51JBek/
	 o1XVaMT9fUz53o94kpPZn17phfX3QfNDLTMqDRN/QpGY7eIMljwanNBAQwSLnZXYk3
	 +h5ZK9nnsaBdM4B0HswCLO4HhUgXzUjwMS/i7q50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgGIJ6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:58:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33857 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIJ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:58:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so1703714wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 02:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fcVd+42gAsaDsTUC8Mwb0seStM1wcCxxRuSbi3ul/6g=;
        b=adpmt9aiFe9FVgaoMmEUMBSLSe2lC7n8/rlOzCtnH9YaGd6bi+T7KwX2cEhawHGczJ
         uC4Q4kzjgFuS2soC8v4FMoyCph3RCaCwyhEH1LrZJhzq8zXYKWGZ3+Zvm5+75gpE3mon
         PNicW+UqIaTTFhlSj0imgLwfQW+PGMXZQ7ctTea/DITH334GQ3VPixjWdw5OCTSU6cPR
         tQJlnbrcCqZTzXuzK7wFRbXQVDJ8YqSGC0KvyutgzZDb+DUA514pjG1VFjH2uXMXsiVW
         2EzdeKNC/EPyAiYGPYJbB1TUyDdP0mZ8e+WnxDUKlAjjnwsNdtVhDnjnVdw1BKAx3lDt
         jVag==
X-Gm-Message-State: AOAM533cy45Phj6F7gcY35zQ6PMYHVxffWCeBgVxQwCipKFKR6OwuvhQ
        1nZ1xVq3WRFT2K33d8hX9x0cZwkW
X-Google-Smtp-Source: ABdhPJzM3UrFs4U+vl/cLoZYR//qWmynuQIsdFV0QyHjo9IzrXkZPtSsmE1OrFRQ0GjCDmtVodE2Ug==
X-Received: by 2002:adf:f203:: with SMTP id p3mr34446609wro.331.1594288722906;
        Thu, 09 Jul 2020 02:58:42 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id w2sm4561772wrs.77.2020.07.09.02.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 02:58:42 -0700 (PDT)
Date:   Thu, 9 Jul 2020 11:58:40 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] doc, mm: clarify /proc/<pid>/oom_score value range
Message-ID: <20200709095840.GE19160@dhcp22.suse.cz>
References: <20200709062603.18480-1-mhocko@kernel.org>
 <20200709062603.18480-2-mhocko@kernel.org>
 <CALOAHbAezHHN58cn0unLNbOjHJyYW=zhzQxpQD8_rD4O7qmYRQ@mail.gmail.com>
 <20200709081813.GD19160@dhcp22.suse.cz>
 <CALOAHbDZLM4bfGi7EQDzE6FabBinnZJ7yF+uZADUgx2S_pfg1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbDZLM4bfGi7EQDzE6FabBinnZJ7yF+uZADUgx2S_pfg1w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-07-20 17:01:06, Yafang Shao wrote:
> On Thu, Jul 9, 2020 at 4:18 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 09-07-20 15:41:11, Yafang Shao wrote:
> > > On Thu, Jul 9, 2020 at 2:26 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > From: Michal Hocko <mhocko@suse.com>
> > > >
> > > > The exported value includes oom_score_adj so the range is no [0, 1000]
> > > > as described in the previous section but rather [0, 2000]. Mention that
> > > > fact explicitly.
> > > >
> > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > > ---
> > > >  Documentation/filesystems/proc.rst | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > > > index 8e3b5dffcfa8..78a0dec323a3 100644
> > > > --- a/Documentation/filesystems/proc.rst
> > > > +++ b/Documentation/filesystems/proc.rst
> > > > @@ -1673,6 +1673,9 @@ requires CAP_SYS_RESOURCE.
> > > >  3.2 /proc/<pid>/oom_score - Display current oom-killer score
> > > >  -------------------------------------------------------------
> > > >
> > > > +Please note that the exported value includes oom_score_adj so it is effectively
> > > > +in range [0,2000].
> > > > +
> > >
> > > [0, 2000] may be not a proper range, see my reply in another thread.[1]
> > > As this value hasn't been documented before and nobody notices that, I
> > > think there might be no user really care about it before.
> > > So we should discuss the proper range if we really think the user will
> > > care about this value.
> >
> > Even if we decide the range should change, I do not really assume this
> > will happen, it is good to have the existing behavior clarified.
> >
> 
> But the existing behavior is not defined in the kernel documentation
> before, so I don't think that the user has a clear understanding of
> the existing behavior.

Well, documentation is by no means authoritative, especially when it is
outdated or incomplete. What really matters is the observed behavior and
a lot of userspace depends on that or based on the specific
implementation.

> The way to use the result of proc_oom_score is to compare which
> processes will be killed first by the OOM killer, IOW, the user should
> always use it to compare different processes. For example,
> 
> if proc_oom_score(process_a) > proc_oom_score(process_b)
> then
>      process_a will be killed before process_b
> fi
> 
> And then  the user will "Use it together with
> /proc/<pid>/oom_score_adj to tune which
>  process should be killed in an out-of-memory situation."
> 
> That means what the user really cares about is the relative value, and
> they will not care about the range or the absolute value.

In an ideal world yes. But the real life tells a different story. Many
times userspace (ab)uses certain undocumented/unintended (mis)features
and the hard rule is that we never break userspace. We've learned that
through many painful historical experiences. Especially vaguely defined
functionality suffers from the problem.
-- 
Michal Hocko
SUSE Labs
