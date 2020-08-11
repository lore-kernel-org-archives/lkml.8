Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85057C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4458F206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHKTnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:43:21 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49717 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726068AbgHKTnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:43:20 -0400
Received: (qmail 345373 invoked by uid 1000); 11 Aug 2020 15:43:19 -0400
Date:   Tue, 11 Aug 2020 15:43:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tom Rix <trix@redhat.com>
Cc:     gregkh@linuxfoundation.org, acozzette@cs.hmc.edu,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: realtek_cr: fix return check for dma functions
Message-ID: <20200811194319.GB344152@rowland.harvard.edu>
References: <20200811151505.12222-1-trix@redhat.com>
 <20200811160348.GD335280@rowland.harvard.edu>
 <1f7d5a64-f264-4fed-bf90-b64e2693652d@redhat.com>
 <20200811175338.GB339805@rowland.harvard.edu>
 <c48fec19-fe2c-65c6-917b-8b8ba40e4c7e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c48fec19-fe2c-65c6-917b-8b8ba40e4c7e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:54:28AM -0700, Tom Rix wrote:
> 
> On 8/11/20 10:53 AM, Alan Stern wrote:

> >>> Instead of changing all these call sites, wouldn't it be a lot easier 
> >>> just to change rts51x_read_mem() to make it always return a negative 
> >>> value (such as -EIO) when there's an error?
> >>>
> >>> Alan Stern
> >> I thought about that but there was already existing (retval != 
> >> STATUS_SUCCESS) checks for these calls.
> > The only values that routine currently returns are 
> > USB_STOR_TRANSPORT_ERROR, -EIO, and 0.  None of the callers distinguish 
> > between the first two values, so you can just change the first to the 
> > second.
> >
> > Note that STATUS_SUCCESS is simply 0.
> 
> Yes, i noted all of these already. My change is consistent with the 
> existing correct checks.  consistency is important.  returning a neg 
> value to reuse the exiting check should mean the STATUS_SUCCESS != 0 
> checks are changed to neg check.

Do you mean the "retval == STATUS_SUCCESS" checks?  Those checks would 
end up doing exactly the same thing as they do now, since 
USB_STOR_TRANSPORT_ERROR and -EIO are both different from 0.

Yes, it is true that consistency is important.  But correctness is more 
important than consistency.

>  i can do this larger change if 
> required.

Let me put it this way: Suppose you changed the USB_STOR_TRANSPORT_ERROR 
in rts51x_read_mem() to -EIO, without changing anything else.  Wouldn't 
that fix the problem reported by the clang static analysis?  If not, why 
not?

Alan Stern
