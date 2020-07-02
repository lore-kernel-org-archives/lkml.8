Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26D2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91712085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HP8bgulw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgGBGCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:02:39 -0400
Received: from mout.web.de ([212.227.15.14]:52213 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbgGBGCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593669729;
        bh=1wsof2EjqnJl8QEWYmm5y3N851fM7oKgM49vh7cC63g=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=HP8bgulw4ad4LQy47XLBIYTkFg+yF4RnryTW6nRwDo29gUowUt+5sQy2qjf/bS5yN
         gRwNX4JE3C2cdyGRjPSJMsicJKC4T1LbnJQ7kKOFaeAyfB+a2eB9yfPShpC55FHUeO
         fg3nuxn4i9loBCs2dd0NAtUa+nsldF6qGq0dY0Wc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.138.52]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MA5dJ-1jfYgj41Y9-00BKkH; Thu, 02
 Jul 2020 08:02:09 +0200
Subject: Re: [v2] Documentation: Coccinelle: fix typos and command example
To:     Julia Lawall <julia.lawall@inria.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-doc@vger.kernel.org
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
 <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
 <648d287e-3636-1858-1439-103d317f8571@web.de>
 <34065299-03cf-5b62-db37-0acc9830be72@infradead.org>
 <65db3f88-1ac8-374d-e3fe-2ea0970ffd67@web.de>
 <30b722ca-1bd8-2b96-ca41-1e9bc7212b66@infradead.org>
 <bd4033cd-f564-0414-4dbf-4ff58f841648@web.de>
 <05f8cb2b-c76e-e2ba-24a8-5676c1792255@infradead.org>
 <5e83b473-8764-fbfc-394c-1acffa74943c@web.de>
 <alpine.DEB.2.22.394.2007012232510.2540@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <33b47421-5966-2b5a-17ec-d55a1169d30b@web.de>
Date:   Thu, 2 Jul 2020 08:01:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007012232510.2540@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qbv8iPdT4jeSigF3B93eqk/Noh3lKM93GKK4O7BpS3U87AnwQCC
 fqnIcS0NPbnrkL8sscnZCndzItzGozLGzTNUsCkM7XMs8zeHsue+0/SEIX7AdWgcJPpkJTX
 fhXzeFDrkZhW99dT9Le8t8JEJ9xjU9RusH1lXpWhLP6axjz8BY4mc2ZDlL4oJFc7IK3aXvx
 PZJOUWs69TD8hoD3aPXfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:65HUgGFLS6M=:nY917XZbMC90o4jUwLL6Ph
 IkaJ1nThoXJbBcNt2iVhsI+oHRLzTLRNUOX9FH8ld5GJWF7X3m1KJYIjfDqvGaCbZM648CWvA
 wDOGgAMT5e3N2piIemnOhT5wY5USWTUAQ4pC3/bMoAe0vs8F9MJFiGnSKBZEPkL3zxlJm79XA
 CoqsFSDeTcpV+Ph1mmNyCuCCfC84s6ya33Ia49bDodDSvmFzYqgQdwwHNqb4JogqVlMj5hG8Q
 c+ZfQvdUhd0A69VXwt5PDEGogNDqps86nCV9IZTUPOV6Rxb8LJ0OqQA+45hT2QMz71TzBAOYK
 KesnPUy6QCmgBzvGu7w2GzI9wl4jjQbiMk+IesKrnZCAZzUCnptqOZn05NidA/dMy+1ahUbvC
 Tqi1ZcpxJspHq0FopZ9NzFKvDBlScCTloiPADAWchFA+6RLltvHeEs9rTGGSMxuh+/UlA8UZ9
 id//oy+iCMD3nSuovcsyFJR0DGUAYx0LYetkxbjZf67eEyld4QTpNCumwRvF+ZHqsO2WQi7++
 guBGWtqcyngT2MHh5uUThdEKHDhqjswRCagUIDETA4cOXafCrg7RvgpAqTlhwisOiEpyyLhnu
 UiRuk5b57hdHjQ2ZCqPMTVdfbXZmbUNJ8E8131IgOLi+CYlx6I7/Fk59I6bIla6gUZgj9FLgW
 PyKvANSG1GS1B3F9EtNwkIoW8qRMhFG1UDuXUV3noOoyXkHLwF5roz4pRfi6W1MA8PUPXmBtF
 nh6UpEBYXY5x3NxURedlyb2n48AIT0PqzXUQYFoql376lon2N9PDi6TrCSvtnnFeFm8nt5c3E
 YegH2kCgm50C+x0W6Lg7eS0wKjpvAu/qLcU5rXPMoBFCKrwuyS1sHYndua3z4Ppuu2WdMVee9
 DFBVOg3qUxIk8wLOS7HsY5Sg0Y7khduDy7jd8/HEVL9wXI0vpxDoYOWXW4swahHcaI4GN8/g0
 KSw1HPRKsfhiA4TVTKvB9eNlwYE/Xf+N4azJSmUnA0kIb+SBYgSPGFo0TuCFpL7gRfdg3Ucoi
 Ggz4cjT7Qp22EEZ38nwX8S7a+v5WmbTopwafXFnpLc4leF+XVu+Tu5ZsZtXj1thVYNMKk+0Gg
 L3QOJC6ox+N61KJWj03MV5ENTbc9SJDsFSBQrH7+BfJlj5HbJHLZ1Te4fp3D+1BjR5kg3KZFH
 EJBK6duwODLeBDPLtKbr5JZWYa3RKrQrlNYOYhQnVrikurUcpgsw+jldLNNqnhN2idorfO18L
 uIC5MIow72R3RciswNkcLvkkw5zYALLNVwZt51Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Julia, Markus- can you tell me how to run coccicheck on one source fil=
e?
>>
>> You can choose between two methods.
>>
>> * Use the documented build target with appropriate parameters.
>>   (How many Linux software modules do consist of only a single source f=
ile?)
>
> This is a useless piece of information.  What are "appropriate parameter=
s".

I propose to take another look at details from the discussed software docu=
mentation
for the desired selection of useful settings.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?id=3Dcd77006e01b3198c75fb7819b3d0ff89=
709539bb#n167

It is mentioned there that the make variable =E2=80=9CM=E2=80=9D can be us=
ed
to apply Coccinelle to a specific directory.

* Which existing directories will contain a single source file for a while=
?

* You can create folders on demand with one source file (or equivalent
  symbolic links), can't you?


>> * Do you get further ideas from another concrete command example?
>>   https://lore.kernel.org/linux-arm-kernel/5b693ee0-0cb1-7ff3-b562-bac6=
bcb6aae8@web.de/
>>   https://lkml.org/lkml/2020/6/29/357
>>
>>   elfring@Sonne:~/Projekte/Linux/next-patched> make J=3D1 C=3D1 CHECK=
=3D'scripts/coccicheck' MODE=3Dcontext COCCI=3D~/Projekte/Linux/next-patch=
ed/scripts/coccinelle/null/show_pointer_usage_before_null_check-20200701.c=
occi drivers/usb/mtu3/mtu3_gadget.o
>
> This is not what is intended.

I am curious how corresponding intentions will be adjusted.


> What is intended has never worked.

I wonder about this view.
Did I get inappropriate impressions from the presented test example?


> The coccicheck script expects that the file name is received on its comm=
and
> line, and that is not the case.  I have asked the person who wrote the
> code if he knows how to fix it.

I am also curious how this area might evolve further.

Regards,
Markus
