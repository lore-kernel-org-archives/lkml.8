Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F6FC55186
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 00:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778F8206CD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 00:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDZAcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 20:32:11 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36577 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725962AbgDZAcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 20:32:11 -0400
Received: (qmail 14241 invoked by uid 500); 25 Apr 2020 20:32:10 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Apr 2020 20:32:10 -0400
Date:   Sat, 25 Apr 2020 20:32:09 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     vladimir.stankovic@displaylink.com
cc:     gregkh@linuxfoundation.org, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mausb-host-devel@displaylink.com>
Subject: Re: [PATCH v5 5/8] usb: mausb_host: Introduce PAL processing
In-Reply-To: <20200425091954.1610-6-vladimir.stankovic@displaylink.com>
Message-ID: <Pine.LNX.4.44L0.2004252027360.13475-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 vladimir.stankovic@displaylink.com wrote:

> Protocol adaptation layer (PAL) implementation has been added to
> introduce MA-USB structures and logic.
> 
> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>

...

> +	/*
> +	 * Masking URB_SHORT_NOT_OK flag as SCSI driver is adding it where it
> +	 * should not, so it is breaking the USB drive on the linux
> +	 */
> +	urb->transfer_flags &= ~URB_SHORT_NOT_OK;

Removing the SHORT_NOT_OK flag is _not_ a valid thing to do.  It will 
cause drivers to malfunction.

Can you please explain this comment?

	What SCSI driver?

	When is the flag being added?

	How does it break USB drives?

	Why haven't you already reported this problem to the 
	appropriate maintainers?

Alan Stern

