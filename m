Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F5FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06D02168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="I2psfdBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgBNSbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:31:21 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55715 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbgBNSbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:31:20 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so4206464pjz.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 10:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=b2tZd1tExc8HDMdHBE3vQFxVxr8Zxh1LCSwV2NCLKvA=;
        b=I2psfdBnjWffVVztPHbsuO6CJ1Wik63YRMJ7O0UZnYqwXbM0XbThRNVDNh7GFGt4JL
         m70CeLxJ8CHuU6pM7QNVUuzZizPkY/avCoYD7zSwwE4x6KERh6m95jrh0i4ikiCd8XRY
         WPcezJytnnIzv3FYja0Zv8mEzFdsDTKHCRBxPwmbEHB6K0wZDWc1FXRkYuX/iM//beDU
         yN/oHf2wS9u+UmOZVh4lDTXPJZQvK/E35/Q6KyJ6dosvdc0edZzptawqkbxSHv2j2X/X
         mEMwuXWsi9Hdw6P8gXgL3ZHPcW9ZTVJHBKjYEyVIO6W9jvKmpjrXxVlrsKStqjIQQGfG
         xOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=b2tZd1tExc8HDMdHBE3vQFxVxr8Zxh1LCSwV2NCLKvA=;
        b=uIkP2upeivHDHh3sbxkFXbkfgSLpoRXPIZKMopAEhi8IcHRuBlpa2vJ35lGdtSQ432
         svBuilYcMfvz2rNgZiH+NajQARnOg0ekd23dRPWTkVxlmCiNQzhZROygDHEl3CNi8tQk
         wrMTelw2KXP/559ZSJAArf8YG91gWgZbyDUosV6Jz/xY7WFZmzhbPs6D2TBb/zM0izkc
         XSN3uYshv7cZNCERneA6uXAsA2iEm95DDG15hnjsySIyZz8cgpS2oas5DDiARVzIHd9S
         feqXMUO37Xu06Q5ztZ96NVDL/t4NFQ2RHDt8F+opN6uS0c3jprQzFLugdcg9N51lGYMD
         xEvA==
X-Gm-Message-State: APjAAAV8pMcO2CD1OCOmTzyaopafjITX3u60jB9Qps+HY82JmXUnwaSS
        GjcrIPA+wtFnaMlMWDM2wIgcTg==
X-Google-Smtp-Source: APXvYqweRvrbcGI+TN/E706xtY2309e9rucgMW2XIhqLYDDV+p9y1XPcO+Pq087xKSbHaBwFV0buhg==
X-Received: by 2002:a17:902:a616:: with SMTP id u22mr4596187plq.173.1581705080166;
        Fri, 14 Feb 2020 10:31:20 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id a10sm782832pgk.71.2020.02.14.10.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 10:31:19 -0800 (PST)
Subject: Re: [PATCH 0/3] random: add random.rng_seed to bootconfig entry
To:     Rob Herring <robh@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
 <1694f42c-bfc9-570a-64d2-3984965c8940@android.com>
 <CAL_JsqKb=qBH6QXphEZi7vMS+2K5kNj1riXQiUWma=bidAjN5A@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <7882e5d2-dd4d-cdfb-2aab-9a3d910882d4@android.com>
Date:   Fri, 14 Feb 2020 10:31:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKb=qBH6QXphEZi7vMS+2K5kNj1riXQiUWma=bidAjN5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/20 10:14 AM, Rob Herring wrote:
> On Fri, Feb 14, 2020 at 11:00 AM Mark Salyzyn <salyzyn@android.com> wrote:
>> On 2/14/20 5:49 AM, Rob Herring wrote:
>>> On Fri, Feb 14, 2020 at 12:10 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>>> Hi,
>>>>
>>>> The following series is bootconfig based implementation of
>>>> the rng_seed option patch originally from Mark Salyzyn.
>>>> Note that I removed unrelated command line fixes from this
>>>> series.
>>> Why do we need this? There's already multiple other ways to pass
>>> random seed and this doesn't pass the "too complex for the command
>>> line" argument you had for needing bootconfig.
>>>
>>> Rob
>> Android is the use case I can vouch for. But also KVM.
. . .
> I'm familiar with Cuttlefish somewhat. Guess who got virtio-gpu
> working on Android[1]. :) I assume DT doesn't work for you because you
> need x86 builds, but doesn't QEMU use UEFI in that case which also has
> a mechanism for passing entropy.
IDK, will have to ask the Cuttlefish Team why UEFI not being used, will 
get back to you.
>
> To clarify my question: Why do we need random seed in bootconfig
> rather than just the kernel command line? I'm not understanding why
> things changed from your original patch.

Command line was identified as the simplest for them to implement 
generically for the x86 and arm64 Cuttlefish instances and hence my 
original patch series.

However, it also is limited in the size of the entropy string that can 
be provided, so we flipped a coin and decided to accept the bootconfig 
mechanism as a viable alternative; that BTW appeared to be simpler to 
implement (mainly because rubbing out the entropy command line argument 
is not easy).

-- Mark

