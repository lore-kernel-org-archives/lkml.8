Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56981C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 00:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C392217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 00:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAKToxYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgBFAMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:12:44 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36676 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBFAMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 19:12:44 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so1704350pjb.1;
        Wed, 05 Feb 2020 16:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=rQxsIm1RCU6N5mf0GNyg2yThpOieDC4Xau8zgE6O5lU=;
        b=HAKToxYbLCaVgCzV4R8R2+Mf6gWlRDjZ3AhiB/R0idM+0WN+8CUMkoxvUcy+oB0iFD
         f4zLjSNvI2Y7MXFMWxHMFJYYDEK7tTsEUD4plqlldiwOQp3B6ZT14f8YTa1jA5Irr3Ce
         U5VYlFoGQQ/vc/drlVCJ7AaBOFV7dY1EHCBuHtiTpvF2h/UYRt4kfbDwe2jb7YDnvRCt
         PC66zlM0cnW9n2f6GmVbG6xzQAPfLxA4J2Cq6lCiPh3emX6R1BIxWi/0N5valT5Olya5
         iUbeOJHdG2sd+PhLMF6zvVXGNnQ4KdTuNCO57AXvJlAOiLYSQzxQ+rTvEWt2Pyb4DL5/
         XU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=rQxsIm1RCU6N5mf0GNyg2yThpOieDC4Xau8zgE6O5lU=;
        b=f7pAl6kprZ/QQe86ECBsRLAsGo8caRvV3uMW9K+0tbHWWpkR3vY1eGcpYKLWc6qauz
         WdSRzo6BcSw2O7DZIDlN7SHwxkRFpq8ow24aTr31LDHyhOJaUWXx9/Xm6ixDW9+mbrzn
         Upj+oyUHOi9YEjAL2mBPcnGux+tkeaKJ4gOKr2jXtWHfsEgctjgzK8N9vjIjuUQCBlQa
         m4eAVu9AtHl9yGNbe0QSR5j/QyYucZJOQqhS6T7WIlyG77euPYNXU0l7j+92FmABAzzG
         MH8dYHbU+OkRENUrr2mo4BH04k3HMnEJXl4yGSyyJgQjFMLwmUrpxewLkI5lqF2UWaHF
         Vrsg==
X-Gm-Message-State: APjAAAUVKP47TTAkaKxQss+ymMuuorZqdwbksTET6Wbe8oYwxVDk9bOd
        IcOgfyjhWqA/BpWYRGV0ffVBMB6yT9Dozg==
X-Google-Smtp-Source: APXvYqzz2MgAnPeYFrZPG88g6teLZ56JTdtX1krn27aTsdnl9YlaxCfFLuDL2lyrQbWuaLeG60uSMA==
X-Received: by 2002:a17:90b:1256:: with SMTP id gx22mr909629pjb.94.1580947963566;
        Wed, 05 Feb 2020 16:12:43 -0800 (PST)
Received: from localhost.localdomain ([211.47.96.9])
        by smtp.gmail.com with ESMTPSA id w203sm646962pfc.96.2020.02.05.16.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 16:12:42 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj38.park@gmail.com>, paulmck@kernel.org,
        SeongJae Park <sjpark@amazon.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>
Subject: Re: Re: [PATCH 2/5] docs/ko_KR/howto: Insert missing dots
Date:   Thu,  6 Feb 2020 01:12:33 +0100
Message-Id: <20200206001233.22023-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205101555.23ffde75@lwn.net> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2020 10:15:55 -0700 Jonathan Corbet <corbet@lwn.net> wrote:

> On Fri, 31 Jan 2020 21:52:34 +0100
> SeongJae Park <sj38.park@gmail.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> I'd really rather not see patches with an empty changelog, please, even
> when they are relatively trivial.  But also...

Sorry, will add changelog.

> 
> > ---
> >  Documentation/translations/ko_KR/howto.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
> > index ae3ad897d2ae..6419d8477689 100644
> > --- a/Documentation/translations/ko_KR/howto.rst
> > +++ b/Documentation/translations/ko_KR/howto.rst
> > @@ -1,6 +1,6 @@
> >  NOTE:
> > -This is a version of Documentation/process/howto.rst translated into korean
> > -This document is maintained by Minchan Kim <minchan@kernel.org>
> > +This is a version of Documentation/process/howto.rst translated into korean.
> > +This document is maintained by Minchan Kim <minchan@kernel.org>.
> 
> Is this even true?  Minchan hasn't touched this document in years, and you
> didn't see fit to copy him on the change.  I'm thinking that adding
> periods doesn't seem like the right fix here.

I only thought that this paragraph seems a little bit weird in the html doc due
to the absence of the period.  Also, thought that this change would be ok
because it's just a simple change.  Sorry if I was wrong.  Anyway, please feel
free to drop this patch.


Thanks,
SeongJae Park

> 
> Thanks,
> 
> jon
