Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A04C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF9920781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgDWLWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:22:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:31377 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgDWLWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:22:51 -0400
IronPort-SDR: AcMptT1DhXDz4m2GJCyOAAB2TkIQVn4ZxkvI0ZrZNJI/oz398TDykOYnN/aM/kkon8AGyBkh/D
 VhcfoNwce77g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 04:22:50 -0700
IronPort-SDR: nvZ0n9gpKH8PS9gK98CYzFUTBic+JqWzsLocu+oZe2X21PWwGBP3keTEdN9j73onVYQO1pbUmG
 Mm4Z/EnAblyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="246238908"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by fmsmga007.fm.intel.com with ESMTP; 23 Apr 2020 04:22:48 -0700
Subject: Re: [PATCH v2] xhci: Set port link to RxDetect if port is not enabled
 after resume
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200311040456.25851-1-kai.heng.feng@canonical.com>
 <B4E44BDC-5AFE-4F8A-8498-0EEE9CDAC0E1@canonical.com>
 <635B3350-F064-4B45-B194-40F793423049@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <35fbb517-31b1-7bba-8e07-795ab18af1ff@linux.intel.com>
Date:   Thu, 23 Apr 2020 14:25:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <635B3350-F064-4B45-B194-40F793423049@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.4.2020 16.21, Kai-Heng Feng wrote:
> 
> 
>> On Mar 26, 2020, at 19:33, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>
>> Hi Mathias,
>>
>>> On Mar 11, 2020, at 12:04, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>
>>> On Dell TB16, Realtek USB ethernet (r8152) connects to an SMSC hub which
>>> then connects to ASMedia xHCI's root hub:
>>>
>>> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
>>>   |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
>>>           |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
>>>
>>> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>>> Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp. USB5537B
>>> Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter
>>>
>>> The port is disabled after resume:
>>> xhci_hcd 0000:3f:00.0: Get port status 4-1 read: 0x280, return 0x280

That sound like the actual problem.
Any idea how the port link ends up ends up in the disabled state?
Was there a request to set port feature, link state to SS.Disabled? 
Or timeouts at resume from U3
U3 -> Recovery  (timeout) -> Rx.Detect -> Polling (Timeout) ->  SS.Disabled

>>>
>>> According to xHCI 4.19.1.2.1, we should set link to RxDetect to transit
>>> it from disabled state to disconnected state, which allows the port to
>>> be set to U0 and completes the resume process.
>>>
>>> My own test shows port can still resume when it's not enabled, as long
>>> as its link is in U states. So constrain the new logic only when link is
>>> not in any U state.

Sounds more like re-enumerate than proper resume if we go to RxDetect in between

>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>
>> Do you think this is a proper fix?
> 
> Another gentle ping...
> 
>>
>> Kai-Heng
>>
>>> ---
>>> drivers/usb/host/xhci-hub.c | 8 ++++++++
>>> 1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>>> index a9c87eb8951e..263f9a9237a1 100644
>>> --- a/drivers/usb/host/xhci-hub.c
>>> +++ b/drivers/usb/host/xhci-hub.c
>>> @@ -1776,6 +1776,14 @@ int xhci_bus_resume(struct usb_hcd *hcd)
>>> 			clear_bit(port_index, &bus_state->bus_suspended);
>>> 			continue;
>>> 		}
>>> +
>>> +		/* 4.19.1.2.1 */
>>> +		if (!(portsc & PORT_PE) && (portsc & PORT_PLS_MASK) > XDEV_U3) {
>>> +			portsc = xhci_port_state_to_neutral(portsc);
>>> +			portsc &= ~PORT_PLS_MASK;
>>> +			portsc |= PORT_LINK_STROBE | XDEV_RXDETECT;
>>> +		}
>>> + 
This doesn't look like the right solution.
This will set the link state to RxDetect for any USB3 roothub port
that is currently not in U0/U1/U2/U3 or Recovery.

Was this roothub port forcefully suspended xhci_bus_suspend()?
i.e. was a bit set in bus_state->bus_suspended for this port?

Any other logs or traces that could explan what's going on?
Is the resume due to a wakeup (device initiated resume) from this device,
or just a host initiated resume?

Thanks
-Mathias
