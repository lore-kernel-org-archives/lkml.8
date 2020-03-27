Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAED2C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B645720675
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv53Tbm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgC0LPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:15:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42621 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgC0LPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:15:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id e1so3326112plt.9;
        Fri, 27 Mar 2020 04:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uw+JRvQxVmOKT1EAzd0lLPvYRpQZw6+NCKGgay1n9fs=;
        b=Bv53Tbm6CkCl0KeoHcAg2ubF7CQILkzuswIAOAmpam0jucd046jXYVrwPS2DfhfHE6
         M/y4LD1eNX18SllZk4d2a7uGY/bdcLXKVHWWIAr5tAwXCEfuDMhm00SuToz04MSCZlcs
         gIxUNd/0lE9OR0EVXi8VSDsIwsOTsnOiQ9KJlLaE1KVt9FCzZ2jToIAUc+AThodgaHXF
         eyGPoYk+xN45TzZ3YYzhtI/6hw8WQrBMWe9dKMz1M+rL0g9ITkkCPszQA2FDE+uuwvy5
         b8/436i5vnpo3qlYmab7CRP64KaN4r/S9NGt/Q1YsFKkQO5UHBwdFFBkAJ6Sytt1NAV6
         1CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uw+JRvQxVmOKT1EAzd0lLPvYRpQZw6+NCKGgay1n9fs=;
        b=N/d+7lVwSkMorjkgnwN2giUAbRL25RKuhrxY/wtftqkJ7gzbDoN3eNqShjB1kgIaMb
         Ju+7aB+IeWNPATbrdaqIFwi4AMKNL2sTT+Tf5asBfSv1LEZovT+buIkWpqPFO448IcUO
         V0HcWdLWCBH0tFAGSJzUsBHkajRQtuRaWGFkMfmQHUm4TpAwYzByws7FxS7SlMC3CDyN
         Bcxus1Ki4rtjo4T8JnIEbTtVhWB+puHNHF91CTTEm+L6DFEN7oKgbxn+GTEYaP7MY195
         n4Pu8idk+k7OT7Q6xOkYIAQmKRxruz5i8p9Zxr9m6/PJhlJoav8cn+fHopmtWrdbWwa3
         tgig==
X-Gm-Message-State: ANhLgQ1u57VZaeNNv0gDXqG3CZZYNy1sivpMOnSLZk5TOmJX0fjN+D2n
        mI7lZuCOcumk2kVzxPyOl2k9Q/UNATpZGh9el9Q=
X-Google-Smtp-Source: ADFU+vsN4zGhg/V1K6dB1j3pTzqSYm4SdDyPc4Gv34XkiJlnNeeWFlTejWgjfku2yneHuhSdQ06C5jvZjv8skW9799g=
X-Received: by 2002:a17:902:7c05:: with SMTP id x5mr7561558pll.255.1585307708811;
 Fri, 27 Mar 2020 04:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <dc52d6a0-12ed-a34c-01c4-0fc5ccbf7b1d@metafoo.de>
 <20200327084302.606-1-m.grzeschik@pengutronix.de> <035d6582-b513-2ebd-f755-325df52e6a10@cogentembedded.com>
In-Reply-To: <035d6582-b513-2ebd-f755-325df52e6a10@cogentembedded.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Mar 2020 13:15:01 +0200
Message-ID: <CAHp75Vfe4XK_2_hz3zbrx0s=n9VkmDynMGwWi9vY0wjgcETuYg@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: don't dequeue requests on already
 disabled endpoints
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        m.olbrich@pengutronix.de, Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:54 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 27.03.2020 11:43, Michael Grzeschik wrote:

...

> > therefor it is not necessary to run the dequeue routine.
>
>     Therefore?

Original as good on its own.

-- 
With Best Regards,
Andy Shevchenko
