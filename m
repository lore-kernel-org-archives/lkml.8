Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BD7C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12C32067D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="E7rBgMfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394417AbgBNRAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:00:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41849 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390550AbgBNRAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:00:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so5154301pfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 09:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mMbk3LUtFFonCbHvxPtq3VRJfckeTUY1K1Awq5IpEbQ=;
        b=E7rBgMfTslEdAa51yhBteDEbNwDifWOiivwEpnXPMMNzoZKvpflgLsVZc40XE+ngvI
         5QH1pUHuUdcQwwYKHxR4MVzCMQSjfJchmWGwkHXa2N4V5ZoDb/PB75kOw5zrlNHkODpP
         nDKL7tDcGoUnqt/iIS40qR9S7P+4WDRrgPAlCV1qS285y6B1MyOriTMeBCIVYaYR7Z0d
         Hc8r6IeWSt4HRmi6C+2rqaOFeSdvRbelf6T3HH9GeF6vyXUgn/RI5m/8cpa8SfVttlm7
         rQO64Ek2PuLq+5v2dQlFxFJbxfbA8BuI3h3cYoCNidcSsqwDv+4WR0MlvuC7wPz7P/pm
         ddYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mMbk3LUtFFonCbHvxPtq3VRJfckeTUY1K1Awq5IpEbQ=;
        b=VmyyFEcnUaPJKmv7qjwZ51xyXU//XW8UXSor1Vk7HDk3ICLh94VBIO206D+lHfiY2r
         snGNm8debCdiqDDr3+WjjhuIrtlsypmolOm4Lp/i0F0+PPUha3FO7leGe2NAUVyatdfK
         lgOTG5tRLWALyPQP9OKjR5wiLUCg+F3ZTZ5752rm+icmTyHAacxhEsy4ikqKfmteJJKJ
         DKyQBed1BWHbKxY90aR9tl851VAkZhKP9ZJJ5pYm3hDisXQ/IEEnYwI5coaREwo5MPwg
         HP1QsaP2cYf8Hu3sWog9AefkiRhT5hBsdXkj+9NjqfEWuqXkfUEKFkGQM7SgjlfIjKhZ
         lpEg==
X-Gm-Message-State: APjAAAWnbqhCuZXMor90S2Q3J93/CcReviwVPEgTkXJRzQ2MMZSGhmwg
        2rwYmPbhqNDrRUcCIs79vxg+ew==
X-Google-Smtp-Source: APXvYqx9pwndWjzTw48b+2ZezAwXcX8mfwTFPA0lWnMyxbbEihEqWPppJWAVTyKw1qxnoF6lMrSwkg==
X-Received: by 2002:a62:8246:: with SMTP id w67mr4318627pfd.107.1581699617881;
        Fri, 14 Feb 2020 09:00:17 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id 133sm7556599pfy.14.2020.02.14.09.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 09:00:17 -0800 (PST)
Subject: Re: [PATCH 0/3] random: add random.rng_seed to bootconfig entry
To:     Rob Herring <robh@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <158166060044.9887.549561499483343724.stgit@devnote2>
 <CAL_JsqJ_VwHdpQ_WnQHu5J-bfs1vRPd5HQwVekR+5kKdVi4sXw@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <1694f42c-bfc9-570a-64d2-3984965c8940@android.com>
Date:   Fri, 14 Feb 2020 09:00:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ_VwHdpQ_WnQHu5J-bfs1vRPd5HQwVekR+5kKdVi4sXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/20 5:49 AM, Rob Herring wrote:
> On Fri, Feb 14, 2020 at 12:10 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>> Hi,
>>
>> The following series is bootconfig based implementation of
>> the rng_seed option patch originally from Mark Salyzyn.
>> Note that I removed unrelated command line fixes from this
>> series.
> Why do we need this? There's already multiple other ways to pass
> random seed and this doesn't pass the "too complex for the command
> line" argument you had for needing bootconfig.
>
> Rob

Android is the use case I can vouch for. But also KVM.

Android Cuttlefish is an emulated device used extensively in the testing 
and development infrastructure for In-house, partner, and system and 
application developers for Android. There is no bootloader, per-se. 
Because of the Android GKI distribution, there is also no rng virtual 
driver built in, it is loaded later as a module, too late for many 
aspects of KASLR and networking. There is no Device Tree, it does 
however have access to the content of the initrd image, and to the 
command line for the kernel. The only convenient way to get early 
entropy is going to have to be one of those two places.

In addition, 2B Android devices on the planet, especially in light of 
the Android GKI distribution were everything that is vendor created is 
in a module, needs a way to collect early entropy prior to module load 
and pass it to the kernel. Yes, they do have access to the recently 
added Device Tree approach, and we expect them to use it, as I have an 
active backport for the mechanism into the Android 4.19 and 5.4 kernels. 
There may also be some benefit to allowing the 13000 different 
bootloaders an option to use bootconfig as a way of propagating the much 
needed entropy to their kernels. I could make a case to also allow them 
command line as another option to relieve their development stress to 
deliver product, but we can stop there. Regardless, this early entropy 
has the benefit of greatly improving security and precious boot time.

Sincerely -- Mark Salyzyn

