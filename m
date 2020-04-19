Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA64C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 10:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E260D21974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 10:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="E12HXv0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgDSK4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 06:56:30 -0400
Received: from mout.web.de ([217.72.192.78]:51859 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgDSK43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 06:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587293780;
        bh=sQhtyMTPvUOXCopFv0Hpe7ga6E4Yxe2mMVPy71UEYxs=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=E12HXv0MeU+dx2CSQ85YH/Q9cLG774yfZ0VnD/xuJp0Yi5Q7mYr/aUcvdh+sigMrM
         8fL3A2LPXGUN8XReakQAmqHSzqSN6Ouwh79Npu6kvrLiC7ZPbqdw/hwHnuAFZ9WErA
         3bR3yV2bmxZ4B+2m5liRLC82x+J45YlIwp296uTI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.85.208]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFcE5-1jTfzl1GWz-00EbHM; Sun, 19
 Apr 2020 12:56:20 +0200
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: asic3: Delete superfluous error message in
 asic3_probe()
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cae9860e-87d5-5a34-ce6e-f61d1429d187@web.de>
Date:   Sun, 19 Apr 2020 12:56:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:Y38Zhjlm2LDbr0vWEo/CZ7RJ9RfuWq8fkj9ONkFVmQRwqOI3oda
 xXLQrUYqjdmjtdzPfOIRQKSTYmBV4q0yghdRZk7aRJp3pV/jnje3HuTN6yA/nQ1v/tcsx9F
 9WfZTeMtfZti8VAXuke4w6L3srUngI6b6ed6yF+P38tkZcOrvnxYnYwnDBWlSGSGF6X6j2Z
 naGvOoRho7pQZI/de083Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2WCwUSbal60=:pc2niHobvQHBXtgRJs0wNr
 XcDLyVMwsMlEVTUQHSuin59jDXEQWdS/UJAvi0hg9y+Jswggur2dZrQg3mAB9j9mMZuukKRWa
 jYHwyxvUkkJ8h5KaDtycqHY8LU269i6slKdxGpP0n0qnUxILdF/aNmE/tXbTBjJXWqBmDCLgc
 F/cLkyMz8pQt7mj6VzcFPs94Yca5GSG2F2sK7jO1dOOxYutoWdS2jJt1V8IJxz/onjuvuqL+6
 fJw99k0rwERs3zLVfDsk5Mj+3x1vMB8CGRZPG/6LuLXKLTjzU+VTJiRg2dW+8aOX2njpgSM4s
 6wPnpWi9hMODWMm57geMvJW1M/rpKkha7kb2buJVRZzjZiu9ynEk+URUzlyuvt6L5dGunl+rY
 sN6XLdmU0tYBGlO+0ZUUYODx9F6SnpRKYvVznvmKyE7ol1eCD4fyrWW8dy8sI20zl+vJG9Igq
 3OWO5Sg0wna+Z2w4hyEA2tT8VwINHCCmSLtEbm6gdnBML9DExi1PaakFcKPVFfawUDW3mh6sK
 IumQ++Y2kjfHDatRqcJ13i9R1SaYXLdSOv7/c6rvt0K2PXbdLaXzH5mX/xGdhLjZndZ8J/0uQ
 DYJL6USfOOZgDzcYMKDMiZwwLjbRJB9XSUI9kmhGeyljX2TsCx2wQ+7GHrirBIAdenm7iTAxI
 BverrUCvuF23BAs30fdT4wBA5X+ZWWiOizj9LEt2fxoUKm/zMbn+6bU1BzSFzdOViRqjpFVtF
 nWA+IjEbzfqlZxH7aMPVKwLeJR60Ebv0gJh4QFT0VTBnul85VbgvBmymlhnA8l2jrCYB/1Zhp
 BflPYNyGR5MLU7YjjilldA7DzU9lD6aFzLg8uOMRZUuLj1V9e+U6YohBI5bTTiDkOZ91wJNBy
 noAvIofQMjpJuzfbmju8MroBFGlcPNLH5mq4X7dCvJoLNSBH2prAptD9broSB55FsB5gPIO6g
 EvdxY/Q1wIFnLgIxJPIZOwLk3+GpUgXF8GG2apCnE4+0PY9voe9SOAv6BIG7AoMLFUlJYCSYw
 Y46u2kNGCKJHnR2IGGEgXJv9+Mkzt8UjpTZYDzb/ZkQJR6SoV6NX6q6HXXcBcSKABLoNZyKCn
 vy4c2tUueJ/6zvMKBMYfk+onBw6PCJXG9vkDOywQx42AXRCJBgmKlN0H7p6ybQlj+kBx4KHmI
 WnGn9sW70OyHYz/g0s7nM5P9rKghUolK73vF41FjEczzEbYLJZnTPgCT5H8pJ60rvyZ1ztXpt
 ZO2Uq4mCctuHiX+tT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the function asic3_probe(), when get irq failed, the function
> asic3_irq_probe() can called platform_get_irq(), which logs an
> error message, so remove redundant message here.

I suggest to improve this change description.

Regards,
Markus
