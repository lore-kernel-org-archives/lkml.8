Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C08DC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E19C20674
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="nxCn1GMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCLQ7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:59:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40791 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLQ7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:59:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id e26so7151992wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9u3p6ZmBDu4sIjHctN+CfxncVqg9SYaJoyC+lPFb9Ms=;
        b=nxCn1GMrumQN8srKFBAE2N3qbzxA/NtcaO6Fn8Prh1MoClGLNmKOmVXYiBaB3s602e
         8jRx2SsGyy1HgF2JaWmpR5tjvcP9LrHbJd04GfwPIVjBVBa84eg5mNf1qBt5Yd+fjpAY
         pXmamcvkkdzpflQPqlsnYDRM5/EBrk1jog3wmNAAwDFx4EFjwQssetoQA8fb2yrPQ/43
         H2CvuYYaNNlPRSq9lfQY4YOSiRar3e0klDTqxiZBAbVpWM4+eyViY5JEixsyDeAFiGVC
         m2BAqs1ClUhW0MydXcVHqZ12NJUvuc7K/2SHNrXw9vAd0DxfLMn/8X91W0Z51c6BHhPF
         pVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9u3p6ZmBDu4sIjHctN+CfxncVqg9SYaJoyC+lPFb9Ms=;
        b=GfpaI7XE1VSzdVlHHOXw/UzMbKqFMYEQO3Kg4toMw3U6Y4L0cJvm61Inwyo4E6vmtQ
         NacCkZmYZvuKKtGk4YlN42k6wF7e0NGpMEEIvWqJUWidvO2AZ5FTx/xAnp//LCE5pY50
         b6g8Gbe537OGsjMzYXNNUzsO/wPQM4c2jYjCPu3FIRfSuhYc5rUAjBrh6lcn4dMiylec
         sbqUDcZfsFh3cFiFNI0x7142ekKow8bvOuGM1qJu+JdGNJ0Yv5OL5vywttqAB10gh0T4
         QuxcQTzvucQRXD+yaf9inIC/KDMTnvv+gpVpZ6fEgig442XL63RHuQaGQ2H20NXFD98L
         S9Vw==
X-Gm-Message-State: ANhLgQ1IvBGG3YfN25D5EbI3u+sbiqWoDXW1orxE9igD+pI+pVB4a7e5
        3ILOr56VjMZXikRtLTvaS2QZ/OJR3uKSJ7p1MnbFmG7T
X-Google-Smtp-Source: ADFU+vvF1OEjUrxCcQCohiqEKXY+aTMPA4Ys3tQ+COKaT2An0jT2NmD917DJ1THflYn43DuAfSnhdWXjrJZwVmsS6K8=
X-Received: by 2002:a05:600c:278a:: with SMTP id l10mr5450191wma.45.1584032350180;
 Thu, 12 Mar 2020 09:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU0qVnCkWpG_NKNQTdYf5LJpRrgOeWX0xH=GgavKJ1QNwg@mail.gmail.com>
 <0c3c16c770d21e5ad2276c83feb27ce4@kernel.org>
In-Reply-To: <0c3c16c770d21e5ad2276c83feb27ce4@kernel.org>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 12 Mar 2020 09:58:57 -0700
Message-ID: <CAJ+vNU0VEgO1gWK11Wi0RPwU95EsqkKZSH=EMVhZoQUxikLOJg@mail.gmail.com>
Subject: Re: CN80xx (octeontx/thunderx) breakage from f2d8340
To:     Marc Zyngier <maz@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Sunil Goutham <sgoutham@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        Robert Richter <rrichter@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 1:55 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Tim,
>
> On 2020-03-11 20:17, Tim Harvey wrote:
> > Marc,
> >
> > Im seeing a failure to boot on an octeontx CN80xx (thunderx) due to
> > f2d8340 ("irqchip/gic-v3: Add GICv4.1 VPEID size discovery"). I'm not
> > sure if something is hanging, I just get no console output from the
> > kernel.
>
> That's odd. It probably means that a SError has been taken to EL3,
> and the firmware is not equipped to deal with it. Great stuff!
>
> > Is there perhaps something in the dt that requires change? The
> > board/dts I'm using is:
> > https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/gw6404-linux.dts
> > https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/gw640x-linux.dtsi
> > https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/cn81xx-linux.dtsi
> >
> > Any ideas? I've cc'd the Cavium/Marvell folk to see if they know
> > what's up or can reproduce on some of their hardware.
>
> This is most probably Cavium erratum 38539. Please give [1] a go and
> let me know whether it helps by replying to the patch.
>
>
> [1] https://lore.kernel.org/lkml/20200311115649.26060-1-maz@kernel.org/

Marc,

Yup, this was it! We need to make sure this gets merged into 5.6. I
didn't have the original patch but attempted to reply via mailto:
link.

Best regards,

Tim
