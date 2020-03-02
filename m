Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01AEC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E925246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pFiiClJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgCBJKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:10:49 -0500
Received: from mout.web.de ([212.227.17.12]:53173 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgCBJKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583140211;
        bh=QAild6O7MCbuXG51IcMsrwxcESICx7Wd74UNesuEsuc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pFiiClJKejpA64Qsj6gGa+j5sVFuOhpzNbCbUXgK1py9JlaYWSydu7I/z6baEKG7t
         p/fj6QnnJyFYkbV3kV+yMhN2U2HryKXLy3w1HWNQFrbYoKbEjCoUb9L8a0rsiKNFxr
         dG4jiiyNtEUsxUj9oLwmYY0th/U/+88f6lO3wIGs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.91.182]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJCSM-1j72Of05nO-002oqc; Mon, 02
 Mar 2020 10:10:11 +0100
Subject: Re: [PATCH v3] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <158313621831.3082.9886161529613724376.stgit@devnote2>
 <158313622831.3082.8237132211731864948.stgit@devnote2>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <385d2d20-5f5d-529f-471c-89d0b4c3efd7@web.de>
Date:   Mon, 2 Mar 2020 10:10:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158313622831.3082.8237132211731864948.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q3Ck4h3EF+MypDVBS79zf2N1d5HCIZLBezu35p+w+bQHzFOehrO
 5o0dZTO0PFB1DAN4WvpVQ9sDjaOXZ2RLxuOBNyqbudAixq3A1eB1Piykqm7+gm48UXTR2Y/
 LV5zjX0k0uotLK8e4WBBW3RBQh/tZRh2urie6GLXDFQHSasnDIg+UjjHiLS8OO5OamNYA/+
 HXX2As7ddTKlMoBokyqYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K6WZoWBY/aM=:MSYQkvh7XHoZqyqBYJYMZs
 sogGWP3C2g9F3KZv1QIkmxV2F00klXkvRDP8zldZ2Jy/ntUSSbCtPnZ/u9iqF+rg1pDUd3yzP
 9O6pR5hQnqvW+U3LivpFNAjtcoRWVcQLkquOjImz/wWT3VvaVs9yEWsDHbxnEkemHgBTgtnFT
 TYmkkMka1c68Ltv+35NpfhrM/CHVAkiHYZH77Io8sDiIMsEpm+tdqMyX8+l1eeBYsxwezb4Ax
 A4F7vz2YvHX7igvNzkujxHbeAfw2ZtMHu1ct0YcKxFUjb8DQawL2a0Pjwg7s51X8Ay0rauhPx
 Fp0uPYnAzilygRLpDoQE22/JrLi0eHLaGeLzKcbGyITvx46sXSbQTM1sF1tMw+ognSTml6EWL
 am5vhSihAhoZnTDJPNMLLNBPMLZLztw+aWwmpgH/sSlwUXRrwuqRd79olGTD+xTSNp0WgWrqL
 aejBAoxhbKwbzeNLK5P70Msml2d8Q+mSloHyjJZEgQE47YfX3lnXXhgC6YWl21SLpPkF5r+PB
 X14GzIF9gmgh5bjqSuszl7SF0md/b/uBtbXz9vPrGrAVWq047HMkCHnsPpn7ygHC4bQ34rCuO
 HPRt8hjGV6O9IH05MbAEvw8yR4l9VWTHMYRSHd5QExhEDAHFCcYz0mxHyzcLqFvty5tXYTvwy
 r65RgSUQS5yPSYVjtxJRKB0GltbrZ3ZBWDfYItYydqdJMa+pftYsGHN/qIVexOpDLiH7oMVqV
 5dgptbhxqeSWHtAR4fFh/6q/FqvvxlAttQJub0v/Umyt7ESmTJcVu8y21t2D4KT6gPZAv5GX9
 Jtzb0eJ1x977ZxtwOn5syfUroTmcIjgUIsidu91pi0YMjVxHfvUDH8VbmvCk0JWWvHpiivZBv
 up+JEh5ufSWv2F3FDGb0g9kEukm+lTAw2AEz7vORYprs8FmWQ+EfuBIsFcKCAcHIQr4JqVyiX
 abXRfeSHPWlEMvbJ7pfrN1DL1AO5iaOvzguIQIfD67M8owMGaGG3tkdLVJokxYfZiJ9pQT9qt
 r8jPUp8DERhKV/Uyvw2q06ZpbbjbGbJoYXp4Q9dxBmcWG1ElZkemVHIQGvy2naLZnoF9NqfNw
 Gg8eKgs06FIoDNZ8YNWCape3PFdlFbTPdt4A+1CbtA4GymfLXYap8W8z4Ox4DkeSbXC91VJgC
 SxT3Z1RFrPFHA9ICfu/N7c5BKtd+rnGjhGc5JLa0a0aqIUyp4oqQZRw2OVnb5AtsScwoD2QS4
 dkEMOIyWpPmha6pDO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/Documentation/admin-guide/bootconfig.rst
=E2=80=A6
> +If you think that kernel/init options becomes too long to write in boot=
-loader
> +configuration file or you want to comment on each option, the boot
> +configuration may be suitable.

I have got still understanding difficulties for this wording.
How do you choose to distribute settings between the mentioned places?


> +Also, some features may depend on the boot configuration, and it has ow=
n
> +root key.

Will the key hierarchy need any further clarification?


> + # make O=3D<builddir> -C tools/bootconfig

Can the order of these parameters matter?


> +The boot configuration syntax is a simple structured key-value.

Would you like to discuss any extensions for such software?

Regards,
Markus
