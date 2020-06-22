Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F10EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470E02065F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjHaCbUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgFVRKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbgFVRKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:10:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D11C061573;
        Mon, 22 Jun 2020 10:10:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so297717wmi.3;
        Mon, 22 Jun 2020 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0adVUwVMLiske06EWkl46gb9csAe3/7ufgKfEsj9RM=;
        b=SjHaCbUt2iSz4Dm4aF5Yn9vonOl8q/TIVfY6WDSpm0UYB0IrGb3Nl/chUNlKws0UYv
         ys0MWm4LB27msAEtiEZdgs+g4vTSNLwp3vmcQ8pvL0BCX+tibrdwtIUJ9PVRAQS0LsqB
         5HV3xtp28pql6V9CLjArKDW1jk73q0eeXKs0B5i1/WplmerUhFAOb7LbEUk/Z15uRKMT
         O09jdWCx44AVEeleXGsZHtrrQOJew6hMUwEq//u1g69OHtzfUST/msoCqval3wWpDXeD
         FbetEQBIW5FeQKyMgBm5JCqWmvcAOrxwYcEeXgB9ICqtpRDtQhbmPVT/qTBb4txe0bxs
         eAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0adVUwVMLiske06EWkl46gb9csAe3/7ufgKfEsj9RM=;
        b=VX20MiXq943mwQDaHSompz1oP0Nt1H8f3GcNqPW1WtqJAxbUXCM+m7ex/FtpuyB8nR
         QIzNzL9syeNm/Wcy99UF6YgClGl1zofFq30mrtyf7Mr6x94+3ek0gCEqXY2s0PNJjFZa
         fngy+V6Yjrr/iGE7rq28v/U2BjSp7raqSeg8cqcpfwjIEr3VvzaRnD2qeF7dsBA+SXml
         N8cCrnE0kK3IWq+nBZ3epZOgkI/c56aTFBFCrZipsOkvgcPsp7bJAMt8Va58+DU2O922
         vps2y/3M+g6cpI7uRHK9JccRfvkf8U8d4HU9L65ltVYyNS2Bxgb1pXvUmywZ5wvQOPrt
         CVQQ==
X-Gm-Message-State: AOAM532aHpLXDrbXo48P4AKgPaTM+JuDoJFAR3oREPT/1LnHmuJ1vyEq
        x427G7LCByKaRCeArHdLl//WDiyxxjaC58+wdwk=
X-Google-Smtp-Source: ABdhPJzPR9EObFv/rCnpdveL2WSCF4odzFO6W2ulI/zv20ILpbitAKlIfQioVU/fGFChvhu8ma0GvOyqo/lLmVQ3vtE=
X-Received: by 2002:a1c:a304:: with SMTP id m4mr20545819wme.49.1592845802825;
 Mon, 22 Jun 2020 10:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200616220403.1807003-1-james.hilliard1@gmail.com> <20200622085321.GA3334@localhost>
In-Reply-To: <20200622085321.GA3334@localhost>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Mon, 22 Jun 2020 11:09:51 -0600
Message-ID: <CADvTj4p6j1bJ8jK5t_nQC9uVRLJn_Fi07-DUu8yQvqM3ymdWMg@mail.gmail.com>
Subject: Re: [PATCH v2] USB: Serial: cypress_M8: Enable Simply Automated UPB PIM
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 2:53 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Jun 16, 2020 at 04:04:03PM -0600, James Hilliard wrote:
> > This is a UPB(Universal Powerline Bus) PIM(Powerline Interface Module)
> > which allows for controlling multiple UPB compatible devices from
> > Linux using the standard serial interface.
> >
> > Based on vendor application source code there are two different models
> > of USB based PIM devices in addition to a number of RS232 based PIM's.
> >
> > The vendor UPB application source contains the following USB ID's:
> > #define USB_PCS_VENDOR_ID 0x04b4
> > #define USB_PCS_PIM_PRODUCT_ID 0x5500
> >
> > #define USB_SAI_VENDOR_ID 0x17dd
> > #define USB_SAI_PIM_PRODUCT_ID 0x5500
> >
> > The first set of ID's correspond to the PIM variant sold by Powerline
> > Control Systems while the second corresponds to the Simply Automated
> > Incorporated PIM. As the product ID for both of these match the default
> > cypress HID->COM RS232 product ID it assumed that they both use an
> > internal variant of this HID->COM RS232 converter hardware. However
> > as the vendor ID for the Simply Automated variant is different we need
> > to also add it to the cypress_M8 driver so that it is properly
> > detected.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v1 -> v2:
> >   - Add more detailed commit message.
>
> Now applied, thanks.
Oh, FYI I think part of the comment got dropped when you amended the patch
I don't see the defines in the comment here:
https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-linus&id=7527d963dff544b0ddfba4319824c50f2a892aeb

I think I had to temporarily change my git config with this to make it not drop
the defines:
git config core.commentchar "*"
>
> Would you mind posting the output of "lsusb -v" for this device for
> completeness?
>
> Johan
