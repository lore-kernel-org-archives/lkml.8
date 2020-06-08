Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19CBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF740206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgFHJ0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:26:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:3297 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728745AbgFHJ0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:26:10 -0400
IronPort-SDR: gnRlLFlILoFDHztL0UBiJTyJn62wFEbNSnJ5MFXvZfVzdbrzYdcJ4uVxW99HFlL1pMxWKvAyNK
 3unn86obubBQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 02:26:08 -0700
IronPort-SDR: 2tlcmwKl52Yp62zIC/6CDdjeuUJqP3+/85PpuxRjJ1EfrqPMXyvetaf6F3+fnJSPBfk171MGA5
 eJwcbNf5MF7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="270451160"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga003.jf.intel.com with ESMTP; 08 Jun 2020 02:26:06 -0700
Subject: Re: [PATCH] xhci: Make debug message consistent with bus and port
 number
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mathias.nyman@intel.com,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200507061755.13280-1-kai.heng.feng@canonical.com>
 <20200507064510.GA787064@kroah.com>
 <C4A734C8-D1C6-45BC-9C0A-92364EAEE3C0@canonical.com>
 <20200507073119.GA876666@kroah.com>
 <90D5B23E-B037-49D2-BD44-7F9B0B2FC155@canonical.com>
 <20200507082149.GE1024567@kroah.com>
 <938b0ce5-cb56-a356-dec8-3a6adc502752@linux.intel.com>
 <E6AD21DC-A086-44B9-98F5-7FB320E9B457@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <dd75ab92-cb02-4a7d-0a03-f105878f71cd@linux.intel.com>
Date:   Mon, 8 Jun 2020 12:29:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <E6AD21DC-A086-44B9-98F5-7FB320E9B457@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.6.2020 6.57, Kai-Heng Feng wrote:
> 
> 
>> On May 7, 2020, at 18:35, Mathias Nyman <mathias.nyman@linux.intel.com> wrote:
>>
>> On 7.5.2020 11.21, Greg Kroah-Hartman wrote:
>>> On Thu, May 07, 2020 at 03:58:36PM +0800, Kai-Heng Feng wrote:
>>>>
>>>>
>>>>> On May 7, 2020, at 15:31, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>>>>
>>>>> On Thu, May 07, 2020 at 03:15:01PM +0800, Kai-Heng Feng wrote:
>>>>>>
>>>>>>
>>>>>>> On May 7, 2020, at 14:45, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>>>>>>
>>>>>>> On Thu, May 07, 2020 at 02:17:55PM +0800, Kai-Heng Feng wrote:
>>>>>>>> Current xhci debug message doesn't always output bus number, so it's
>>>>>>>> hard to figure out it's from USB2 or USB3 root hub.
>>>>>>>>
>>>>>>>> In addition to that, some port numbers are offset to 0 and others are
>>>>>>>> offset to 1. Use the latter to match the USB core.
>>>>>>>>
>>>>>>>> So use "bus number - port index + 1" to make debug message consistent.
>>>>>>>>
>>>>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>>>> ---
>>>>>>>> drivers/usb/host/xhci-hub.c | 41 +++++++++++++++++++++----------------
>>>>>>>> 1 file changed, 23 insertions(+), 18 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>>>>>>>> index f37316d2c8fa..83088c262cc4 100644
>>>>>>>> --- a/drivers/usb/host/xhci-hub.c
>>>>>>>> +++ b/drivers/usb/host/xhci-hub.c
>>>>>>>> @@ -1241,7 +1241,8 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>>>>>>>> 			temp = readl(ports[wIndex]->addr);
>>>>>>>> 			/* Disable port */
>>>>>>>> 			if (link_state == USB_SS_PORT_LS_SS_DISABLED) {
>>>>>>>> -				xhci_dbg(xhci, "Disable port %d\n", wIndex);
>>>>>>>> +				xhci_dbg(xhci, "Disable port %d-%d\n",
>>>>>>>> +					 hcd->self.busnum, wIndex + 1);
>>>>>>>
>>>>>>> Shouldn't xhci_dbg() show the bus number already?  
>>>>>>
>>>>>> It's the PCI bus number, different to USB2/USB3 root hub bus number...
>>>>>
>>>>> But if this is using dev_dbg(), and it is, then you know how to look
>>>>> that up by seeing where that device is in sysfs at that point in time.
>>>>>
>>>>> So why add this again?
>>>>
>>>> xHCI has two HCD, one for USB2 and one for USB3.
>>>> If both of their port with same number are in use, for instance, port 1, then they are port 1-1 and port 2-1.
>>>> Right now the debug message only show "Port 1", we still can't find the corresponding port via sysfs with insufficient info.
>>>
>>> Look at the full kernel log line, the xhci hcd device should be showing
>>> you unique information.  If not, something else is wrong.
>>>
>>
>> What Kai-Heng suggest here makes sense, and is useful.
>> We use similar style debugging in other places, and it is helpful as it matches
>> usb core debugging style.
>>
>> This might seem odd but reason is that the xHC controller is one device which
>> doesn't really separate USB2 and USB3.
>> All ports are for example in one long array.
>>
>> On the xhci driver side things look very different. We register two HCD's,
>> one for usb 2 and one for USB 3. In many cases the debugging is not tied to a HCD
>> in any way,  (starting, stopping controller, command completion interrupts etc),
>> other cases the debugging is very much tied to a specific hcd,
>> for example when we are handling a port requsts for the roothub.
> 
> A gentle ping...
> 

Added to my for-usb-next branch, (which I'll need to rebase on 5.8-rc1 once released)

-Mathias

