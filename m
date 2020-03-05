Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BEEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4843B20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E/kkoPaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgCEI02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:26:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44237 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCEI01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:26:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id y26so2398252pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 00:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pEatHTWH0KovQUE1IliiOOh+OJO6vJzogkc3LdB4OY0=;
        b=E/kkoPaC2FMeGYEZ+bcmO62AmBz6ioa1QQm9IiXemxyUaA7oKQKDSF84iTdG7NT6m6
         btxAs0G47enywKwVaiVOlSyznVAcx8fSXopz5vsetifC/uyO3YhjiqBsZx3pLve+j76/
         UkzGgSX4JdMpqLgCRi0vjG1HGcBz0K5sn/Qtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pEatHTWH0KovQUE1IliiOOh+OJO6vJzogkc3LdB4OY0=;
        b=fEut5ZrnlZy20a0OWB3aH9DjC4HVGr9OhD7VyoeuOMlYnVT1VTI/HiDu6Ph+IGaMgr
         ns2XkQHzBvnY5pnomG8m7jeTY83uEMlMzFwSVPRIpT/n5PrAKk3JiSb9XxfWhZVA5I1g
         f2QvQ2a3efeeCVKOu0ZhjYqt4qSbe6k/q7tIDx2rHdi0aEHtE6R3ur/AsEBNEdpUT9il
         QEycgAYgifLYhrxYjQGhkL56ijpr5Y7xZMKbgIk7AhDM3ksnhCPvgT3+MPutSaKFIc3X
         XwXma+YkaD3kZD77zJJOcXu4RCJBf6K1w/Q0RfQ05vKadwt6rZIrivzTfR/6M6Uxnv8J
         Go3A==
X-Gm-Message-State: ANhLgQ184yE9dQV49zYFPEU6kY49h9y0TMDPnRYGYXaNqEkvrPxRGq+N
        etfGdbWsCKRi7dDD/KOOEaLVGw==
X-Google-Smtp-Source: ADFU+vtzSJ2ErVWBCNHqCv68ee7q7/rHaGMcbMhofpwmAUpPHp6vsLSbOD4qp3AIRnc9whaK7cnjSQ==
X-Received: by 2002:a65:468d:: with SMTP id h13mr6418693pgr.359.1583396786314;
        Thu, 05 Mar 2020 00:26:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1sm26930783pff.11.2020.03.05.00.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 00:26:25 -0800 (PST)
Date:   Thu, 5 Mar 2020 00:26:24 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to
 copy_from_user()
Message-ID: <202003050010.A1A965BF37@keescook>
References: <20200302130430.201037-2-glider@google.com>
 <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
 <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
 <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com>
 <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com>
 <18b0d6ea5619c34ca4120a6151103dbe9bfa0cbe.camel@perches.com>
 <CAG_fn=U2T--j_uhyppqzFvMO3w3yUA529pQrCpbhYvqcfh9Z1w@mail.gmail.com>
 <20200303093832.GD24372@kadam>
 <202003040951.7857DFD936@keescook>
 <20200305080756.GB19839@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305080756.GB19839@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 11:07:56AM +0300, Dan Carpenter wrote:
> On Wed, Mar 04, 2020 at 10:13:40AM -0800, Kees Cook wrote:
> > On Tue, Mar 03, 2020 at 12:38:32PM +0300, Dan Carpenter wrote:
> > > The real fix is to initialize everything manually, the automated
> > > initialization is a hardenning feature which many people will disable.
> > 
> > I cannot disagree more with this sentiment. Linus has specifically said he
> > wants this initialization on by default[1],
> 
> Fine, but as long as it's a configurable thing then we need to manually
> initialize as well or it's still a CVE etc.  It will take a while before
> we drop support for old versions of GCC as well.

Yes, I agree; that's totally true. We need to continue to fix all the
uninitialized flaws we encounter unless this is on by default for all
supported compiler versions (which will be a looong time). (But it's
not relevant to this patch because copy_from_user() does already do
the initialization.)

This set of patches was about dealing with the pathological cases of
auto-init colliding with functions that do, in fact, fully init. Though
I must say, I remain concerned about inventing such markings for fear
they'll be used in places where the "trust me, it's fully initialized"
state does not actually hold[1] but the author thinks it does.

-Kees

[1] https://lore.kernel.org/netdev/1509471094.3828.26.camel@edumazet-glaptop3.roam.corp.google.com/

-- 
Kees Cook
