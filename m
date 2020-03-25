Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58B6C2D0E6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1062076F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585163280;
	bh=26Uk9meXN96js/gICre78nVAjflPsXGx6aYynHLKmGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y/qk9xH3PABLlJjat8tYndmn9iGCLNmi8V/Ar4FnhSCI1ua6wrBytGUVkZWWL5B77
	 tbL0NPhnOLvo8wl38sW2+P+cFKFdy78p3SamnshuF+VGaxR38zF0daJ+y3EJZdp872
	 X2SjtFNlwMSk2bgZqdBAsD9MR02tQ0iQfhvCSDn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCYTH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgCYTH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:07:59 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78E4D20714;
        Wed, 25 Mar 2020 19:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585163278;
        bh=26Uk9meXN96js/gICre78nVAjflPsXGx6aYynHLKmGM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AvNzVfwsdnqkrxQA3Q54688/DCKofvQC6qVJnKLKNUAHGTtn/glf39ws7XSzGyjyK
         DHlQ9CRU1d5aMFU6cDgTsp/E+WIaxcwoZ7pSlyS+RsCa213Zyx80G7kxDYwrYSJpfw
         fQ64BNPKo5N2iJxYJT6DPUH272YT//TfiC386tPY=
Received: by mail-qt1-f181.google.com with SMTP id i3so3174372qtv.8;
        Wed, 25 Mar 2020 12:07:58 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0gOoaNzaD+wq+W3uVDHpZb3ZuNBvRqe6DqZVI70un/tWt8YdWy
        7vQ8GZEuaWQV0+WJd7ACm9Y7pJRRzrFSx0NOWw==
X-Google-Smtp-Source: ADFU+vuTndY+wDPw79ZNIs5Xbyn1ONlKDN1cNv+Vsq80x/BVGrqoyD/vBaotVdkdCJ1DdFZbyMgkgqCGN7aXaoQEiro=
X-Received: by 2002:ac8:59:: with SMTP id i25mr4605237qtg.110.1585163272778;
 Wed, 25 Mar 2020 12:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200228084842.18691-1-rayagonda.kokatanur@broadcom.com>
 <CAL_JsqLXvVnVq0Mc1d0WMLNjURbHe9T3bKNb+5D6Nz3iyTK8GA@mail.gmail.com> <CAHO=5PFuercRYBzupd-Zb3q8v3sQWGT2ySXodG9S5NVj7Ta+1Q@mail.gmail.com>
In-Reply-To: <CAHO=5PFuercRYBzupd-Zb3q8v3sQWGT2ySXodG9S5NVj7Ta+1Q@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 25 Mar 2020 13:07:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLW+3aJrB2EOEU74o+aVO9yPG74xi=Eov5_6++NdnOBPg@mail.gmail.com>
Message-ID: <CAL_JsqLW+3aJrB2EOEU74o+aVO9yPG74xi=Eov5_6++NdnOBPg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] scripts: dtc: mask flags bit when check i2c addr
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 9:56 PM Rayagonda Kokatanur
<rayagonda.kokatanur@broadcom.com> wrote:
>
> On Fri, Feb 28, 2020 at 7:20 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Fri, Feb 28, 2020 at 2:48 AM Rayagonda Kokatanur
> > <rayagonda.kokatanur@broadcom.com> wrote:
> > >
> > > Generally i2c addr should not be greater than 10-bit. The highest 2 bits
> > > are used for I2C_TEN_BIT_ADDRESS and I2C_OWN_SLAVE_ADDRESS. Need to mask
> > > these flags if check slave addr valid.
> > >
> > > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > > ---
> > >  scripts/dtc/Makefile | 2 +-
> > >  scripts/dtc/checks.c | 5 +++++
> > >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > dtc changes must be submitted against upstream dtc.
>
> Please let me know link to clone the upstream dtc branch.
> >
> >
> > > diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> > > index 3acbb410904c..c5e8d6a9e73c 100644
> > > --- a/scripts/dtc/Makefile
> > > +++ b/scripts/dtc/Makefile
> > > @@ -9,7 +9,7 @@ dtc-objs        := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
> > >  dtc-objs       += dtc-lexer.lex.o dtc-parser.tab.o
> > >
> > >  # Source files need to get at the userspace version of libfdt_env.h to compile
> > > -HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt
> > > +HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt -I$(srctree)/tools/include
> > >
> > >  ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
> > >  ifneq ($(CHECK_DTBS),)
> > > diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> > > index 756f0fa9203f..17c9ed4137b5 100644
> > > --- a/scripts/dtc/checks.c
> > > +++ b/scripts/dtc/checks.c
> > > @@ -3,6 +3,7 @@
> > >   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2007.
> > >   */
> > >
> > > +#include <linux/bits.h>
> >
> > Not a UAPI header not that that would be much better as dtc also builds on Mac.
> >
> > >  #include "dtc.h"
> > >  #include "srcpos.h"
> > >
> > > @@ -17,6 +18,9 @@
> > >  #define TRACE(c, fmt, ...)     do { } while (0)
> > >  #endif
> > >
> > > +#define I2C_TEN_BIT_ADDRESS    BIT(31)
> > > +#define I2C_OWN_SLAVE_ADDRESS  BIT(30)
> > > +
> > >  enum checkstatus {
> > >         UNCHECKED = 0,
> > >         PREREQ,
> > > @@ -1048,6 +1052,7 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
> > >
> > >         for (len = prop->val.len; len > 0; len -= 4) {
> > >                 reg = fdt32_to_cpu(*(cells++));
> > > +               reg &= ~(I2C_OWN_SLAVE_ADDRESS | I2C_TEN_BIT_ADDRESS);
> >
> > I'd just mask the top byte so we don't have to update on the next flag we add.
> Do you mean something like this, shown below ?
> reg &= 0xFFFF_FC000;

Yes, but as I said, the 'top byte', so 0xFF000000.

Rob
