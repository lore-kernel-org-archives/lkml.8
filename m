Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EB5C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD392070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CudzcFJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFJfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:35:18 -0500
Received: from mout.web.de ([217.72.192.78]:49321 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgCFJfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583487278;
        bh=rUutctVSoXOpWom/7T1TZtB2Hhzq45dxgXswPAdIQCc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CudzcFJTkmVXVun+430uQsAOqSN3g73zmuVbOyIF5XHjfDPnfi5cSXb0QKnAHfaUx
         BPtLRpbDqtTGQWdj2uc3Lxbu8lyvG+hpptiOXccmYDqHno3s7qrbAzZGIyYaSZIW6m
         Ck2gj9yh51+5niJap3xG8hyv2Z3U0XszpETFYqho=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.156.79]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lheqz-1jfNSJ25mD-00mu4f; Fri, 06
 Mar 2020 10:34:38 +0100
Subject: Re: [PATCH v5.1] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <158341540688.4236.11231142256496896074.stgit@devnote2>
 <f3c51b0a-2a55-6523-96e2-4f9ef0635d9f@web.de>
 <20200306105107.afba066a97db1eb12f290aff@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <58f4d6b3-ce3d-d1a5-aa0f-c31c1bbec091@web.de>
Date:   Fri, 6 Mar 2020 10:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306105107.afba066a97db1eb12f290aff@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4cuSGlOvvsGuCntOe3AeGEGEMa74iNrCzb7XNMS+5VxDS0dCpwD
 0a/ICsuEPiT4ttqHoA8iNVXTlvbpOC59QfWk2ucaFse7vxgvMt3ETCfslBjbiTsgRI1rfWE
 HghZJkbLOVHEHouE728JcJRzy2Tia9dc6UzQXnxXZ+ByV6Km7L8MCNfoBxA0ZINpcuhKpft
 iAllhPtVgN/5TMIExu2iQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T9SsRQ8wg5M=:j6O6HCNxfzSqOGIhy0X2Ae
 3D8oXJUnVZKhe0oVvrMkSp/zdMruSJiRwYMB0qMle2mt60qxhUPo6HVbpHTMorvg3qLD/ve+M
 f38CHXofRqJ+JOvpdvDxfDIS4TrI4uALnlEe7qYFo9f6ufagwHocCWE29kr1yr9UwIZUW9lM1
 Z3gbvgekPMVH4AtcHUDWCjBNwRfRrsIe0pmg2C9/U93NHpN4JXP7mRV57VkFAZxVY+zCNsWhT
 08Jh+oP5D2Tja0aBANuVtKrcSmCdg0TVJWg4JcQ1CWOiOxFDIjXWpltORK/7IHn/7B4x6qZVw
 xkUGMOaoikuD8SqFBIGvfa/WMIcuN6FxU9m49N43zMggc29rYUxYJzqO5BjOuQzB9BZZMedgO
 SMtu2mlbNrBYGYJt67wcv1EVY8KHzxJ73tYetvcxHQbMHV1I6fekiTn+4cHMwwFQxMJxg/Re8
 QTJSzz/AD/lQ8bIfmkYvlcAY+waONES963QVMtLIwegtV0XK0R5XD1g4UGCrTD56dTMKZzITx
 3Ztu1ys06GT7vUP2YyL7Ehrg6xyiOyCI1ybh/WYDK/qvtgEICtJZA751cDycMj37hgjEi/Vbo
 2cPEf4+GgVrMhGx1G8d3yddZ5LCnYDqaanT/no/g7cBNE5/gybGbo0mwZHc8I4gQvsn28S3SH
 E7CE0Zgwp09PkWQ67k5EsaecP8ROEAzJv4GIeYyhaMBWDS8pA86G90jykAvHFFZd1lSrfGrMx
 zSojoM+n5c9bNpyOUs/DbdYxpVYWDSLDUluwyWUpywVrBbark93C5jAiyZW4Gg6ydQCPyEBHJ
 2VOvX3UmO66y/g620LWP4M5UL8RO7srKAsF/ZzbANkNyWWNyd3dcIU0lsCg8XpcXqmfkC8LGP
 hQn+eEJCEuxNXNxMxoYYHFfi6lXPPkDtngk9GiMKX+ffUmsEkvfz4iIApzujZg+kNZSVCyuV0
 MePpeSkG+ajZiTnxUFq7fUhVdGAsz750XIMfy0iMpjSPtwehpxFbVyzINqXwer5nBBJGBn62O
 5U+NCV71QbjEsrLj1/f9f+woVuk0Qvam+I5dNBNVpYjsGT0jtFj3KzjSmQrxAAgEVRi/RUp6w
 DijVylcwPLsOtuJexjyitapPzyDeiR2Rx/Laa6I6/6OdPV/JzoWT++V/pWrxUIwWX+S1m6R1P
 duP7JqM16XlIYPhCha26yM3sjiCoZpjlO3eK+foMgV6DPq4wunxjYJqYKgcuFn1QU9dgfl83m
 MwEmrKFrYKRF5zSjk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you think you have "any more" update candidates, feel free to make
> an update "patch" and send to us.

I pointed a few change possibilities out already.


> That will be the next step.

I got the impression that we are in the process of constructing another pa=
tch together
which will fix known wording weaknesses.


By the way:
I wonder about the shown version identifier.
Will the patch numbering need also further considerations?


>> =E2=80=A6
>>> +++ b/Documentation/admin-guide/bootconfig.rst
>> =E2=80=A6
>>> +If you think that kernel/init options become too long to write in boo=
t-loader
>>> +configuration file or you want to comment on each option, the boot
>>> +configuration may be suitable. =E2=80=A6
>>
>> Would you like to specify any settings in the boot configuration file
>> because the provided storage capacity would be too limited by the kerne=
l command line?
>
> Yes.

How will affected places be improved after such an agreement?

Regards,
Markus
