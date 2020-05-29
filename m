Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825E3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630172074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590754605;
	bh=j8XFEaITdgnYq1YBW3ki8W+eaXfhFE7ORxoziBpq+x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tx9H+51S9FUxYz17wdRzcMH1p/XRBgyf2aLmmuwZQ9uj7LsJ1gndLt38TIwHc0DdU
	 bHGCr3b7bXiv1tciUCDuhNTLvJDemqDYId5PQXb47Qt2MS8HqKcx4/Zz0vpfqjWsxX
	 egoIvDwfuXCjt5+FDhSuv5tzXv+7NK3KARVc7nDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgE2MQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:16:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39606 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2MQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:16:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id w20so1411972pga.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1QRcJc+0V37tU9/CoMttBOeUhGM/q++JCRSrvKfZi1c=;
        b=mrToAZkCGeM3m8Ch8XABChsN7Ld5riGdsDHPndszDfEHk77xvZKvLeq8EtWO8yR6lJ
         Us6v8jHyDJV2eKg/XyRqzucRi5mZDop3N9CfoxoMCQNlY/8A8YRLeYtgw+vFgJCQXWl/
         bd2JZu8o5pb1UASV0b/l0dBVYZ8HB0gyJywsrMstoSClLPW5XEA02L8U6gr5Ey2arKNh
         PfG0cfhcQGm2YIXa2IHADq10WO33Po8YWSl9vfJ5R5pW6rHg+B8LEzlcs+iWjJVktm8G
         uCNpKRLzHNWSCHeep5cL/DuCwZ9Ui5oIhmC7rUqPs+fM36i7niS1o7G/kolL/P6i35vN
         bKeA==
X-Gm-Message-State: AOAM531IMhjS75KAyTYnyv0HrDEPpta3FmxIORMXNKSmkn49P4VZN3ii
        Yn19nrRcTOU6iaZ8BhA+Lww=
X-Google-Smtp-Source: ABdhPJyXXen44MBfu6MyEx4C7z2Ttl/Mr2eBWsGlqpPiqejkkDLE4gTu0+5b69yRv2/USHCPT392yg==
X-Received: by 2002:a63:dc0f:: with SMTP id s15mr7843478pgg.182.1590754602683;
        Fri, 29 May 2020 05:16:42 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z13sm7663876pfj.153.2020.05.29.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 05:16:41 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 982654046C; Fri, 29 May 2020 12:16:40 +0000 (UTC)
Date:   Fri, 29 May 2020 12:16:40 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, axboe@kernel.dk, clemens@ladisch.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, benh@kernel.crashing.org,
        rdna@fb.com, viro@zeniv.linux.org.uk, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, vbabka@suse.cz,
        sfr@canb.auug.org.au, jack@suse.cz, amir73il@gmail.com,
        rafael@kernel.org, tytso@mit.edu, julia.lawall@lip6.fr,
        akpm@linux-foundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] sysctl: add new register_sysctl_subdir() helper
Message-ID: <20200529121640.GE11244@42.do-not-panic.com>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-2-mcgrof@kernel.org>
 <87d06n17mm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d06n17mm.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 11:13:21AM +0300, Jani Nikula wrote:
> On Fri, 29 May 2020, Luis Chamberlain <mcgrof@kernel.org> wrote:
> > Often enough all we need to do is create a subdirectory so that
> > we can stuff sysctls underneath it. However, *if* that directory
> > was already created early on the boot sequence we really have no
> > need to use the full boiler plate code for it, we can just use
> > local variables to help us guide sysctl to place the new leaf files.
> 
> I find it hard to figure out the lifetime requirements for the tables
> passed in; when it's okay to use local variables and when you need
> longer lifetimes. It's not documented, everyone appears to be using
> static tables for this. It's far from obvious.

I agree 2000% that it is not obvious. What made me consider it was that
I *knew* that the base directory would already exist, so it wouldn't
make sense for the code to rely on earlier parts of a table if part
of the hierarchy already existed.

In fact, a *huge* part of the due dilligence on this and futre series
on this cleanup will be to be 100% sure that the base path is already
created. And so this use is obviously dangerous, you just *need* to
know that the base path is created before.

Non-posted changes also deal with link order to help address this
in other places, given that link order controls how *initcalls()
(early_initcall(), late_initcall(), etc) are ordered if you have
multiple of these.

I had a link order series long ago which augmented our ability to make
things clearer at a link order. Eventually I believe this will become
more important, specially as we end up wanting to async more code.

For now, we can only rely on manual code inspection for ensuring
proper ordering. Part of the implicit aspects of this cleanup is
to slowly make these things clearer for each base path.

So... the "fs" base path will actually end up being created in
fs/sysctl.c after we are *fully* done with the fs sysctl cleanups.

  Luis
