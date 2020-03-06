Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A27C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E211F2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8A3yV5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCFJjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:39:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34632 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgCFJjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:39:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id t3so838035pgn.1;
        Fri, 06 Mar 2020 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b2TSqr/uhMKtbA+zXLI8hLCbfOoEw3UBdPm36dQPxYc=;
        b=b8A3yV5bxw8y5Pknd7drXx0KJ3W5zCt08RO0s1S3BMI5upnjnTCOF49ap6p1ZeKnMr
         IEhgJUOWCwKObVejxhGsextEhhXer4iI6imyJdRxR/s2Mo+bPX6RwcaFzCaHfCCxXE1L
         rtxAZa/6u8nMkBvVYktzZoKrtLwlDKgzTHQXkYnUBH6bxaizTuyhxT++N1as5OmjupkV
         q5SYgc8JIyatj8N2Wb0H2Ygt0c89vAdVLK8moZIcftbMXiIecTRNscnYQfLgDOXSpz43
         uz22r8ZUn/A2Eja8XCNM32DA8c9B/rsuPxxb3P7MGURl7Q5u2Y70kySMD+nBjh2GSh14
         1acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b2TSqr/uhMKtbA+zXLI8hLCbfOoEw3UBdPm36dQPxYc=;
        b=P5LdT57dRCqYE+3zYGwdSJ7Dn05cAUfB1C1Qm0wTWyfY8HOhxtB+b4CN9pDraZ6cuk
         l9DYYpm4mNcdgU1mVZG69INR+ybO2HR5vvxzHo+/EKxZcTNl+sJ7BPZYwDf8w4lWIAHf
         a21wZTiulsbXhh5VR7O5JUfHy6b8O3JOQf9qJnsGFMbruVmW7K+AiYzR4vZWHQA6Zp8P
         lmLTjeUzxrNuTLZMT5F81xl0Wry0iPzRG5oSEE4zd3A9vFYfAdzLNO9r+ebjpdNSc/AY
         1Zi5VFXDKeyJ7NN4OPiyraZKE5qryPG+XMbihv8rvgig1giiX+vkPTmTMLp4PrmH9Q1g
         8Zdw==
X-Gm-Message-State: ANhLgQ1Iu2OCMfEldaowuf00sa++JYQjcwtpQ32XZEWL6/D5SfTHqXbv
        Ab78rcpzDDV4GihXLosBryjI17J+0q0lKYc7eXI=
X-Google-Smtp-Source: ADFU+vt+uLkjAGLU+ffvw9ORBLIBQnPWsOsGBtbYUBLTWOqjf9fxItcQWcwQo6mwklTeFlhJh6rECMl2/wlEpOtLO70=
X-Received: by 2002:a62:f20c:: with SMTP id m12mr2943831pfh.64.1583487552331;
 Fri, 06 Mar 2020 01:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20200305214747.20908-1-j.neuschaefer@gmx.net>
In-Reply-To: <20200305214747.20908-1-j.neuschaefer@gmx.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 6 Mar 2020 11:39:04 +0200
Message-ID: <CAHp75VdsP5+CGFa+rJ4goEPP1mtmCwPQSkZJ0W78CkbigJ0tQw@mail.gmail.com>
Subject: Re: [PATCH] docs: Move Intel Many Integrated Core documentation (mic)
 under misc-devices
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linux Documentation List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 11:51 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> It doesn't need to be a top-level chapter.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b229788d425..cb2f714b3191 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8578,7 +8578,7 @@ F:        include/uapi/linux/scif_ioctl.h
>  F:     drivers/misc/mic/
>  F:     drivers/dma/mic_x100_dma.c
>  F:     drivers/dma/mic_x100_dma.h
> -F:     Documentation/mic/
> +F:     Documentation/misc-devices/mic/
>
>  INTEL PMC CORE DRIVER
>  M:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>

Had you had a chance to run parse-maintainers.pl and see if the change
is in order?
I think the order is broken and perhaps fixing it at the same time
would be nice.

--=20
With Best Regards,
Andy Shevchenko
