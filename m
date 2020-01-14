Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572D3C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32561206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgANOqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:46:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:51924 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgANOqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:46:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 06:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,433,1571727600"; 
   d="scan'208";a="305163859"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2020 06:46:36 -0800
Subject: Re: [PATCH 2/3] xhci: Wait until link state trainsits to U0 after
 setting USB_SS_PORT_LS_U0
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        AceLan Kao <acelan.kao@canonical.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200103084008.3579-1-kai.heng.feng@canonical.com>
 <20200103084008.3579-2-kai.heng.feng@canonical.com>
 <17701887-a249-eade-eecb-541df6c2c704@linux.intel.com>
 <CAAd53p56oXDsPBKqZA_HJbtajWNBQz_LfK-fpOiuxoTrn3WU5w@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <7f6d4742-6e68-ea1d-4266-c69c27a19df6@linux.intel.com>
Date:   Tue, 14 Jan 2020 16:48:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAd53p56oXDsPBKqZA_HJbtajWNBQz_LfK-fpOiuxoTrn3WU5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.1.2020 11.18, Kai-Heng Feng wrote:
> On Fri, Jan 10, 2020 at 11:27 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>>
>> On 3.1.2020 10.40, Kai-Heng Feng wrote:
>>> Like U3 case, xHCI spec doesn't specify the upper bound of U0 transition
>>> time. The 20ms is not enough for some devices.
>>>
>>> Intead of polling PLS or PLC, we can facilitate the port change event to
>>> know that the link transits to U0 is completed.
>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>>    drivers/usb/host/xhci-hub.c  | 8 +++++++-
>>>    drivers/usb/host/xhci-mem.c  | 1 +
>>>    drivers/usb/host/xhci-ring.c | 1 +
>>>    drivers/usb/host/xhci.h      | 1 +
>>>    4 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>>> index 2b2e9d004dbf..07886a1bce62 100644
>>> --- a/drivers/usb/host/xhci-hub.c
>>> +++ b/drivers/usb/host/xhci-hub.c
>>> @@ -1310,11 +1310,17 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>>>                                        spin_lock_irqsave(&xhci->lock, flags);
>>>                                }
>>>                        }
>>> +                     if (link_state == USB_SS_PORT_LS_U0)
>>> +                             reinit_completion(&ports[wIndex]->link_state_changed);
>>
>> All the other suspend and resume related port flags/completions are
>> in struct xhci_bus_state. See for example rexit_done[].
>> Not sure that is a better place but at least it would be consistent.
>>
>> Could actually make sense to move more of them to the xhci_port structure,
>> but perhaps in some later suspend/resume rework patch.
> 
> Ok. Should I keep this part of the patch as is? Or move it to
> xhci_bus_state and probably move it back to xhci_port in later rework
> patch?

Maybe move it to xhci_bus_state for now.

> 
>>>
>>>                        xhci_set_link_state(xhci, ports[wIndex], link_state);
>>>
>>>                        spin_unlock_irqrestore(&xhci->lock, flags);
>>> -                     msleep(20); /* wait device to enter */
>>> +                     if (link_state == USB_SS_PORT_LS_U0) {
>>> +                             if (!wait_for_completion_timeout(&ports[wIndex]->link_state_changed, msecs_to_jiffies(100)))
>>> +                                     xhci_dbg(xhci, "missing U0 port change event for port %d-%d\n", hcd->self.busnum, wIndex + 1);
>>
>> We might be waiting for completion here in unnecessary.
>> No completion is called if port is already in U0, either set by
>> xhci_bus_resume(), or we race with a device initiated resume.
> 
> Is there a way to know if device initiated resume is inplace?

Yes, before xhci interrupt handler handles the device initiated resume PLS
is XDEV_RESUME and PLC is set.

After the interrupt handler PLS goes from XDEV_RESUME to XDEV_RECOVERY to XDEV_U0.
A bit is set for bus_state->port_remote_wakeup, and on usb core side
also bus->resuming_ports |= bit is set, (having both may be a bit redundant, we might
be able to get rid of bus_state->port_remote_wakeup, but not right now)

> 
>>
>> Maybe read the current port link state first, and don't do anything if it's
>> already in U0, or fail if it's in a state where we can't resume to U0.
> 
> What happens if device initiated resume happens right after we query the PLS?

Not sure, fortunately the drivers task is to write XDEV_U0 to PLS both when
we want a host initiated resume, or when we want to react on a device initiated
resume. So hopefully that's ok, but this race exists.

Better keep calling completion for both host and device initiated resume cases
when port reaches U0/U1/U2 to avoid waiting for the completion unnecessary,
like you current patch does.
  
-Mathias
