Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F006DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E7120720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgGGUWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:22:20 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59859 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgGGUWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:22:20 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mcp7M-1kSW6a2uJO-00Zykd for <linux-kernel@vger.kernel.org>; Tue, 07 Jul
 2020 22:22:18 +0200
Received: by mail-qk1-f176.google.com with SMTP id k18so39416006qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:22:18 -0700 (PDT)
X-Gm-Message-State: AOAM531fjJAWO+VJSZ317fuzQIAs2NfUmGRn4uh7QqgP9VMcIcCVmuSA
        v/BazfSM6aMOCUM89f7RIyJNJeNBkxPTuN/asq0=
X-Google-Smtp-Source: ABdhPJzITVPjCxnHXfkdIPiqRtJAJl7o7eHfkI0AJsg/hshzs9HDGWn7jRdSvYOiXcuLAqTcP5fU3OgLVaJS7zYb8+w=
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr55482944qke.352.1594153337508;
 Tue, 07 Jul 2020 13:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200623142401.3742-1-hdegoede@redhat.com> <1cbeeac9-650b-fc6a-9d2d-a5dc26ce1a45@redhat.com>
In-Reply-To: <1cbeeac9-650b-fc6a-9d2d-a5dc26ce1a45@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Jul 2020 22:22:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1wbk2FvF3ZN=DL9ecQe0Z5HEGG5jG9CQSDxpe=8DHJpg@mail.gmail.com>
Message-ID: <CAK8P3a1wbk2FvF3ZN=DL9ecQe0Z5HEGG5jG9CQSDxpe=8DHJpg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] virt: vbox: Add support for the new
 VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ocf5EPrE+rbJxxdksA8HUD7yosnOWwuhA1Hg6CzwoqiMrdm06Dr
 R8y68PI+asbXZtda5LA9yIqgtIm52dUTVTds81tcJaaFMBMiwM3/HkjtWN8z5VKZqoTnNOc
 5IhKcPtPy4CgfA9ALArETSPgHNak97nRsQoFRTWHgfb+pT9EMhOEkrLeELKXZfvDCRsrMoG
 EjjzDF0BZcBz7zlG1luGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YDg0yz8Tqjo=:D7ur5HV57RZSOe9Q2SvN2h
 gA6g99HtsHsa+EwFZiI+gUxYebHkpyXcsfITb2TWx7a4NFUWTFU0pfcBdAGNvOHoSXG42II5o
 QVCr5CXxiApVJkSx+WYMYQB0sHIA+t+dmCoNn0tn2hvpxQaNswiy4kPjEwjNs7vkmhM6CVxBx
 6aRBrQ8UCJ1pH1L+worA8tmfTWz3lLWBcHESVSwsd4UCuDoNvJ/pkpa6ZFXmLZ8W0LYi3Rc4z
 6sgjKV/YFh8RUxCiYpf8AcwLm7aTmdSi/WFc9TQUlU0uSIZUR4qGaAnRkaELVbd2T6I66xRGQ
 c1I2HCaimUz232WwovzBlVuRTBW/KwRncfzVhYRNjdX3Re3kOFefAIEykP8+jxxfXShJDmgpV
 QRCWvGjqrYLB0+oR89fkdzrTekp/6UwMUZ2fBsKhAa/hVoikNDrtfhBhxPQ2sUCDk1c1jbw/Q
 kWrcV9oY29DaFBdXSv//GuEDRak355mbpTJruKHIE5omigrTDXV91o6KsXNGDBfw77XOlBJ2h
 BGp4AvAogzpNfqqUM+7xSQuACt5pdCQbwdi7ug4MaYbVGkgJAJ2SQwvdat8UnJW3kYFKUfXrG
 g4rzyo8bVZIdWqUjSbKZcayXg0tl8TwJmkefqfMndZLcfpuskjkf7sAST8HmGdj9YETvxslyh
 xKT6Jtq1d6m2HE82i1hEqCgKsRRzbUy4Oz/kuyop6y6cPt/d2eI/o/0Xu/oGX3OBPE0Czx2DJ
 UHYJyZJ27kOKB1Y/9VjUWlEuRJhv/3EbfIfYoQFMngo4tNtI/YG2mCjECNweHPQrh1761E+Me
 TZsEdTwxcZmmUupUH1cej1YHHPsDCFlbgp6uX+HySH25AI/G3GaEEJIj5l+FulmZZeBU2fw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 5:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Arnd,
>
> On 6/23/20 4:23 PM, Hans de Goede wrote:
> > Hi All,
> >
> > Here is v2 of my vboxguest driver patch-set adding support for the
> > new VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl which is necessary to
> > make guest resizing work with the new(ish) VMSVGA emulation in vbox +
> > some other small fixes.
> >
> > The only change since v2 is rate-limiting the error-logging in:
> > [PATCH v2 7/8] virt: vbox: Log unknown ioctl requests as error
>
> What is the status of this series?   I've addressed the one review
> remark you had on v1 of this series and it would be nice to
> get it upstream for the next cycle.

Ok, sorry I missed v2 of the series. It all looks ok to me, so please add

Acked-by: Arnd Bergmann <arnd@arndb.de>

and resend for Greg to pick up.

      Arnd
