Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F37AC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 17:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E11206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 17:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595785658;
	bh=At8weKOPFuWZgCqPHXYU6Q0grmqr3Gf8vImWklxU8cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kwKxiojOwOrAumCP7vohhTH2dhDvJTCoekjtT7+HhQuL77ZDIqP98AKKe+nYmhodE
	 /BMjX6VOu3bySJLdZeFsaJSXnvkZ1tXhVlrqH8p6Xvok+S1s+rrwzzU8TtpOj5jWBN
	 LvroCjeXWd3FnWJB9X6mlgYpR+2FA8p9o3Bsh1PI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGZRrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 13:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGZRrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 13:47:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0556DC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 10:47:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id kq25so1829582ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5UWv79W/mn1m0FOxs5JKLUTGnpOEf+fg9+uBnox/wQY=;
        b=BFx0qhHQKtFxrM1DGCd4wtmSwJ7USTaY4R7Flp9eqsykeIoR6OyxOAQDsRE2ylBrk5
         Qlv1uczH3Du3XVfTNcl3eJ2NnuMdW1d2wTM0Cx8k4JTbDeJ3ACPmPh2yaiGB83ovPzGW
         LDrlU7CRkyQBk8yyEX1Fh4o5TgYPj5KK81cNVp/TLcCNTKXw/T4fsxYZ/iV+jN6UTRkD
         nwcBIjrAaPUeg8sbjsItbHFXvdAgr1slgFQQoio3dOjq3cULcNOYW/oqLWT5UiqIhZ4+
         36OMiqNH9kFSuAHWT4OpGpZxWDNfRQ841DwVjDImLVxzp42xB9q6dTE788xRcwleuJpv
         vrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5UWv79W/mn1m0FOxs5JKLUTGnpOEf+fg9+uBnox/wQY=;
        b=pxHF9vkESoC/O960Rj9ABMvoEMWgz7KjHVwi2GWd7vOnvK20am3yEwfYQmngBn0FJb
         AvKsD90OwVzg+UNIudSfC+7Xom9Fknhg60Rq163JYuwdkfD1Y4nh9BBk5XmVIBIcv9Sc
         rKIsnUBRF4mA2VJSzwutESA3HyrIFRy6hSW2Dra9i2n96yPbbnRdi+WvoQY+ndGzcPEH
         GZXS+zh5+2YAyX4RD9Dz0PxdcVnjBQDZ87ob0UVBfp49F7hxMFHqpDvlsYleKn29zKso
         +qpvVdtZx6teyIhCXCY7inc5Zh67Y48x62n/p8NJFMRUsJAHpEmFxv1pR+FWkz0Cu/OE
         o5kg==
X-Gm-Message-State: AOAM530aaMBUzTDQOKtLLXgHZPq0QBH6X8rJZiNNGY56nZmTFzx7UnVC
        CBki6hk8b46heLolIJ1XSgklNLOU
X-Google-Smtp-Source: ABdhPJzhGf+cetYHGIq9aFSp+JRUGe5sbLoZxyFJlOcvThhp1nuFBOzUiztKdQi2zyjbLerUMramhg==
X-Received: by 2002:a17:906:c285:: with SMTP id r5mr17615135ejz.153.1595785654663;
        Sun, 26 Jul 2020 10:47:34 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s7sm5712311edr.57.2020.07.26.10.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 10:47:33 -0700 (PDT)
Date:   Sun, 26 Jul 2020 19:47:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] entry: Fix CONFIG_SECCOMP assumption
Message-ID: <20200726174731.GA786388@gmail.com>
References: <20200725091951.744848-1-mingo@kernel.org>
 <20200725091951.744848-2-mingo@kernel.org>
 <87a6zmcs5q.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6zmcs5q.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Ingo Molnar <mingo@kernel.org> writes:
> > The __secure_computing() callback only exists on CONFIG_SECCOMP=y,
> 
> No. There is a stub function for the SECCOMP=n case.

Which was buggy:

  static inline int __secure_computing(void) { return 0; }

Note the 'void' argument, while it should take an argument.

For example on x86-64 allnoconfig there's !CONFIG_SECCOMP.

> > and on architectures that have CONFIG_HAVE_ARCH_SECCOMP_FILTER.
> 
> which is a prerequiste for converting over.

Yeah, and the patch I sent makes this explicit instead of implicit.

> > Instead of complicating the #ifdef within the generic entry code,
> 
> There is no #ifdef in the generic code and there is none required.

I simply carried that #ifdef over from the x86 code, but indeed fixing 
the stub is a bit cleaner.

> > make the generic entry code depend on the availability of a modern
> > seccomp framework. This was implicit in the generic code due to
> > x86 being a modern seccomp-filter architecture.
> >
> > Also move the Kconfig entry to after its HAVE_ARCH_SECCOMP_FILTER
> > dependency and fix minor whitespace damage while at it.
> >
> > Fixes: 142781e108b1: ("entry: Provide generic syscall entry
> > functionality")
> 
> I don't see what that fixes.

A build bug.

Thanks,

	Ingo
