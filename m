Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57867C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290A92076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvWpMxY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgCXPYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:24:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37140 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgCXPYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:24:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so19085488ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GjMXRxYK8hnYgiX8zhNqagmWow1EQZjJPKYukRaF0z0=;
        b=IvWpMxY7ZzJo/D62y8H91XxyuC9BelSAUPHbwYxTegZd8gkQAikSBsnF+hPpT1AWV0
         7Od9TEtAEZWOQYN41SVngmRhQKVxrq2kPSlylIlaEMUvf8tlsRijyxQgM11giuJwCE3E
         gZSwJwzZKRF3VYDr57BdSciSsuekvz8dY2gJMLs7safJwc4hAn5UynIrr6D42/JqgRbq
         IpcTtUJO5kxQrNRabzzCgqJqZe/Vsu0k4cZwcmI14zOcnDXBWAxHYXYk0FpnhPmTMvq/
         j6f3AANFkTUpBRiyUoD9Y2kudIdAn+gepWbasIhN1d9uxyaI+bvouyeoFArmTbdfK70n
         txnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GjMXRxYK8hnYgiX8zhNqagmWow1EQZjJPKYukRaF0z0=;
        b=AU0/hdWP67EKr3GxEusWo1sKyzYzb/JctejONh3NehDvcMNcKh2c3aUNSPOhCsT69A
         fCienKcbf1GBxrZtpOpftqFcdwKlbs7MeckV4cqDULJyryuPF1tZJeI/k0MoAUBtU1P3
         F09y8P/f0Kmy12eh1YQ09KszxJ2G+qfFQRuulBMhOK+ZvnlPtRQcoVpMJZalnziazvuT
         hwostjYC4vEs2vBR7GnqDWl06DBXCLL6jLUoyDDqgFko/zgaDxdxQJMeAhdx3wo0C2/T
         WInxXC3Kxb+W1BwK8YmsG94lnSm4QUXFV/I+sVNxuWeKxso2R/54JIgHLcfpx2Aidyv6
         2dfA==
X-Gm-Message-State: ANhLgQ1Z9c+3BRZjxQypcmXjMK7DYvMoGEcigkDN4soK29dLwDbvqwOn
        AKjS9bIs2gwtGQnrsXD5/eNUuR8oZ7kYRrcuuHxHDw==
X-Google-Smtp-Source: ADFU+vtllPBYG7uivkhCwRoSfkWZ0eDqCX8QSadz/VPvGbWoI/ZIo+X6RS/4K0m9RdjaSgbrBDmgEC4eg68kkpN1260=
X-Received: by 2002:a2e:94d5:: with SMTP id r21mr16560291ljh.81.1585063453777;
 Tue, 24 Mar 2020 08:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200323072824.254495-1-mcchou@chromium.org> <20200323002820.v1.1.I0e975833a6789e8acc74be7756cd54afde6ba98c@changeid>
 <04021BE3-63F7-4B19-9F0E-145785594E8C@holtmann.org> <421d27670f2736c88e8c0693e3ff7c0dcfceb40b.camel@perches.com>
 <57C56801-7F3B-478A-83E9-1D2376C60666@holtmann.org> <03547be94c4944ca672c7aef2dd38b0fb1eedc84.camel@perches.com>
 <CALWDO_U5Cnt3_Ss2QQNhtuKS_8qq7oyNH4d97J68pmbmQMe=3w@mail.gmail.com> <b7b6e52eccca921ccea16b7679789eb3e2115871.camel@perches.com>
In-Reply-To: <b7b6e52eccca921ccea16b7679789eb3e2115871.camel@perches.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 24 Mar 2020 11:24:01 -0400
Message-ID: <CALWDO_U8hruyjvZmN5P3kYz-awhD8t7yNbX9K0uXd5OdDejdMA@mail.gmail.com>
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

On Tue, Mar 24, 2020 at 11:19 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-03-24 at 11:10 -0400, Alain Michaud wrote:
> > On Mon, Mar 23, 2020 at 4:11 PM Joe Perches <joe@perches.com> wrote:
> > > On Mon, 2020-03-23 at 19:48 +0100, Marcel Holtmann wrote:
> > > > Hi Joe,
> > >
> > > Hello Marcel.
> > >
> > > > > > > This adds a bit mask of driver_info for Microsoft vendor extension and
> > > > > > > indicates the support for Intel 9460/9560 and 9160/9260. See
> > > > > > > https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/
> > > > > > > microsoft-defined-bluetooth-hci-commands-and-events for more information
> > > > > > > about the extension. This was verified with Intel ThunderPeak BT controller
> > > > > > > where msft_vnd_ext_opcode is 0xFC1E.
> > > > > []
> > > > > > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > > > > []
> > > > > > > @@ -315,6 +315,10 @@ struct hci_dev {
> > > > > > >         __u8            ssp_debug_mode;
> > > > > > >         __u8            hw_error_code;
> > > > > > >         __u32           clock;
> > > > > > > +       __u16           msft_vnd_ext_opcode;
> > > > > > > +       __u64           msft_vnd_ext_features;
> > > > > > > +       __u8            msft_vnd_ext_evt_prefix_len;
> > > > > > > +       void            *msft_vnd_ext_evt_prefix;
> > > > >
> > > > > msft is just another vendor.
> > > > >
> > > > > If there are to be vendor extensions, this should
> > > > > likely use a blank line above and below and not
> > > > > be prefixed with msft_
> > > >
> > > > there are other vendors, but all of them are different. So this needs to be prefixed with msft_ actually. But I agree that having empty lines above and below makes it more readable.
> > >
> > > So struct hci_dev should become a clutter
> > > of random vendor extensions?
> > >
> > > Perhaps there should instead be something like
> > > an array of char at the end of the struct and
> > > various vendor specific extensions could be
> > > overlaid on that array or just add a void *
> > > to whatever info that vendors require.
> > I don't particularly like trailing buffers, but I agree we could
> > possibly organize this a little better by with a struct.  something
> > like:
> >
> > struct msft_vnd_ext {
> >     bool              supported; // <-- Clearly calls out if the
> > extension is supported.
> >     __u16           msft_vnd_ext_opcode; // <-- Note that this also
> > needs to be provided by the driver.  I don't recommend we have this
> > read from the hardware since we just cause an extra redirection that
> > isn't necessary.  Ideally, this should come from the usb_table const.
> >     __u64           msft_vnd_ext_features;
> >     __u8             msft_vnd_ext_evt_prefix_len;
> >     void             *msft_vnd_ext_evt_prefix;
> > };
> >
> > And then simply add the struct msft_vnd_ext (and any others) to hci_dev.
>
> Or use an anonymous union
That would also work, but would need to be an array of unions, perhaps
following your original idea to have them be in a trailing array of
unions since a controller may support more than one extension.  This
might be going overboard :)

>
>
>
