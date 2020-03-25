Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB7C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290A720719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HV62cuaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCYFSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:18:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36412 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYFSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:18:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id g12so1121282ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 22:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPdsfolAYBymNTtjFbWm1sGcSl3euUAzGo5gu/sysho=;
        b=HV62cuaHNm0sLpPBqbW77tm1j9IRBrwfwZQ4V4KalwZ9pz83sNLLlOl3wYB9F2NPq1
         /AthsNfbxYNA4nrE4JWW/CpN92ffFxD4pd1T5KrGlDua3N7tZB7vVnbvlrENLcqEpdxk
         ksjMcj8hQuXbDYbzP0/lFfLqTvRT3epWfBpN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPdsfolAYBymNTtjFbWm1sGcSl3euUAzGo5gu/sysho=;
        b=KbBgGMzPD7O3Eo2f1SSQAWXhBmyiKsUd2Ixp9K1wZvBd2kO+vD2dP4rvNnCAyBY0Q4
         iNywvPrHC8gdkid6oTLHqtga+3dqMNYDy0YXPZDVoEVWxlJT3CiJrtwNMMLOCb7byO8L
         DgeNSaWcuGZ9/pvw7EAhCT2RF9dSnhn6wXEC2izdLPYdZ0s6UomDNiouL3BTekgYXYrB
         RxJSmhJ90zkO1qpNxk6Fcj9vYRxsgP+BNqTIoD6OZvi7HMxIj6N5KuE1nu2S83BpGNXd
         jfHubgMrWsU489vWIU7NB+1Ai8IA12/0kDeZjAHw7bhJdGJ8UfJQSPc8+dQpcM0vzuWq
         XjPg==
X-Gm-Message-State: AGi0PubovaEo7U1rwZo/NypzQ0ek1AZAVjitLLzE2reLGk7xmhGdyr3P
        XYKTDYkoWHF2V0VxJiEQrAF45Llcqh3ppRtWksKMkg==
X-Google-Smtp-Source: ADFU+vtZD1HGvN+DQ13pTWzYdoo8gG5ct+mgTQBTtLRVyqiOPrMAUEgQcPZ2Lj1ENhxI54Gu7sGwUdrwP8XwGF26SXE=
X-Received: by 2002:a2e:a551:: with SMTP id e17mr822190ljn.86.1585113522357;
 Tue, 24 Mar 2020 22:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200323072824.254495-1-mcchou@chromium.org> <20200323002820.v1.1.I0e975833a6789e8acc74be7756cd54afde6ba98c@changeid>
 <04021BE3-63F7-4B19-9F0E-145785594E8C@holtmann.org> <421d27670f2736c88e8c0693e3ff7c0dcfceb40b.camel@perches.com>
 <57C56801-7F3B-478A-83E9-1D2376C60666@holtmann.org> <03547be94c4944ca672c7aef2dd38b0fb1eedc84.camel@perches.com>
 <CALWDO_U5Cnt3_Ss2QQNhtuKS_8qq7oyNH4d97J68pmbmQMe=3w@mail.gmail.com>
 <643C6020-2FC5-4EEA-8F64-5D4B7F9258A4@holtmann.org> <CALWDO_Uc6brpXmVfoUd+jgyy_F0-WSrYb1+hXtXm498dGzCOSg@mail.gmail.com>
In-Reply-To: <CALWDO_Uc6brpXmVfoUd+jgyy_F0-WSrYb1+hXtXm498dGzCOSg@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Tue, 24 Mar 2020 22:18:31 -0700
Message-ID: <CABmPvSF7xLihcnk9bd3ZeK6Nr_DsQq2ypXV7wn8bU4UnQ0sKUg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btusb: Indicate Microsoft vendor
 extension for Intel 9460/9560 and 9160/9260
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Joe Perches <joe@perches.com>,
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

On Tue, Mar 24, 2020 at 12:32 PM Alain Michaud <alainmichaud@google.com> wrote:
>
> On Tue, Mar 24, 2020 at 2:35 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Alain,
> >
> > >>>>>> This adds a bit mask of driver_info for Microsoft vendor extension and
> > >>>>>> indicates the support for Intel 9460/9560 and 9160/9260. See
> > >>>>>> https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/
> > >>>>>> microsoft-defined-bluetooth-hci-commands-and-events for more information
> > >>>>>> about the extension. This was verified with Intel ThunderPeak BT controller
> > >>>>>> where msft_vnd_ext_opcode is 0xFC1E.
> > >>>> []
> > >>>>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > >>>> []
> > >>>>>> @@ -315,6 +315,10 @@ struct hci_dev {
> > >>>>>>        __u8            ssp_debug_mode;
> > >>>>>>        __u8            hw_error_code;
> > >>>>>>        __u32           clock;
> > >>>>>> +       __u16           msft_vnd_ext_opcode;
> > >>>>>> +       __u64           msft_vnd_ext_features;
> > >>>>>> +       __u8            msft_vnd_ext_evt_prefix_len;
> > >>>>>> +       void            *msft_vnd_ext_evt_prefix;
> > >>>>
> > >>>> msft is just another vendor.
> > >>>>
> > >>>> If there are to be vendor extensions, this should
> > >>>> likely use a blank line above and below and not
> > >>>> be prefixed with msft_
> > >>>
> > >>> there are other vendors, but all of them are different. So this needs to be prefixed with msft_ actually. But I agree that having empty lines above and below makes it more readable.
> > >>
> > >> So struct hci_dev should become a clutter
> > >> of random vendor extensions?
> > >>
> > >> Perhaps there should instead be something like
> > >> an array of char at the end of the struct and
> > >> various vendor specific extensions could be
> > >> overlaid on that array or just add a void *
> > >> to whatever info that vendors require.
> > > I don't particularly like trailing buffers, but I agree we could
> > > possibly organize this a little better by with a struct.  something
> > > like:
> > >
> > > struct msft_vnd_ext {
> > >    bool              supported; // <-- Clearly calls out if the
> > > extension is supported.
> > >    __u16           msft_vnd_ext_opcode; // <-- Note that this also
> > > needs to be provided by the driver.  I don't recommend we have this
> > > read from the hardware since we just cause an extra redirection that
> > > isn't necessary.  Ideally, this should come from the usb_table const.
> >
> > Actually supported == false is the same as opcode == 0x0000. And supported == true is opcode != 0x0000.
> I was thinking of a more generic way to check if the extension is
> supported so the higher level doesn't need to understand that
> opcode==0 means it's not supported.  For the android extension for
> example, this would be a simple boolean (there isn't any opcodes).
> >
> > >    __u64           msft_vnd_ext_features;
> > >    __u8             msft_vnd_ext_evt_prefix_len;
> > >    void             *msft_vnd_ext_evt_prefix;
> > > };
> > >
> > > And then simply add the struct msft_vnd_ext (and any others) to hci_dev.
> >
> > Anyway, Lets keep these for now as hci_dev->msft_vnd_ext_*. We can fix this up later without any impact.
> I agree, this doesn't have a whole lot of long term consequences,
> although some will want to cherry-pick this to older kernels so if
> there is something we can do now, it will reduce burden on some
> products.
Thanks for all your inputs. I will group these msft_vnd_ext_* into a
struct msft_vnd_ext with future refactoring in mind if new extensions
are introduced.
