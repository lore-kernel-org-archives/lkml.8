Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85B5C43458
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986242076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgGQS5n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:43 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45967 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgGQS5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:01 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N8GAQ-1krRjX073Q-014CI7 for <linux-kernel@vger.kernel.org>; Fri, 17 Jul
 2020 20:56:59 +0200
Received: by mail-qv1-f47.google.com with SMTP id h17so4696626qvr.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:56:58 -0700 (PDT)
X-Gm-Message-State: AOAM530Xqwa2KSEfB8S8aRwgpBSY15VvyGRDodckZD4q9QpwfRvTr7VW
        oxHOaXx03VJoIKCXn9xw9+fHEyj3iKwVOz06T0E=
X-Google-Smtp-Source: ABdhPJyVXNhsgwWTPE8D5CfsbmTw2ZDb4FpAvw84vgLhwJ9spQC/CtRqEmuskcTMUPdGIMWzya32DGplOuYM7XeHoZs=
X-Received: by 2002:a05:6214:1926:: with SMTP id es6mr10425899qvb.222.1595012217881;
 Fri, 17 Jul 2020 11:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200712134331.8169-1-gage.eads@intel.com> <20200712134331.8169-5-gage.eads@intel.com>
 <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com> <SN6PR11MB2574F33CF9C422517B3C13CFF67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB2574F33CF9C422517B3C13CFF67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jul 2020 20:56:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a09C6-auonW9jw30z_CijLgT+LkWfYowYoVdrwSzNGWKg@mail.gmail.com>
Message-ID: <CAK8P3a09C6-auonW9jw30z_CijLgT+LkWfYowYoVdrwSzNGWKg@mail.gmail.com>
Subject: Re: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
To:     "Eads, Gage" <gage.eads@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:GFC6EpKBexwL8NaBvnFHHVamJgfztztHaLC16VgkE05EmCqYguh
 vzFZug+L6FfbZfPcw+UH1sKhHKilpDZXOluffl7qctiiH84VSuV9YptPOE1f7NeXabSRchO
 8DpaGNFQt1QxtVr1robit5SUq63Flr9/JSsOS1O1WAFzeuVfRwdheNiKTufZoYtY8WTqGKE
 bs/pvHPw8DFyf8xfCaLlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1emOe0pwqCY=:rhJ3ouaMAj5WauqP43Tao8
 YMeNNN8eUNVWyFV+iYdbYhQvC4+WqFZnRBZpvnvmIg6qq74Zg+1pKd1xI4uRkuYMZ225VIYhb
 S1galxuNQe7RkqBrPyTWMHMBi0UV+zgO3WWfIs9u0J31ixTljSs/mptf2vc62GcsKA+2h/4si
 4ju3JOzTC+VqauvVq9aOeb8ZJdXhZuYYTXe9ubMSgZcnISkIey5shLGiPrS21hkggH6MLxDWZ
 yHf1Fw18iC0DOJBLw5IvAYWalUVEZ34SIz4DJR0Z5I2FtqpWWrQ7avu32Ai7F8l2/R40bfu0k
 z9lfPqL1yXXS4wvmskzKK19lWsREf00dCIit1o49rzE/xKv5JE37DnmBN33jUlzvOlYtYCLVU
 1cdWpyBn4YssIRLJMpVF07C82M009KSXwopLM/qX6/uKkL9kHfeGJFt4UpS6NRUODlgqRqoJm
 QYop7P9XtXi3/KiFwrkykSQCRQ93HtHn0FJ8LKefnJKW/d7uUatf4yl+jnlw2ce2rY6TwGDAI
 PcpjCHyCDmDLRSfExZJPZTXcqwcbIBG/A2FahJ3bpDXZ37OtLleD+jHWopaghXid5DtWPn5CY
 UP+cP1WUBJiLkhaxEoIbEtqY5EKSeSzcFP2FIfGExIQ7ivg7dnM7jj2tJ0tTZRmUt5sBGM6rO
 C2Lpz0D9nRCXGD3qE+lteGg3MXgpaBSnCSBUIO0eqU0p40c/HPdZfvbcdCCC5WF9OXVDTaoE+
 2nlhHbFFnBEEKxRNopQcu0elBpojcFWjyD8ovroIUqkgUarFJsSKw/0tM8QIDBsidlR32VTh/
 dmcrTayTGq6kJ2OjrdXmT4O7/dFXTDS2OP1pBpKxWSX1XAFdLtB610Kj/H/Kf+AK2cTSuor
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 8:19 PM Eads, Gage <gage.eads@intel.com> wrote:

> > A plain copy_from_user() in place of this function should be fine.
>
> This function also validates the user size arg to prevent buffer overflow; centralizing it here avoids the case where a programmer accidentally forgets the check in an ioctl handler (and reduces code duplication). If it's alright with you, I'll keep the function but drop the dev_err() prints.

Once you use a 'switch(cmd)' statement in the top ioctl handler, the
data structure size will be fixed, so there is no way the argument
size can go wrong.

> >
> > > +/* [7:0]: device revision, [15:8]: device version */ #define
> > > +DLB2_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
> > > +
> > > +static int dlb2_ioctl_get_device_version(struct dlb2_dev *dev,
> > > +                                        unsigned long user_arg,
> > > +                                        u16 size) {
> > > +       struct dlb2_get_device_version_args arg;
> > > +       struct dlb2_cmd_response response;
> > > +       int ret;
> > > +
> > > +       dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);
> > > +
> > > +       response.status = 0;
> > > +       response.id = DLB2_SET_DEVICE_VERSION(2, DLB2_REV_A0);
> > > +
> > > +       ret = dlb2_copy_from_user(dev, user_arg, size, &arg, sizeof(arg));
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret = dlb2_copy_resp_to_user(dev, arg.response, &response);
> >
> > Better avoid any indirect pointers. As you always return a constant here, I
> > think the entire ioctl command can be removed until you actually need it. If
> > you have an ioctl command that needs both input and output, use _IOWR()
> > to define it and put all arguments into the same structure.
>
> Ok, I'll merge the response structure into the ioctl structure (here and elsewhere).
>
> Say I add this command later: without driver versioning, how would
> user-space know in advance whether the command is supported?
> It could attempt the command and interpret -ENOTTY as "unsupported",
> but that strikes me as an inelegant way to reverse-engineer the version.

There is not really a driver "version" once the driver is upstream, the concept
doesn't really make sense here when arbitrary patches can get backported
from the latest kernel into whatever the user is running.

The ENOTTY check is indeed the normal way that user space deals
with interfaces that may have been added later. What you normally want
is to keep using the original interfaces anyway, unless you absolutely
need a later revision for a certain feature, and in that case the user space
program will fail no matter what.

> > This function can also be removed then, just call the dispatcher directly.
> > >         int err;
> > >
> > > -       pr_info("%s\n", dlb2_driver_name);
> > > +       pr_info("%s - version %d.%d.%d\n", dlb2_driver_name,
> > > +               DLB2_VERSION_MAJOR_NUMBER,
> > > +               DLB2_VERSION_MINOR_NUMBER,
> > > +               DLB2_VERSION_REVISION_NUMBER);
> > >         pr_info("%s\n", dlb2_driver_copyright);
> >
> > Just remove the pr_info completely.
>
> Can you elaborate? Printing the driver name/copyright/etc. seems to be a common pattern in upstream drivers.

Most drivers don't do it, and it's generally not recommended. You can
print a message when something goes wrong, but most users don't
care about that stuff and it clutters up the kernel log if each driver
prints a line or two.

     Arnd
