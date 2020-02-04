Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C5BC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7329D2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgBDJmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:42:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:8712 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgBDJmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:42:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 01:42:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,401,1574150400"; 
   d="scan'208";a="310993361"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2020 01:42:18 -0800
Subject: Re: [PATCH] xhci-mtk: Fix NULL pointer dereference with xhci_irq()
 for shared_hcd
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Sriharsha Allenki <sallenki@codeaurora.org>
References: <1579246910-22736-1-git-send-email-macpaul.lin@mediatek.com>
 <08f69bab-2ada-d6ab-7bf7-d960e9f148a0@linux.intel.com>
 <1580556039.10835.3.camel@mtkswgap22>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <39ec1610-1686-6509-02ac-6e73d8be2453@linux.intel.com>
Date:   Tue, 4 Feb 2020 11:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1580556039.10835.3.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.2.2020 13.20, Macpaul Lin wrote:
> On Fri, 2020-01-31 at 16:50 +0200, Mathias Nyman wrote:
>> On 17.1.2020 9.41, Macpaul Lin wrote:
>>> According to NULL pointer fix: https://tinyurl.com/uqft5ra
>>> xhci: Fix NULL pointer dereference with xhci_irq() for shared_hcd
>>> The similar issue has also been found in QC activities in Mediatek.
>>>
>>> Here quote the description from the referenced patch as follows.
>>> "Commit ("f068090426ea xhci: Fix leaking USB3 shared_hcd
>>> at xhci removal") sets xhci_shared_hcd to NULL without
>>> stopping xhci host. This results into a race condition
>>> where shared_hcd (super speed roothub) related interrupts
>>> are being handled with xhci_irq happens when the
>>> xhci_plat_remove is called and shared_hcd is set to NULL.
>>> Fix this by setting the shared_hcd to NULL only after the
>>> controller is halted and no interrupts are generated."
>>>
>>> Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>> ---
>>>    drivers/usb/host/xhci-mtk.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
>>> index b18a6baef204..c227c67f5dc5 100644
>>> --- a/drivers/usb/host/xhci-mtk.c
>>> +++ b/drivers/usb/host/xhci-mtk.c
>>> @@ -593,11 +593,11 @@ static int xhci_mtk_remove(struct platform_device *dev)
>>>    	struct usb_hcd  *shared_hcd = xhci->shared_hcd;
>>>    
>>>    	usb_remove_hcd(shared_hcd);
>>> -	xhci->shared_hcd = NULL;
>>>    	device_init_wakeup(&dev->dev, false);
>>>    
>>>    	usb_remove_hcd(hcd);
>>>    	usb_put_hcd(shared_hcd);
>>> +	xhci->shared_hcd = NULL;
>>>    	usb_put_hcd(hcd);
>>>    	xhci_mtk_sch_exit(mtk);
>>>    	xhci_mtk_clks_disable(mtk);
>>>
>>
>> Could you share details of the NULL pointer dereference, (backtrace).
> 
> This bug was found by our QA staff while doing 500 times plug-in and
> plug-out devices. The backtrace I have was recorded by QA and I didn't
> reproduce this issue on my own environment. However, after applied this
> patch the issue seems resolve. Here is the backtrace:
> 
> Exception Class: Kernel (KE)
> PC is at [<ffffff8008cccbc0>] xhci_irq+0x728/0x2364
> LR is at [<ffffff8008ccc788>] xhci_irq+0x2f0/0x2364
> 
> Current Executing Process:
> [iptables, 859][netdagent, 770]
> 
> Backtrace:
> [<ffffff80080ead58>] __atomic_notifier_call_chain+0xa8/0x130
> [<ffffff80080eb6d4>] notify_die+0x84/0xac
> [<ffffff800808e874>] die+0x1d8/0x3b8
> [<ffffff80080a89b0>] __do_kernel_fault+0x178/0x188
> [<ffffff80080a81b4>] do_page_fault+0x44/0x3b0
> [<ffffff80080a811c>] do_translation_fault+0x44/0x98
> [<ffffff8008080e08>] do_mem_abort+0x4c/0x128
> [<ffffff80080832d0>] el1_da+0x24/0x3c
> [<ffffff8008cccbc0>] xhci_irq+0x728/0x2364
> [<ffffff8008c98804>] usb_hcd_irq+0x2c/0x44
> [<ffffff8008179bb0>] __handle_irq_event_percpu+0x26c/0x4a4
> [<ffffff8008179ec8>] handle_irq_event+0x5c/0xd0
> [<ffffff800817e3c0>] handle_fasteoi_irq+0x10c/0x1e0
> [<ffffff80081787b0>] __handle_domain_irq+0x32c/0x738
> [<ffffff800808159c>] gic_handle_irq+0x174/0x1c4
> [<ffffff8008083cf8>] el0_irq_naked+0x50/0x5c
> [<ffffffffffffffff>] 0xffffffffffffffff
> 

Thanks,
Could you help me find out which line of code xhci_irq+0x728 is in your case.

As Guenter pointed out there is a risk of turning the NULL pointer dereference
into a use after free if we just solve this by setting xhci->shared_hcd = NULL
later.

If you still have that kernel around, and xhci is compiled in:
gdb vmlinux
gdb li *(xhci_irq+0x728)

-Mathias
