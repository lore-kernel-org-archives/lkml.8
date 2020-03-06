Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D47BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A502051A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVkfhhfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCFRRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:17:55 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55051 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgCFRRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:17:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id np16so1319819pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PqoNxF7YSq276eb0T6mYjC4MPZB53ux70sz8XMDxMWk=;
        b=mVkfhhfUuFheVuWJ0iAe2Ivg9al6M3WovWk79tXXnm/dD57dm/XXH8HCfENjuK19oF
         hDBdfbEqKasrEkZELvrkFAhM2OJcVmjiLuiWdu64TKgdd7M45nqwv19cdvBAniP5Wi1X
         a4VSM/uaqN995/JTm1WonY0Y1KkLdhRAJQP4YBuqBTSTMYoTaE5wQTyoXDVFPVHTelgj
         9KNBqhseYChMGMmDjNXtWjIxuYZuIWal2hy2QgOZZlZUug167egJ+2SxC21fArW3B130
         0vTOeD1FSnQiX+LrmJT1AskZ6BAQqghsjLt0RlKDrYvb5QGridMOWkaYs1dmbhDBNszO
         0eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PqoNxF7YSq276eb0T6mYjC4MPZB53ux70sz8XMDxMWk=;
        b=S5m4rnghEbCBKrlXm5nY4lDpRex4dusxbnIRSQ4ZrSAD7ONiUkRS32RCyJH5tu5oZx
         +9O+gfkEPB39oFOnfQJrLo5vy0NOURUJ1Wl5cMBKuHx17GS9b9T3x8sl9bfAAJj0s3Lf
         zqEfHc1sBc2dBBgIF73mUEUAguEOQUbIymLvlZfbIl+JoSfsE9RCIKKyNGnrPVRD9+6R
         WlR8dPWVAZUNvYb1rq6oUS2T0u7eB5LakKEciYHNcDQHd2xxHUwys5S1uBYcJ6q2eH3E
         rbdxrz5mmzzC89AB7SNVMal8Z8iXAPiXzwxSi7MoHcrDm+VtRsHkdyaUFPZhPSAUkwln
         K6cw==
X-Gm-Message-State: ANhLgQ1gYfO5TPOxaR9+2WZ0v1ixDtHSpSM01/R5C8M21JI9jUDwtAU0
        5DAUfQSOj5nvIiv3gCQvUqp9mmKrdQ==
X-Google-Smtp-Source: ADFU+vs9n504icpcgBRWS8dnnvqO26KvHaArPJDCaoPpwfCavpuYcrvN3HP5MAoT5BX8aEvuS8C0VQ==
X-Received: by 2002:a17:90a:2370:: with SMTP id f103mr4437987pje.187.1583515071837;
        Fri, 06 Mar 2020 09:17:51 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6493:b6ea:b913:73f:c15a:6595])
        by smtp.gmail.com with ESMTPSA id j12sm10349346pjd.4.2020.03.06.09.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Mar 2020 09:17:51 -0800 (PST)
Date:   Fri, 6 Mar 2020 22:47:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Daniele Palmas <dnlplm@gmail.com>
Cc:     David Miller <davem@davemloft.net>, kuba@kernel.org,
        bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvalo@codeaurora.org
Subject: Re: [PATCH v2 0/2] Migrate QRTR Nameservice to Kernel
Message-ID: <20200306171742.GA14558@Mani-XPS-13-9360>
References: <20200220151327.4823-1-manivannan.sadhasivam@linaro.org>
 <CAGRyCJGMxMO-8b3QniJP0XVgTT4zxSd=pm_O=4T5N3f3H3aM2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRyCJGMxMO-8b3QniJP0XVgTT4zxSd=pm_O=4T5N3f3H3aM2w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 06, 2020 at 05:18:01PM +0100, Daniele Palmas wrote:
> Hello Mani,
> 
> Il giorno gio 20 feb 2020 alle ore 16:15 Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> ha scritto:
> >
> > Hello,
> >
> > This patchset migrates the Qualcomm IPC Router (QRTR) Nameservice from userspace
> > to kernel under net/qrtr.
> >
> 
> I saw those and the MHI driver related patches, thanks for doing them.
> 
> Are you going to submit also the controller and device (uci, netdev)
> drivers for SDX55 modem?
> 

This is certainly on the TODO list but there is no fixed timeline. Current
patchset focuses QCA6390 only, which does not need these drivers. So maybe
sometime later, we can expect these drivers to get upstreamed.

Thanks,
Mani

> Thanks,
> Daniele
> 
> > The userspace implementation of it can be found here:
> > https://github.com/andersson/qrtr/blob/master/src/ns.c
> >
> > This change is required for enabling the WiFi functionality of some Qualcomm
> > WLAN devices using ATH11K without any dependency on a userspace daemon. Since
> > the QRTR NS is not usually packed in most of the distros, users need to clone,
> > build and install it to get the WiFi working. It will become a hassle when the
> > user doesn't have any other source of network connectivity.
> >
> > The original userspace code is published under BSD3 license. For migrating it
> > to Linux kernel, I have adapted Dual BSD/GPL license.
> >
> > This patchset has been verified on Dragonboard410c and Intel NUC with QCA6390
> > WLAN device.
> >
> > Thanks,
> > Mani
> >
> > Changes in v2:
> >
> > * Sorted the local variables in reverse XMAS tree order
> >
> > Manivannan Sadhasivam (2):
> >   net: qrtr: Migrate nameservice to kernel from userspace
> >   net: qrtr: Fix the local node ID as 1
> >
> >  net/qrtr/Makefile |   2 +-
> >  net/qrtr/ns.c     | 751 ++++++++++++++++++++++++++++++++++++++++++++++
> >  net/qrtr/qrtr.c   |  51 +---
> >  net/qrtr/qrtr.h   |   4 +
> >  4 files changed, 767 insertions(+), 41 deletions(-)
> >  create mode 100644 net/qrtr/ns.c
> >
> > --
> > 2.17.1
> >
