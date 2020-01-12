Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C833C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 10:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0733A206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 10:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Z6i8AbYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732568AbgALKRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 05:17:20 -0500
Received: from mout.web.de ([212.227.15.14]:45441 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732557AbgALKRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 05:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578824230;
        bh=5i96d9WBH6Yxu0PP+hyCQbbIFIlqnaw0r9G2sPEDDhw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Z6i8AbYB65Cd9EpS6dkzLU92Yeimce0XscMnPMPLBn13rpoMhu64cxwNMftJqGtll
         Lj9TlWv/O6b5oqmHZOMPqOGoNWhH82SPObQNyLZys8JAOqNjkDsZsJB+WEpqwCYjT5
         dxBs5qtWbRJcauFg1eJazYOimQ4+zFD2PCQqSdh0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.23] ([89.12.27.144]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbftD-1jVwWj2ODr-00lEAA; Sun, 12
 Jan 2020 11:17:10 +0100
Subject: Re: [PATCH v2 0/5] mfd: RK8xx tidyup
To:     Robin Murphy <robin.murphy@arm.com>, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org
References: <cover.1578789410.git.robin.murphy@arm.com>
From:   Soeren Moch <smoch@web.de>
Message-ID: <fafe31fa-8a26-6993-2c78-e1cc06ecc05a@web.de>
Date:   Sun, 12 Jan 2020 11:17:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cover.1578789410.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Provags-ID: V03:K1:PlqFJBikMPfIGJPHDPMU3lWulN2oviAdnx+7/MmzajGV0k3IQkh
 CoAn8J87rJmjfGklRZjOfZciV9Iy2koLfmlcvEB151pahokN9/QBja+GAHWpeoJfudHpymx
 r3WUN5NrackIpyDo4CNQ8Dla61rz/2ZJPUtFStFB8wIpqw0AIOBnlNUaucUydS588FLneMn
 DNuwb1fh5fAAdgKlG1YuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Q/z5ypQwFw=:VBZE/RZssMZIOWKI4nrZNh
 I4vEsojy2gAu2fCLj+xW7+HW0jlKwprN90EIQjLoJDFDoPuBr6VUIJuTBjej+9n27E0JeoVbH
 3YuI8CzCjserm0NpvO7pGoqfP5l5gDu4gasHLnR+qvdHQoNu+PV6keDfAMLToo4Gn0xzAqKws
 3Zxna9FqYnvHcNtUoDIj0/IKZWobY0JsPNoHiPl2V9+3k2/+vgxtBNyS0M6whYjHP2enKZIRN
 G3+vdkPYwwSbey8wMGBP7hLVHv4+uchTWR3k39hAPFNCBVemqk+TAI9/I1BuDwk8EAw3GR36u
 4wNM0xNWU96b1fJyPut9IXXJUAToow3K9PZ+455hime9iQCt5SkbwfSvxitm1zgIHledZ7Zvl
 /CciWcxluE/FTZKkhjSyEa0DnO3WKdWx24fwqYuE6bWK7p/ligXcLtqewJg4cKq4dSZKu+Obg
 wTBAmwbWTU0h+vFi3oCakdScw73shye5wOIb+SoSyWcWZsjvPHFOKUQxq0QYJGhvX2ZgbfrhA
 4WKUJiyxuM1sd6PBvb9oCOTPSG11VlJaFUbagkQdpGb1EwYMJVMj6VfPkP7dKVGi5DL1NJSjB
 ZDahO5xqYBAWjotC9fDtx8KxThyFPUfmBoiGLVhnYmTeIJQK1D3KGE5pyyKGg+wJm7DjAIK6o
 Q1kI2uayBQmKkXMOTEWQVUJQBJExFHigcNEbpMgNaaW1aaPGLZBxiEd/pxU3UEhrsTJ2FXwiB
 TJ+R8mo2I34NICONi3bzdy2BIXciEwALd9Mp9OHW4CHz+VLC1oRGQquB6l+RWn+acLf3QRk3a
 sLgAAYSRq1c4v722l6Xi6xzzFeX5SZJcSv6nmmHeCqtpDYl3yiZDaGY9vdyJ7eDJTiItIPgJ6
 I8SXsde3X5R+UDeMppK/GsETwywA/2MMwWhH8IDP5vc3LunzyvsFmYo/b79ZK1NB/4HqOnZ4r
 LI3iVOjad2rOc7/3LcvvJFFRNUWn/Zlh/XpO6V5+VXjWUOA9TMWRe4NenvEyXBdDFleHhtsSZ
 lKKeCze4CK29CLmUm70sDoXNzUMhgMcljNoqRTdRDaYouLdsE6JpCuy196MksEADKhfZvbAD5
 /p58zLnyQCKHusb+pSfMZF6WIlalrc5u/TG/f2AuicgvA/zqTjThhC61L7GCejwWMKO//DIxx
 UXVWsCf2mW0esIlv/z291GU6DRv4D36MD6ZrW0orCiEfpJXGQnkUrAREim/U6BGZIdQGMCGQ/
 o6LrMb4JG6HjEh4kYMCPASpv4YqMHB9m5IU1VuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.20 02:54, Robin Murphy wrote:
> Hi all,
>
> Here's a second crack at my RK805-inspired cleanup. There was a bit
> of debate around v1[1], but it seems like we're now all happy that this
> is a reasonable way to go. For clarity I decided to include Soeren's
> patch as #1/5, but since I've rewritten most of my patches I've not
> included the tested-by tags.
I re-tested this series on a RockPro64 board with RK808 PMIC.

Tested-by: Soeren Moch <smoch@web.de>

Regards,
Soeren
>
> Robin.
>
> [1] https://lore.kernel.org/lkml/cover.1575932654.git.robin.murphy@arm.com/
>
> Robin Murphy (4):
>   mfd: rk808: Ensure suspend/resume hooks always work
>   mfd: rk808: Stop using syscore ops
>   mfd: rk808: Reduce shutdown duplication
>   mfd: rk808: Convert RK805 to shutdown/suspend hooks
>
> Soeren Moch (1):
>   mfd: rk808: Always use poweroff when requested
>
>  drivers/mfd/rk808.c       | 139 +++++++++++++-------------------------
>  include/linux/mfd/rk808.h |   2 -
>  2 files changed, 48 insertions(+), 93 deletions(-)
>

