Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF1DC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6DD2071C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="aDSI/zho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgECMci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 08:32:38 -0400
Received: from mout.web.de ([212.227.15.14]:35345 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbgECMcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 08:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588509147;
        bh=CESW9uzXd86XV2AIcjWhiGbs6GMfhTN1+g5Sybprzq8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=aDSI/zhonE9VOWZ3tVDyW832AxhJoqbVnCCA+osZx3l02c51v2Mkce1X/XAn08nDE
         ebcK9Eyi+e32IO/pFloeaD+cDdkW5TzDpzJ1hxMAaCw6dDkXC4Wrg17L9x2Dr3ayyx
         ySZlyZXwN3AqDpzggGAgPMPMmMDr8hESQ9a0zQlM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.26.31]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNcHy-1jWqcD1MaI-007Fer; Sun, 03
 May 2020 14:32:27 +0200
Subject: Re: [v4] checkpatch: add support to check 'Fixes:' tag format
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200502185421.GB9082@udknight>
 <6a3a6f8d-e8be-0002-780d-1991f6152c8f@web.de>
 <20200503114557.GA10332@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <975e6172-b333-37ab-ccc7-9e9a85986dfe@web.de>
Date:   Sun, 3 May 2020 14:32:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503114557.GA10332@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mPEkw1o0ozQn9s8Xl478J6S/giYtPx8RmnsSAo8BqmU9Pa/GNHv
 YZjCb++9zurPhqKT7eMXugs77h9EYl8SDeWhssPPxB7hqJN/N1Qz0gc3q8MjyFHJgZlb1Te
 EdXHJg4gCpxXvKiQJfGt52aIf25RII2cPKsamPhiruK05uubTSNgbUdE8kkOgVmWJTzRIxT
 hWJQzbXYg6IDgB7Co3Lsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bck9WKT1DCE=:qsAIpURQeJYzaf3jdXdYb1
 hAGHwLHsI/tgd9cFctV7lry2eZS5D2CWSJtsVnHc/k3sckZIX7tzLdeB4sGebeVjZ6sLZ+1JS
 ARgYVVkc5qSd3AFe52q0PNKre2uLdjSpAYXb0qgx8r1GroPxkKfJc7DvhSkAOrgaatvhlL+cb
 3sa7gHjbadnB9OdjGJGypPlzdFqWlP/Z8TBkAQ4sjvXkh9Jiol0qnkoS09NMzH3e82GKZYD4R
 UPp7uvWHC+U0C/5aXZCTxtn/QCNajK48Sg/19rYB6vWEQAOfZyp3XLc3X0tjvKVBqtcaOllLO
 v7toI6LkLSOMj0ZS1+3HnVtaZPv2qfVgsV3bEup/cwKPLdw4Na0lOygziwhuxaJPiH3oTld21
 RO6gUhYwcISQ/yKcFMcRXd7Xxe0oAoIl4OFYoJFs/icgLDQd6T36qs7M5ta2XdAk6BH+Y1Joc
 tb0yYakjJ/wCjtIXG804F8SXenUnZEEGYymZvtmaIXqrdecLjTn2IqXuB4SzUTfJEC8AKGXRm
 W/uE0jb3JIMeWKcqxzuwRJx7SaLZkoN4dpmVxMAp86heactBKakdIwQ65KvrWCA/47ibAIlpU
 U4lZIDcpOB7yGgEpYLZjJ9w1cIvPYgd0kRzpyiLpFWSiG6BKLcIViaZt63PaG1pEWgsWhg+Js
 tx8KHPKI+11UEJB0aY1a4EAsJudX+xhl76DftDrnFKnK/RBAkXsvLh4UwClDLlEXS/1vSd2aL
 llSVVTp2cnnuLBbYplRS6ZQkdJifDG1uw3cpmAGB3NgkFR7w+C3Erz1KfDMnvlcaH+/KT8z/b
 oOklfv9bRI+j46KZ0Sou+HcOCo/XQcrxCJd2Izo0SXjhcmfe84C5uEywwYFOY4gsulVAA1TB7
 +2rp41Zp1BVNL/vdtDXge1JvbxlKelyS4b3XPteLD41KAJQrS1SKSUR/mYiwRuu8vZBO7a82M
 d7QJXQsJoV6/Ln4fTjdzxvL+xgf974Bu4zT8+CcSo6uHCCnrO3VmSsnpk0Huwe5N6vvhHhVuV
 G+kB/NCtkyFS/YUU2vlpHCoW0ojsp64xUzyW+HcwPWq57JjA6F+yio/BCIX6+cqqN5jqooUrQ
 pNrGz+IqfcyX+B9EaE671gkdRqjjRHN0PTzrm4iP4uyAC/LdazJ77SEQpP1+iZwOb/h+MQM2u
 g8ElYpolTz0VdK54p5NpEDahKyewrNknmsgOoAXyEmxMS66VyHMAJKGpvm2/XFHIzlwLyOkPc
 u5hYdni6FHRSCzLCq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +				$diagnostics .=3D "Missing a pair of parentheses '()' or a pair o=
f double quotation marks (\"\").\n";
>>
>> Can such a message trigger any more thoughts and development ideas?
>
> No, I don't think so. '(" ... ")' is the minimum interface between analy=
ser
> (checkpatch) and commit id description (normal commit id and 'Fixes:' ta=
g)

* I am proposing to recheck the influence of quotation character alternati=
ves
  also at this place.

* How do you think about to provide an information without the word =E2=80=
=9Cor=E2=80=9D
  in error messages?


> about the title, it is very difficult if not impossible to guess the tit=
le
> boundary and whether it is the *REAL* title that folllow the SHA1 withou=
t
> this precondition,

I find this concern reasonable.


> and it is more difficult to do it when we need to support
> title which across lines in the normal commit id description.

I imagine that further software design options can be considered.


> At last I really doubt the benefit it brings deserves the complexity and=
 the
> current diagnostics info is enough clear for most situation.

* Will a safer data format description trigger corresponding efforts?

* Will the structure of the commit title matter?

* Would you like to improve checks (and program organisation) besides
  the application of regular expressions?

Regards,
Markus
