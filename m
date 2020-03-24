Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEFAC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647DA20789
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lV8x446t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgCXPLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:11:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43810 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgCXPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:11:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id g27so10143720ljn.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyFduZ6VwjzQIiJQ/lBuEzWDfMDYvttrQIwiQL9qENU=;
        b=lV8x446tzSYygFYppGaw9+2BQMof1D1ksnvF9IK7P+8mx5vNtsOTdVM0v5TOcGdG8c
         Uq/7Q2y3gt/SJglq0t0+tp+EzPFRMtEiihvrZGEacloF6tkUjAPyuAdHfPwlfchVODTM
         EAg9baoKJ4IAG1KVVOb8L5IYhjdwl4ziCTLTBv+d2XvrOK76ub1eNBh24xv4N4j+nHj+
         sr8DHzmtdyy5bC97jyU+bv5+Va3RnF4ILk0I5qJ38KnPf9wKY+9VpiXPVm3kzoi1/dd5
         NkptJKCJSWlkoNTqNamItZDIi9AC3tW3wh+vpWkBuMGne7WWacZxIDntgraqioVPopWc
         dmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyFduZ6VwjzQIiJQ/lBuEzWDfMDYvttrQIwiQL9qENU=;
        b=LWkv/ArYsKpguAI4TpDNJWN6g0QTpjxHD81uaN5Gd7KnGNCCg5FTR0oLJUmw+kTVMB
         86sxzRZSdgAU9/7QSvmdcsjRfAboELd9JHGSiSj6A4sd/2HaFC2QkVk831/ZqnTuQNwI
         Oq1beYWjktH/l1jAZro1bU/FUqXvTqrOX5tXZvPnRPNBklwA0Sl0G/zUehQpj7HeX5MJ
         Sbj5L8TePDlY7OfbWfT4kswMcj5FqMEVWs1dF6lC9zxQ7i3IprWOKyqcRgsyrys0xALw
         7hxzww+nfsqTHNab8JPesTv+VoFYd6pYafjMxC8b4zG4cz7cev70znoAIPV7RnDnt0GR
         EhdA==
X-Gm-Message-State: ANhLgQ3is5f0MGjyPNpOKG0wsvOfO+uRtjtJA/d8xo8A/2hwhgH3/EMT
        8GQStYyuNA81uX+uh4C0hoOBZnUPb1el7OqGHR359w==
X-Google-Smtp-Source: ADFU+vt120QxoRsGIUo7LYX7YrOtz0MGH7R9zC4EUX4bJ9TcmMHdG0IrAOwJcnSSrk7cTWcI/eIzyXRxb40GKoHKLow=
X-Received: by 2002:a2e:9a90:: with SMTP id p16mr18017042lji.277.1585062664389;
 Tue, 24 Mar 2020 08:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200323072824.254495-1-mcchou@chromium.org> <20200323002820.v1.1.I0e975833a6789e8acc74be7756cd54afde6ba98c@changeid>
 <04021BE3-63F7-4B19-9F0E-145785594E8C@holtmann.org> <421d27670f2736c88e8c0693e3ff7c0dcfceb40b.camel@perches.com>
 <57C56801-7F3B-478A-83E9-1D2376C60666@holtmann.org> <03547be94c4944ca672c7aef2dd38b0fb1eedc84.camel@perches.com>
In-Reply-To: <03547be94c4944ca672c7aef2dd38b0fb1eedc84.camel@perches.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 24 Mar 2020 11:10:52 -0400
Message-ID: <CALWDO_U5Cnt3_Ss2QQNhtuKS_8qq7oyNH4d97J68pmbmQMe=3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btusb: Indicate Microsoft vendor
 extension for Intel 9460/9560 and 9160/9260
To:     Joe Perches <joe@perches.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 4:11 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-03-23 at 19:48 +0100, Marcel Holtmann wrote:
> > Hi Joe,
>
> Hello Marcel.
>
> > > > > This adds a bit mask of driver_info for Microsoft vendor extension and
> > > > > indicates the support for Intel 9460/9560 and 9160/9260. See
> > > > > https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/
> > > > > microsoft-defined-bluetooth-hci-commands-and-events for more information
> > > > > about the extension. This was verified with Intel ThunderPeak BT controller
> > > > > where msft_vnd_ext_opcode is 0xFC1E.
> > > []
> > > > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > > []
> > > > > @@ -315,6 +315,10 @@ struct hci_dev {
> > > > >         __u8            ssp_debug_mode;
> > > > >         __u8            hw_error_code;
> > > > >         __u32           clock;
> > > > > +       __u16           msft_vnd_ext_opcode;
> > > > > +       __u64           msft_vnd_ext_features;
> > > > > +       __u8            msft_vnd_ext_evt_prefix_len;
> > > > > +       void            *msft_vnd_ext_evt_prefix;
> > >
> > > msft is just another vendor.
> > >
> > > If there are to be vendor extensions, this should
> > > likely use a blank line above and below and not
> > > be prefixed with msft_
> >
> > there are other vendors, but all of them are different. So this needs to be prefixed with msft_ actually. But I agree that having empty lines above and below makes it more readable.
>
> So struct hci_dev should become a clutter
> of random vendor extensions?
>
> Perhaps there should instead be something like
> an array of char at the end of the struct and
> various vendor specific extensions could be
> overlaid on that array or just add a void *
> to whatever info that vendors require.
I don't particularly like trailing buffers, but I agree we could
possibly organize this a little better by with a struct.  something
like:

struct msft_vnd_ext {
    bool              supported; // <-- Clearly calls out if the
extension is supported.
    __u16           msft_vnd_ext_opcode; // <-- Note that this also
needs to be provided by the driver.  I don't recommend we have this
read from the hardware since we just cause an extra redirection that
isn't necessary.  Ideally, this should come from the usb_table const.
    __u64           msft_vnd_ext_features;
    __u8             msft_vnd_ext_evt_prefix_len;
    void             *msft_vnd_ext_evt_prefix;
};

And then simply add the struct msft_vnd_ext (and any others) to hci_dev.


>
>
>
