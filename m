Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA781C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925002082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgBKOyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:54:07 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:33660 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727264AbgBKOyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:54:06 -0500
Received: (qmail 2909 invoked by uid 2102); 11 Feb 2020 09:54:05 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Feb 2020 09:54:05 -0500
Date:   Tue, 11 Feb 2020 09:54:05 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     peter enderborg <peter.enderborg@sony.com>
cc:     Johan Korsnes <jkorsnes@cisco.com>, Jiri Kosina <jikos@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] HID: Extend report buffer size
In-Reply-To: <91e0077e-b229-e43f-6f5c-5088b0c0f561@sony.com>
Message-ID: <Pine.LNX.4.44L0.2002110952570.1574-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020, peter enderborg wrote:

> On 2/10/20 4:01 PM, Alan Stern wrote:
> > On Mon, 10 Feb 2020, Peter Enderborg wrote:
> >
> >> In the patch "HID: Fix slab-out-of-bounds read in hid_field_extract"
> >> there added a check for buffer overruns. This made Elgato StreamDeck
> >> to fail. This patch extend the buffer to 8192 to solve this. It also
> >> adds a print of the requested length if it fails on this test.
> >>
> >> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> >> ---
> >>  drivers/hid/hid-core.c | 2 +-
> >>  include/linux/hid.h    | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> >> index 851fe54ea59e..28841219b3d2 100644
> >> --- a/drivers/hid/hid-core.c
> >> +++ b/drivers/hid/hid-core.c
> >> @@ -290,7 +290,7 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
> >>  
> >>  	/* Total size check: Allow for possible report index byte */
> >>  	if (report->size > (HID_MAX_BUFFER_SIZE - 1) << 3) {
> >> -		hid_err(parser->device, "report is too long\n");
> >> +		hid_err(parser->device, "report is too long (%d)\n", report->size);
> >>  		return -1;
> >>  	}
> >>  
> >> diff --git a/include/linux/hid.h b/include/linux/hid.h
> >> index cd41f209043f..875f71132b14 100644
> >> --- a/include/linux/hid.h
> >> +++ b/include/linux/hid.h
> >> @@ -492,7 +492,7 @@ struct hid_report_enum {
> >>  };
> >>  
> >>  #define HID_MIN_BUFFER_SIZE	64		/* make sure there is at least a packet size of space */
> >> -#define HID_MAX_BUFFER_SIZE	4096		/* 4kb */
> >> +#define HID_MAX_BUFFER_SIZE	8192		/* 8kb */
> >>  #define HID_CONTROL_FIFO_SIZE	256		/* to init devices with >100 reports */
> >>  #define HID_OUTPUT_FIFO_SIZE	64
> > The second part of this patch is identical to the "HID: core: increase
> > HID report buffer size to 8KiB" patch submitted by Johan Korsnes a few
> > weeks ago.  You might want to submit just the first part of your patch,
> > or not submit anything at all.
> >
> > Alan Stern
> >
> >
> Korsnes patch is not in Torvalds tree nor is it requested for stable. How do we get it there?

Bring the whole matter to Jiri's attention.  He is the person who will
take care of it.

Alan Stern

