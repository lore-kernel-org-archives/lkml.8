Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F99C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D1E20707
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRTKU7Rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIACcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIACcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:32:43 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A6FC06136D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:32:43 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id g11so2704950ual.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8cuCW4UG5Ed1e/kY33jplyyTlIIty/LC2aDLumsAvBg=;
        b=jRTKU7RlvutznVWkIyYAQAks/zFgT9iRl7hrrn3kcFYyCAJ0TmlZlkArx95l9Wg1lt
         J9etQ/nSkA3OLkb4r8u/VkG9O4VRi9WVjp0eoPcaKZYqf/+tkILRKdewR4xfz3N5+oqO
         hST/V4wQqatuza8EmZcxORiybaTLAuN2bHRGtKC2+7SOTiP2kHryFvG6/J8Cr7wJS8vy
         ZYKWfFxpnfHznPnSJErNWYuHa5/WTThyc7+cphuzXA/v5ATwx5UI/ctnEukQ7pGPxl4V
         iMxbKpHFmU1djdC9ZvHZ1mStOIh6ZHXcB0ENnPEHiWbG0LTuffnSNN83UmuzQDWW9uzr
         vBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8cuCW4UG5Ed1e/kY33jplyyTlIIty/LC2aDLumsAvBg=;
        b=JjUhTedc+D+438aKdhjEhQg8CSUOV9GN1Yh24l65klaDrZ8BOhmAMRG6vxUnZWRSRO
         mpV3029eufO7hgFpo36F5IHKM9usfO7qLPITG4yCtcWuu8oNXK1HSoinW8OkFdfDxdXM
         t6maiWPi6RlbIWKCO3Au7tXreHvdNNDxXDzMMDovX6usuxhiebDCr+IyF9OQXjL5vWlB
         BFhgyDN4PlKoazbfrFy8FOYctc9/a1TDc/PqdV8dzfwHs//my+L7z3ogdo5RFqDafDJi
         CxDuN+2CyA3G0bw445ECL+r0aEZ7N7Y0+XPza0patwaDmWDQ8TEJ6kH8C84TpKLfVVWN
         8+3w==
X-Gm-Message-State: AOAM5324mhL90MEknNpgEbwkyYGVOUcAZmEJ7xW42mfdqnujKIOjc5V2
        +Bp06MnV/e/nnpECvqFVX4M21CDsZiCvi/9wDz3ghg==
X-Google-Smtp-Source: ABdhPJwzI3ZCb++m9ycTyc1BwPJ3hr+C63fUeALlFF1nLsb6NUYiDOgZjbHnnWGio36wAKATCS8+XOS0OK1ftOVFm1E=
X-Received: by 2002:ab0:14c8:: with SMTP id f8mr3418947uae.23.1598927562467;
 Mon, 31 Aug 2020 19:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200706133341.476881-1-lee.jones@linaro.org> <20200706133341.476881-9-lee.jones@linaro.org>
 <ca14707c-7d40-07ac-da1d-ca27a2e93dcd@redhat.com> <20200706142051.GA3500@dell>
 <65f27abc-69c8-3877-be5b-e5e478153af9@redhat.com> <20200714135456.GB1398296@dell>
In-Reply-To: <20200714135456.GB1398296@dell>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 31 Aug 2020 19:32:06 -0700
Message-ID: <CAPTae5L3cVYc+00-bPzDADXRjzFCOGPB5NnmSZ4_c=0D5Mxikg@mail.gmail.com>
Subject: Re: [PATCH 08/32] usb: typec: tcpm: tcpm: Remove dangling unused
 'struct tcpm_altmode_ops'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Kernel test robot is still reporting this issue. I have my repo synced
to ToT usb-next:
Output of git repo:
5fedf0d295d3 (origin/usb-testing, origin/usb-next) Merge 5.9-rc3 into usb-n=
ext
f75aef392f86 (tag: v5.9-rc3, origin/usb-linus, origin/main) Linux 5.9-rc3
e43327c706f2 Merge branch 'linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
dcc5c6f013d8 Merge tag 'x86-urgent-2020-08-30' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
d2283cdc18d3 Merge tag 'irq-urgent-2020-08-30' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
0063a82de937 Merge tag 'sched-urgent-2020-08-30' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

Were you able to get your patch merged ?

Thanks,
Badhri


On Tue, Jul 14, 2020 at 6:55 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 14 Jul 2020, Hans de Goede wrote:
>
> > Hi,
> >
> > On 7/6/20 4:20 PM, Lee Jones wrote:
> > > On Mon, 06 Jul 2020, Hans de Goede wrote:
> > >
> > > > Hi,
> > > >
> > > > On 7/6/20 3:33 PM, Lee Jones wrote:
> > > > > Looks as though a079973f462a3 ("usb: typec: tcpm: Remove tcpc_con=
fig
> > > > > configuration mechanism") pulled out the only use of 'tcpm_altmod=
e_ops'
> > > > > last year.  No need to keep it around.
> > > > >
> > > > > Fixes the following W=3D1 kernel build warning(s):
> > > > >
> > > > >    drivers/usb/typec/tcpm/tcpm.c:1551:39: warning: =E2=80=98tcpm_=
altmode_ops=E2=80=99 defined but not used [-Wunused-const-variable=3D]
> > > > >    1551 | static const struct typec_altmode_ops tcpm_altmode_ops =
=3D {
> > > > >    | ^~~~~~~~~~~~~~~~
> > > > >
> > > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > >
> > > > This is necessary for adding Display port over Type-C support
> > > > on devices using the tcpm code, rather then firmware, to do
> > > > the Type-C alt-mode negotiation.
> > > >
> > > > I have a local patch in my tree which adds support for this.
> > > >
> > > > But Heikki did not like my approach, so that patch
> > > > (which needs the bits you are removing) never landed
> > > > upstream:
> > > >
> > > > https://patchwork.kernel.org/patch/11199517/
> > > >
> > > > Which is somewhat old now.
> > >
> > > Yes, that's a just a little old now.
> > >
> > > If it drags on for much longer, perhaps consider taking it out for th=
e
> > > time being and adding it back when you start to make use of it again?
> >
> > Ok, I've just submitted a reworked patch-series upstream which
> > actually uses this code. So please drop this patch from your
> > patch-set.
>
> No problem.
>
> Thanks Hans.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
