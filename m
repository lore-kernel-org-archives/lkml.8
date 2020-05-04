Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5661C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC8F2071C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgEDKKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:10:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:50967 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgEDKKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:10:16 -0400
IronPort-SDR: ABPYJ/XjenKMfjxbrEQIxK3JF3CPB8hjh0B7xWDfIdk4pOmQnwHYKmpBEuLR9Ds0v1rOfFC9vU
 /q4jZhKxxAKA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 03:10:15 -0700
IronPort-SDR: BDVxcggN+h9n0YU3gnuw2ItbbJHk7bjEHBGfqBJvAw/SBwFBaY5WX2FegrwUyzv76TCVxz263+
 aBjxWBpodEFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="259285901"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2020 03:10:14 -0700
Subject: Re: [PATCH] xhci: Prevent runtime suspend all the time with
 XHCI_RESET_ON_RESUME quirk
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200504091952.15820-1-kai.heng.feng@canonical.com>
 <1588585655.13662.5.camel@suse.com>
 <88A0FF32-C7D7-4E49-8470-FE23401371BD@canonical.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <6fca4532-b4a2-9730-bd96-5ac15357f752@intel.com>
Date:   Mon, 4 May 2020 13:13:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <88A0FF32-C7D7-4E49-8470-FE23401371BD@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.5.2020 13.02, Kai-Heng Feng wrote:
> 
> 
>> On May 4, 2020, at 17:47, Oliver Neukum <oneukum@suse.com> wrote:
>>
>> Am Montag, den 04.05.2020, 17:19 +0800 schrieb Kai-Heng Feng:
>>> Etron EJ168 USB 3.0 Host Controller stops working after S3, if it was
>>> runtime suspended previously:
>>> [  370.080359] pci 0000:02:00.0: can't change power state from D3cold to D0 (config space inaccessible)
>>
>> Apparently this controller has issues with D3cold
>>
>>> [  370.080477] xhci_hcd 0000:04:00.0: can't change power state from D3cold to D0 (config space inaccessible)
>>> [  370.080532] pcieport 0000:00:1c.0: DPC: containment event, status:0x1f05 source:0x0200
>>> [  370.080533] pcieport 0000:00:1c.0: DPC: ERR_FATAL detected
>>> [  370.080536] xhci_hcd 0000:04:00.0: can't change power state from D3hot to D0 (config space inaccessible)
>>> [  370.080552] xhci_hcd 0000:04:00.0: AER: can't recover (no error_detected callback)
>>> [  370.080566] usb usb3: root hub lost power or was reset
>>> [  370.080566] usb usb4: root hub lost power or was reset
>>> [  370.080572] xhci_hcd 0000:04:00.0: Host halt failed, -19
>>> [  370.080574] xhci_hcd 0000:04:00.0: Host not accessible, reset failed.
>>> [  370.080575] xhci_hcd 0000:04:00.0: PCI post-resume error -19!
>>> [  370.080586] xhci_hcd 0000:04:00.0: HC died; cleaning up
>>>
>>> This can be fixed by not runtime suspend the controller at all.
>>>
>>> So instead of conditionally runtime suspend the controller, always
>>> prevent runtime suspend with XHCI_RESET_ON_RESUME quirk.
>>
>> What does that do to other controllers that can do runtime suspend
>> under the current scheme?
> 
> Ok, I'll add a new quirk specific to this controller.
> 
> Kai-Heng

Host shouldn't runtime suspend by default unless set by userspace, or
it has XHCI_DEFAULT_PM_RUNTIME_ALLOW quirk set.  

-Mathias
