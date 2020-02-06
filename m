Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A715BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7963A21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBFOXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:23:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:28232 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgBFOXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:23:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 06:23:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,409,1574150400"; 
   d="scan'208";a="279687715"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Feb 2020 06:23:11 -0800
Subject: Re: TI PCIe xHCI and kexec
To:     Joel Stanley <joel@jms.id.au>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <CACPK8XdFUWoEr6YvVHf-g28hREFOWMX0g5=Vsdxq9Asq=ftOVQ@mail.gmail.com>
 <26635edf-2df3-df0f-5644-e016e1e20248@linux.intel.com>
 <CACPK8XfsuyVXiLtra7mBNWTDucArPAZfOUqt96squmtBnqsGvg@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <fa02dbf7-9681-55e4-f0d7-a46939e6e18e@linux.intel.com>
Date:   Thu, 6 Feb 2020 16:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XfsuyVXiLtra7mBNWTDucArPAZfOUqt96squmtBnqsGvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.2.2020 5.37, Joel Stanley wrote:
> On Wed, 5 Feb 2020 at 09:35, Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>>
>> On 5.2.2020 2.55, Joel Stanley wrote:
>>> I'm supporting a system that uses Linux-as-a-bootloader to load a
>>> distro kernel via kexec, The systems have a TI TUSB73x0 PCIe
>>> controller which goes out to lunch after a kexec. This is the distro
>>> (post-kexec) kernel:
>>>
>>> [    0.235411] pci 0003:01:00.0: xHCI HW did not halt within 16000
>>> usec status = 0x0
>>> [    1.037298] xhci_hcd 0003:01:00.0: xHCI Host Controller
>>> [    1.037367] xhci_hcd 0003:01:00.0: new USB bus registered, assigned
>>> bus number 1
>>> [    1.053481] xhci_hcd 0003:01:00.0: Host halt failed, -110
>>> [    1.053523] xhci_hcd 0003:01:00.0: can't setup: -110
>>> [    1.053565] xhci_hcd 0003:01:00.0: USB bus 1 deregistered
>>> [    1.053629] xhci_hcd 0003:01:00.0: init 0003:01:00.0 fail, -110
>>> [    1.053703] xhci_hcd: probe of 0003:01:00.0 failed with error -110
>>>

>>>
>>> 0003:01:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB
>>> 3.0 xHCI Host Controller (rev 02)
>>>
>>> The full debug log of the distro kernel booting is below.
>>>
>>> [    1.037833] xhci_hcd 0003:01:00.0: USBCMD 0x0:
>>> [    1.037835] xhci_hcd 0003:01:00.0:   HC is being stopped
>>> [    1.037837] xhci_hcd 0003:01:00.0:   HC has finished hard reset
>>> [    1.037839] xhci_hcd 0003:01:00.0:   Event Interrupts disabled
>>> [    1.037841] xhci_hcd 0003:01:00.0:   Host System Error Interrupts disabled
>>> [    1.037843] xhci_hcd 0003:01:00.0:   HC has finished light reset
>>> [    1.037846] xhci_hcd 0003:01:00.0: USBSTS 0x0:
>>> [    1.037847] xhci_hcd 0003:01:00.0:   Event ring is empty
>>> [    1.037849] xhci_hcd 0003:01:00.0:   No Host System Error
>>> [    1.037851] xhci_hcd 0003:01:00.0:   HC is running
>>
>> Hmm, all bits in both USBCMD and USBSTS are 0. This is a bit suspicious.
>> Normally at least USBCMD Run/Stop bit, and USBSTS HCHalted bit have
>> opposite values.
> 
> Does this suggest the controller is not responding at all?
> 

The Capability registers looks fine, so does port status registers.
It's just the operational USBSTS and USBCMD registers that return 0.

Current xhci implementation assumes host failed to halt because USBSTS
HCHalted bit is still 0, and bails out before reset.
Host is probably not running, register just returns all zero.

Can you try if the below code works, it checks if host is running from
an additional place, and continues with the host reset.

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index fe38275363e0..2dbfeaf88574 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -177,8 +177,16 @@ int xhci_reset(struct xhci_hcd *xhci)
 	}
 
 	if ((state & STS_HALT) == 0) {
-		xhci_warn(xhci, "Host controller not halted, aborting reset.\n");
-		return 0;
+		/*
+		 * After a kexec TI TUSB73x0 might appear running as its USBSTS
+		 * and USBCMD registers return all zeroes. Doublecheck if host
+		 * is running from USBCMD RUN bit before bailing out.
+		 */
+		command = readl(&xhci->op_regs->command);
+		if (command & CMD_RUN) {
+			xhci_warn(xhci, "Host controller not halted, aborting reset.\n");
+			return 0;
+		}
 	}
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "// Reset the HC");
@@ -5217,7 +5225,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	/* Make sure the HC is halted. */
 	retval = xhci_halt(xhci);
 	if (retval)
-		return retval;
+		xhci_warn(xhci, "Continue with reset even if host appears running\n");
 
 	xhci_zero_64b_regs(xhci);
