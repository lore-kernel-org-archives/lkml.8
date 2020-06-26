Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04E3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C642070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgFZOkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:40:32 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47483 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFZOkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:40:31 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MlNYj-1j8NNI3jKv-00ljnc for <linux-kernel@vger.kernel.org>; Fri, 26 Jun
 2020 16:40:30 +0200
Received: by mail-qk1-f174.google.com with SMTP id f18so8979045qkh.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:40:29 -0700 (PDT)
X-Gm-Message-State: AOAM531EEdAruZIdBhHMACbfbFuS/r5nlUW5rLv0bN9HtNhhvfIZl2Hw
        8sr5IS4vAeYtO/cQo89whn/Ul885q6OC5dkncZM=
X-Google-Smtp-Source: ABdhPJwrXFM+SLcrgoPi1DOYI8PEt3aSAzau+pSFHBstqo+vxYMi+K+MABzs4Tt3/4Fkb+kXKyFW5390RTLyVbWMy70=
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr3165534qke.352.1593182428831;
 Fri, 26 Jun 2020 07:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-11-lee.jones@linaro.org>
In-Reply-To: <20200626130525.389469-11-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jun 2020 16:40:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a18eU3ozfH3iYrnuotr3TrLHNvtWZ-BaC1T4EyXciuyMQ@mail.gmail.com>
Message-ID: <CAK8P3a18eU3ozfH3iYrnuotr3TrLHNvtWZ-BaC1T4EyXciuyMQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] misc: pti: Fix documentation for bit-rotted
 function pti_tty_driver_write()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        J Freyensee <james_p_freyensee@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HMGYK/Y4ZhZ65zQfnf6iyjWxQRHpXsMM1Hm22jq1GZAcpqnKz9X
 wCSAsJCp1IX4SUjSWk8QzDFpDZ4JpXSVnPvPLDu0jDbSaMqQgC6zKcwzILbKWeHoyLPfW0/
 oBNDEIcpLKMGcJdVKC2VGZIFxY2FpCKUvLhK8fC9Yb/x1n2uScj7O31fQYzIzdQd7SkAqaw
 It8VckmnmJhqPPeXsJr4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RyRLEmvD750=:lWdveFqg/nga3guv97LCoW
 7qTRtRLBcu2Tc2JfgXUmUE6LAP0QCFfzcPWu3ofPDOUOIcla4JyO1OJV66xoZcUnJoAu+R0+X
 jK+s0VqNwHUsHy2SYfxExZxMtV3JMJIB8QZ1gYtWEf5dBiaKa9olffHMRWlDV4hQ45NHDZVAT
 blDlEIl0Ky/dOhMrf5BAGkrIYmYKXwBQCxydOrxDGUi0fMlo8JAhlHPwYjcNc4taEymiiuZ8e
 msEQBCA29KMvGZsR5/nrSgzUjrTq0jHPociX6ZQVwteLbIm49QiEKWI3iDCqNs/e5rgJtyBAQ
 Km3bAdEYmUzL32ZX3liesD3Tgvbr8fihaOt+cHG74xW0lhyCwXlwDlp513N9+2sjwXTIruxoQ
 RgFFJFCGQbiHvGyLeWPEKo3ehfOuwWQVXn+4NQcLbobDvhxIrFlwWTdLvy2d2WX3nbIhjmizf
 FkXKiLgpotXaql/g6FtN8qwpMQX65Zr03++lIXVNOh0BinKm73CQK7rQxtDChSMS3RWVdxJx5
 Mc17T9VUlGpJOEHJU4smMW57TOphiaMQeHjExb3SYgsKzq0f1IomPF5fsjndE4n8JmQkQVEcw
 /p98MtnwmvkHjY3+bVDOE6bNzg9sMLLHubRYwqxLPbwPCkDHZWAEP7G8tyMZK1pHUhY2/5Pmp
 3WyAGId3/cUJjW+I2jPlFbLvR5KLsI00gX+D0j/6WydprtlnlYlgPDg74KOCLyapGc+e2eq16
 8aZC6xwnmfNRK4zPWCkrk1ANNi/5Pjq5C8AJCjIOT/luGgjVLFMA5ZDNYt8rhQNV9PREh9bK/
 b3ZUKwOxd2MtRWiWPaYJJVBQzXLw1daQC+DOtsL8RGProvK820=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 3:05 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> The API has moved on since the original function header was
> authored.  This changes brings the function's documentation
> back into line with reality, complete descriptions of the
> latest arguments to be used.
>
> Squashes the following W=1 kernel build warnings:
>
>  drivers/misc/pti.c:510: warning: Function parameter or member 'tty' not described in 'pti_tty_driver_wr
>  drivers/misc/pti.c:510: warning: Function parameter or member 'buf' not described in 'pti_tty_driver_wr
>  drivers/misc/pti.c:510: warning: Excess function parameter 'filp' description in 'pti_tty_driver_write'
>  drivers/misc/pti.c:510: warning: Excess function parameter 'data' description in 'pti_tty_driver_write'
>
> Cc: J Freyensee <james_p_freyensee@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
