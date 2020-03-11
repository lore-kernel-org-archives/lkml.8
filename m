Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806D7C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DED21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI5c3OUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgCKLlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:41:00 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41371 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgCKLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:41:00 -0400
Received: by mail-il1-f195.google.com with SMTP id l14so1652329ilj.8;
        Wed, 11 Mar 2020 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iT+/77wGIgxe5NKzEJXkODg4mDWs/H6aQobSDKel4Q=;
        b=UI5c3OUXejo8eGqcr3kFYkKLiQpv9ohYscdECuxyAidajdNPWlW857Xch4QYvtPibB
         cDcuDIYXzZNmBploJyZdB3DSJvHZLOyTXW1uLd6mGCqFKhLBEovwwoG7uglNXyVxaVj2
         CyXNwUji/jwgnnkseq/Aj/oALBNVt+qslkTQDuqlwTtUBGeAj6LX22Cy8Ih8KJnKODQw
         Z6Hi+NNr6XCPvca7590K1gqMLMwzl5fWuRFWaj4kZ5M3TXE2j1Ot7MSBuAq5MqaFMuAC
         QsFXlAAFoKq4fU8uHbSWCH/kotAT4S/Je669eEI877IobCaCp7nBdU/CvrpRCC0eRzMB
         UJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iT+/77wGIgxe5NKzEJXkODg4mDWs/H6aQobSDKel4Q=;
        b=ABTz/LbB6PvE0svAQzBGVndYzaJXWa6fU8dim+cHmOOpuPAT7G2fRL2DknZSTkem5u
         sAIO+L/bGDqmcXE/8319jjyrjzawpFlr5bojuyS/norlMSgOsHMOC9jlv2pEyMZxriND
         dPGQPJVgZYAMreJYzB6Tm/sZpy8jHDAmQqip/CLur6uDtZelb2LqAPccAcXjvk1Jt2En
         fuHoZJDXSLq9CmjEWjuxFDzwB8o43qGbRx4t25fsCn6hWJ9032FBvddROShyWMA48+pG
         P6KrbDX64DJBFYwhoJRF80ohLXWXrn5Ys4D80oMhi74U2dwJzgjjOjjpUYX2/tr3xBAY
         tGbQ==
X-Gm-Message-State: ANhLgQ0NuzQLeMJQ7wMCkTpBGLhlr2iD2oYf2ihXzm36Ceyk4OPUfbrz
        gTjEpgJC1Bo1/tuxiS9vM2LyXT/I6cPMuIONurZayA==
X-Google-Smtp-Source: ADFU+vuFG7c1gKFZ23vYoBq6KTOZr4HtkPF0RhagtHNmNaAuQ6HcuFve/0/SkOgW3Uqsb1Y8Sesvl5yRcCXHOpoU5ME=
X-Received: by 2002:a05:6e02:be7:: with SMTP id d7mr2771041ilu.238.1583926858135;
 Wed, 11 Mar 2020 04:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200306160659.16319-1-alcooperx@gmail.com> <74c294a3-8eaa-a48e-3371-a7027d5aabd2@linux.intel.com>
 <CAOGqxeWhsdtvmZBg3RLzSyHeLpCWGoRghTp+8u3gx3Aafi-vgA@mail.gmail.com> <38c5e0e8-2fe4-d20d-22c5-3f94ea34b878@linux.intel.com>
In-Reply-To: <38c5e0e8-2fe4-d20d-22c5-3f94ea34b878@linux.intel.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Wed, 11 Mar 2020 07:40:47 -0400
Message-ID: <CAOGqxeWDroVtZ1MNvGqDUx9QugbLwysPr8BT1R91H+tnZu6a9Q@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci: Error enumerating USB TV Tuner
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

Al

On Wed, Mar 11, 2020 at 3:28 AM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 10.3.2020 20.34, Alan Cooper wrote:
> > On Mon, Mar 9, 2020 at 8:19 AM Mathias Nyman
> > <mathias.nyman@linux.intel.com> wrote:
> >>
> >> On 6.3.2020 18.06, Al Cooper wrote:
> >>> Unable to complete the enumeration of a USB TV Tuner device.
> >>>
> >>> Per XHCI spec (4.6.5), the EP state field of the input context shall
> >>> be cleared for a set address command. In the special case of an FS
> >>> device that has "MaxPacketSize0 = 8", the Linux XHCI driver does
> >>> not do this before evaluating the context. With an XHCI controller
> >>> that checks the EP state field for parameter context error this
> >>> causes a problem in cases such as the device getting reset again
> >>> after enumeration.
> >>>
> >>> When that field is cleared, the problem does not occur.
> >>>
> >>> This was found and fixed by Sasi Kumar.
> >>>
> >>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> >>> ---
> >>>  drivers/usb/host/xhci.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> >>> index dbac0fa9748d..5f034e143082 100644
> >>> --- a/drivers/usb/host/xhci.c
> >>> +++ b/drivers/usb/host/xhci.c
> >>> @@ -1428,6 +1428,7 @@ static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
> >>>                               xhci->devs[slot_id]->out_ctx, ep_index);
> >>>
> >>>               ep_ctx = xhci_get_ep_ctx(xhci, command->in_ctx, ep_index);
> >>> +             ep_ctx->ep_info &= cpu_to_le32(~EP_STATE_MASK);/* must clear */
> >>>               ep_ctx->ep_info2 &= cpu_to_le32(~MAX_PACKET_MASK);
> >>>               ep_ctx->ep_info2 |= cpu_to_le32(MAX_PACKET(max_packet_size));
> >>>
> >>>
> >>
> >> Thanks, nice catch.
> >>
> >> If you agree I'd like to change the the subject of this patch to something like:
> >> "xhci: Fix enumeration issue when setting actual max packet size for FS devices"
> >>
> >> While looking at this it seems that the current EP_STATE_MASK is not correct either.
> >> It should be 0x7 instead of 0xf.
> >>
> >
> > Agree on both points.
> > Should I re-send a v2?
> >
>
> No need, I can make those changes
>
> -Mathias
