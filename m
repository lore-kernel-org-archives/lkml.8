Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F7AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6166C207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YYHXtG9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgGVGol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:44:41 -0400
Received: from mout.web.de ([217.72.192.78]:58173 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgGVGok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595400271;
        bh=qdXJ2H2awvG7G9Lnt2ipx4hll8cpX5j5hKL8axwtj74=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YYHXtG9vgAMl0RqikVOl+GiFzHkrCvyLNpdfwXQBs4bmqX61umAF/KN8xQmQXsT/L
         51UTlGnHVHSxpuCv6jAQjxs/d4O0u3BP5vZE1SYoNGJAuPccaIMW+uek9ihr9NYYhz
         g5Eknyr/K1QN/mEdfkYjNLCyuS2ybzda33enmt08=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.82.161]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MNcIg-1jvPjY3094-007ELL; Wed, 22
 Jul 2020 08:44:30 +0200
Subject: Re: [v3 2/3] coccinelle: api: extend memdup_user rule with
 vmemdup_user()
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <e3d2ffb9-2a47-3d77-0501-9d48845435bd@web.de>
 <alpine.DEB.2.22.394.2007211158310.2487@hadrien>
 <0b326e2b-723c-3482-c0ef-5d6592a9c6cb@web.de>
 <alpine.DEB.2.22.394.2007220801590.2918@hadrien>
 <07a06754-94dd-60b1-1ad1-9e602c86b1f8@web.de>
 <alpine.DEB.2.22.394.2007220823050.2918@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c6809db7-2979-7057-5cac-d2d1a57e77e2@web.de>
Date:   Wed, 22 Jul 2020 08:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007220823050.2918@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pVc2A3E7p9wl9YfeDW7K4gk+6JucGa4pAalQbpBYtfYD+xrBuCc
 n2Pu1wl17PjVUQRxRinaqGhweV5+QJUkn+Fw7w3cueEAdLVD4IlrdD5GojF5FBD6y0CIO/f
 JAc+UHUte3qk5Ot3x+zB+4sLelORffc/pewtQ5QDo3c2HDrhyiGwrtACTuwX0FieN5Rq5zC
 tSEl5mqrPCq2WQGTRF87Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:95i03QYO6bE=:iMqhzajn5U5Ob7WHEN7PAy
 IT/piLEKT/+i5yM5aGH+6xeALvzXE7oS9CmLWzbVEjRhJogs/AWv7IHUEXDUATCyJAwM2dsEn
 n4n065bwQtjKXN1S0kkCaDtnhk7HtI5gYt+8WX94pZ99XuARGzEgWc7rXfC3+n9NfOotw2E2x
 C0uxiOB2mVbJZF21k0gXGlua2O8MS+Xqn5Ynf9zd5d2avJ/QDISrVXhdkoDcAXwGPQtSJnIrU
 6T1qiXlYQImDKF56CACnbDvZ9JLjYiX30w5LPE5HZmfXy1ExG7TVF7eAmYWrJYL7Q0BranAOy
 ZayHxE3niHbCugbn9L+luRijSsMCM5kWtBdC1+A8w2AT0ZTK+kfCO1jv44W6/2jb1VWR0jpwP
 Ann4C3AHa+WydoS7EXQ0R2DF6m8zaNiZnG1aocLWobltZqyLKIvXspoNU3YNqNd+xTZvv6qm7
 rCjPRyrEBcOba/yJfWz6VbAHF+36jDYUUGOYxS2yiiMl/0VFc6uH2gcdYsvNAPJEY8K8cYN36
 3bZtS07KiZZ3AXR5vGIQ+cG8eOPI3WRaH7nVEggZCN3I/oOHYa0rI9VNPConxrbXTEMctGqib
 XmgPSGs7Q0nlyeOIgmmPgIFZ9ibtrTLb/GiPykQwG9v5ODJTbrJ0MWQ8B3YWQdiuVXg9pzbcf
 e6+PNbb7usjJGYHnDhBTHCol4haOr6dxVP6AGCLKPo8C8GxsDrm9XFiZvAvDfpBi5e8Se98vW
 eQj44lIPtuf478WG8ThcMfpf0HPQ78Grt5+VtlCkTUSfTKBSDwZloUV8YUOxfB3iBAJ5XqxZD
 8CoNWfnew1tUQDxiv4No67Iri1cSPe0/Rf9bREI9FqczzWaluOqe7ad4Fxm1uUANvkXK7THrn
 xqUqzlDGvfnD6kt0JY1fQeAUVg3iaqHsdxk++dhwm47DUyAsMbiw8lkzQ8ShAjOBJLJDOSrIX
 McVD9M45Y6y66ufhe737Zj/e20QpCgc7vWUCWv2v+GUn9voIeuyQT6rMjZd257RKvcc7Qq1Y+
 sp1ktXeZV4Dg3QOUtVoq4+UaNjCB/UaxbdEX0ibjpI/aqEGNSsfNPOq0RxG8kjk2JnA3VMEVJ
 7sU5enGobq0MBlEv7B26JMoUiGR+xnNFfVxTQt20hvWs+K59vanVriV8nZbBHXBymJw0t6D9P
 Dgc1jC/Mvc4pPjlU2C6kLBR23NuhBx/TV6iNqZaxk7T9nJ/6/rhmY+mt7bbQO3abamh5+BBpu
 NWTsUx47wd/MLXPheCl/pjACIICPvFWSCBUnA+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Under which circumstances would you begin to care more for involved dif=
ferences
>> in corresponding run time characteristics?
>
> When the difference is hours vs seconds.

Such a view can be influenced by execution environments in considerable wa=
ys.


> In this case, there are tradeoffs between the two options,

I am trying to improve the awareness for possible software design variatio=
ns.


> andI don't know which would be faster,

I am curious if more contributors would get into the mood to compare
data processing approaches a bit more.


> but I think it is extremely unlikely that the difference is noticible.

But the following effects may be known for the evaluation of a SmPL rule
which was combined for two code parts.

* The SmPL dependencies are checked only once.

* Can the source code search efforts be reduced a bit?


> But if you are concerned about it, you are welcome to try.

Will anybody become interested to measure the software behaviour exactly?

Regards,
Markus
