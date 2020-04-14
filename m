Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62554C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB7E206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hJLnLGAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437227AbgDNIxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:53:20 -0400
Received: from mout.web.de ([212.227.17.11]:60149 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437215AbgDNIxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586854384;
        bh=w5n7ibZJDJPEVWgwg4sOt2B8XgFjaiQQgTuB4bX2Xno=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=hJLnLGAXWKW9jObvnCeHZn1xL/7KkghMa+TNsTFzV3MfsfBNKJSEVctyd7Nq2pr98
         biCaVaqB9nNXIdFuhx2tApMF1gXehFRVG8b6p7Qb3etRw7irP3Q1mT4T7dOcN82vSA
         tsyIuxaeC7NrtcVnQHb1siJmKrEOt/aUL844ncGI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.66.171]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mb8wp-1jiH8W3CoN-00KjVY; Tue, 14
 Apr 2020 10:53:03 +0200
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 4/4] remoteproc: Get rid of tedious error path
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e5e03d6b-46bd-5ece-a7f6-3cb557c3b0b0@web.de>
Date:   Tue, 14 Apr 2020 10:53:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B0DW/5lFpXhx9rruFnKuF+D5nWJqygtq2HkqEfoYJvWA5wY2Vfi
 6w1ztsa3ylpooh8Qv4nsPiSAnbX3juAwck7TKxB3eByvEv3RRy48SCssLvt6OtlkdcRL5py
 cwMZ9DBi23fdixeRs06VzTJdLpxWkcWMPBXC/DISRn82FzND4ksF80O7vouNP9a/eg6jhbU
 A1WfPhPtE6yI9x/7vyASw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kz40wMuz+KE=:ftig1vVMN2qEHVvSWMydJv
 9jrZp7OpbOaA4cQkBct6xCTELd8wjZ/Q+ExkOX3jxhYEVYngs4EVN3WVzlllVVNn6HC0g9h36
 Y2+Dw3JtNJKSqHxXp6g7YrkVwrRfSrfpP1pqTiptwxCLUoBKICEjdxG56zv0G4rsTV9hH+loG
 9FejdDaNdxgAL1D8jrgibctMlU+JS6g7I/tQeZozin+XYgJFe87LlQlGJ6wD3mQjXxOWe75af
 c+EpgR7vYxC24sHwYq4fkvf8XPTNaLUN/h9mkpCxiPEnGEb+E35rXjFwF4fUnyFLs3d4ubVJg
 sCmW+FIt9SeEt4EOQW2NAmVgIeY/uXGL34mFX9QRyC6GkZ3w1IVqs/1Cm8z7cPCGH1hNc7uqM
 M81b1NhtU581PxrM4j+1dxJIMBBYIln5ErtC/jrpTzMpuR67vFvIq1/Ds4UiRpfiwrCfA9/G1
 nZTuAqk7BlieHDsq3fv6oOlfVxhWi+WyXKc3zlb7yDKE8xTW22qf9UUe7mqdnQ9mSvMoCU5c8
 YUzr8SKILYpSc3Kap8RHL1Bguv0ukQu5pH1xrhGeX3oUG65QTVqwdXfddFFMtQ24W0q7JTSz+
 F5UJRUpcgjYxxpV2lHdClXW4mCJINWNmRBM4G0a94a9u5rBhjJKWhf2cYnjsN4cY7i/HXwlOD
 h0n7Gey4aPD1wAFY6Y6HCb9sBLO9fiKx2LlFjTGFqywF9iKBpKei/LvTEF+lypIW+aFfogQzO
 U7ePIyJgAmyl+82RJ4HSiZBGBXpUUVDU+KzsZm5mv3HYFfkbNOoMDoGPOi9rcRtfhcIqkvnXw
 qMLCpAcosyQ/y/Bague0Cy5uAe4gDUpcyR1zXQ/Bn8fLxtPqef3rlyBVkA5tzecScBtKZxtU5
 LTaS4X6QH5fxQrNFoERzJHmFnY5oDKZmnEETCqAYCMTw7qa1oaJFUsUxZTOKjuNvvxsc+l3aY
 VAorrS+tRJJPCeegsFuqXkFx7nLP1IMWGKInyQeOTk+pk7QeyiHm44ukp5YH7h38nRl2QIjcc
 KincS1T810i18/N/F8bSTwBxsgt/WLgpfHlPJG6SivaVjH2vSTge6qMRqfB3gEjtWhTbpFeQd
 yT5wWH4bkuP/Z+UNFOPSfjBsTbNUeHfUQNl7ylwL+5w1QiHVky50X9x+wfQZ2koB2WyZDosu6
 5enbC0JooRDV/UXoGjvwvhdUUPsSxeDKYscUo+hmzspTBg5211JEoOk1x7BP9BeUXkuU1SPF/
 oovUERdZsVBsFYzLi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/drivers/remoteproc/remoteproc_core.c
=E2=80=A6
> @@ -2105,11 +2104,8 @@ struct rproc *rproc_alloc(struct device *dev, con=
st char *name,
=E2=80=A6
> +out:
> +	put_device(&rproc->dev);

How do you think about to use the label =E2=80=9Cput_device=E2=80=9D?

Regards,
Markus
