Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC98C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C632206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a5R1okyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgEOQD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOQD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:03:58 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12004C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:03:57 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s20so1040961plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=26j6mugXkifv9OznhflnKDPN13EyIMvO85x9VYvrewo=;
        b=a5R1okyD9SFHDeV6TRe3Q1g8xfttKurC2131F6oXd1cQCRJMD0PBZMryKaAvh45Qsc
         MHCs7/nEwKuluYb0EN1/fobj0my8160DZrEA86vvP4TU4pzej/2dHr/GdGEchi1cE5uU
         NeewMmWWBkR4M5H0i8e5VvdwYtSpr3f+RIvhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=26j6mugXkifv9OznhflnKDPN13EyIMvO85x9VYvrewo=;
        b=k5YM2y5vpEBBJUk/W5vrNYok/BSovY4NjJ55RdVCJtIMcnehytPxITdbHYBXl0qSTE
         uD5ZnO3nJeRtlMVI4lN2/18Qfjr2c+VNucYWgKFAP2G9hQSGlHXm0koeKO4OvX23ju8g
         hyoQxNW3O6AFds3iMe+tCXQVK9A1BC+MH6HMG75UaQDYFPy+D01sBijaJ40BxzGM8tk1
         2Wl3+DemCBOX2YcZtqmCDeatGTyNRrd3Wh+OzSWvZubWpZsWkSA0hB6ywhHqWInO77Nq
         jTunz7B3EbR5WpSSdJs5y82t8IBMSCPsRGrQ1lDGUK0ILCIaQgE3+S5rVO/eisvWYTVA
         CFaA==
X-Gm-Message-State: AOAM533Wlnh6DFGo2itb5m1ZMw29LlLk9H1QCNuicPC81CnP/ht3RJ7W
        dkyFsO18WSDniltEemDkur5/5w==
X-Google-Smtp-Source: ABdhPJyziM+jU2CP/scXclsOHRPb3/N2euGeSuQyyVzMYnEcr7sfXfrF3dKUwXlkXO8UJjb7A1j1Lw==
X-Received: by 2002:a17:90b:41d5:: with SMTP id jm21mr3919360pjb.96.1589558636642;
        Fri, 15 May 2020 09:03:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lj12sm1913431pjb.21.2020.05.15.09.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:03:55 -0700 (PDT)
Date:   Fri, 15 May 2020 09:03:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        dvyukov@google.com, svens@stackframe.org, joel@joelfernandes.org,
        tglx@linutronix.de, Jisheng.Zhang@synaptics.com, pmladek@suse.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH 1/4] hung_task: Move hung_task sysctl interface to
 hung_task_sysctl.c
Message-ID: <202005150902.9293E99B8@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-2-git-send-email-nixiaoming@huawei.com>
 <202005150103.6DD6F07@keescook>
 <b72e0721-d08a-0fef-f55d-eb854483d04f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b72e0721-d08a-0fef-f55d-eb854483d04f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 04:56:34PM +0800, Xiaoming Ni wrote:
> On 2020/5/15 16:04, Kees Cook wrote:
> > On Fri, May 15, 2020 at 12:33:41PM +0800, Xiaoming Ni wrote:
> > > Move hung_task sysctl interface to hung_task_sysctl.c.
> > > Use register_sysctl() to register the sysctl interface to avoid
> > > merge conflicts when different features modify sysctl.c at the same time.
> > > 
> > > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > > ---
> > >   include/linux/sched/sysctl.h |  8 +----
> > >   kernel/Makefile              |  4 ++-
> > >   kernel/hung_task.c           |  6 ++--
> > >   kernel/hung_task.h           | 21 ++++++++++++
> > >   kernel/hung_task_sysctl.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++
> > 
> > Why a separate file? That ends up needing changes to Makefile, the
> > creation of a new header file, etc. Why not just put it all into
> > hung_task.c directly?
> > 
> > -Kees
> > 
> But Luis Chamberlain's suggestion is to put the hung_task sysctl code in a
> separate file. Details are in https://lkml.org/lkml/2020/5/13/762.
> I am a little confused, not sure which way is better.

Ah, yes, I see now. Luis, I disagree with your recommendation here -- I
think complicating the Makefile is much less intuitive than just
wrapping this code in an #ifdef block in the existing .c file.

-- 
Kees Cook
