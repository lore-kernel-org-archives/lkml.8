Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447F3C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0642020721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RsgIBncG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgAJPql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:46:41 -0500
Received: from mout.web.de ([212.227.15.3]:50561 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbgAJPqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578671180;
        bh=+mOvcGuT9xlUSkuQ9BjFm5JU89ylI+6ZMgvGje3HC1U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RsgIBncGmNruf7tsPpgjWIrTNUrUfWyAPiy4W6DRgk+/pt0JrGGbV5ds0kZLxeSGV
         6Sz+5uu5ATVDyW6Dx8AqGO3pn3e57tmbzwkXdH6PwbKQv5ce21mywdpiiUURPvLxDr
         7FizTWSBReniucV+JWqYeNb4vm5ggT2iY4C2chko=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.170.191]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDxFv-1iu4hQ3fe3-00HS2I; Fri, 10
 Jan 2020 16:46:20 +0100
Subject: Re: [v2] coccinelle: semantic code search for inappropriate do_div()
 calls
To:     Julia Lawall <julia.lawall@inria.fr>,
        Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200107170240.47207-1-wenyang@linux.alibaba.com>
 <b6e7b8ac-4de8-00a0-d12c-ebf727af3e26@web.de>
 <alpine.DEB.2.21.2001101334160.2897@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a5a88792-5aec-caa8-d355-75f3f7dc1742@web.de>
Date:   Fri, 10 Jan 2020 16:46:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001101334160.2897@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:W9fkE6mpBkbHKLtBwhji9eh61zF/7QJxfoFtwpPg3SWcM9nKsg9
 lirlXqldKDkzej6kreQShQvuiAP9jW5dzQBdwcyhV5R4zuYNV9ZJ1F1ZrHHAHfh0EFZ2/3/
 8Cw6FeMAK019g2yxy9mhQbrBDUzwUUG1dnU+5eCU7C3nYBAoNFnkgQyLBQbznK63NfQvj4g
 IZjTHWEDx6OW6S1T2dwGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w902qL1PtMg=:fhYu+fyjdA3zJluDFyroFx
 Mcf+a2eB00/cw2bbn2IwVMafRgCrqh+BDmcLZsuzNs1cWFftAMgGG5FqYN9NlgZVwvLMxA0/v
 3MmK1866HQ1UVU2dX0ZAPEs0vnOB06xq0vdkpDE2L0yDgm1546Jc5WR0bA+aMwCHwGj4Cy+Am
 ZFo+4hfCMwGT2w+F9jbr7Xdi2vPa8BjT5BwIeC8RRNjnNQ5KymHzW0RwRaFKHO0GTVPqIcKBY
 JBrAWDPGTIDfNN7JVQbY61uVEV5A+M/vXRUMPp0Eq/ZqeQY4HVlBfnVziUOQt4R8zgFEmqwOY
 eerJhGIO+xdzT5NCnMu9SMyWkMrNZIIdrd9val3g5tfFS9O/wkO3oSxk8+bzWgqw13grss8/i
 SK3eTyNJ5jXHXS0/y8ng41cE0veq4d22AMACIIDVeTDn9d1qV31wbEjlhHqjZADSDq+VedGXn
 hiugIivOTn5ItpB5WNM5E163DJR430mQXmnydlgIPgiIjzexUvs63pm5qv9st2buGTDiBDHON
 YcC1347Rqcm6FPbX4rlM+h1370g9mk7qJH1OZkNPv0G4W/ED02nmjgiRPOmB8tSBo1jY5e4j0
 SQhyVvAVicri2upDMhukh1dbHQfggWLLLIIOHh/7KkjAY9wNyrMyBItHEYOzPAn+dKC66om0g
 4LmVnSg45SfUkphPVvkrtyC/8mlMmXW1cfdszkr+MY+EGel+y66C77R41Kz8PLD9amAYXVElY
 Yc6Tlu+jhsAWCa08ktWFe7oBFeKKlV854t1knPWQKDYMPmg9gnsP+cULT9SyXiM7lazQoQDuP
 z5vT6FLnPaCuE7M+D25tv9lGOeYCoIwRlEpXv90mwVA4yQn0ZdtKR25KGvW6bogcllyPwe0MN
 Lc/sTgRFvpyvKXp9td4ncx0/NkXkLFUCYrqUle/BzYHzOzsggmjkICouTLEomcwkQcLVsm7FT
 iGMYN+fulfOaTDI1l4ZLp0lCb00kiySHYq9z5WqlA3dQXrvY7VKdPyPr8RAtMqJKaV7XlDCby
 qdJQAO7W5SlSKS0YiYBuUPBwDDrazLN7JXidcLA2j/gfth5GdHk86HDONXychZVQwoxiEhc/R
 yrDWS4Oe/c4+vcKVv5vF/sC5UoWGhQzVy7fadDOqQcAF5hGkuwgSnL5ZhhPn5f8IyZb3Ij+pL
 DbrfTPuC5lsdcUj41iwj868qgd2osFneGrGYOQXnRJWtYbHv+/sqXELnc/xoqHo5JbfVigzRn
 le+2X7cO3dP0HYH0+Y9GdDo+iv609rGdTiJ3DbuLxY7c9goxrQdFz2AVXsY8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The code is fine as it is in these respects.

I have noticed additional software development opportunities.
Thus I became curious if further collateral evolution will happen.

Regards,
Markus
