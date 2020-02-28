Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E57AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AB9246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc7ZBPxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgB1AhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:37:02 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51802 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgB1AhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:37:02 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so519908pjb.1;
        Thu, 27 Feb 2020 16:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QE+argeuCRAuvITS41/jAIWoLAo7PoR6Fkkr31YU2NA=;
        b=hc7ZBPxZCvi/RCs8hpFjQtsPdJGC3EfyAGZ4nwITnuuJPe2Km/x0b65qhE0ex8DJO1
         +h7KQw6/Wn/+orRoByfIcgkG9KfZ7kmOsOlsqr91FrDWZl3T/Q4muXmDtTWJAjsp7+5Q
         ea045xobgoVNA7jfDvqQdpBfoU3MzGOjbDZH+MzWs3/9XzqhKWCYGsn9Lt+7/0kAPDzj
         P8o6LLg1a0wGvnloiPq++/7kxUO/1CDil1ROBcTDzqByzadqktgO8mKsi4g7xmX1XpzE
         RFru8ZXgtQAtZB5SIMER0fKit2CvaMREdDzAGQ2Zt+Ik8olI9QirL+uIXzrdvqWQcG+q
         zaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QE+argeuCRAuvITS41/jAIWoLAo7PoR6Fkkr31YU2NA=;
        b=MxF3QZGBgZzJj2dCP15LTikeX8C063JINn7u0/ye3p/1kx2gIXZs6eKK3bnsb4JtEo
         IlrVrAmemKiC+k9l6NnZrB100Gi1qAUbUwyt2yh0LvuyeS3b3EuMRC2StW0IIA0go72n
         y08rjIWxe7l/yWxRtqxv9+506wVd+9Z9Th0uzmU/EKjqYMynCowJxDsE3gbBR4S0r9wI
         AqM5IHCkJz0gT/E+OCvfSPggqs6zJK8y29pf1cd4YgEzS4sdkMz5aTDpg/1aNnzd8afv
         MZ60DYQqHcfUv0zvRZSKHcPsZgOn0/yy7zDhJsy/0qFVuOsAAUR5zArGDbWJtodm5/IE
         C48A==
X-Gm-Message-State: APjAAAUQHRv8YKRzNV5UiWHsEwG/H3/1nV1+uBgScp8UAD1XlVCFFauF
        neHfhnDqUXBzZv21ddt9OuE=
X-Google-Smtp-Source: APXvYqwQ9TxbddBpG+jrVbWlwVr7M1E8y3xVGtot5BWddsvErijnETR5fLQv1SnVtUrpAEkJv2L6dQ==
X-Received: by 2002:a17:90a:a385:: with SMTP id x5mr1762369pjp.102.1582850221209;
        Thu, 27 Feb 2020 16:37:01 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d24sm8922211pfq.75.2020.02.27.16.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 16:37:00 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:36:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antti =?iso-8859-1?Q?Sepp=E4l=E4?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
Subject: Re: [RFT PATCH 3/4] usb: dwc2: Abort transaction after errors with
 unknown reason
Message-ID: <20200228003659.GB11811@roeck-us.net>
References: <20200226210414.28133-1-linux@roeck-us.net>
 <20200226210414.28133-4-linux@roeck-us.net>
 <CAD=FV=UMB8=qxAH=9VCZk-g6iFqPpM2RnrekmTXuqcOrHkVuLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UMB8=qxAH=9VCZk-g6iFqPpM2RnrekmTXuqcOrHkVuLw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 02:06:55PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Feb 26, 2020 at 1:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > In some situations, the following error messages are reported.
> >
> > dwc2 ff540000.usb: dwc2_hc_chhltd_intr_dma: Channel 1 - ChHltd set, but reason is unknown
> > dwc2 ff540000.usb: hcint 0x00000002, intsts 0x04000021
> >
> > This is sometimes followed by:
> >
> > dwc2 ff540000.usb: dwc2_update_urb_state_abn(): trimming xfer length
> >
> > and then:
> >
> > WARNING: CPU: 0 PID: 0 at kernel/v4.19/drivers/usb/dwc2/hcd.c:2913
> >                         dwc2_assign_and_init_hc+0x98c/0x990
> >
> > The warning suggests that an odd buffer address is to be used for DMA.
> >
> > After an error is observed, the receive buffer may be full
> > (urb->actual_length >= urb->length). However, the urb is still left in
> > the queue unless three errors were observed in a row. When it is queued
> > again, the dwc2 hcd code translates this into a 1-block transfer.
> > If urb->actual_length (ie the total expected receive length) is not
> > DMA-aligned, the buffer pointer programmed into the chip will be
> > unaligned. This results in the observed warning.
> >
> > To solve the problem, abort input transactions after an error with
> > unknown cause if the entire packet was already received. This may be
> > a bit drastic, but we don't really know why the transfer was aborted
> > even though the entire packet was received. Aborting the transfer in
> > this situation is less risky than accepting a potentially corrupted
> > packet.
> >
> > With this patch in place, the 'ChHltd set' and 'trimming xfer length'
> > messages are still observed, but there are no more transfer attempts
> > with odd buffer addresses.
> >
> > Cc: Boris ARZUR <boris@konbu.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/usb/dwc2/hcd_intr.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> 
> Seems sane to me.  Also suggest a "Fixes" or "Cc: stable" tag.
> 
Added:

Fixes: 151d0cbdbe860 ("usb: dwc2: make the scheduler handle excessive NAKs better")

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!

Guenter
