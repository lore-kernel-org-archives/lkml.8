Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B650C352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 06:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5052083B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 06:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7GOzfkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgBOGxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 01:53:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43025 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgBOGxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 01:53:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so13410805wrq.10;
        Fri, 14 Feb 2020 22:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=uEzSeZ4ou8cFL6O+xmrt70X+FzXbL0vSbBjS4bDp0bU=;
        b=s7GOzfkxN9UfJZjPzOshkQtyUO9FqgrcRgK/zvdAiazYZxKB7lVldi5tSfvV26Jr+6
         7YdtGkQJYHjGFTNL6i+xwBIWXCOVGNowYUOgnig97+DUMhhLx3rpY6kXDzwHxEP3ZS0m
         mqy43vByg1HfgNOCAN1+0djgx31f4nlgPXbja+Qb0m/0G8d0K1uYlDGvQnfXUVIuCCjX
         z6R9NnsHulh21tDy7m3smSqAh96nSmgwj/SNTa143OJ5kHGN/uU3CKamttEYVaxtg1pM
         zB6hUQvo4rrHSDnIcOKPz7ajc0b5/DO0pnGetd81HaQou3glcvOlAvv+qYdcF1gBZgQp
         g0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=uEzSeZ4ou8cFL6O+xmrt70X+FzXbL0vSbBjS4bDp0bU=;
        b=Fh/GzG7o8EJNgYPmoke7U27xBfr5UQp6Qa1CI8R416VvNjD4SgR1Tpy+UM4n0+/Q6P
         PmAQy5qvr4HtKLRA1AY8C6rm9LRh6E+/M6V9jHvIeBbDp5cVRTK9bY7h6SchTfgSiNFl
         kJPjkbUGIYtGHWd+O1BRenn8kKWA4PVUSr3/fbsg+9EKiSTtbgRv6AKFXREwzWG/oad8
         3JPPDQOuIryggHGDIehYk4L8d6Gwx0byJTUMmWVVhxasTablMtS2ESktSZzyfqp9HflF
         Sj2v3w8ObjbePn1vA7oNQGHERk3G42Tk9YSUsHWc/+5GY3+wniKfZCtxNKLBKmOzdSUK
         a5+w==
X-Gm-Message-State: APjAAAUCl9P2olAAhmvdMkA3c6SvAQu3HCUbBExzcB5i0R+mUTnJ3Tqh
        ra++YnYAYrnGvt/KnRaqy0I=
X-Google-Smtp-Source: APXvYqxUjQtmJngMyKavkHRSckvCMrerITBbx52c79ipxPRiBRcqrI4doHxH9LL/hfu+IJyCVKSYqA==
X-Received: by 2002:a5d:68c5:: with SMTP id p5mr8355656wrw.193.1581749586459;
        Fri, 14 Feb 2020 22:53:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:38ff:a358:bd66:4274])
        by smtp.gmail.com with ESMTPSA id c9sm10398370wmc.47.2020.02.14.22.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 22:53:05 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     sjpark@amazon.com, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        brendan.d.gregg@gmail.com, brendanhiggins@google.com, cai@lca.pw,
        colin.king@canonical.com, corbet@lwn.net, dwmw@amazon.com,
        jolsa@redhat.com, kirill@shutemov.name, mark.rutland@arm.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        sj38.park@gmail.com, vdavydov.dev@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v4 10/11] mm/damon: Add kunit tests
Date:   Sat, 15 Feb 2020 07:52:51 +0100
Message-Id: <20200215065251.13754-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <4a541951-fd36-2a19-75a0-ccfcf60e6f14@infradead.org> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 20:07:47 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 2/10/20 6:53 AM, sjpark@amazon.com wrote:
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 387d469f40ec..b279ab9c78d0 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -751,4 +751,15 @@ config DAMON
> >  	  be 1) accurate enough to be useful for performance-centric domains,
> >  	  and 2) sufficiently light-weight so that it can be applied online.
> >  
> > +config DAMON_KUNIT_TEST
> > +	bool "Test for damon"
> 
> s/bool/tristate/ ?

Thank you for this comment!

It seems Kunit does not support module build, as its core functions are not
exported to modules.  That said, as this might be confusing and even could
cause a build failure with some configuration combinations[1], I will change
this dependency to `DAMON=y && KUNIT` in next spin.

[1] https://lore.kernel.org/linux-mm/20200214111907.7017-1-sjpark@amazon.com/

Thanks,
SeongJae Park

> 
> > +	depends on DAMON && KUNIT
> > +	help
> > +	  This builds the DAMON Kunit test suite.
> > +
> > +	  For more information on KUnit and unit tests in general, please refer
> > +	  to the KUnit documentation.
> > +
> > +	  If unsure, say N.
> > +
> >  endmenu
> 
> 
> -- 
> ~Randy
> 
