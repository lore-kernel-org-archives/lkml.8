Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7290C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B8A2074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="U/7D27KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDHHFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:05:47 -0400
Received: from mout.web.de ([212.227.15.14]:58329 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgDHHFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586329531;
        bh=JXnwcpm+IXspFjmxjaHwilFO2kCKNHmVXgBOCZO6Y94=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=U/7D27KX344Go1qHiv6a0Jlh+j7u6sYTWi5uOKCi1xsovTibwLp19w7/vzNTua7Oa
         c/LfEb90w88WqL6vXfJm62Mbd7tLG6RV6XMvVstssiZLp4OpXqpMxB+g+tF/mkP2bF
         N1HJhivUvWBSQyXvhQpvDtoLnJm0bDyUr7VmMZr0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.170.28]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lm4jx-1imjtK2yRN-00ZcjE; Wed, 08
 Apr 2020 09:05:31 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] usb: host: ehci-tegra: Remove superfluous dev_err()
 message
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
Message-ID: <23c90343-3398-a475-650e-a7bae9aa5675@web.de>
Date:   Wed, 8 Apr 2020 09:05:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QdhC+v3KdhI5Epb+HzVc72ubblTG/SZQfYsP29hy4blct2g7jth
 sGTFU94jAJlxJzQWVKA6EE97AE6dXymueYmQFBPfdzWsQjPVVF3A+VeuqEEPZpZLvV6RaWh
 sUBxGxJyHXQr91M1bWpAonbAu7ahdWwtgRjyLRMA3+gCt6HnafRZ/LWFd2SD81Ljuv/wE7W
 kMMbuvNd2fGZFjJyK9SDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MI9mgsTiIww=:dYykbTzN8Zy+OSeDjkltYa
 Z1S5ZA86ojF8aOMR56WdBiZg1+mgwymyGF5gYdc5EQVA9slkIs9mqtZNfhpF4TIWNI9BLLPCE
 jWWZAFSTB1wDNa3StbuUyUKfwgyVVBJ3NCt3Fu3zRYBMyaDRJVaWbepjy8i7OVeqMz5bUDv2T
 GdLcDX5rh2QLJQMU4NgcbZmhB1ygrXc0dAhwwe8BBpmxaVf92S4RrnlfSBKnrBjwV4LgFCGO4
 SkgIj2SYQtDYsTXM+T3LrlhSOltobqH79lKsigDY2fika6jHLYUiGsxRt0QLSWAwhlK2iBF+R
 0Q3ezZi8Zsd+b1TDPA1j6xybyQxpQ9XRgV59x6KIDmsbY4EMZZGSlJdnGQpIYejM+5kDphLgs
 cqbRxMkRG8PpG71e7UIxH9iv1hvH01zY2EOjMBv57gxV2i9MTEqu/VAWRaZ+vCIfiJivDfki2
 NSNMvvbBZ78/+72DbfoRTos/jSVn1rkAIqT+nFrH3oVNksP3R75ujsP8kttaYHMicil4wBDmw
 KQ9Ig5kdhrEtoXlw8DRKTZuDOVxzJgleqJcN8XVPnCeqaKm1/fAjHllSD8TjmgLTobvafZp79
 +PPY+3U+QxL7duZuVIzIk9+OYczqDqgVnLF6EWitTruLeiNheqrgXYlZ0nJFLyJevN0FwrbvB
 zXT4heeO1oXIesgrhrdttWYPll0+Dw0q9vrlD0D7UP+YqGSr9cp2irpWImgqXzTi5hEJslXUQ
 H9Iu+pUbaW3tN1xzbjV5SZkoBcfe/waWSnaVhG3Jen+e7TMVYzhu8g1DhArz7DkKsZlj95VZM
 S1gxhd/A+NdMEr+h6IOoDh6L7qH+vFnyhm4UPDJmns9u/hmDu3CeIj9/l9xE29gACT7OJdw+T
 lkqDVo0SU5RiK1VIrJXewwK4gkJVvPGeHPnCRNSHYTapKrj7T9gUHh3OJeiP0F//l000MFgUH
 BktFKLi6rBUeIwznZQw+e8hbn4Mj4UIZxXDudKASWmWG3R6L6/DviY4FijvCZwzwI2HyMz8Pk
 IHYLAcOvYBVft9UEI4On0atD0ujZcwIoJ1s1sLsSaiw/Hl2nbXF+KhXRZg69V8c4XhBFvKFO6
 Gk0tMUQM7/v28H6+7zGN/oJozSjVdVKSr1GLSOYvi2GHGSw76Qj/RBIhfSwUQ5EadFLXA0hq8
 QCWJyPzvC5E3mduqVCxwycaUUhPvpzSBYMhcyQeOEVaPmIz4xEbBqaAjXonpRgqV0AI6/Oq5t
 UcNI8r5lqJRKuw17Z
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The platform_get_irq() can print error message,so remove the redundant
> dev_err() here.

I suggest to adjust the commit message.

* How do you think about to use the text =E2=80=9Cusb: host: ehci-tegra:
  Remove an error message in tegra_ehci_probe()=E2=80=9D as the commit sub=
ject?

* Would a wording like the following be nicer?

  The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already=
.
  Thus remove a redundant message for the exception handling in the
  calling function.


=E2=80=A6
> +++ b/drivers/usb/host/ehci-tegra.c
> @@ -480,7 +480,6 @@ static int tegra_ehci_probe(struct platform_device *=
pdev)
>
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (!irq) {
> -		dev_err(&pdev->dev, "Failed to get IRQ\n");
>  		err =3D -ENODEV;
>  		goto cleanup_phy;

I find another implementation detail questionable here.
The software documentation is providing the following information
for the used programming interface.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/base/platform.c?id=3Df5e94d10e4c468357019e5c28d48499f677b284f#n221
https://elixir.bootlin.com/linux/v5.6.2/source/drivers/base/platform.c#L20=
2

=E2=80=9C=E2=80=A6
 * Return: IRQ number on success, negative error number on failure.
=E2=80=A6=E2=80=9D

Would you like to reconsider the shown condition check?

Regards,
Markus
