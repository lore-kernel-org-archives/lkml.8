Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9D5C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A77F21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mRoO3xim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbgBYTbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:31:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46094 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbgBYTbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:31:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id y30so16948pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 11:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EJ8HPUktc58qJYFrDAIdvsZ1Ei72XTyb2PR3F/Eja5g=;
        b=mRoO3ximDl17LdEWrFR3sIPemcYle9IAprIuQGT7k9qxAXCZvML8ln5am7XhoUgTIk
         +aGyOyaTzXGab4oJumoYVV6plrgijKkaIuaHuVKxl10zAQKX22W2JxU/F1CScvPk/dTk
         mLp8j8X4SciZ9bdFTxukYo0F9vTijuu4ZqEh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EJ8HPUktc58qJYFrDAIdvsZ1Ei72XTyb2PR3F/Eja5g=;
        b=ND7gxnAfhdS59bSCNZcg8Z5+haJhVhaQxp62QrTOpVQG/+DpSrJOCxC2YfdgXRRrMW
         jhdQZCnvtG6/YdItP3G3WTGo71s6LML+M14rWALPJCGxb7kxgG1B2oKQic8KFyhrxEw1
         3S2niiVmCyg7Od5foFhmkvVO9jf07h6pp4X1P6jmVEkpi4YCfelEAh13u2ONqNOmHFx6
         jzDiyObk+UeTIgx81IGSrZF9y8SlKZRL9+gASrXgESqcKOeQrUWUyFoDsv4HHO75eF9/
         zDNkUBijsMtSmzytWs4rIAD7r8TASy8yYkHq8RJ1hfbb8RCGuJehFEKNz3r34MyNaIeN
         b+vw==
X-Gm-Message-State: APjAAAXO+y5JIi1evJIRh8gHRxsdJj8xTRqVEI6pLOg89aV72Iu4QBxT
        k9UbPc26vvGFu5REUlC9RGTE8Q==
X-Google-Smtp-Source: APXvYqwHIqJ+S/3dOkffGiH+IfUlFNqQf+XT34kSaOfgtD9L5Eh6wi2VrsRkUUKjFze3JGnIcP/gXg==
X-Received: by 2002:a63:a741:: with SMTP id w1mr80479pgo.131.1582659073819;
        Tue, 25 Feb 2020 11:31:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r3sm18490808pfg.145.2020.02.25.11.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 11:31:12 -0800 (PST)
Date:   Tue, 25 Feb 2020 11:31:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>, ankita@in.ibm.com,
        Will Deacon <will@kernel.org>, ardb@kernel.org,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Subject: Re: selftests: Linux Kernel Dump Test Module output
Message-ID: <202002251126.66255B5@keescook>
References: <CA+G9fYu3682XJ2Kw2ZvQdUT80epKc9DWWXgDT1-D_65ajSXNTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYu3682XJ2Kw2ZvQdUT80epKc9DWWXgDT1-D_65ajSXNTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 04:39:37PM +0530, Naresh Kamboju wrote:
> The selftest lkdtm test failed on x86_64 and arm64.
> am I missing any pre-requisite?
> [...]
> ref:
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.6-rc1-19-g359c92c02bfa/testrun/1212254/log

Looking at this, I see debugfs mounted, I see LKDTM enabled, but I see
the console freak out just as lkdtm starts:

[  349.262263] kselftest: Running tests in lkdtm
#      4	0x0000000000401014 ?? ??0
0x0000000000401014: ??_??0 #
#      5	0x00007f9de1221a56 ?? ??0
0x00007f9de1221a56: ??_??0 #
#      6	0x0000000000401399 ?? ??0
0x0000000000401399: ??_??0 #
#   madvise failed,
failed,: _ #
#   addr 0x7f9de1000000
0x7f9de1000000: _ #
#   length 0x200000
0x200000: _ #
#   src_type 0
0: _ #
# Testing guest mode PA-bitsANY, VA-bits48,  4K pages
guest: mode_PA-bitsANY, #
# Guest physical address width detected 39
physical: address_width #
[FAIL] 11 selftests kvm vmx_dirty_log_test # exit=254

Is a kvm test running at the same time? It just looks like the entire
console goes silent (which would certainly make the lkdtm tests fail)

> https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.5-11440-gd1ea35f4cdd4/testrun/1202720/log

Similar happens here, only this time it seems to be gpio tests?

[  363.276824] kselftest: Running tests in lkdtm
# ./gpio-mockup.sh line 89 ./gpio-mockup-chardev No such file or
# directory
line: 89_./gpio-mockup-chardev #
# GPIO gpio-mockup test with ranges <-1,32,-1,32,-1,32> 
gpio-mockup: test_with #
# -1,32,-1,32,-1,32 
...
[  407.481225] test_bpf: #0 TAX jited:1 63 62 132 PASS

The console seems broken for over 40 seconds?

-- 
Kees Cook
