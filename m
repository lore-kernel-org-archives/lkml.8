Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC74C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A0120BED
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fqMNCUph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgIIVM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgIIVMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:12:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F01C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 14:12:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so3251611pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k/NDEz4vbfaB6VuU1c+sy+9x1uqLEvej+MXiCZvwYh0=;
        b=fqMNCUphBvZ0MnuRX6VZZ8eu48QSN++BysXWW1SsAx1sR54Zaasid7QqN6D3GWYNPL
         EI6M8yIM03m9Sp2wi7W3G2wTccpR75lI9BahABODHjHhILqYzFSsgTxmW+BUQGG1UKuT
         KcWgTziDsywMxkCulieIPvsxkkNUYgx35A7l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k/NDEz4vbfaB6VuU1c+sy+9x1uqLEvej+MXiCZvwYh0=;
        b=Vb4AuTHbSFtHgxdjyccTCtuxSwwcoFWMe1l8LEsJkJyMbeu0Ob2bWf3zz4SLOvcrM+
         yi5YU1Kk1c8Z3/iSeZBnF7iIc5vhv4mrm2ha2jmd5MUa1ThEBMqaWyzWD/CVUI6pf5Al
         s9Qe4eb4tk/qMf28yD5lUstxVreKXM2ThYNAKJHKsfiWO2r6u7jEx/8/CNhaKkcwr+Gj
         ++LkeexxqVfjf9B7byca44XULDqnWul099I+SUCLOnqy4Cd3ZjtxIFqastk9Q52VRnOA
         XyVTrwyIM8XST5581nkacbZ1KbK+c8dJacaAp4MH+DVPOckljYgtgztQa/HCzUv8sK8g
         Rpxw==
X-Gm-Message-State: AOAM531xX9sjxVBj/Jyyq2NPo6daoiYzVevnU1ZdYb3s9POR0GYou/SN
        Nkqag2hxQmT/4uXofIrYlL1b8Q==
X-Google-Smtp-Source: ABdhPJxU69fTLA5teDOru19c153yZPgb8/yQ3wAqiKY2jMW/ehgBcntyRsJdCpo8dnbPbO4K73XNHg==
X-Received: by 2002:a17:902:a585:b029:d0:afd3:d851 with SMTP id az5-20020a170902a585b02900d0afd3d851mr2846962plb.2.1599685970909;
        Wed, 09 Sep 2020 14:12:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15sm3505454pft.84.2020.09.09.14.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 14:12:50 -0700 (PDT)
Date:   Wed, 9 Sep 2020 14:12:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
Message-ID: <202009091412.6BDB426@keescook>
References: <202006261358.3E8AA623A9@keescook>
 <202009091247.C10CDA60C@keescook>
 <9f3e5c23-3acd-d14f-06f9-acbc84e052a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f3e5c23-3acd-d14f-06f9-acbc84e052a5@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 04:29:50PM -0400, Joe Lawrence wrote:
> On 9/9/20 3:49 PM, Kees Cook wrote:
> > 
> > On Fri, Jun 26, 2020 at 01:59:43PM -0700, Kees Cook wrote:
> > > Instead of full GNU diff (which smaller boot environments may not have),
> > > use "comm" which is more available.
> > > 
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > > Link: https://lore.kernel.org/lkml/CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com
> > > Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Shuah, this really needs to land to fix lkdtm tests on busybox. Can
> > you add this to -next? (Or is it better to direct this to Greg for the
> > lkdtm tree?)
> > 
> > Thanks!
> > 
> > -Kees
> > 
> > > ---
> > >   tools/testing/selftests/lkdtm/run.sh | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> > > index 8383eb89d88a..5fe23009ae13 100755
> > > --- a/tools/testing/selftests/lkdtm/run.sh
> > > +++ b/tools/testing/selftests/lkdtm/run.sh
> > > @@ -82,7 +82,7 @@ dmesg > "$DMESG"
> > >   ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
> > >   # Record and dump the results
> > > -dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> > > +dmesg | comm -13 "$DMESG" - > "$LOG" || true
> > >   cat "$LOG"
> > >   # Check for expected output
> > > -- 
> > > 2.25.1
> > > 
> > > 
> > > -- 
> > > Kees Cook
> > 
> 
> Hi Kees,
> 
> You may want to consider a similar follow up to the one Miroslav made to the
> livepatching equivalent:
> 
> https://lore.kernel.org/live-patching/nycvar.YFH.7.76.2008271528000.27422@cbobk.fhfr.pm/T/#m1c17812d2c005dd57e9a299a4a492026a156619e
> 
> basically 'comm' will complain if two lines from dmesg have the same
> timestamp prefix and their text portions are not sorted.

Ah-ha! Thank you. I will send a v2. :)

-- 
Kees Cook
