Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C3FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B422250E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgGTBS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:18:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44992 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgGTBS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:18:58 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1jxKSF-00036H-OX
        for linux-kernel@vger.kernel.org; Mon, 20 Jul 2020 01:18:55 +0000
Received: by mail-pg1-f200.google.com with SMTP id j9so12673844pgm.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dTQyUG61kX2XCwIUiPSY5cCF6yJekK9Ymo10gmabLSw=;
        b=WDFN4pyDKWLGvwmHxU7HaweQNruRKPGvT0HIENPRnmKLMR4P0ccFTsIT7lIIy3F4Se
         ETfabA9DgLAqKKJX1rrTW2a7AqxxtCCnDBscRLMwm7n/uFGSdAvN3U4QR/NktOxiKTL6
         xyUAPaM0InF0rn/zmAGXlCZ7WRUR+ElB7GkdrxFnv3utM1bY9WbYUgjiGpFeDFWffXdU
         OGw3HUP0S8UH1w/DTYl6HdprIj9VntF1MbLrhN8Ky+TcRBCa6MhaJFn39WT3k7OrgObG
         FPMlpvtY/gnL/yFC1Zvo+m+ongO33mOKpX0xr3+pq8bU/h9XGL3dUyfc1ergYoVQTIJf
         ppww==
X-Gm-Message-State: AOAM532r4cYLgPMcWWXu5os5FzuCOztz1slzD3Aw6D8zSiB+U89jytyS
        kpOPCqN+dTjHvCeQs0PRR4swrHC2+y+Dbcg4cbluueRh5un5nFCTd7smyy/nNOi88I1Ezb8UZ98
        dtrKRWWphphkVFbpo/Yz1r4b7NOoABqRs4VDhtbZQzA==
X-Received: by 2002:a65:490d:: with SMTP id p13mr16441330pgs.183.1595207934350;
        Sun, 19 Jul 2020 18:18:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwudbwMDOJLkji0WfrSzxkPuyTod60uCI/xIM8pY05aS+io4K0fWco4Zfmkc0P1TnvefU0aMw==
X-Received: by 2002:a65:490d:: with SMTP id p13mr16441307pgs.183.1595207933994;
        Sun, 19 Jul 2020 18:18:53 -0700 (PDT)
Received: from [192.168.0.119] (d66-222-144-129.abhsia.telus.net. [66.222.144.129])
        by smtp.gmail.com with ESMTPSA id 15sm10012333pjs.8.2020.07.19.18.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 18:18:53 -0700 (PDT)
Subject: Re: [PATCH] RFC: ACPI / OSI: remove workarounds for hybrid graphics
 laptops
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lyude Paul <lyude@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
References: <20200717190547.648604-1-kherbst@redhat.com>
 <e7a8cb3a-e9f8-b78a-93f0-c09e5eb5ed10@canonical.com>
 <CACO55tvLCrqeV8MsVDbTaWP2EPAeZtfU08Kb2fVGCD6X+g3-rg@mail.gmail.com>
From:   Alex Hung <alex.hung@canonical.com>
Message-ID: <8ad1866d-eb61-a30c-5875-5ffbfd2e17e1@canonical.com>
Date:   Sun, 19 Jul 2020 19:18:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACO55tvLCrqeV8MsVDbTaWP2EPAeZtfU08Kb2fVGCD6X+g3-rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-19 1:50 p.m., Karol Herbst wrote:
> On Fri, Jul 17, 2020 at 9:52 PM Alex Hung <alex.hung@canonical.com> wrote:
>>
>> On 2020-07-17 1:05 p.m., Karol Herbst wrote:
>>> It's hard to figure out what systems are actually affected and right now I
>>> don't see a good way of removing those...
>>>
>>> But I'd like to see thos getting removed and drivers fixed instead (which
>>> happened at least for nouveau).
>>>
>>> And as mentioned before, I prefer people working on fixing issues instead
>>> of spending time to add firmware level workarounds which are hard to know
>>> to which systems they apply to, hard to remove and basically a big huge
>>> pain to work with.> In the end I have no idea how to even figure out what systems are affected
>>> and which not by this, so I have no idea how to even verify we can safely
>>> remove this (which just means those are impossible to remove unless we risk
>>> breaking systems, which again makes those supper annoying to deal with).
>>>
>>> Also from the comments it's hard to get what those bits really do. Are they
>>> just preventing runtime pm or do the devices are powered down when booting?
>>> I am sure it's the former, still...
>>>
>>> Please, don't do this again.
>>>
>>> For now, those workaround prevent power savings on systems those workaround
>>> applies to, which might be any so those should get removed asap and if
>>> new issues arrise removing those please do a proper bug report and we can
>>> look into it and come up with a proper fix (and keep this patch out until
>>> we resolve all of those).
>>>
>>> Signed-off-by: Karol Herbst <kherbst@redhat.com>
>>> CC: Alex Hung <alex.hung@canonical.com>
>>> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> CC: Len Brown <lenb@kernel.org>
>>> CC: Lyude Paul <lyude@redhat.com>
>>> CC: linux-kernel@vger.kernel.org
>>> CC: dri-devel@lists.freedesktop.org
>>> CC: nouveau@lists.freedesktop.org
>>> ---
>>>  drivers/acpi/osi.c | 24 ------------------------
>>>  1 file changed, 24 deletions(-)
>>>
>>> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
>>> index 9f68538091384..d4405e1ca9b97 100644
>>> --- a/drivers/acpi/osi.c
>>> +++ b/drivers/acpi/osi.c
>>> @@ -44,30 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
>>>       {"Processor Device", true},
>>>       {"3.0 _SCP Extensions", true},
>>>       {"Processor Aggregator Device", true},
>>> -     /*
>>> -      * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
>>> -      * cards as RTD3 is not supported by drivers now.  Systems with NVidia
>>> -      * cards will hang without RTD3 disabled.
>>> -      *
>>> -      * Once NVidia drivers officially support RTD3, this _OSI strings can
>>> -      * be removed if both new and old graphics cards are supported.
>>> -      */
>>> -     {"Linux-Dell-Video", true},
>>> -     /*
>>> -      * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
>>> -      * audio device which is turned off for power-saving in Windows OS.
>>> -      * This power management feature observed on some Lenovo Thinkpad
>>> -      * systems which will not be able to output audio via HDMI without
>>> -      * a BIOS workaround.
>>> -      */
>>> -     {"Linux-Lenovo-NV-HDMI-Audio", true},
>>> -     /*
>>> -      * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
>>> -      * output video directly to external monitors on HP Inc. mobile
>>> -      * workstations as Nvidia and AMD VGA drivers provide limited
>>> -      * hybrid graphics supports.
>>> -      */
>>> -     {"Linux-HPI-Hybrid-Graphics", true},
>>>  };
>>>
>>>  static u32 acpi_osi_handler(acpi_string interface, u32 supported)
>>>
>>
>> The changes were discussed and tested a while ago, and no crashes were
>> observed. Thanks for solving PM issues in nouveau.
>>
>> Acked-by: Alex Hung <alex.hung@canonical.com>
>>
> 
> By any chance, do you have a list of systems implementing those workarounds?
> 

I don't keep a list but the workaround, in theory, should only apply to
the systems with the specific nvidia hardware.

I reminded OEMs and ODMs that these _OSI strings were temporary
solutions, and highlighted we were going to remove them after our
discussion last year. If they were paying attentions recent systems
shouldn't have these _OSI strings.

-- 
Cheers,
Alex Hung
