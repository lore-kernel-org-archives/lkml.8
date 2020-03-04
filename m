Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE66C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B30E20838
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgCDOhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:37:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:9333 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgCDOhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:37:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 06:37:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="229345602"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2020 06:37:32 -0800
Subject: Re: [PATCH] xhci-mtk: Fix NULL pointer dereference with xhci_irq()
 for shared_hcd
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Sriharsha Allenki <sallenki@codeaurora.org>
References: <1579246910-22736-1-git-send-email-macpaul.lin@mediatek.com>
 <08f69bab-2ada-d6ab-7bf7-d960e9f148a0@linux.intel.com>
 <1580556039.10835.3.camel@mtkswgap22>
 <39ec1610-1686-6509-02ac-6e73d8be2453@linux.intel.com>
 <1583291775.12083.59.camel@mtkswgap22>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <ef4d9d96-df4d-be0c-22af-a97a03c39d3a@linux.intel.com>
Date:   Wed, 4 Mar 2020 16:39:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583291775.12083.59.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.3.2020 5.16, Macpaul Lin wrote:
> On Tue, 2020-02-04 at 17:44 +0800, Mathias Nyman wrote:
>> On 1.2.2020 13.20, Macpaul Lin wrote:
>>> On Fri, 2020-01-31 at 16:50 +0200, Mathias Nyman wrote:
>>>> On 17.1.2020 9.41, Macpaul Lin wrote:
>>>>> According to NULL pointer fix: https://tinyurl.com/uqft5ra
>>>>> xhci: Fix NULL pointer dereference with xhci_irq() for shared_hcd
>>>>> The similar issue has also been found in QC activities in Mediatek.
>>>>>
>>>>> Here quote the description from the referenced patch as follows.
>>>>> "Commit ("f068090426ea xhci: Fix leaking USB3 shared_hcd
>>>>> at xhci removal") sets xhci_shared_hcd to NULL without
>>>>> stopping xhci host. This results into a race condition
>>>>> where shared_hcd (super speed roothub) related interrupts
>>>>> are being handled with xhci_irq happens when the
>>>>> xhci_plat_remove is called and shared_hcd is set to NULL.
>>>>> Fix this by setting the shared_hcd to NULL only after the
>>>>> controller is halted and no interrupts are generated."
>>>>>
>>>>> Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
>>>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>>>> ---
>>>>>    drivers/usb/host/xhci-mtk.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
>>>>> index b18a6baef204..c227c67f5dc5 100644
>>>>> --- a/drivers/usb/host/xhci-mtk.c
>>>>> +++ b/drivers/usb/host/xhci-mtk.c
>>>>> @@ -593,11 +593,11 @@ static int xhci_mtk_remove(struct platform_device *dev)
>>>>>    	struct usb_hcd  *shared_hcd = xhci->shared_hcd;
>>>>>    
>>>>>    	usb_remove_hcd(shared_hcd);
>>>>> -	xhci->shared_hcd = NULL;
>>>>>    	device_init_wakeup(&dev->dev, false);
>>>>>    
>>>>>    	usb_remove_hcd(hcd);
>>>>>    	usb_put_hcd(shared_hcd);
>>>>> +	xhci->shared_hcd = NULL;
>>>>>    	usb_put_hcd(hcd);
>>>>>    	xhci_mtk_sch_exit(mtk);
>>>>>    	xhci_mtk_clks_disable(mtk);
>>>>>
>>>>
>>>> Could you share details of the NULL pointer dereference, (backtrace).
>>>
>>> This bug was found by our QA staff while doing 500 times plug-in and
>>> plug-out devices. The backtrace I have was recorded by QA and I didn't
>>> reproduce this issue on my own environment. However, after applied this
>>> patch the issue seems resolve. Here is the backtrace:
>>>
>>> Exception Class: Kernel (KE)
>>> PC is at [<ffffff8008cccbc0>] xhci_irq+0x728/0x2364
>>> LR is at [<ffffff8008ccc788>] xhci_irq+0x2f0/0x2364
>>>
>>> Current Executing Process:
>>> [iptables, 859][netdagent, 770]
>>>
>>> Backtrace:
>>> [<ffffff80080ead58>] __atomic_notifier_call_chain+0xa8/0x130
>>> [<ffffff80080eb6d4>] notify_die+0x84/0xac
>>> [<ffffff800808e874>] die+0x1d8/0x3b8
>>> [<ffffff80080a89b0>] __do_kernel_fault+0x178/0x188
>>> [<ffffff80080a81b4>] do_page_fault+0x44/0x3b0
>>> [<ffffff80080a811c>] do_translation_fault+0x44/0x98
>>> [<ffffff8008080e08>] do_mem_abort+0x4c/0x128
>>> [<ffffff80080832d0>] el1_da+0x24/0x3c
>>> [<ffffff8008cccbc0>] xhci_irq+0x728/0x2364
>>> [<ffffff8008c98804>] usb_hcd_irq+0x2c/0x44
>>> [<ffffff8008179bb0>] __handle_irq_event_percpu+0x26c/0x4a4
>>> [<ffffff8008179ec8>] handle_irq_event+0x5c/0xd0
>>> [<ffffff800817e3c0>] handle_fasteoi_irq+0x10c/0x1e0
>>> [<ffffff80081787b0>] __handle_domain_irq+0x32c/0x738
>>> [<ffffff800808159c>] gic_handle_irq+0x174/0x1c4
>>> [<ffffff8008083cf8>] el0_irq_naked+0x50/0x5c
>>> [<ffffffffffffffff>] 0xffffffffffffffff
>>>
>>
>> Thanks,
>> Could you help me find out which line of code xhci_irq+0x728 is in your case.
>>
>> As Guenter pointed out there is a risk of turning the NULL pointer dereference
>> into a use after free if we just solve this by setting xhci->shared_hcd = NULL
>> later.
>>
>> If you still have that kernel around, and xhci is compiled in:
>> gdb vmlinux
>> gdb li *(xhci_irq+0x728)
>>
> 
> Sorry that I couldn't get back to you soon. The internal code version
> for this issue was really old and a little bit difficult to rewind to
> that version.
> However, I think the following dump might be correct for the code base.
> 
> (gdb) li *(xhci_irq+0x728)
> 0xffffff8008cc8634 is in xhci_irq (*stripped*
> kernel-4.14/drivers/usb/host/xhci.h:1694).
> 1689     */
> 1690    #define XHCI_MAX_REXIT_TIMEOUT_MS       20
> 1691
> 1692    static inline unsigned int hcd_index(struct usb_hcd *hcd)
> 1693    {
> 1694            if (hcd->speed >= HCD_USB3)
> 1695                    return 0;
> 1696            else
> 1697                    return 1;
> 1698    }
> (gdb)
> 
> Thanks
> Macpaul Lin
> 

Ah, it was a 4.14 kernel.
This should be fixed in 4.20 with patch:
1245374e9b83 xhci: handle port status events for removed USB3 hcd

Port arrays/structures were changed completely in 4.18

Something like the below should work for 4.14:

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 61fa3007a74a..e7367b9f19c5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1640,6 +1640,12 @@ static void handle_port_status(struct xhci_hcd *xhci,
 	if ((major_revision == 0x03) != (hcd->speed >= HCD_USB3))
 		hcd = xhci->shared_hcd;
 
+	if (!hcd) {
+		xhci_dbg(xhci, "No hcd found for port %u event\n", port_id);
+		bogus_port_status = true;
+		goto cleanup;
+	}
+
 	if (major_revision == 0) {
 		xhci_warn(xhci, "Event for port %u not in "
 				"Extended Capabilities, ignoring.\n",


-Mathias
