Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B0EC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A4920848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yly52uOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgCCE4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:56:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47001 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgCCE4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:56:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id h18so1947625ljl.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 20:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwMP5oZox6Y4kOGUdZo8BHcMoyromC78BYS7tU+3+Fk=;
        b=Yly52uOaENemYmwtIDMOdmo+8VrTj5xg18Z7UUH9uiXajRoem4QSxRLPJFruhRYRYd
         hdrpfzLuELidowjJAHZFwnCNPKVWkmkQT5CDniucu3T9czdQp5LfCU8weeHwijgWWDRt
         8YahMYVv+4tGjxuE6Wc1HGjXpsdeM81uGySPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwMP5oZox6Y4kOGUdZo8BHcMoyromC78BYS7tU+3+Fk=;
        b=XS3P+Of3gTKK5F62ondGl+CYRxNdipHniexkTpj6n0FoTotIAu1+qAyTzA5+l3bFMz
         51dqqyWfXv/1khM2TJD8NO6x8BsQ4F5h0aT4MXPPBopXEpG8f5oX/TE0lXJQ9vScnOBx
         n85RydyJ1NXHzQFG8ktH1Og5nUDqMT0tJ9Js2GzqBD0abWGLf96mn6CCwvYD90KrPEUH
         b8ruexzwt0LOGXQ+Ky+yhP6SYyAVQOuGkWMceA0GleBQ0AGkO0nys0rlASOVRn8EXM3H
         ZCUbKHVZjOSElUd6XS44Jb0c/0vO55w73KNOEa+LhpmkVdBf0Tp5rIHSYVNhuPH8fHc8
         lTtw==
X-Gm-Message-State: ANhLgQ1Y5GiXVXrJligj2niRq8wiGNRu+JNuWnM4gCBrscmoLotjmn9+
        SmG0Ii8m69UGSBLbQNsajTHQK+Tp8osa+2lY0MxWfw==
X-Google-Smtp-Source: ADFU+vuIE9xrn+W2Q9MlLUg9pq2k3PM91Oafv76TMl6rksWSbmRHriyiiNAtHik7F2jm+2shZYnZGhd1BrDCWEmcjXM=
X-Received: by 2002:a2e:2243:: with SMTP id i64mr1219121lji.264.1583211389300;
 Mon, 02 Mar 2020 20:56:29 -0800 (PST)
MIME-Version: 1.0
References: <20200228084842.18691-1-rayagonda.kokatanur@broadcom.com> <CAL_JsqLXvVnVq0Mc1d0WMLNjURbHe9T3bKNb+5D6Nz3iyTK8GA@mail.gmail.com>
In-Reply-To: <CAL_JsqLXvVnVq0Mc1d0WMLNjURbHe9T3bKNb+5D6Nz3iyTK8GA@mail.gmail.com>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Tue, 3 Mar 2020 10:26:17 +0530
Message-ID: <CAHO=5PFuercRYBzupd-Zb3q8v3sQWGT2ySXodG9S5NVj7Ta+1Q@mail.gmail.com>
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

On Fri, Feb 28, 2020 at 7:20 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Feb 28, 2020 at 2:48 AM Rayagonda Kokatanur
> <rayagonda.kokatanur@broadcom.com> wrote:
> >
> > Generally i2c addr should not be greater than 10-bit. The highest 2 bits
> > are used for I2C_TEN_BIT_ADDRESS and I2C_OWN_SLAVE_ADDRESS. Need to mask
> > these flags if check slave addr valid.
> >
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > ---
> >  scripts/dtc/Makefile | 2 +-
> >  scripts/dtc/checks.c | 5 +++++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
>
> dtc changes must be submitted against upstream dtc.

Please let me know link to clone the upstream dtc branch.
>
>
> > diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> > index 3acbb410904c..c5e8d6a9e73c 100644
> > --- a/scripts/dtc/Makefile
> > +++ b/scripts/dtc/Makefile
> > @@ -9,7 +9,7 @@ dtc-objs        := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
> >  dtc-objs       += dtc-lexer.lex.o dtc-parser.tab.o
> >
> >  # Source files need to get at the userspace version of libfdt_env.h to compile
> > -HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt
> > +HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt -I$(srctree)/tools/include
> >
> >  ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
> >  ifneq ($(CHECK_DTBS),)
> > diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> > index 756f0fa9203f..17c9ed4137b5 100644
> > --- a/scripts/dtc/checks.c
> > +++ b/scripts/dtc/checks.c
> > @@ -3,6 +3,7 @@
> >   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2007.
> >   */
> >
> > +#include <linux/bits.h>
>
> Not a UAPI header not that that would be much better as dtc also builds on Mac.
>
> >  #include "dtc.h"
> >  #include "srcpos.h"
> >
> > @@ -17,6 +18,9 @@
> >  #define TRACE(c, fmt, ...)     do { } while (0)
> >  #endif
> >
> > +#define I2C_TEN_BIT_ADDRESS    BIT(31)
> > +#define I2C_OWN_SLAVE_ADDRESS  BIT(30)
> > +
> >  enum checkstatus {
> >         UNCHECKED = 0,
> >         PREREQ,
> > @@ -1048,6 +1052,7 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
> >
> >         for (len = prop->val.len; len > 0; len -= 4) {
> >                 reg = fdt32_to_cpu(*(cells++));
> > +               reg &= ~(I2C_OWN_SLAVE_ADDRESS | I2C_TEN_BIT_ADDRESS);
>
> I'd just mask the top byte so we don't have to update on the next flag we add.
Do you mean something like this, shown below ?
reg &= 0xFFFF_FC000;

>
> Rob
