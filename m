Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A3BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E0C2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591982426;
	bh=+h54KEHq1zlJ4WiPNclPw2S/UdsBR7FdJBNgoGHsx5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qwgqbD5itz9KBu1+m/EKM7eqbHfRRhB0Tf2pwhU8IhPIW/KPXEGL33QuNOLCRFiRi
	 awApq+rw6his8Bf4jw7UfzuWkVkZEfohx3pAeBEAAL0syUWbJh3cUhZmsR7B4MzhYF
	 F+Q4Yn88jgBeWsZNGxYfKX/vsWrKkcmQgkX5jBbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgFLRUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgFLRUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:20:24 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187EC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:20:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a26so1445127lfj.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TseYOsqlKicldlfC8TDdcHanvSbPQ6ayvl06yiOJrtg=;
        b=Cu8AHJdCWY7DEpWHKlBPVUXHrrlhCRklZMN1J6RSuAlkIZhniyvKia2bviBLOWt63z
         kuK2NDfpzvfkmoohmkCQFTGzwLXZf5XPOsk9y/2h1L2URB9qiy43/g2kYEAc3kW3fSTD
         kv5rLg24iPdUCAJ5STcLILBsC9g6AWOE44u2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TseYOsqlKicldlfC8TDdcHanvSbPQ6ayvl06yiOJrtg=;
        b=Y9dk90DhhxVJGy0qDfZwcAxfCtRehVmDR/0lFgYAWpcjW5dVMwk0DUofBzUWQhSrG6
         Z7s31XXdLj/1mHgTWyVcIZtZgOniickKtnXWxukw9kTd1XxnMczOok77FJP8p2sUN74x
         9QOVdv91TfIaGnPzD0KNv8P7STgbGbPBlf77dMkAuZiEMpP5entVXQ/F5nkYR9YMwzus
         axKcPhRxhRdeP95SxcIcnR4JYsToW5DCyJavUNDj6zWITXZx1khOfOadoLCicVD/jPWV
         yKHSFFkx4J6oJb0Jb9pK8QPqkpcp3BSgBAv1Dnh6CRe37gxj92ptn3I2RoivrLVGwzyR
         b8bg==
X-Gm-Message-State: AOAM5324E/bXSn5mqL4R7xFKwfXS/EabrP9ViqfPgAJSpfSc0CXwDeHv
        /2L7iPaH22P+uDL0Fk8wrucLevb/fCA=
X-Google-Smtp-Source: ABdhPJz7a4kcE6RW5nPGkp00XT+4Qk0TvDQppS54vIkLmInX6A+yW1G3OtuYv+3XQ2W35js6cU7B4Q==
X-Received: by 2002:a05:6512:308e:: with SMTP id z14mr7495616lfd.29.1591982421137;
        Fri, 12 Jun 2020 10:20:21 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 15sm1824547ljw.46.2020.06.12.10.20.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 10:20:20 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 9so11933615ljv.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:20:20 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr7093784ljj.102.1591982419850;
 Fri, 12 Jun 2020 10:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200612105026.GA22660@zn.tnic>
In-Reply-To: <20200612105026.GA22660@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jun 2020 10:20:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKr+eAdPg3q7S6N4Cwd1aMEOHc5qLaKE-wwhouZRo=uw@mail.gmail.com>
Message-ID: <CAHk-=wjKr+eAdPg3q7S6N4Cwd1aMEOHc5qLaKE-wwhouZRo=uw@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/msr: Filter MSR writes
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 3:50 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Disable writing to MSRs from userspace by default. Writes can still be
> allowed by supplying the allow_writes=1 module parameter and the kernel
> will be tainted so that it shows in oopses.

Since you already added the filtering, this looks fairly sane.

IOW, what MSR's do we expect people to maybe write to normally? You
added MSR_IA32_ENERGY_PERF_BIAS as an allowed MST, maybe there are
others?

So I'm not against this, but I suspect the whitelist should be thought
through more, and then maybe the "allow_writes" parameter should be
yes/no/default/<msr-list>, where "default" is that list of
known-normal MSR's.

And I suspect it's a lot longer list than your single one. IIRC,
people were working around CPU bugs or features by doing MSR writes at
startup.

So the first phase might be to introduce this, but have the default
for non-recognized MSR's be "log", not "deny".

                Linus
