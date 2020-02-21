Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CF8C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C782073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zz+PDM0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgBUP16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:27:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46927 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgBUP15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:27:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id k29so1365190pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xI8RnNckMhOpgc8JZHRhZjsgqcl40BWt6G95H+aWOoU=;
        b=Zz+PDM0K7Qrf5SV0dWyBiTayeEubbX43OPijG9fKgBCAnj+8u+NNASe79oNoj7j7ud
         F4Fya9QZzU6D/qa7G+AIGgm0LEpEMKHPJBnjGo/Edprf2V1gcUWbGQJfLpN+YCuGWisj
         t0cwdKVOoSdPz3NNHCAga1Lh6xVqx76AJcYTg44CxEDYkePVaVTpjOTjlFFq1FFgEusZ
         HzuXc92uRjyBtXfhyavSuzbr+cr9fZTzPxcBvbElCc7JydTDszeg7H9Vq+/IWypdROQ+
         QFycdBBeJWxdj0hTHa+M6VIaknIj9rlvTOsOmSE6lVlvUFlnO+7msz5q4rBAgChcyQif
         F+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xI8RnNckMhOpgc8JZHRhZjsgqcl40BWt6G95H+aWOoU=;
        b=M6ow7lxxyMtclWsyDTwGXlAJ/hpPCaosYBHC/hjUKr2J9jK70ToT3D8611X4xp1+4q
         eEKjRInlDU0RWiaKXxxAuyp2vzwUK8GIQXRDP3sAsYraGD4r0Y8QSMZQcMwVHWxreFWN
         US26a2DuElfcSrOT77N4OItaH+uFOpy9TaZ1+RHju43NxVYpE2xtZdAdmXI+nAnyQyvo
         2Rrm1EyhWJxrn1oXuXLh2U8jUO8LaR6nBMZizBml3mM433iSs21ikRAIZjUu3QlXTUCa
         nrcdDDxf/wqLzq9tCjvyJTf0TVA1exyaQOdlLR8kOUzebRAPkrYaGTP2xK2/mdbpKfZm
         2gUw==
X-Gm-Message-State: APjAAAVxY9AkIGzBMKpDiverEhCC5I60Tz27V/yt3Ixe7iLoRsYkDUn8
        lhbCQAVHGAQKQVnXR0sSkr5vuAFuuWiOCUhcdVI=
X-Google-Smtp-Source: APXvYqwK/vdKqMPHAvQp8kKEIM6NKGTpe7j8v8tUzk3A6xy2i23JvEQjY6Z74esd92IbMn0SfVYVmH6OibB26lSnjoI=
X-Received: by 2002:a62:1a09:: with SMTP id a9mr38036828pfa.64.1582298876791;
 Fri, 21 Feb 2020 07:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20200221085723.42469-1-andriy.shevchenko@linux.intel.com> <20200221145141.pchim24oht7nxfir@pengutronix.de>
In-Reply-To: <20200221145141.pchim24oht7nxfir@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Feb 2020 17:27:49 +0200
Message-ID: <CAHp75VfR+X6Mw8ywKNW5mTomzmuHSM8ecQUhxtM=LUkWaSe9CA@mail.gmail.com>
Subject: Re: [PATCH v1] lib/vsprintf: update comment about simple_strto<foo>() functions
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 4:54 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Feb 21, 2020 at 10:57:23AM +0200, Andy Shevchenko wrote:
> > The commit 885e68e8b7b1 ("kernel.h: update comment about simple_strto<f=
oo>()
> > functions") updated a comment regard to simple_strto<foo>() functions, =
but
> > missed similar change in the vsprintf.c module.
> >
> > Update comments in vsprintf.c as well for simple_strto<foo>() functions=
.

...

> > - * This function is obsolete. Please use kstrtoull instead.
> > + * This function has caveats. Please use kstrtoull instead.

> I wonder if we instead want to create a set of functions that is
> versatile enough to cover kstrtoull and simple_strtoull. i.e. fix the
> rounding problems (that are the caveats, right?) and as calling
> convention use an errorvalued int return + an output-parameter of the
> corresponding type.

It wouldn't be possible to apply same rules to both. They both are
part of existing ABI.

--=20
With Best Regards,
Andy Shevchenko
