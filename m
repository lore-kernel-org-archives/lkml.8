Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3520C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A5020776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpD0tjID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbgFPR5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgFPR53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:57:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B054C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:57:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j10so21704948wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oEBfLPiOYvV8Wp4MUoFiCMdsHve7/PzLYazK5rtAoxo=;
        b=rpD0tjIDuylGgqeb8JmVhI6WWVv8neBbwDdRxGG8H5r8xcH7lwZWNbUvwF9eX20GmG
         abTRGAMJLBbKsFwL1joM4tlQrAlo3S0XNpsMBD74578aILPPtpJVmze4OmmCzq/Lwycw
         NXlgSQyEdyLS9+qRjueUIz9kaGfCvVYlzqg03xmdoSWYSnozH3MpulHuncW5IJIYId9s
         1ArCFwF08jvhuvLEgrW6sxN+Fd/MA5ELKg2N3+Gh8e2N+8y0q8jyF4CoeVql0ZW+sEGN
         373KAe4+D52Aq4wWcEGRHCqYYyqMRP6pjOQds5rzdQEfvUwWogD8a0XzP68zG9jvPhBh
         I1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oEBfLPiOYvV8Wp4MUoFiCMdsHve7/PzLYazK5rtAoxo=;
        b=ZElZrXzEgsrVbV9lmC2yBiDsDx8Bqj8GfYVOC3aNmkP5P6bDfBfPWqJcewcgEiye+Q
         hE0F2I/AP1hNEKgroFRSFEnu4xv0ZCIYpacW9AKfcQrVzv4W9TJnb42GZYJlwR5T/lNU
         wUBHEtTmsjPsArH3t/zhAML6CntmbT2/+WMKiX5J0UwYoEyhuUR6O8kIGAMjbEiYOCze
         pWSHg6F4OZISIJG8KyOvn1hUL3A8rDhiSuLjvQnnVZ5H1I4OLRZfNFWJv30nthbW1jEH
         Go4HL70c37WJS34dDQsMcrGQKUEOHNG+tV+oyiZ3Dw8xrC7D912vDFX9Q4wsI9A2OvwY
         fUlw==
X-Gm-Message-State: AOAM532T5tEg7dbHn6dye8r6bA/eELJOZK/JkLShQQmwgiK0YVAc0tzw
        kPV9tXhqvyWWZrYPe6tw7d5PkSckrI8=
X-Google-Smtp-Source: ABdhPJzHE0/Us52Z0TZBqRSkkSink7YtGieP4JIIpIl4KB1gKQYiH/BFjgPeTpyrbSTvPca849OeQA==
X-Received: by 2002:adf:b60b:: with SMTP id f11mr4274582wre.7.1592330246776;
        Tue, 16 Jun 2020 10:57:26 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id g19sm4742347wmh.29.2020.06.16.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 10:57:25 -0700 (PDT)
Date:   Tue, 16 Jun 2020 19:57:20 +0200
From:   Marco Elver <elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, shuah@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] torture: Pass --kmake-arg to all make invocations
Message-ID: <20200616175720.GA124701@google.com>
References: <20200616094924.159539-1-elver@google.com>
 <20200616160524.GW2723@paulmck-ThinkPad-P72>
 <20200616164202.GA208325@google.com>
 <20200616174222.GB2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616174222.GB2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16 2020 at 10:42AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 16, 2020 at 06:42:02PM +0200, Marco Elver wrote:
> > On Tue, Jun 16 2020 at 09:05AM -0700, Paul E. McKenney wrote:
> > > On Tue, Jun 16, 2020 at 11:49:24AM +0200, Marco Elver wrote:
> > > > We need to pass the arguments provided to --kmake-arg to all make
> > > > invocations. In particular, the make invocations generating the configs
> > > > need to see the final make arguments, e.g. if config variables depend on
> > > > particular variables that are passed to make.
> > > > 
> > > > For example, when using '--kcsan --kmake-arg CC=clang-11', we would lose
> > > > CONFIG_KCSAN=y due to 'make oldconfig' not seeing that we want to use a
> > > > compiler that supports KCSAN.
> > > > 
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > 
> > > Queued and pushed, thank you!
> > > 
> > > Would the following patch make sense, at least until such time
> > > as some other compiler supports KCSAN?
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > commit 88bcaa730b6d40ddf69b09ed6f0a14803d087d99
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Tue Jun 16 09:02:34 2020 -0700
> > > 
> > >     torture: Make --kcsan default to using Clang 11
> > >     
> > >     Currently, Clang 11 is the only compiler that can support KCSAN.
> > >     Therefore, as a convenience to the KCSAN user, this commit causes
> > >     --kcsan to specify Clang 11 unless a "CC=" argument was already
> > >     specified via the --kmake-arg argument.
> > 
> > As soon as more compilers support KCSAN (e.g. clang-12, etc...) we run
> > the risk of actually inconveniencing ourselves more because then we
> > really need to say '--kmake-arg CC=clang-1X' to not use the old
> > compiler. Or revert this in time.
> > 
> > My command-line looks more like this right now:
> > 
> > 	kvm.sh ... --kmake-arg "CC="${HOME}/local/<gcc-or-clang>-11.kcsan/local/bin/<gcc-or-clang>" ...
> > 
> > I think the safer alternative would be to error if CONFIG_KCSAN=y is not
> > in the config, and simply suggest "Did you forget to switch your
> > compiler with '--kmake-arg CC=<cc-that-supports-kcsan>'?" (of course, a
> > 'gcc' in $PATH that supports KCSAN would also be fine -- see below).
> > Eventually, when the default compilers support KCSAN, this will resolve
> > itself gracefully.
> > 
> > Also, I'm going to send a series later this week to re-enable GCC
> > support. ;-)
> 
> OK, sounds like I should leave well enough alone, then.  ;-)
> 
> In its current state, specifying "--kcsan" without a KCSAN-capable
> compiler does get you this:
> 
> :CONFIG_KCSAN=y: improperly set
> :CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
> :CONFIG_KCSAN_VERBOSE=y: improperly set
> :CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
> Clean KCSAN run in /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2020.06.16-09.53.16
> 
> Which admittedly is a bit obtuse, especially that last line.  So how
> about the following patch, which instead results in this?
> 
> :CONFIG_KCSAN=y: improperly set
> :CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
> :CONFIG_KCSAN_VERBOSE=y: improperly set

Noticed that CONFIG_KCSAN_VERBOSE=y warning still appears, because it
wants CONFIG_PROVE_LOCKING=y.

> :CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
> Did you forget to switch your compiler with --kmake-arg CC=<cc-that-supports-kcsan>?

Sounds good, with another suggestion below, but otherwise

Acked-by: Marco Elver <elver@google.com>

Thanks,
-- Marco

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit f571795b1146007407851675a258b6685ea2d589
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jun 16 10:38:57 2020 -0700
> 
>     torture: Improve diagnostic for KCSAN-incapable compilers
>     
>     Using --kcsan when the compiler does not support KCSAN results in this:
>     
>     :CONFIG_KCSAN=y: improperly set
>     :CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
>     :CONFIG_KCSAN_VERBOSE=y: improperly set
>     :CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
>     Clean KCSAN run in /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2020.06.16-09.53.16
>     
>     This is a bit obtuse, so this commit adds checks resulting in this:
>     
>     :CONFIG_KCSAN=y: improperly set
>     :CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
>     :CONFIG_KCSAN_VERBOSE=y: improperly set
>     :CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
>     Did you forget to switch your compiler with --kmake-arg CC=<cc-that-supports-kcsan>?
>     
>     Suggested-by: Marco Elver <elver@google.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
> index 357899c..837643a 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
> @@ -44,7 +44,8 @@ do
>  			then
>  				echo QEMU killed
>  			fi
> -			configcheck.sh $i/.config $i/ConfigFragment
> +			configcheck.sh $i/.config $i/ConfigFragment > $T 2>&1
> +			cat $T
>  			if test -r $i/Make.oldconfig.err
>  			then
>  				cat $i/Make.oldconfig.err
> @@ -73,7 +74,10 @@ do
>  	done
>  	if test -f "$rd/kcsan.sum"
>  	then
> -		if test -s "$rd/kcsan.sum"
> +		if grep -q CONFIG_KCSAN=y $T
> +		then

For completeness, could add this above:

	echo "Compiler or architecture does not support KCSAN!"

Because we might also be on an unsupported architecture.

> +			echo Did you forget to switch your compiler with '--kmake-arg CC=<cc-that-supports-kcsan>'?
> +		elif test -s "$rd/kcsan.sum"
>  		then
>  			echo KCSAN summary in $rd/kcsan.sum
>  		else
