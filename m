Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920DDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D1D207D0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="c3uBVHmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFEI6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:58:07 -0400
Received: from mout.web.de ([212.227.15.3]:36563 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgFEI6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591347477;
        bh=mvKBubzFUDxdlOMgJZA16TcBAVFbjITInuGBs3aqAuQ=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=c3uBVHmTVbcY2pMiDiu32Xac2xD76mWfCjOSBrnW9v+rPiQvDBK2K6yP9VSxy1WRd
         HZEo8ScIhiwt13cE7/Dd1U6xm1+KBbDdoA2L+mPQmpIKbLiZ440E7Fye5LJ/7vQWaM
         A+E88cIiDelpoMLbKQ5kjIM8lppLtUYB9yQ/oa2Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1jSwqP0ZC8-00Y7HP; Fri, 05
 Jun 2020 10:57:57 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungtae Kim <kt0755@gmail.com>
Subject: Re: [PATCH] usb: gadget: function: printer: Fix use-after-free in
 __lock_acquire()
To:     Zhang Qiang <qiang.zhang@windriver.com>, linux-usb@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5207d179-0a7d-b5ff-af34-102fb21028b5@web.de>
Date:   Fri, 5 Jun 2020 10:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g1UIEY0k7OwMw1allXLSGsecgBjQu3CCAc1mDU/pq9erQifvD9f
 dLPTmSa3N/gXqkCT5VS8ifyTAUpl/ZEb5qaZRCfKcUzZiP6L+Ko2Var1BWveUwhbDVconBT
 W8NlTy5/hqSsLEkWbLHLINGUuixYHCArsUnjKfy3QLhGbwi1xjLDro9WhHIp7qmE2J3z22V
 9lc2BhYYgNrJ1bEMaQr3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uT7lgZaP7iQ=:v9fqPdj3XEknU0jRUkmSzo
 d7ZUHDIRjZwQJI6JswyFkUSnHspPkWJYOJ6CD2sbleAhKkaOuXgFeWut3in7KPQYodF9AieGq
 pL1Hiy1Cf8F9tPUuSX3u/UhBHrA49daJC/y7+hjGHt9lmTgKSSrw/oipYrlsvDGIREX9+hPhp
 wS+ZvJ9NMQaZ5HZ9jOeuZ1ENtwIGZOJXHqlKj3i7mP/8yowDhpBu+tBzFRE7AHJ0MZfO1iOSs
 XfEOSjqmqXhZjX0kOZiacIMNSHiZnoikKFb75Yx/6Nl1Gkm0ch2wAge3syydwU3sMhrt9xOqw
 tTfBwo29hp+3jpTXUr8mdLelXdy6S8QFAIA2fk+lJBiPQHK4CeiFyjJ8siwB6vnOsXFWn8edU
 owy0tRlBi3OAc4UX+bKWZZHBcRdTtuBtIE74XqFDpq4R4hjxwOw+pdQkVfuzlVX7QER8STAeW
 mOozLuLEsGKLPqrjCrU9xYECXkS4i5Iesor1MennT0AnA6BmC+2ITRj/lX1mPhbJEB9lo0FjB
 KzBZCpusIhdAeb/s4dRfKCJHciMMdOE8Pdgsl1CkraYErjC27uQ0FJNVOX0dcjTZhGnvwWXXy
 eXvHgXLy7Rn/H1NEXtizyakvskNu5QFxN6VbqfQTg3nsuuTB28DbaVYgd76b/M+jqs4Ojgw27
 Y4vdE8bWGyptW1QVT+JA/XS0wG9qFe3nXb9NZFidJIY0JszHbTHtNmUimuHgGIDJ1kMjYtQaZ
 caU+w+Ft3eT/DMa4QQrHNbrWXgY+7O7R6PYeTez4qFG+Bsicj8KU0tx2jSWxLeR9O2oyd7AVf
 KJV700Le1raUJ/Vs9qobqmarMNV5shp7kseo+cP4u/K2xDAdSASUG6NbVGfbQoQW05fN7c8eP
 X3q3hgfFmA3ZhR26fghJXL/m5i9rLLEd1UFbUVkOXaoQahw3OKxWHpjWDZon6ckIQ7JteHB8R
 qEPAg1TX/M7Ljb2XJrkFQnjpdOKKCiJic98VKzsepweRl7AHCSryfWDdDRcidirjxYW9F6NdF
 XDT0wwDLEaVdTJWV02qmrDliZ6s5UyY1/FYcP8fSKzV3ms4OKv7shbff24ChwHYfAAL/lb/Hk
 78GCVx/ZZi56IjbMJxdZaEugfdzyzhvsXXQ/lsPh9ijYiiBmVmotBfbUCSr2+8mBfgk/JN5LO
 UV9rZ9Q88lZ+PXSvzUkvFGWSMIUj7dAXzksN0dGq5ozaUStu+oKZHJMXoyNdqS8A5GNZy63yy
 foRkbv7ERFO96II+M
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fix this by increase object reference count.

I find this description incomplete according to the proposed changes.

Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
