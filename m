Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35A6C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 12:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76CE24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 12:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBUM2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 07:28:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:3690 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgBUM2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 07:28:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 04:28:06 -0800
X-IronPort-AV: E=Sophos;i="5.70,468,1574150400"; 
   d="scan'208";a="229837267"
Received: from jmiler-mobl.ger.corp.intel.com (HELO localhost) ([10.249.38.187])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 04:28:01 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>, Mark Pearson <mpearson@lenovo.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nitin Joshi <nitjoshi@gmail.com>,
        Mat King <mathewk@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Benjamin Berg <bberg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [External] Re: [PATCH] thinkpad_acpi: Add sysfs entry for lcdshadow feature
In-Reply-To: <CACK8Z6HWkafL4EzOndRyiA3k-VyUg8bQ=2diw_wJSxSTyqsE+w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200220074637.7578-1-njoshi1@lenovo.com> <CAHp75VcJmEOu1-b7F2UAsv=Gujb=pPLzjz2ye9t4=Q68+ors-w@mail.gmail.com> <HK2PR0302MB25937E2946BF38583B3A905DBD130@HK2PR0302MB2593.apcprd03.prod.outlook.com> <CACK8Z6GwuOnJUUscriGwKWGBp5PFKyuqUkFYC8tEXa0UEuEZww@mail.gmail.com> <PS1PR0302MB260492DDE243BE0A64A39AA7BD130@PS1PR0302MB2604.apcprd03.prod.outlook.com> <CACK8Z6HWkafL4EzOndRyiA3k-VyUg8bQ=2diw_wJSxSTyqsE+w@mail.gmail.com>
Date:   Fri, 21 Feb 2020 14:28:06 +0200
Message-ID: <87tv3kxgyx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020, Rajat Jain <rajatja@google.com> wrote:
> Hi Mark,
>
>
> On Thu, Feb 20, 2020 at 11:03 AM Mark Pearson <mpearson@lenovo.com> wrote:
>>
>> Hi Rajat,
>>
>> > -----Original Message-----
>> > From: Rajat Jain <rajatja@google.com>
>> > Sent: Thursday, February 20, 2020 1:39 PM
>> > >
>> > > For this particular issue what is the best way to contribute and get
>> > > involved? We'd like to make it so ePrivacy can be used more easily from
>> > > Linux. I agree a more generic way of controlling it would be good.
>> > > I looked at the proposed patch from Rajat
>> > > (https://lkml.org/lkml/2019/10/22/967) - it seems like a good solution to me.
>> > > We can help with testing that on our platforms if that would be useful.
>> >
>> > Thanks you, just so that you know, the latest patchset is at:
>> > https://lkml.org/lkml/2019/12/20/794
>> >
>> > It would be great to get some additional testing if possible. I can
>> > send a sample ACPI (for our platform) in case it helps.
>> >
>> Sounds good - we'll definitely try this out and see how it goes. I
>> suspect we'll have some questions once we try it out and get more
>> familiar.
>>
>> > >
>> > > I need to understand how we connect that implementation with the ACPI
>> > > controls we have (as I believe what we have are thinkpad specific and not to
>> > > a drm spec; we need to confirm that). We also have the ACPI events that
>> > > notify if ePrivacy was changed by the hotkeys and that seems like something
>> > > that should be done in thinkpad_acpi.c and not the drm code.
>> > >
>> > > Not sure if the two need to be connected somehow (or if handling the
>> > > event is actually not important and polling is acceptable)?
>> >
>> > So there was some brief discussion about this on my patches - but
>> > atleast on  the platforms I have seen, there was no way to change the
>> > privacy screen out of software / kernel control. Essentially, if there
>> > are hotkeys, they would send an input event to the kernel, who'd send
>> > them to userspace, who'd use the DRM method to toggle the privacy
>> > screen. Thus the current version of the patch only supports
>> > controlling the privacy screen via set() method. The get() method just
>> > returns the cached value.I hope that works for you.
>> >
>> OK - on the thinkpads we have function+D as a 'hotkey' to control the
>> feature...and my understanding is that bypasses everything and goes
>> straight to the firmware.

In general I think it's preferrable if the hotkey sends the key event to
userspace that then makes the policy decision of what, if anything, to
do with it. Everything is much easier if the policy is in userspace
control. For example, you could define content based policies for
enabling privacy screen, something that is definitely not possible with
firmware.

I emphatize with the desire to just bypass everything at the
hardware/firmware level, because that is totally in your control (as an
OEM), and requires no interaction with the operating system
initially. Exposing the read-only state of the privacy screen is
helpful, but prevents the OS from building more advanced features on
top, failing to reach the full potential of the nice hardware feature.

That said, we obviously do need to take such hardware/firmware
implementations into account as well.

>> The changes Nitin had been working on in thinkpad_acpi.c was to make
>> this more Linux and friendly - provide a sysfs hook for user space to
>> connect to with the aim of allowing it to be configured from user
>> space and have on screen display when it was triggered etc.

IMO one of the problems with using sysfs for this is that it's not
connected with the graphics subsystem. The userspace has to go out of
its way to make the connection between the privacy screen and the
display. It shouldn't have to. It's a property of the display, not some
unrelated device (although, technically, I presume in hardware it might
be ;).

We've made the mistake with backlight before, and we still somewhat
struggle with it. Please let's not repeat that.

>> I'm personally not sure yet how this ties up with the DRM method -
>> more digging required. I'm intrigued to see if it works on our
>> systems (sadly I don't have anything with that feature available on
>> my desk right now...I need to get my hands on one)
>
> Just FYI, Here is the brief discussion we had about an interrupt
> mechanism to support a (hardware based) "kill switch" for the privacy
> screen.
> https://lkml.org/lkml/2019/10/25/992

I agree with Pekka's mail [1] in that thread.

BR,
Jani.


[1] https://lkml.org/lkml/2019/10/28/94

-- 
Jani Nikula, Intel Open Source Graphics Center
