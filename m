Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8410CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624C4206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvtLldIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406863AbgE1TvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406741AbgE1TvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:51:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F10C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:51:18 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q2so34915106ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUWteLk1qo/EQ4bMelbArMawbtwfGJA1RUwrky8bVBE=;
        b=jvtLldIrYKX300AzToiku7J6CFXrR/LCiCWvns51CFZMNLl68OXNG2qe0R3J/bhCu2
         D6X4iy42RnXaeC/qOT91y6FXIKJNiYQj3jfYvV99vn20N9jkrk7tgFon8cDayxprvBVR
         IKQwzc55OgVYyi2SG10dNMHO8M3PTr02Exeg78gVLvnipth6k2bMo0NqC+e7ytkZ8s2X
         eQZjJjf9p6fG63rA3UtRCNanFbAhH8u11835MH2OnOjzCbtLFd/rRtUEilWca9Wt9CbK
         3zmDRyO8UyB1028lutz2PFy31zktI2fJUznxLcNtQj2qo32+/RSVvOY6zvPiXAglo2pw
         f+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUWteLk1qo/EQ4bMelbArMawbtwfGJA1RUwrky8bVBE=;
        b=g61t7VNKBl7QOMmNV9nwT/PVA2unKKRWnn79aWFvZEn/Y57zm+NHKFEz89I9jLWJC6
         UeSWe1UTg5z33CUIG2SXL/SvZGpdmtgzrgSsaA8TTxaSOrj6is6LDUd72JJMpodiyUSm
         7yhMQtfB0T5cBMJiG0zSiP5kENmvo5CBzTT9OAPqEI4n12z6Any/xEMpVH1u3mc4o2sT
         EXxUPMT8/yDN9Hr7hTkcJYWDCDnmmyGsl4R8KLC1QouQKXM8pdEVhk4cyrCvWxnBG6lI
         slWNGygd0mVCgjBH4184TeuHs8rQ1lci6ivr4W4TO1rHgL+c+xAAI7GyyvHTt8buMKns
         n9sA==
X-Gm-Message-State: AOAM533brPIwZS3yBPd2fMthmpWQBYLFtNzWpltDh7mUBsAszOhUECR/
        v8yfiFNQUY4kuWzDbOMm1SDWxJ8/HxhkbimQeZZvIw==
X-Google-Smtp-Source: ABdhPJwVlSEUIqKm3ytEt4ZeDf8mVNXY7GJDgsEX4PDMBqYyKpwp6lFyxNZmXX+LL999hVVGiHTHCyQzK22+WhbuLHQ=
X-Received: by 2002:a2e:9684:: with SMTP id q4mr2373751lji.431.1590695476954;
 Thu, 28 May 2020 12:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvnJNre4G=ZsPAon_Zt+kT_QLQB_VZVhdWKYbn29xtsRA@mail.gmail.com>
 <20200528193840.GD30353@linux.intel.com>
In-Reply-To: <20200528193840.GD30353@linux.intel.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 29 May 2020 01:21:05 +0530
Message-ID: <CA+G9fYsC91dc5qp3Fb4nnZ=GzWu_9TG-_RVD2ie6xLmYD77n8w@mail.gmail.com>
Subject: Re: BUG: arch/x86/kvm/mmu/mmu.c:3722: kvm_mmu_load+0x407/0x420
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>, eesposit@redhat.com,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vivek Goyal <vgoyal@redhat.com>, Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 at 01:08, Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, May 29, 2020 at 12:59:40AM +0530, Naresh Kamboju wrote:
> > While running selftest kvm set_memory_region_test on x86_64 linux-next kernel
> > 5.7.0-rc6-next-20200518 the kernel BUG noticed.
> >
> > steps to reproduce: (always reproducible )
> > -------------------------
> > cd /opt/kselftests/default-in-kernel/kvm
> > ./set_memory_region_test
> >
> > BAD: next-20200518 (still reproducible on next-20200526)
> > GOOD: next-20200515
> > git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > kernel config:
> > http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-next/777/config
> >
> > kernel crash log,
> > -----------------------
> > [   33.074161] ------------[ cut here ]------------
> > [   33.079845] kernel BUG at /usr/src/kernel/arch/x86/kvm/mmu/mmu.c:3722!
>
> I'm 99% certain this is already fixed[*], I'll double check to confirm.

Thanks for looking into this problem.

> [*] https://lkml.kernel.org/r/20200527085400.23759-1-sean.j.christopherson@intel.com

I see you made a recent fix (on Wed, 27 May 2020).
Let this patch get into the linux-next tree master and our build system
will pull it and test it. I will report back once it is fixed.

- Naresh
