Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A153C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621E42078A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fFZLJ+13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407804AbgDPG1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:27:32 -0400
Received: from mout.web.de ([217.72.192.78]:50043 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407924AbgDPG0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587018404;
        bh=v9bJsFZNeftckyjYHiKUOSturkAW6MVswujCNqtEHtc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fFZLJ+13/6Qq18AqriC5l5jiYbTLn/I5rDWoljsJRRJxg3eQpNy9ayVwb+KfaGD8p
         jAeT9h3xaPiSvV70Zt8JDBPJwcYuroKzftiBXaNJXaicbMr4JPU0SuexpvDTac9mDp
         W1ppB+Jx7gUQ9sxdPwp53KOjLqycEtaOCryxOsPU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.109.113]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRlED-1jrBAj2QP3-00Sseo; Thu, 16
 Apr 2020 08:26:44 +0200
Subject: Re: [PATCH v2 5/7] remoteproc: Restructure firmware name allocation
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-6-mathieu.poirier@linaro.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <aa565fea-b1c4-9b5c-73ed-591244afee19@web.de>
Date:   Thu, 16 Apr 2020 08:26:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415204858.2448-6-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tyjQl+vYuNBgx7miHK7mjuRsg4s04EKseaSAW668a6p/97hYIId
 fgC3Ls2QlwgfIsVQHZFTFlwj3iCyV/Fcwbaj3yzCWU/lgEjw9PuxBlcF3UBx1miqdCDkuGe
 N9+XZz/D3TTKX5a9CQSAPDrD8flvlMGzAGJ41VDttseq+uOGR7Cc/R8KxGqhc5DygQWcRrL
 n+3msiNEZnTGumVeO+IOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JDXHgPTjxVs=:0EAxGvoOA4l6LXnRhukjP9
 GcS3MTQsbLxsrBsxUeBWuM2LOVk1ZSZQuY5Vj2ZEg3hJ80wAgVcpqYgFddflVcdKUPKaPac+n
 0/SXEh81ZeTwlua7C4RXT38+d6GCY1+cym6UIjFVu7lCVQRBoVas208zCmvXRDgCA0cof/AUh
 HASVJ1476jNaQt0oYx31gzXqVyKYQBMXl/NiIiI6SEpxFQUWiOrWznHQS0MlLhlSLms+eBoId
 0t3r/7dVdpE/HfH9NDXtGZX+iS2SfjYpVEiLg7C2wm+R094i4EOibIHPVvRflWVL2VOfriWui
 NwUIUn58hRWFZUqABgyufx+yV5tyNEB45Y6bksceH9G+RMBv+PdEv16ZD30uz5R4/9T/Nxvz/
 5aCe3fxhV/3TkGO4AexH8ldoCS/0ostkrD7R2WWWdd7czbGln0wQ1Yd26wA9eXweQJ1Q8/Xn5
 EzGXWclxRLWq1dOrFpgIQr73kygWAEpu2uVQJEdZvDSivqWw2XOrS+HbjIbtq7TdOwoGpx8IQ
 XtGFC7y2pd5DeJsy0veKefk6ZMc3zdfCeWcXIWIDDJIis7QpvFvXdHoKuJ7E02TL1Wv5XHjhf
 b0YVCtuSqNIDxH94UuaPMopOvO+uukJgyh+B1l0+KsMpMuYBekoBWhDXo8VSlkQ0ocPjdceVX
 kaKc71YaP7/4f4cmVGEq1qBtpyw8pOCqJA7tvoay+ogkdErbhzROdKhXLyf3QuoA0NBBztOEt
 b62PSHWyqgMtublSrUUa6e3NNQPeWanPooXMfOiRx4iI92TNrY4GCkLgmtfTu2jfQE9VXn36g
 YK9OsnpZixJE+Wuf1HjnhrzYsYoW+62L3Bt7BCpr91nKIZf3W8dQ6IXd94X4IxSbg2O0hkBXy
 WEabqvcHr0TRp/Oo9VyThohjFVDYfxW6kxNmEta3tnLgduGx/HAk8ivQo9/zuRgwJndDD7YlO
 nqcprc+VvHCbQuMpmcNyJIY8OfZEV6i2c/pRyTCBvd5yqvOYiTkEzKOE4G0sThgW53Xcd5JUr
 Re+nNEEgckM18dLX9rCptLYo16/tIy4BUvYT3eX00HpXGLNlcSotYIo62yHeu6E1V7oTG+yeZ
 dN/jM2F+xL3fbDKgrO2y+K++Iq7JXcGeWBsbM8CE8ADq1zFlHiTOaWVOxqZFa2c3SoBksfCLH
 QX4ZWQt3cU2fqoFodinu82DFz/7tMEa+mgpk/yJF0oT4YnjC8whckuHAIhCapWxzq+wvO+VsB
 ipZJRGOFVlp9/qcGc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1984,14 +1984,14 @@ static int rproc_alloc_firmware(struct rproc *rp=
roc,
>  {
>  	const char *p;
>
> -	if (!firmware)
> +	if (firmware)
> +		p =3D kstrdup_const(firmware, GFP_KERNEL);
> +	else
>  		/*
>  		 * If the caller didn't pass in a firmware name then
>  		 * construct a default name.
>  		 */
>  		p =3D kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
> -	else
> -		p =3D kstrdup_const(firmware, GFP_KERNEL);

Can the use of the conditional operator make sense at such source code pla=
ces?

	p =3D firmware ? kstrdup_const(=E2=80=A6) : kasprintf(=E2=80=A6);

Regards,
Markus
