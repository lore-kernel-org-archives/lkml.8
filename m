Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A63C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5114920EDD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHaLdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:33:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:16962 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgHaLdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:33:50 -0400
IronPort-SDR: 9EJTa+cDqumSxd0Qplu1ngsqH7WiuyrVXM8WTX3oTf/5oUKgrdRonzvYjPnofyod3AqNfIrFF4
 cS6fhGVLlAyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="241763897"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="241763897"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 04:33:49 -0700
IronPort-SDR: FJyjIyehmz1fnVOPR1WLFIk8RvYiiQvO3IMVoQkvwsQyGFrMEhKzmMdO4PbkP85gZPiFafTc/6
 qMVIY07nQ0wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="445680219"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga004.jf.intel.com with ESMTP; 31 Aug 2020 04:33:45 -0700
Subject: Re: kworker/0:3+pm hogging CPU
To:     Alan Stern <stern@rowland.harvard.edu>,
        Salvatore Bonaccorso <carnil@debian.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dirk Kostrewa <dirk.kostrewa@mailbox.org>
References: <20200720151255.GE1228057@rowland.harvard.edu>
 <20200720163355.GA4061@dhcp22.suse.cz>
 <20200720173807.GJ1228057@rowland.harvard.edu>
 <20200720174530.GB4061@dhcp22.suse.cz>
 <20200720174812.GK1228057@rowland.harvard.edu>
 <20200720181605.GC4061@dhcp22.suse.cz>
 <20200720200243.GA1244989@rowland.harvard.edu>
 <20200721055917.GD4061@dhcp22.suse.cz>
 <20200721143325.GB1272082@rowland.harvard.edu>
 <20200829095003.GA2446485@eldamar.local>
 <20200829155949.GA499295@rowland.harvard.edu>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <38dfdef4-f9ab-1755-8418-2285d843af86@linux.intel.com>
Date:   Mon, 31 Aug 2020 14:37:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200829155949.GA499295@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.8.2020 18.59, Alan Stern wrote:
> On Sat, Aug 29, 2020 at 11:50:03AM +0200, Salvatore Bonaccorso wrote:
>> Hi Alan,
>>
>> I'm following up on this thread because a user in Debian (Dirk, Cc'ed)
>> as well encountered the same/similar issue:
>>
>> On Tue, Jul 21, 2020 at 10:33:25AM -0400, Alan Stern wrote:
>>> On Tue, Jul 21, 2020 at 07:59:17AM +0200, Michal Hocko wrote:
>>>>> Sorry, my mistake.  The module name needs to be "xhci_hcd" with an '_' 
>>>>> character, not a '-' character -- the same as what shows up in the lsmod 
>>>>> output.
>>>>
>>>>
>>>> [14766.973734] xhci_hcd 0000:00:14.0: Get port status 2-1 read: 0xe000088, return 0x88
>>>> [14766.973738] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0xe000088, return 0x88
>>>> [14766.973742] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0xe0002a0, return 0x2a0
>>>> [14766.973746] xhci_hcd 0000:00:14.0: Get port status 2-4 read: 0xe0002a0, return 0x2a0
>>>> [14766.973750] xhci_hcd 0000:00:14.0: Get port status 2-5 read: 0xe0002a0, return 0x2a0
>>>> [14766.973754] xhci_hcd 0000:00:14.0: Get port status 2-6 read: 0xe0002a0, return 0x2a0
>>>> [14766.973759] xhci_hcd 0000:00:14.0: Get port status 2-1 read: 0xe000088, return 0x88
>>>> [14766.973763] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0xe000088, return 0x88
>>>
>>> According to the xHCI specification, those 02a0 values are normal and 
>>> the 0088 values indicate the port is disabled and has an over-current 
>>> condition.  I don't know about the e000 bits in the upper part of the 
>>> word; according to my copy of the spec those bits should be 0.

That's a 0x0e000088 where the 0e00 bits are the wake bits. Leading zeroes are not shown. 

>>>
>>> If your machine has only two physical SuperSpeed (USB-3) ports then 
>>> perhaps the other four ports are internally wired in a way that creates 
>>> a permanent over-current indication.
>>>
>>>> [14766.973771] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 0 status  = 0xe000088
>>>> [14766.973780] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 1 status  = 0xe000088
>>>> [14766.973789] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 2 status  = 0xe0002a0
>>>> [14766.973798] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 3 status  = 0xe0002a0
>>>> [14766.973807] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 4 status  = 0xe0002a0
>>>> [14766.973816] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 5 status  = 0xe0002a0
>>>> [14766.973830] xhci_hcd 0000:00:14.0: Bus suspend bailout, port over-current detected
>>>>
>>>> Repeating again and again. The last message suggests a HW problem? But
>>>> why does the kernel try the same thing over and over?
>>>
>>> Because over-current is supposed to be a transient condition that goes 
>>> away quickly.  It means there's a short circuit or something similar.
>>
>> Dirk exprienced the same issue aand enabled dynamic debugging showed
>> similar pattern. His dmesg excerpt is attached.
>>
>> The Debian report is at https://bugs.debian.org/966703
>>
>> What could be tracked down is that the issue is uncovered since
>> e9fb08d617bf ("xhci: prevent bus suspend if a roothub port detected a
>> over-current condition") which was applied in 5.7-rc3 and backported
>> to several stable releases (v5.6.8, v5.4.36 and v4.19.119).
>>
>> Dirk found additionally:
>>
>>> I just found out, that if none of the two USB ports is connected, there
>>> are two kworker processes with permanently high CPU load, if one USB
>>> port is connected and the other not, there is one such kworker process,
>>> and if both USB ports are connected, there is no kworker process with
>>> high CPU load.
>>> I think, this supports your suspicion that these kworker processes are
>>> connected with the overcurrent condition for both USB ports that I also
>>> see in the dmesg output.
>>
>> Reverting the above commit covers the problem again. But I'm not
>> exprienced enough here to claim if this is a HW issue or if the Kernel
>> should handle the situation otherwise. Is there anything else Dirk can
>> provide?
> 
> It is undoubtedly a hardware issue.  The dmesg extract shows that ports 
> 1-10, 1-11, and 2-5 (which is probably the same port as one of the 
> others) have overcurrent conditions; I'm guessing that these are the 
> ports which have external connections.
> 
> What were the devices Dirk plugged in that got rid of the kworker 
> processes?  In particular, were they USB-2 or USB-3?  (The dmesg log for 
> when the devices were first attached can answer these questions.)
> 
> As far as I know, there is no way for the kernel to work around this 
> problem.  Preventing the controller from going into runtime suspend is 
> probably the best solution.
> 
> Perhaps Mathias (the xhci-hcd maintainer) will have more suggestions.

In the original case the over-current condition was always quickly
resolved and returning -EBUSY did the trick.

xhci specs say that over-current active bit shall cleared by hardware once
the over-current condition is no longer present, it's not much the driver can do.
(xhci 5.4.8 - Port status and control register)

I can't come up with any good solution to this right now.
Only bad ideas such as
a. Add a sleep to the over-current case, 
   doesn't solve anything else than the ~100% cpu hogging part of the problem 
b. After some retry limit of returning -EBUSY we return success and just hope
   for the best the xHC won't hang in this case.

Not sure how much additional complex code it is worth doing because of a couple cases
that seems to be broken hardware. If we get more cases, or can  
point to some specific setup with broken design we can create a quirk for it.

-Mathias



 



