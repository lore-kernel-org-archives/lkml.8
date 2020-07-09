Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8F6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0233520578
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zu0R2foe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgGIX3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgGIX3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:29:35 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8807C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 16:29:34 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id q15so1260109uap.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjY53ZWFZGRVCcgeyGe3Vzmlwh5PcCorcd2Oa7eNfnE=;
        b=Zu0R2foe9ngqfN44p73YMv5Nmrf5rbD4KKYGsuAnZweJMFDYl3OXJJEGunnASpfOsJ
         i768kfjK3pmpDgcI1c14KMSKWUVoGvDxC/tA1NMffZ3djAv2128XDVg6OeiZr/HiYFF0
         dWlEBcCSPRtMdf1HXlByTe/RuLKT00drA2ZHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjY53ZWFZGRVCcgeyGe3Vzmlwh5PcCorcd2Oa7eNfnE=;
        b=ZlUNorjjo2wXgMXYYsoXjfUT/8+HdVyDKGIJ1Og7gTMhHUtn0gKSdenSJR/CJkPrq6
         sAIH0aH2qve+XTu1pqA7YpIBrrLtOAcjXyJOoqjmpdn+x3h3uhS6m14R3zkXfSM6bqzJ
         WNoP2i7vP0oiJZ1jLt9n4e6qaWx75pS6w40lOFHCxrpwgIAh70o32CJqFrb2wWpZxcUL
         cfpNrpAWdyhOOUIK4WNa65ntbRpyN9ZL5FJ44WpL34XKmu+tS4fC/QJe44HfX6SruvBB
         xLBuZl8GlhfA+PVc3K8GpRvyFHzlAFZmBjYJm+Co1ot4e8ZHMcc3dkLU1Km97PtAwmRd
         lpUA==
X-Gm-Message-State: AOAM531sjT3Ryd/zCd1FgDLD2+6RUKDuueqU/+IsjOO0hqVHRyeo+hWS
        GWH1RIQjm2DMzLONLbIClf2aaQUxCww=
X-Google-Smtp-Source: ABdhPJyaihsgkHqDxSSsoBSzYyxo9/XDdj9nepHoid0sRsq77xkiBYjSWJIPwOccMMgZv+pUdEQ4QA==
X-Received: by 2002:ab0:6812:: with SMTP id z18mr22983973uar.106.1594337373562;
        Thu, 09 Jul 2020 16:29:33 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id k23sm604725vkn.24.2020.07.09.16.29.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 16:29:31 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id u133so2036912vsc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 16:29:31 -0700 (PDT)
X-Received: by 2002:a05:6102:20a:: with SMTP id z10mr40234084vsp.213.1594337370694;
 Thu, 09 Jul 2020 16:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200708194715.4073300-1-abhishekbh@google.com>
 <87y2ntotah.fsf@nanos.tec.linutronix.de> <CAD=FV=WCu7o41iyn27vNBWo4f_X_XVy+PPPjBKc+70g5jd5+8w@mail.gmail.com>
 <20200709224319.GC12345@mtg-dev.jf.intel.com> <CA+noqojC3z_o8+_Ek=17XxjVC+efoLHsUh08cbcTDrgxMcEGNQ@mail.gmail.com>
In-Reply-To: <CA+noqojC3z_o8+_Ek=17XxjVC+efoLHsUh08cbcTDrgxMcEGNQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Jul 2020 16:29:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VE5NRfjykJv4gTZJP17C3CwmvLRwWVdWWXJaO3UDGdjQ@mail.gmail.com>
Message-ID: <CAD=FV=VE5NRfjykJv4gTZJP17C3CwmvLRwWVdWWXJaO3UDGdjQ@mail.gmail.com>
Subject: Re: [PATCH v5] x86/speculation/l1tf: Add KConfig for setting the L1D
 cache flush mode
To:     Abhishek Bhardwaj <abhishekbh@google.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 9, 2020 at 4:05 PM Abhishek Bhardwaj <abhishekbh@google.com> wrote:
>
>
>
> On Thu, Jul 9, 2020 at 3:43 PM mark gross <mgross@linux.intel.com> wrote:
>>
>> On Thu, Jul 09, 2020 at 12:42:57PM -0700, Doug Anderson wrote:
>> > Hi,
>> >
>> > On Thu, Jul 9, 2020 at 3:51 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > >
>> > > Abhishek Bhardwaj <abhishekbh@google.com> writes:
>> > > > This change adds a new kernel configuration that sets the l1d cache
>> > > > flush setting at compile time rather than at run time.
>> > > >
>> > > > The reasons for this change are as follows -
>> > > >
>> > > >  - Kernel command line arguments are getting unwieldy. These parameters
>> > > >  are not a scalable way to set the kernel config. They're intended as a
>> > > >  super limited way for the bootloader to pass info to the kernel and
>> > > >  also as a way for end users who are not compiling the kernel themselves
>> > > >  to tweak the kernel behavior.
>> > > >
>> > > >  - Also, if a user wants this setting from the start. It's a definite
>> > > >  smell that it deserves to be a compile time thing rather than adding
>> > > >  extra code plus whatever miniscule time at runtime to pass an
>> > > >  extra argument.
>> > > >
>> > > >  - Finally, it doesn't preclude the runtime / kernel command line way.
>> > > >  Users are free to use those as well.
>> > >
>> > > TBH, I don't see why this is a good idea.
>> > >
>> > >  1) I'm not following your argumentation that the command line option is
>> > >     a poor Kconfig replacement. The L1TF mode is a boot time (module
>> > >     load time) decision and the command line parameter is there to
>> > >     override the carefully chosen and sensible default behaviour.
>> >
>> > When you say that the default behavior is carefully chosen and
>> > sensible, are you saying that (in your opinion) there would never be a
>> > good reason for someone distributing a kernel to others to change the
>> > default?  Certainly I agree that having the kernel command line
>> > parameter is nice to allow someone to override whatever the person
>> > building the kernel chose, but IMO it's not a good way to change the
>> > default built-in to the kernel.
>> >
>> > The current plan (as I understand it) is that we'd like to ship
>> > Chromebook kernels with this option changed from the default that's
>> > there now.  In your opinion, is that a sane thing to do?
>> >
>> >
>> > >  2) You can add the desired mode to the compiled in (partial) kernel
>> > >     command line today.
>> >
>> > This might be easier on x86 than it is on ARM.  ARM (and ARM64)
>> > kernels only have two modes: kernel provides cmdline and bootloader
>> > provides cmdline.  There are out-of-mainline ANDROID patches to
>> > address this but nothing in mainline.
>> >
>> > The patch we're discussing now is x86-only so it's not such a huge
>> > deal, but the fact that combining the kernel and bootloader
>> > commandline never landed in mainline for arm/arm64 means that this
>> > isn't a super common/expected thing to do.
>> >
>> >
>> > >  3) Boot loaders are well capable of handling large kernel command lines
>> > >     and the extra time spend for reading the parameter does not matter
>> > >     at all.
>> >
>> > Long command lines can still be a bit of a chore for humans to deal
>> > with.  Many times I've needed to look at "/proc/cmdline" and make
>> > sense of it.  The longer the command line is and the more cruft
>> > stuffed into it the more of a chore it is.  Yes, this is just one
>> > thing to put in the command line, but if 10 different drivers all have
>> > their "one thing" to put there it gets really long.  If 100 different
>> > drivers all want their one config option there it gets really really
>> > long.  IMO the command line should be a last resort place to put
>> > things and should just contain:
>>
>> This takes me back to my years doing android kernel work for Intel, I'm glad
>> those are over.  Yes, the android kernel command lines got hideous, I think we
>> even had patches to make the cmdline buffer bigger than the default was.
>>
>> From a practical point of view the command line was part of the boot image and
>> cryptography protected so it was a handy way to securely communicate parameters
>> from the platform to the kernel, drivers and even just user mode.  It got
>> pretty ugly but, it worked (mostly).
>>
>> What I don't get is why pick on l1tf in isolation?
>
> Because this is what we needed given the state of our projects.

Right.  Basically the flow is:

1. Someone comes up with a tweak that they think some people might
want to try out but it's not expected to be the default for anyone:
add a module parameter.

2. Someone comes around and says: I think it's sensible to change the
default for a whole class of devices, but another class of devices can
still use the old default: add a config option in addition to the
kernel parameter.


If #2 never happens then it can stay a module parameter forever.  If
#2 happens that's fine--it doesn't really hurt to add a config option
for it.


>> There are a bunch of
>> command line parameters similar to l1tf.  Would a more general option make
>> sense?
>
> Maybe. Given how much resistance this CONFIG has met, I can only imagine the resistance
> upon introducing a more reaching configuration. I also think there's a fine line between YAGNI (You Ain't
> Gonna Need It) vs planning for the future. I don't want to introduce a big CONFIG that won't be used for
> anything else. I'd rather we cross that bridge when someone else feels the same way about other options.

What are you envisioning?  I guess the "generic" solution is to add
cmdline extension (being able to combine kernel and bootloader
cmdline) to all platforms in a somewhat uniform way without breaking
any backward compatibility.  You'd still end up with a really ugly
"/proc/cmdline" if you had too many options there, but I guess it
wouldn't be the end of the world.

Getting this done on all platforms doesn't seem like it'd be an easy
task, though.


>> Anyway, I think there is a higher level issue you are poking at that might be
>> better addressed by talking about it directly.
>
>
> I am new to this process. I don't know who to "convince" or talk about these issues. Who is the final authority on
> this ?. I don't think appeasing every concern is going to be productive for anyone. I've offered to change the implementation,
> if that is what's required. However, if the final authority is against a CONFIG, I don't really know how to proceed.
>
>>
>>
>> --mark
>>
>>
>
>
> --
> Abhishek
