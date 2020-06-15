Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11E9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC5820810
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mfT5qYMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbgFOSIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFOSIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:08:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC41C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:08:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d8so7109358plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wNA6Ua9Lonp8W1XwPz+OQDM2cFgREkBYyRe/5AvHSyM=;
        b=mfT5qYMslqR0NSzLt2YbNgSHf2yXFmMLVQ6ukeXZkCkzarBaNDR4BlvrPhBw8FPp4J
         lP8nIEfU6h/Y5BieUQ9fN2gsR+LuoTFJJUuYmPA4pKdBt3bZa1Ehi452whffbSAa38Lp
         /wpPrYgD1c9QkDUEzZXiZQVB02fpsPkOKAj60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wNA6Ua9Lonp8W1XwPz+OQDM2cFgREkBYyRe/5AvHSyM=;
        b=dDreZMpOHLhFBtQatbcesicmK0Xjcd0exr++p/ubVEAcSklw3thlrJhbMWB6UwdgOY
         R4IdExbA18h+6fg5VwmdGfIyKyvumFeV6VWm9ask2xCgEKzi1tr3ZLEi7iCIPxWn2ypn
         Qe4YTGHe1y/RGQ6USbmSI1F88IXFIgthjmVJ5PgomhQVtEUuhoL3eZPPHcsDV6UVcBD8
         x3MOx5GXtTO8z5GaS1l3LK0OKVABMyJ6vxR5D7kG8EHJnEr2RuKIhN4KNSRLISqDP9+w
         daEPmczXZp3jKcAE+RfQzFLd3JwW/3i2kImdZuWuH/pakJDq420umlH+VkUp5Kammzf3
         r0oA==
X-Gm-Message-State: AOAM532ACJV69ZWzlljKv5SsNJn0DPLQ3feECFJdVSSdZpo0JaezplCd
        iVm6Q0z8u6xgAxXYa4n8B/YsUw==
X-Google-Smtp-Source: ABdhPJx1uTCtEysTdsh5KwD95wd27X1vLNF8jXSOTLrnI5ZnRgaT2kjt78URIQIrBwa7IpmcRX/2ag==
X-Received: by 2002:a17:90a:55c7:: with SMTP id o7mr426683pjm.205.1592244515390;
        Mon, 15 Jun 2020 11:08:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e124sm14211530pfh.140.2020.06.15.11.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:08:34 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:08:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        "alex.huangjianhui@huawei.com" <alex.huangjianhui@huawei.com>,
        "dylix.dailei@huawei.com" <dylix.dailei@huawei.com>,
        "chenzefeng2@huawei.com" <chenzefeng2@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
Message-ID: <202006151108.5B25D5A31@keescook>
References: <20200612183450.4189588-1-keescook@chromium.org>
 <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
 <202006142054.C00B3E9C9@keescook>
 <CY4PR1101MB23261B27ACF9D7FBC3969318E79C0@CY4PR1101MB2326.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1101MB23261B27ACF9D7FBC3969318E79C0@CY4PR1101MB2326.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 05:35:58AM +0000, Reshetova, Elena wrote:
> > On Mon, Jun 15, 2020 at 10:10:08AM +0800, Xiaoming Ni wrote:
> > > On 2020/6/13 2:34, Kees Cook wrote:
> > > > This series was never applied[1], and was recently pointed out as
> > > > missing[2]. If someone has a tree for this, please take it. Otherwise,
> > > > please Ack and I'll send it to Linus.
> > > >
> > > > Thanks!
> > > >
> > > > -Kees
> > > >
> > > > [1] https://lore.kernel.org/lkml/20190306110549.7628-1-
> > elena.reshetova@intel.com/
> > > > [2] https://lore.kernel.org/lkml/1591957695-118312-1-git-send-email-
> > nixiaoming@huawei.com/
> > > >
> > > > Elena Reshetova (3):
> > > >    nsproxy: convert nsproxy.count to refcount_t
> > > >    groups: convert group_info.usage to refcount_t
> > > >    creds: convert cred.usage to refcount_t
> > > >
> > > >   include/linux/cred.h    | 15 +++++++-------
> > > >   include/linux/nsproxy.h |  7 +++----
> > > >   kernel/cred.c           | 44 ++++++++++++++++++++---------------------
> > > >   kernel/groups.c         |  2 +-
> > > >   kernel/nsproxy.c        |  6 +++---
> > > >   net/sunrpc/auth.c       |  2 +-
> > > >   6 files changed, 38 insertions(+), 38 deletions(-)
> > > >
> > >
> > > Should mm->mm_users also be replaced by refcount_t?
> > 
> > I'll say "yes". :)
> > https://lore.kernel.org/lkml/1487671124-11188-1-git-send-email-
> > elena.reshetova@intel.com/
> > 
> > > In addition, is it better to change all variables that use
> > > atomic_dec_and_test to control the release process to refconut_t?
> > 
> > For the most part, yes. The following may find a lot of them:
> > scripts/coccinelle/api/atomic_as_refcounter.cocci
> > 
> > If you can go through that and double check for prior series from Elena,
> > we can get through all the rest of them.
> 
> I have these ones also here in case anyone is interested:
> https://github.com/ereshetova/linux-stable/commits/refcount_t_fs
> https://github.com/ereshetova/linux-stable/commits/refcount_t_block
> 
> They haven't been rebased for a while, but if there is an interest, 
> I can certainly do it.

That would be great; yes!

-- 
Kees Cook
