Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E538C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7127D21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgCKOPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:15:48 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:59316 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729572AbgCKOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:15:47 -0400
Received: (qmail 1610 invoked by uid 2102); 11 Mar 2020 10:15:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Mar 2020 10:15:46 -0400
Date:   Wed, 11 Mar 2020 10:15:46 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] [PATCH v2 3/3] USB: Disable LPM on WD19's Realtek Hub
In-Reply-To: <4F77B65D-77B0-4E63-ADB3-BF127BDE3BA2@canonical.com>
Message-ID: <Pine.LNX.4.44L0.2003111015070.1492-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020, Kai-Heng Feng wrote:

> Hi Greg,
> 
> > On Feb 5, 2020, at 19:26, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > 
> > Realtek Hub (0bda:0x0487) used in Dell Dock WD19 sometimes drops off the
> > bus when bringing underlying ports from U3 to U0.
> > 
> > Disabling LPM on the hub during setting link state is not enough, so
> > let's disable LPM completely for this hub.
> > 
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> As Mathias stated, this patch can be considered as a separate one.
> Can you please review and merge this patch?
> 
> Kai-Heng
> 
> > ---
> > v2:
> > - Use quirk instead of the original approach.
> > 
> > drivers/usb/core/quirks.c | 3 +++
> > 1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> > index 6b6413073584..2fb7c1602280 100644
> > --- a/drivers/usb/core/quirks.c
> > +++ b/drivers/usb/core/quirks.c
> > @@ -371,6 +371,9 @@ static const struct usb_device_id usb_quirk_list[] = {
> > 	{ USB_DEVICE(0x0b05, 0x17e0), .driver_info =
> > 			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
> > 
> > +	/* Realtek hub in Dell WD19 (Type-C) */
> > +	{ USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
> > +
> > 	/* Action Semiconductor flash disk */
> > 	{ USB_DEVICE(0x10d6, 0x2200), .driver_info =
> > 			USB_QUIRK_STRING_FETCH_255 },
> > -- 
> > 2.17.1

Acked-by: Alan Stern <stern@rowland.harvard.edu>

