Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E6EC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553D122464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBGPWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:22:18 -0500
Received: from netrider.rowland.org ([192.131.102.5]:56381 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726674AbgBGPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:22:17 -0500
Received: (qmail 4104 invoked by uid 500); 7 Feb 2020 10:22:16 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Feb 2020 10:22:16 -0500
Date:   Fri, 7 Feb 2020 10:22:16 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Enderborg, Peter" <Peter.Enderborg@sony.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.4 17/78] HID: Fix slab-out-of-bounds read in
 hid_field_extract (Broken!)
In-Reply-To: <96c523ea-799f-ad2f-f1c4-46ff6f9f6d6c@sony.com>
Message-ID: <Pine.LNX.4.44L0.2002071018580.3671-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2020, Enderborg, Peter wrote:

> On 2/6/20 4:14 PM, Alan Stern wrote:

> > I guess you have to unbind the device from the usbhid driver first in
> > order for lsusb to get them.  Can you do that?
> >
> > Alan Stern
> >
> Im not sure exatly what you need to unbind. But I assume this is what you want:
> 
>  lsusb -v -d 0fd9:0060

Yes, that's it.  Most of the reports have:

>             Item(Global): Report Size, data= [ 0x08 ] 8
>             Item(Global): Report Count, data= [ 0x10 ] 16

which means they are 16 bytes long.  But one report has:

>             Item(Global): Report Size, data= [ 0x08 ] 8
>             Item(Global): Report Count, data= [ 0xfe 0x1f ] 8190

meaning it is 8190 bytes long (plus one byte for the report ID).  
Therefore setting the maximum buffer size to 8192 should allow this 
device to work properly, with no other changes needed.

Alan Stern

