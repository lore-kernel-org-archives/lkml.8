Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE4F207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYgPHMZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgG1GzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgG1GzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:55:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83889C061794;
        Mon, 27 Jul 2020 23:55:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so9385299ply.11;
        Mon, 27 Jul 2020 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nC2AVRf2c1+kNdOxWVZpB9OXd75YLHJ4HOrQqIa0OVc=;
        b=ZYgPHMZNVej+YPqaDhckIlF0sY8YH1KNTSbmNvsXsJ33wj2Ir1LpEuWCUtsgB2gb/2
         5KCLHNhm1XtQ6N68wlpeUm1NM5nUCmHHJw1WN7n2Q7l7T9VlIYXzOmXiQdknm+V7nERD
         9gNgEbC9YVijfMqiM2YBr+sxUB7XzznShdouzbB8hWo6+1Ds/B+4u/z4WDS0rJLaZGbC
         slBwpk2MgidgzJLe0FPS7kbaFLthOBcz+diOLT5TauMbS/128dZzUal12x/h+HFOoZ1a
         Oj3/fpC3QAS77HSSUSdt4m5S2hLtYxdZf1vtxZpM5qAr7aWvK89dOyY3uAdJ59NVN3Ea
         dnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nC2AVRf2c1+kNdOxWVZpB9OXd75YLHJ4HOrQqIa0OVc=;
        b=rZ/jBiVHdX1A1dTyH6C5oi3Nt5AcpfWraa8qm2sylJp5e/cM4oVsSqDL0fih1FDM1F
         p26mub2fsYkjKFe01tER8FU5Op+YhZ/8HddIVfqonFmIcNQBMSGqJkw1REcli30NBL3j
         TVKDPoxIikQZww+2/gIRav3F/n3w8IX9TI5PY4Xk5Hf4YF8kIYRbAnmhtP/S0VEW9ueS
         5nMcLVogqZ+TUVeFD0wfjiWJmJOTKQa9mKlqV+yUGcSNyYRAzIfAlrKJdoe2oZ/oH456
         be7B8dYr9bVBd6b+spssi0v25dVhASPSw5ADwhgT/nv9lO/sB4l1W53Z4oJA3R1993v9
         OOGA==
X-Gm-Message-State: AOAM531VpRqQaGPQONGZVyrn5xX82bN8zwSFdoKiGf8g2mfG8Jt82bmY
        gEvpdj5e/33QkUvrC/o1p5EL6FaMSIrus8qdce4=
X-Google-Smtp-Source: ABdhPJz2NO7e90OIjomVeQ1pDB1iSPvL/HmFYDY3RstNzuc2gEMJlSF06u5fHOklEDB5BzZZsL+vFZlzB4x2kPz59rQ=
X-Received: by 2002:a17:902:8491:: with SMTP id c17mr21727415plo.262.1595919323028;
 Mon, 27 Jul 2020 23:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200727100336.32153-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAHp75VeO86j-onVJX-M7YmOZeQuX=Jx58jnT3dLkwCsBom1aTQ@mail.gmail.com> <4354752f-3e36-fbf1-a863-495aff80dacb@linux.intel.com>
In-Reply-To: <4354752f-3e36-fbf1-a863-495aff80dacb@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 09:55:06 +0300
Message-ID: <CAHp75Vdfk=oiHMD=YonmLsRkvuAOpObTG-Ry5c8kuB_25KFCjg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] phy: Add USB PHY support on Intel LGM SoC
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Felipe Balbi <balbi@kernel.org>, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 5:52 AM Ramuthevar, Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> On 27/7/2020 7:09 pm, Andy Shevchenko wrote:
> > On Mon, Jul 27, 2020 at 1:08 PM Ramuthevar,Vadivel MuruganX
> > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:

...

> >> v7:
> >>    - No Change
> >
> > I guess it's not the correct changelog entry.
> > You moved file to another subsystem, didn't you?
>
> Already added in v5 changelog, kindly please see below , Thanks!

I see. I didn't realise it was already two versions farther. Thanks!

> >> v5:
> >>    - As per Felipe and Greg's suggestion usb phy driver reviewed patches
> >>      changed the folder from drivers/usb/phy to drivers/phy



-- 
With Best Regards,
Andy Shevchenko
