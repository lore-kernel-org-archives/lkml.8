Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FABC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7FE20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FDYxI6xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDILpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:45:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:32839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgDILpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586432695;
        bh=K7D8BGQFCMpn4R7rMXXwygtnH7RyFjFLFJ9+JV6zBrI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FDYxI6xf/LlLptXIsxFPzL36agOwj5G/1aMNnPQF00Xv3sCmbfQVAQjstFPfU75b5
         6M0SJ4Yug5TUTiMOsIgL2MSZ5BuXwkxqUQSiVJx+1Ru8gHSAtDDum1uSOZcRozCpNq
         yE+G6d9mAWD1fqKVk6+zNTtJXsVW+ek/CyYmdi2o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from medion ([82.19.195.159]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkHMP-1itnd01SgL-00kfO5; Thu, 09
 Apr 2020 13:44:55 +0200
Date:   Thu, 9 Apr 2020 12:44:50 +0100
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
Subject: Re: Coccinelle: zalloc-simple: Fix patch mode for
 dma_alloc_coherent()
Message-ID: <20200409114450.io57vlnrzotsemqp@medion>
References: <beeed2c8-1b5a-66a8-ec41-f5770c04bae9@web.de>
 <20200407160330.5m75sfkhrrx3wgrl@lenovo-laptop>
 <045a4a1a-c841-2979-c899-b632ca418b3b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <045a4a1a-c841-2979-c899-b632ca418b3b@web.de>
X-Provags-ID: V03:K1:EHcv7ZoRNqEat2p9pitzu+oEfylG1jMtYB4nTkNpN16pcm+sW8T
 5xJ2xy3Nr353DnIbSrP47UXLYEIus5Lun0uSb0WAKKPgvZ1tdMIZ/FeqGKBNsQV7M57fIM/
 nK98ieoPuiyRPBWOjMwd9FsxsEnOYTGnDtqO3UqR9fyomGW6jBJKPYC/D3tqevSUYDRdesx
 KMeryVYZxRk0jBHp6fDUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ro2NTf+59tc=:KGN1txuX7HuhMpihl1DSMo
 O6lSFnJ7TE6JUbMj3yxgQb7JpxnNJaJPWzufVKwyiuH4Oo9WSC9uaF9uSkt6X5qXiDf0CfRo+
 4OAlNv30wOA0F5BZTa2kPYiTWYZsEAz0tkKIsyVgZ0YeahS1dvVcJEXEmNQp378v9eTgwcjPS
 lqUMIwwYL3NNSP1EfHc97ryqhWQuKnblxxuFXxJtEYZY7t4tQxQe4MLmY32iU25mTQTNUAi4o
 i48ljDzDILQlTj9oSNrzFtBlZ+J3Zd9xNcr62h6gZ5X9L/PcVeYXYWZ2TdY7eZKPvtxhzwyG8
 Cma50oxVEiD37iq9xOerGF7tgTZS0lgkWMEJdwaehsY+DwoNN6rtHLPiRyxPBN3mpFVeuclZX
 SiqwDh9aHjXEnceqT2VgGEOeJmXDECUXocPyVK4p0k+3RkNcblzhYd/ji+njlppdHw76SiVMY
 qa6tT5yQhbL+XWRhXgRhCE7AcwBoC3qUrvgS/cSKgTLo3K4bcsL4B3Vgi9/KrqgOh1GyfHhg3
 Th9sUaivlKTcqlyqiGX8fBy5ECZcuu5nKO5FBicvyaA3gQyCmtcwYC90B9s79gUf+61CCLOWm
 rDJJri2/By06Sti87ys6tfsW1HGNBfNcJN9MyBrp3DhDd1ZQUqxzwJ0NI/hA27DiOfchwuzls
 SrjaGzYbvXV6egwxqpNtN/qcjcuH2M2iZT5jM9ZjK/Y0zCuFwIPC+mfuAYAvYZwo3YIRveWje
 LZl8FXT5D3pKbZaKv5Zrh0bpINHThhtC4XoIv1k3jkOCFgi4vmOqbRiIw6YNM87vlLxwq9eEZ
 JYScA7bBhXA68/VZo1IUOwUENuEHEV5el/DN8d4znBj+QxbG9sp6f7dZGriEZixNWkiO2dbi9
 kNyZmlczdCe3cPhmoc0HinXOLCEw7De6+ShympDaPsl+B8Ws7w6VF2PMS+I8FDW32E9O5k8Vy
 kMcC8ZHNSHjoGt/sSGZsAgUPByqggrX2lQtEG7VEJVn8wfD8Wx6BpiG4q0SulEskGd1Eq/RfX
 shUnj5z/g0GTBIRTJ9ONb26K3paghH855eI+fGexXFyasoFM4RUiS8Y8tXLMlxusH8gdotEa+
 uLyZdF6PCQ+rFONRBUj3PvEtT3pOpWzvVOf8/XC7ZnkWBfaS2ArYV2VpJM7hWcxTIj2rxNmJz
 4LHNbpjHO26u090sRZc9XMaTQHeT2+HC+OhBr0K77qXIXb5Y3ioIy1v2DBDYTSNluOinA+kJv
 Bxg1IeNVI2whEyevL
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 07:10:46PM +0200, Markus Elfring wrote:
> >> Will the software development attention grow in a way so that further
> >> implementation details can be adjusted also for the mentioned SmPL sc=
ript?
> >
> > I'm not sure I understand what you mean. Would you mind clarifying?
>
> You would like to a change a file for which some software development
> discussions happened a while ago.
> Do you get any further ideas from available information in message archi=
ves?

Hi Markus,

What should I be looking for in the archives? I've referenced what I
think is the relevant commit here.

>
> Julia Lawall (and me) pointed special development concerns out.
>
> Example:
> Code duplications in SmPL disjunctions
> https://lore.kernel.org/cocci/alpine.DEB.2.21.2004062115000.10239@hadrie=
n/
> https://systeme.lip6.fr/pipermail/cocci/2020-April/007099.html

I have replied to these messages now.

Best,
Alex

>
> Regards,
> Markus
