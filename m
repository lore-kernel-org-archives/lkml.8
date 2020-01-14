Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AABC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892B0207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZsk/3S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgANHwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:52:00 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42829 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANHv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:51:56 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so11645650qtq.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 23:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhT+e3kmyPDqgmQXDlJ4XsnZWAFBKtN4akZdNapdz4g=;
        b=WZsk/3S904U6Amhzam+HkGVGpD9ofxhA0809RiDrT4fVh1PaMXFYcK96PQcfeyPXZl
         FlPKJH9jlqc5Ygh1B+1E3BbPSYyZiE9w4na87cGBZfI0kChGFZNae2WE61YWxiuqQeTN
         zuAGmr5K/3zvgCUsMOh1QPxfKAKIsTYj2kOwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhT+e3kmyPDqgmQXDlJ4XsnZWAFBKtN4akZdNapdz4g=;
        b=hpfP0l8Ithd1juClecBZOcZ73K3BVIgMGGHkhbwoawH6DO2tWJj8n2rD55A5by6T+G
         VJ0H5EWnsu7uTUcyWIIrV4Dnkq1w5SIJi2nGY7RqbM/xzk5Gh19tgxsl5jEJTvQbA+q4
         T6/n2pFf5ERs7yvggX1RKoAI6A7Ta31d2TGEO7iWm013Xz5Kqtg591iwfM6+yISr8DBn
         fIi3uVV03TjA57EOXgEpBBYBLF/gtGmjnbHHE+lf7zAqSpPdnlS/niUul7il7VoTdqHa
         AASOKLsveeiLC8lq4RpYZyYUZdOdJ/UI+HxQEr7jyhnoZycjesLxCMZkUNZu9uiYxfNf
         xeiA==
X-Gm-Message-State: APjAAAW17vocLTjOYarbAS8jqNt/sa0Dqq3htTUi0LZEwla63gAywdeG
        C01/IayMSuE/wx8xmTAFrahDHq00awKH6poVBWvjBK+k534=
X-Google-Smtp-Source: APXvYqwhQYF/GKLD9HKWK24cEOdmxhckIK4Lacr+f3TBQEpZsO2ajEnxpItfNVrVcpPo1oY6aK0PPcZ8WZLG9FomFVA=
X-Received: by 2002:aed:29e1:: with SMTP id o88mr2577201qtd.182.1578988313958;
 Mon, 13 Jan 2020 23:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20200114044127.20085-1-kai.heng.feng@canonical.com>
In-Reply-To: <20200114044127.20085-1-kai.heng.feng@canonical.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 13 Jan 2020 23:51:42 -0800
Message-ID: <CACeCKacQpDsptRi6AZhuFYg2c87-bW0KS6vy=CacB8+j+6YBXA@mail.gmail.com>
Subject: Re: [PATCH] r8152: Add MAC passthrough support to new device
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     David Miller <davem@davemloft.net>,
        Hayes Wang <hayeswang@realtek.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Grant Grundler <grundler@chromium.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        David Chen <david.chen7@dell.com>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 8:41 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Device 0xa387 also supports MAC passthrough, therefore add it to the
> whitelst.
>
> BugLink: https://bugs.launchpad.net/bugs/1827961/comments/30
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/usb/r8152.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index c5ebf35d2488..42dcf1442cc0 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -6657,7 +6657,8 @@ static int rtl8152_probe(struct usb_interface *intf,
>         }
>
>         if (le16_to_cpu(udev->descriptor.idVendor) == VENDOR_ID_LENOVO &&
> -           le16_to_cpu(udev->descriptor.idProduct) == 0x3082)
> +           (le16_to_cpu(udev->descriptor.idProduct) == 0x3082 ||
> +            le16_to_cpu(udev->descriptor.idProduct) == 0xa387))
Perhaps we can try to use #define's for these vendor IDs (like
https://github.com/torvalds/linux/blob/master/drivers/net/usb/r8152.c#L680)
?

>                 set_bit(LENOVO_MACPASSTHRU, &tp->flags);
>
>         if (le16_to_cpu(udev->descriptor.bcdDevice) == 0x3011 && udev->serial &&
> --
> 2.17.1
>
