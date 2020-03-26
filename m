Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE2EC2D0EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17E32070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DT5EldjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZFxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 01:53:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44801 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgCZFxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:53:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so5090203lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 22:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OamWJL+Kraa8aO4Mkhy7ZkgdOxINecQMyrACLlFZPL8=;
        b=DT5EldjKHxzvFeMbmuQkccpeMvDVkVAh7h2G1YJS+3oTIcBcOxVNUzo0njpHzC07aP
         qftgGWtlSjcONHnap3ytTGZvdBK5TrQ9qn/Fi3K9645uAI8eYdMrWfTPolE8/Dg6mHpI
         4toDx71shQVGj2fSTCpufOkWDU/mXBnc5YV9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OamWJL+Kraa8aO4Mkhy7ZkgdOxINecQMyrACLlFZPL8=;
        b=myfNabWiKZxuHlUDTQdUoMFHeUdVWk+Buhiscnewjfr/RX/v3joWxOGbgZp7oqtcPk
         K8leVVas/ujWto0LhpHrll78wp0/Oqs45UQU+amc3G8NMSZ6iLvnwsgHh7rpX2SEY2GX
         Iik8F7/pjyCx/chOVUTo/VW/kLy0NPSbk274OK0rOeaXZzp/d9IMX6JM63c5beJEBR27
         4k5PSXPz2UHi1h/orEJrC5TTaV0VBSojY+B7T1dpQf42d2OEYudZyign/xwtYz6QiMSd
         af9mWic7f0rIFC8dPMrkD4fmATskGZPSsplpIBv7+nqeYCmqEExOoPzk2O4TDl1+Wwkq
         Uyzg==
X-Gm-Message-State: AGi0PuYZ56+Qtd/siTFT25Hx5/jt4vkHevjKWv5w/5aZ7ZqGCrM7DWqU
        COFpAsKQW/Z91TPROciXG60Q34albxkxP5ensnV6cQ==
X-Google-Smtp-Source: APiQypJFZkp52F4PqCr2TUsH6tvpdBDaO3MlZ3gnWs88/rEddguemkOsIxCUPkHx08J7PVHpdA/hRPk7l6QfTWJIjI4=
X-Received: by 2002:a2e:8511:: with SMTP id j17mr4191189lji.292.1585202026293;
 Wed, 25 Mar 2020 22:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200228084842.18691-1-rayagonda.kokatanur@broadcom.com>
 <CAL_JsqLXvVnVq0Mc1d0WMLNjURbHe9T3bKNb+5D6Nz3iyTK8GA@mail.gmail.com>
 <CAHO=5PFuercRYBzupd-Zb3q8v3sQWGT2ySXodG9S5NVj7Ta+1Q@mail.gmail.com>
 <CAL_JsqLW+3aJrB2EOEU74o+aVO9yPG74xi=Eov5_6++NdnOBPg@mail.gmail.com> <CAHO=5PEEgQ+0xhBmFwjvi2nBada17fxDYeG42SDjk5qdzCQANg@mail.gmail.com>
In-Reply-To: <CAHO=5PEEgQ+0xhBmFwjvi2nBada17fxDYeG42SDjk5qdzCQANg@mail.gmail.com>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Thu, 26 Mar 2020 11:23:34 +0530
Message-ID: <CAHO=5PHbOWcjAc-C-v-h7YiaKwtKJvS0DcKaxpLfSsfrEeGTAQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] scripts: dtc: mask flags bit when check i2c addr
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:04 AM Rayagonda Kokatanur
<rayagonda.kokatanur@broadcom.com> wrote:
>
> On Thu, Mar 26, 2020 at 12:37 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Mon, Mar 2, 2020 at 9:56 PM Rayagonda Kokatanur
> > <rayagonda.kokatanur@broadcom.com> wrote:
> > >
> > > On Fri, Feb 28, 2020 at 7:20 PM Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Fri, Feb 28, 2020 at 2:48 AM Rayagonda Kokatanur
> > > > <rayagonda.kokatanur@broadcom.com> wrote:
> > > > >
> > > > > Generally i2c addr should not be greater than 10-bit. The highest 2 bits
> > > > > are used for I2C_TEN_BIT_ADDRESS and I2C_OWN_SLAVE_ADDRESS. Need to mask
> > > > > these flags if check slave addr valid.
> > > > >
> > > > > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > > > > ---
> > > > >  scripts/dtc/Makefile | 2 +-
> > > > >  scripts/dtc/checks.c | 5 +++++
> > > > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > dtc changes must be submitted against upstream dtc.
> > >
> > > Please let me know link to clone the upstream dtc branch.
> > > >
> > > >
> > > > > diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> > > > > index 3acbb410904c..c5e8d6a9e73c 100644
> > > > > --- a/scripts/dtc/Makefile
> > > > > +++ b/scripts/dtc/Makefile
> > > > > @@ -9,7 +9,7 @@ dtc-objs        := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
> > > > >  dtc-objs       += dtc-lexer.lex.o dtc-parser.tab.o
> > > > >
> > > > >  # Source files need to get at the userspace version of libfdt_env.h to compile
> > > > > -HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt
> > > > > +HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt -I$(srctree)/tools/include
> > > > >
> > > > >  ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
> > > > >  ifneq ($(CHECK_DTBS),)
> > > > > diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> > > > > index 756f0fa9203f..17c9ed4137b5 100644
> > > > > --- a/scripts/dtc/checks.c
> > > > > +++ b/scripts/dtc/checks.c
> > > > > @@ -3,6 +3,7 @@
> > > > >   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2007.
> > > > >   */
> > > > >
> > > > > +#include <linux/bits.h>
> > > >
> > > > Not a UAPI header not that that would be much better as dtc also builds on Mac.
> > > >
> > > > >  #include "dtc.h"
> > > > >  #include "srcpos.h"
> > > > >
> > > > > @@ -17,6 +18,9 @@
> > > > >  #define TRACE(c, fmt, ...)     do { } while (0)
> > > > >  #endif
> > > > >
> > > > > +#define I2C_TEN_BIT_ADDRESS    BIT(31)
> > > > > +#define I2C_OWN_SLAVE_ADDRESS  BIT(30)
> > > > > +
> > > > >  enum checkstatus {
> > > > >         UNCHECKED = 0,
> > > > >         PREREQ,
> > > > > @@ -1048,6 +1052,7 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
> > > > >
> > > > >         for (len = prop->val.len; len > 0; len -= 4) {
> > > > >                 reg = fdt32_to_cpu(*(cells++));
> > > > > +               reg &= ~(I2C_OWN_SLAVE_ADDRESS | I2C_TEN_BIT_ADDRESS);
> > > >
> > > > I'd just mask the top byte so we don't have to update on the next flag we add.
> > > Do you mean something like this, shown below ?
> > > reg &= 0xFFFF_FC000;
> >
> > Yes, but as I said, the 'top byte', so 0xFF000000.
> Thank you, will do as per your suggestion and send v2.
Hi Rob,
I have pushed separate patch which is prepared against dtc master branch.
Please review.

> >
> > Rob
