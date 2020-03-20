Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52F4C43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A04320409
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvAklPMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgCTUKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:10:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43635 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCTUKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:10:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id f206so3847747pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 13:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8wBJM863apF0IwOPmO9fuaOOqzaQw306izkJnc0/fII=;
        b=fvAklPMvJlNS9vNQhJdK1AuiQZmkjC9vvIRMZAQNcvfDDWR0w81khYqp5RiIul11WS
         WNDSy3c75Luwy9fag1iFfAx9/w70boBzrfy11P7KavWhZ+KyL4ceLQOJRHR1B3zrPJUZ
         qdClxBt0eYYcn70/mYeISAvctswbPnd48V7CRpzrwo3NX8m/mAo6R6EhXlXVD9++v7TH
         uYxvLdjJRlOBxjGld2ZPPSL3GxoFznoZ8mkQV+c9Q3N7U+vOYd5Lmjf43xm/r76g91X/
         AUhtUkfSWDvveqHe5UZzR9+cCVaNJjrJ+Pco0WFaX1iLxXn9O15Mu5/ruLY0L6YUn2/+
         4ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8wBJM863apF0IwOPmO9fuaOOqzaQw306izkJnc0/fII=;
        b=Pctifv8R4EeWEemupbeH5nzHNhH5jJ0q8uxYqGBTk5l3AESSKxPXp2ICLI9x79mwJA
         M6h7PLZ/ODJCb/khOe0o3OUn6ze6imJCh8E84fmRWwkcCxXnVk+OD5ZDG02cwqAbX+P8
         wJ03552eudlLrSTVBwi/Aea2q69wnYTTVaQEDWAOrRoad1NMp10f2xDkxUTbxFk2G5AV
         56mQaJMX+BK5KdaTy2i3LzIs0vseOjgHO2MwJJ+M06TSFpwxCQBT9LfbHfy3qURuiPIV
         NqDC9fkW1gD3xjcNMqM9hzHAvVbx1ul1roRxXrLnOOgbs09ZQRAVU+bjvtl+fDtRZmpA
         /+5Q==
X-Gm-Message-State: ANhLgQ3U3aPgrDxAhv11QAUxe1jXkqyzsguZM0/TyrXEURs5w12m4xa7
        97Xi+NBHiv9PTRBaQrqH0S4QGA==
X-Google-Smtp-Source: ADFU+vt4bqdyXNnRbChIEYqGnF9tjkMzkpQ2TcoyY685E+bmpfFRtb9zrOeEKlZxBHUT4jtOCkI9MQ==
X-Received: by 2002:a63:4d6:: with SMTP id 205mr10113365pge.10.1584735044151;
        Fri, 20 Mar 2020 13:10:44 -0700 (PDT)
Received: from google.com ([2620:15c:211:202:ae26:61fb:e2f3:92e7])
        by smtp.gmail.com with ESMTPSA id t142sm5878431pgb.31.2020.03.20.13.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:10:43 -0700 (PDT)
Date:   Fri, 20 Mar 2020 13:10:38 -0700
From:   Marco Ballesio <balejs@google.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
        Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-pm@vger.kernel.org, Minchan Kim <minchan@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] cgroup-v1: freezer: optionally killable freezer
Message-ID: <20200320201038.GB79184@google.com>
References: <20200219183231.50985-1-balejs@google.com>
 <20200303134855.GA186184@mtj.thefacebook.com>
 <CAKOZuevzE=0Oa8gn--rkVJ8t69S+o2vK--pki65XXg6EVuOhMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuevzE=0Oa8gn--rkVJ8t69S+o2vK--pki65XXg6EVuOhMQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:46:15AM -0700, Daniel Colascione wrote:
> On Tue, Mar 3, 2020 at 5:48 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Wed, Feb 19, 2020 at 10:32:31AM -0800, Marco Ballesio wrote:
> > > @@ -94,6 +94,18 @@ The following cgroupfs files are created by cgroup freezer.
> > >    Shows the parent-state.  0 if none of the cgroup's ancestors is
> > >    frozen; otherwise, 1.
> > >
> > > +* freezer.killable: Read-write
> > > +
> > > +  When read, returns the killable state of a cgroup - "1" if frozen
> > > +  tasks will respond to fatal signals, or "0" if they won't.
> > > +
> > > +  When written, this property sets the killable state of the cgroup.
> > > +  A value equal to "1" will switch the state of all frozen tasks in
> > > +  the cgroup to TASK_INTERRUPTIBLE (similarly to cgroup v2) and will
> > > +  make them react to fatal signals. A value of "0" will switch the
> > > +  state of frozen tasks to TASK_UNINTERRUPTIBLE and they won't respond
> > > +  to signals unless thawed or unfrozen.
> >
> > As Roman said, I'm not too sure about adding a new cgroup1 freezer
> > interface at this point. If we do this, *maybe* a mount option would
> > be more minimal?
> 
> I'd still prefer a cgroup flag. A mount option is a bigger
> compatibility risk and isn't really any simpler than another cgroup
> flag. A mount option will affect anything using the cgroup mount
> point, potentially turning non-killable frozen processes into killable
> ones unexpectedly. (Sure, you could mount multiple times, but only one
> location is canonical, and that's the one that's going to get the flag
> flipped.) A per-cgroup flag allows people to opt into the new behavior
> only in specific contexts, so it's safer.

It might also be desirable for userland to have a way to modify the behavior of
an already mounted v1 freezer.

Tejun, would it be acceptable to have a flag but disable it by default, hiding
it behind a kernel configuration option?
