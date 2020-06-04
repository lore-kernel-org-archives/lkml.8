Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDA5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317C4207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="WmMiVkZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgFDQIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:08:16 -0400
Received: from mout.web.de ([212.227.17.11]:45287 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgFDQIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591286886;
        bh=pETVOrwMewilbon2Kkzk73yrGNcVCxiSROPPm8A1Nsg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WmMiVkZNPqxzF640OmaGcGsdi61daoih07Hayb6aiUy4UrvCwi1EKOnhfZfsPZaxY
         5mcO9rmM7wHrfQx+FSjmhituBZpbxUU8T558yFHz61YLx8j/vbErUtiY+qaumw1uIM
         kYN0uNg5W/s9kwWMIF5TZQi9jEHD7bumIEuuzA7o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.94.220]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsyRS-1ixSou2sCw-012bnM; Thu, 04
 Jun 2020 18:08:06 +0200
Subject: Re: coccinelle: api: add kzfree script
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <96653281-3812-8b44-0dd8-6e7540a26a89@web.de>
 <alpine.DEB.2.21.2006041755360.2577@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e814fbbe-37a9-a059-fcbb-64cebba4c8e2@web.de>
Date:   Thu, 4 Jun 2020 18:08:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006041755360.2577@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H7KrQdVcf7Y7qO/hqy7nQpY7+jnzWKTRxLgu1fgUTDlrk7hzlkr
 kBUMoGh6/47t5icJEKC48S/ZecN1D9eBf6Nr7/pvoKibNA8BlPFzddfJzTmhGV5VwrbFzMG
 iOBsh2kDFXkuVfnCkEhds2uobzEW3x1rHp78oN3O1ZfxcW00adfulQJ0NNQPyj1ODOqIfI/
 APXBrBXbt4/xGrqbSA/PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8fihY4PaWVc=:mnj5ghreCfBCSfuR+mUjLr
 z3GCthogMBTnVaoVKezMn9T7CrhSRxglf5Im4Tw1Y8oWbDKaEG8op7G6MknvfHMG0o39mu4E4
 sKhjKmlrNBoy1fCfBaWQqKmaYVZscdYt/lUroSQHUy6CsTGfDcLizzcaCHrFSLXwTFi3bHuYz
 RSwPHcVQX/FixDqvq5oqd39eUcgLE4Zl37bWRODOTBNaCU+pb3yb9biGKBpCbIcYlBq4Rai8d
 dkw4S3pb3jBZPxnCR4qBMaNgIBimvOzrxxv1Puu7zNfcmN3KbnJfi90TRUDY2GkS4wSe5eBzx
 pXVsLQXX/e2HSE5duhc9sGCwvyxa3dKAxl5uZxDx94anvFB/cT7lbuN/aXxP7+/Ok5L/2Pp8Q
 0Y0MQNyBZEOevmiNvHh5Q3V+WYGLweVH46fWn8ua2TgZTHuD40bF0JXOoxYgH2Zz6gsW+UDoU
 Up/nDiVTy2oWAatmWhSQ7LCht3Uzw6T/ycSObTCHHEasLpx9Sy/SuKcQyViiZxfWPASXFd6Ge
 5ICOZ5J5A2eohCVibz6Q56YQR5sUSak9wm9EiekCSQ+/yscrHBlG5Dc2ZrBPIJFcsFrjzWoRn
 V8Ljsce47tD5GCxFXJ+Gl6Q5wgaCqUIvef6w1FK7HPq+kqIuTMu/9HCRIGMclwf1DCCPkj0p/
 jBZ8r5i5nrTyeMWprgidRc8idbg48/SuKrKD1ByzCjVQN70CZTILaOH3JCs8dGjGqRQIVfuzB
 0bYYii6FxF7YLHqYGHbwDzyuuWwWVkAeJhVYnuhzJ3SnC2HAsZnpB+4Wle1dHOmEbEDCu3pWF
 FvKXtrlyfGPLe5P6EqBv5mF+FUekL9PdQud3Yp1a/Kf3RdRX47MfSG9YV9QGk5may4nFz2Bsn
 LfUqK3laSuP0Suf6c78S3k21dZmWSO0hejHXYrOQUQGq8d7rYhv2mmmgsnXN++4zjaw5zreRU
 ePKlEd6C4cq92SC/4FasIPm/Wiy5mf/lOkxsQfr33GuGL1N+EP2VTOprMPzPNHaB5x9Xtb05k
 kAaEVflaFhOzxNgnkJgLzJbVrGeDGUuG57jMSvqfPZIBn61xHPrALZXoWVxkNk77WLVB5/zs7
 tDt/sDaYvX9sJBVe5GeNMSnMXrrKxZMpkPxTDaGf+UKOp8GEFXatKAZp72jBEcrE5ZJ1EoFxO
 ztEOBhKSReEZVt597aUtyg+gzCaleKRtmRd5iFJ8QqDs68/ehAat82OtZhT8W3HkH1e0IPjnS
 HXSMUOz6bfxR3Gdo2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +virtual context
>>> +virtual org
>>> +virtual report
>>> +virtual patch
>>
>> +virtual context, org, report, patch
>
> This is pointless.

I find the proposed SmPL code variant more succinct.


>> How does the SmPL asterisk functionality fit to the operation
>> modes =E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D?
>
> make coccicheck uses the option --no-show-diff for the org and report mo=
des.

Can it be nicer to avoid the usage of specific functionality
in the SmPL script directly?
Should the corresponding SmPL rule dependencies become clearer?

Regards,
Markus
