Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D131C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DF42076E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YQgWSAR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgDCTDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:03:18 -0400
Received: from mout.web.de ([212.227.15.14]:42741 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbgDCTDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585940572;
        bh=/x8uFqRPlQTYSp5Fw85UUgxsY+d2Tw7WMUXmxkGPMQE=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=YQgWSAR/5IgF900Eju1QPHuv+1WPbDV5BVeG2ejisYYbf5cDFuUIqEY3G6jJUMWmE
         OWxSxXmE2tSYic9CIN1WtybuhBKC8vQwVdku1JsYuWAk+wT3Vr99MKFi/qhmxOFgqR
         pAgy1j2EpeGvAFQVFE3d4J+hzyb3FFL4fyDwHAoA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.25.116]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MaYGX-1je1q91OGH-00K5tP; Fri, 03
 Apr 2020 21:02:52 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ipmi: bt-bcm: Use platform_get_irq_optional()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Arnd Bergmann <arnd@arndb.de>, Corey Minyard <minyard@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net
Message-ID: <e5d4574d-cc8d-a24d-9c76-f32390b0472b@web.de>
Date:   Fri, 3 Apr 2020 21:02:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P1Q1HhkvmnupdZ92g7WgoJPlntQ82hRC1tgvOL18uEfqkZuc8/j
 CYkBB4lN8Eb5xTQJ9UCqUclwyPe1GDiCWsOwTjfHve4V3zq92ofbc/yWS2xUJyXOWoOYw36
 IbeIVIBcqVFTa7Q2pm1q+GHKo4YQh+vq02X9L2ITlyHlWIHpg7aQbLW8Tw7HxSn1IoZJC9s
 XSOeWCNTrp55Ih6beZLgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3+N+T/J+1YQ=:gkzQoB4wqqdL33AQB5mdeD
 SHWv7b3uRAtDwZ8pGNhuwW7JLr3W20n1MIgmLXDgPyV6j/yCP7Woqbb+uqbx+ve4SRQTV9F08
 fXITt3af7DTABS9frs6wvMrSdefcw8JADE0gcqyvL7gkm45sBw1JQ4GjU3fpNuOky4panGm9e
 kzJj5MqnIZzu6EszG6lO20TqDTMbq99RgW9pRs9Zm8yYe80mtKvSpfB35STwrMpStQ4M/6Ef4
 8dX3olxv3iZJxabW3+FtVRra77tnKCV8nCC5drDhGGokSjAEuElCs8p7CQmnr13mKF32L1g4c
 BmQeMhjolkVYeRz2tblaBGIek85XXf5oPfFW8yKm2dGQBn09kjcnxhUj5MH6ILdJajVYuAvwg
 bodUW+c743awLMu3G0y3OaPd88AYkMORIoMFOTyqf0ZfygN4ApsXnx0Ps/owDVNfYvZP+e2ym
 tVX9dizMGANW1IfTZ6xgS2/H6/QJwV+CKy8J5Z3CtmJ9CpMmvmXL/DJfIqwl52KrJd/C/iMlX
 eBBjLCPvXWrRFhZBcJ2TCEFfrHUoOuNBN+uQikYRwuuU7rvWrxdwq57mSRn8099PMeo4Jz6o1
 hKhybItbJudiw+4i+BDQHwmC4CgVYzJm3A+Lh/aNR23c+oZoTOHNr6WBZNLpTrv70Aax5J0t7
 QUEWQTxnN8GUSKFRwJtXUbtnPnpbIQK4qAwy98NAUI8cqVW1mXCGpu6fYnmX9UBWGHTGhhj3v
 lxZEhApMg8EYc42b2v5yKBgLlUHyMBRhUUqqdZR3UNbn5oGDl/44XZqxmTY2qozWmAXiyALrP
 tgLMJRFgrPG6/7YksY6lkVDblMqR0ZawsrM30JQO1jmEc310+6D/CM3BEV7jjLO4k5M6Sv5lr
 nTEqv1boGHEs4XHMN5vAEL17u9KDlSmQDkP8IO9fQSsiXV5oSTUfUJ0hYVifo388Ap2tDtmCf
 4tQXKI+RExYUzvkFFqnkg/JhQZaBF3XD7/pBnoIVVnnLgoqVX1qUyXXX24zWRTiYWGGsDEdKD
 zxBSNBOlz+Empc8aLnGo8BEckSkbwatg1AX+Aaocjg8LOtHjNowc22zNqu8bRiZpLTfxq6l37
 naEpn2t5JV7JL94N1BaQUn7KZZ9/kIBiBFd8250NkoY50ZHwR1cFSzL4Imasd/pw+uRU1fJav
 F3Hw7Nu8zNOrCKb3B3aDYguSh7eXRdrKI0gw/3TRS//F11UWoUAWP8uhvRq3UqWssAOi/90BO
 8tI93oxg1l/hQsHgA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In this function's reference function 'bt_bmc_probe()',

I have got understanding difficulties for this information.
Would you like to refer to the function =E2=80=9Cbt_bmc_config_irq=E2=80=
=9D?


> there are judgments of print message about 'bt_bmc->irq',

Would an other wording be nicer?


> so use platform_get_irq_optional() instead of platform_get_irq()
> to avoid redundant dev_err() message.

Will a separate sentence be helpful?

How do you think about another bit of fine-tuning for the commit message?

Regards,
Markus
