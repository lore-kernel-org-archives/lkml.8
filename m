Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146F9C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7602075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jIN5hjrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgDGQD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:03:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:40645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgDGQD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586275414;
        bh=e3mRm5CWAZ94bLSIQgu24+nnAMT62ywXZ1pN+mDxiVA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jIN5hjrSASiCcNRUHqRZCzPOYwhWWdaVRg9MoG+Uq2mqNFDGhB0vSQK/n2MN3VmSy
         h92TJRIfqf5DB+Z+GEjspLoee1s236JsuuNPn/DHrq71lNusQKjsPgaa99S4s1hy8y
         QKZlRV+KDzvHwXUAI5SagxvyAhK7cwpy6HywOOaE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from lenovo-laptop ([82.19.195.159]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvbFs-1j3d5f3HN8-00sfoC; Tue, 07
 Apr 2020 18:03:33 +0200
Date:   Tue, 7 Apr 2020 17:03:30 +0100
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Allison Randal <allison@lohutok.net>,
        Christoph Hellwig <hch@lst.de>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coccinelle: zalloc-simple: Fix patch mode for
 dma_alloc_coherent()
Message-ID: <20200407160330.5m75sfkhrrx3wgrl@lenovo-laptop>
References: <beeed2c8-1b5a-66a8-ec41-f5770c04bae9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <beeed2c8-1b5a-66a8-ec41-f5770c04bae9@web.de>
X-Provags-ID: V03:K1:VyTCQk3EiMwZojK0lcw8VVypr4boid8PMeIUQcoFh5hfKXppl56
 f55N+K3JBSSRb1BRquGaiX4iXL3AXghXl6kjS9BQyMfsiE7wKmAzQjMA6az0OKeLnxKig21
 0jtHzgLZDn7oelFHXALFodCvR1ijjVom5BFJsf81wct7THQwETUEq5ke8Cip0Y+QW5kyvzn
 tgfNXExVv5a25wkN2Eo4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7YENew970fU=:3ut9H6t0BFdslC+tkJ3dnR
 4vEXMQannVKiiPvU4Ifp81a8B/GXumK0AUngL5R0LwXPAGET5HxyNp9IvUET//yuSKo1LgWJM
 zC+s4sn+xZ4ESLWwFE0oJX42w94ZdqosLisZaQqpAlkAF6Rkj/EWXNkNZ1tkmmlJOl/uzPIny
 5TTUVZMDkN4kxA9iOUGfSf9ikSxrPITG3E+urpXnOCVWM5ZgYfslrxuvyL0At4dFTTfiaYBW0
 FqxTgTSDTCUOu52A+JEfZa65NvVBB2ldi4sU/VhalGYYa6FJGp85NsHrhzj+49K1RRJaUqd5D
 2+6bT+IMpLL+uiol8SpyBVsottPF2KlkEFLAnNT9+RG4hpjq6YDfJ6pKD5mds1KoNhaLiJQiy
 6tOGt/XM+4bkUFaqXGGLqC3Je+zto3vqMW5lx1y+R60pC1oA2FEWKsPYGkjWKvVu527zi6zyj
 WRa1UT97yPy9FuKTlYoiPJ6DxehYCZ4b4rI8mfbrpwZCGJ0nySBWcrQ5yxRP0YkmOD39NYLYP
 2clVJS4sDs+vUpZY5kp882AvQyStkPuJZ5gYgzAkBsjaZd3YaKN9FXOJxhkDhKRBKRqj6T2J3
 WgmXLgxDl10l8OveZP5X7QBUBbCC3RSvfYHyPp+nCbzZPHT2IXXikUE56feY34aZkpgqI9TD4
 7gH/zKpSlp9avP9PSCfkzfsYe8JEI7SI+VOLHVRZBl9RfLoOGZghWWrha6kVKZ8gNhixV2Npz
 QeHs6xVdAgbt3RMfz1QEHOdGpHxsRyFcw/bZ1Uoo4dE2JH91/WFVeLl84J6iM+F5oF/oSXC8S
 Yn4EbLN6PzaiIt4Sf7OPCssoA0uNr41i4mlZJoKbpwA+8lw+XYzWZM5JN77FnhHQynKcllLmb
 LtamXhONciuKcqE9P0lJfLtKGrIbLlEQJmsj8fkeJGMZ0HH0rLXkIfgLMhVf9/++xVcA4/e4l
 2ZWGFPlANUS1cX6bjWcWmTnF6Kj+JMrm1ccvgCRVPgL+/I9QgG4g4RYofMrca4tSnX4bTPOHp
 qpnXzrPel7V2RzxAARtJ8zrbP42Z/br8iNMZqfVMYmGq1eprif+D5ixyt8GHCstUw8kxjpycJ
 Y9QqL2IDdi/tOtD7PgCjvKs/+cLQuvgFwDa0Fb5btAQraaJ2Px1Qu2zMg1tm0RsIDr8n2to2t
 Uzdjg7ZfJQtSQj9uhiJB3P9Ne7Gr6KVZWrFsYRlfcJohjVJOFUUaRSP4hrNoYfA6tdLPSxlNR
 iEBlZEtOjOrF1ex8v
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 09:06:46AM +0200, Markus Elfring wrote:
> > Commit dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()"), in
> > removing dma_zalloc_coherent() treewide, inadvertently removed the pat=
ch
> > rule for dma_alloc_coherent(), leaving Coccinelle unable to auto-gener=
ate
> > patches for this case. Fix this.
>
> I suggest to reconsider also the distribution of recipients for your pat=
ch
> according to the fields =E2=80=9CCc=E2=80=9D and =E2=80=9CTo=E2=80=9D.

Good point.

>
> Will the software development attention grow in a way so that further
> implementation details can be adjusted also for the mentioned SmPL scrip=
t?

I'm not sure I understand what you mean. Would you mind clarifying?

Best,
Alex

>
> Regards,
> Markus
