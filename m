Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6315AC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A4F20727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nteIfRRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCJSfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:35:12 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42569 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgCJSfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:35:10 -0400
Received: by mail-il1-f193.google.com with SMTP id x2so12924203ila.9;
        Tue, 10 Mar 2020 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAlymheSsVWS6TtBZwVUxTy84/oSe1RgGaUvIw1jjFc=;
        b=nteIfRRrG4iHGpc2U9paJ7vONjWM7TbY5Sqngd3SnUvHmWoUY4Zdryj6mMZmIb3QXn
         OUdOxwFJDhwxWhFJzNPdycGcU8mMnXUTMfP3crKxirezquLoYhLOie5Gj+z1wrmWbPPc
         MTBCYLo+2yGUW6sImdEx31HtO6uoob7oINv609+LnS7L2G6ldNRuekXK4a+O/vlvYixc
         ZkqVHI3XRBY8u6mmPOzDHRBrUq5LmVX/Og+H1tvlbahE4IKoQAFWZkWJAo//eJLKiuXa
         4NhgbdIfYoj6yPYPhsvooaw5rwQxly9huCMrWncEyQ3rQpdVo4pwFsLu6pPxrt/cltok
         cqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAlymheSsVWS6TtBZwVUxTy84/oSe1RgGaUvIw1jjFc=;
        b=EM7CWYqwdTLyAunbO9fXAfI1vK2SMyt4ht0fEwUtDTWiQQG3vjtaKZc4RvN5ojxRW0
         bU4witmbePGNVZbUb+bo9tILnZm31K8YBnnoTbB9i1QovbXjxesq5hIfjBt2QLfBOKcT
         XIv7H6KKOxKfOhT/oyf1QIhRJJcbLmRK3b7ZyQKgm/fRgRSlj1m6DtX/UO9DUvJ67Fzt
         468NazhhLfbvkfHBNW22NwuA/p+8BJP1FeyX6mDmoiGijKa8fq3YzgCNZxeGPhjyan51
         I/nQs8st2XTeeztHqUTqcSMi0GAgVR2mA9mlYKeWKTtqdMs2EB+KpPlU0L8P/jo1Rgn2
         CZjQ==
X-Gm-Message-State: ANhLgQ0oFRqvLKKdC4lK+H9ax4OHCSi1xVP1czVE7ilUYyadfqn8hg04
        /gUZ2ePAAjKhQ+DC6pPP9BwZcmN0uvqusOvWNa4=
X-Google-Smtp-Source: ADFU+vuo9UDPQM++PFizNAWpJw++AiJVW+wVcXy2+OV9oXXm/ItiHXTBNR6ieNS1CBj42fJbdMaLqlHXYVFRbOq0/Os=
X-Received: by 2002:a92:1a12:: with SMTP id a18mr21449997ila.10.1583865309464;
 Tue, 10 Mar 2020 11:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200306160659.16319-1-alcooperx@gmail.com> <74c294a3-8eaa-a48e-3371-a7027d5aabd2@linux.intel.com>
In-Reply-To: <74c294a3-8eaa-a48e-3371-a7027d5aabd2@linux.intel.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Tue, 10 Mar 2020 14:34:58 -0400
Message-ID: <CAOGqxeWhsdtvmZBg3RLzSyHeLpCWGoRghTp+8u3gx3Aafi-vgA@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci: Error enumerating USB TV Tuner
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Agree on both points.
Should I re-send a v2?

Thanks
Al

On Mon, Mar 9, 2020 at 8:19 AM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 6.3.2020 18.06, Al Cooper wrote:
> > Unable to complete the enumeration of a USB TV Tuner device.
> >
> > Per XHCI spec (4.6.5), the EP state field of the input context shall
> > be cleared for a set address command. In the special case of an FS
> > device that has "MaxPacketSize0 = 8", the Linux XHCI driver does
> > not do this before evaluating the context. With an XHCI controller
> > that checks the EP state field for parameter context error this
> > causes a problem in cases such as the device getting reset again
> > after enumeration.
> >
> > When that field is cleared, the problem does not occur.
> >
> > This was found and fixed by Sasi Kumar.
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > ---
> >  drivers/usb/host/xhci.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index dbac0fa9748d..5f034e143082 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -1428,6 +1428,7 @@ static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
> >                               xhci->devs[slot_id]->out_ctx, ep_index);
> >
> >               ep_ctx = xhci_get_ep_ctx(xhci, command->in_ctx, ep_index);
> > +             ep_ctx->ep_info &= cpu_to_le32(~EP_STATE_MASK);/* must clear */
> >               ep_ctx->ep_info2 &= cpu_to_le32(~MAX_PACKET_MASK);
> >               ep_ctx->ep_info2 |= cpu_to_le32(MAX_PACKET(max_packet_size));
> >
> >
>
> Thanks, nice catch.
>
> If you agree I'd like to change the the subject of this patch to something like:
> "xhci: Fix enumeration issue when setting actual max packet size for FS devices"
>
> While looking at this it seems that the current EP_STATE_MASK is not correct either.
> It should be 0x7 instead of 0xf.
>
> -Mathias
