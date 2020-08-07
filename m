Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83C6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BBA2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="gtD8Yifa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHGTMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:12:15 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:27949 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHGTMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:12:14 -0400
X-Greylist: delayed 15999 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2020 15:12:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1596827532;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=P7mhstXZ3r0aQzc0W25GtF8XW6jQOXfcbCvk2BpLqd4=;
        b=gtD8Yifad49HtTIHnnFZCLt/JeinfJOUn9Lgf4Bno5aLASOk4/48s4qdq6qs9vjl/R
        Ddefe3cog4Otn2y0rq0/ROX4NU9cXj/o2iMJpq/dJHfS4IVtMrsrrcnzacTYJkTGky59
        1D4AGFS0DWRTDg8NoomMKk4y8c2f13H14D4bTc5XdXHrpsrTtLUKxaBTVjG85ykgnBPL
        WED9y0qBVfFypJDd0NDfqSrQb9/F7JjGAwBAFEbdy/IePhC5/r8bnSwOPfocFTNwtxvt
        cigRU7RWypzJ0Id4ETccajbzIHGx2tyj60fSKD7WCfpfwyOiu348/UEHqQhf/IZ2j+Y6
        xabg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7b2Zx37owlXZszUtLBzgXn3WKO295t5bmobInEcRf"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:b10d:ea0c:6c03:2994:72c7:709e]
        by smtp.strato.de (RZmta 46.10.5 AUTH)
        with ESMTPSA id 60686ew77JC9QLb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 7 Aug 2020 21:12:09 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [Latest Git kernel/Linux-next kernel] Xorg doesn't start after the seccomp updates v5.9-rc1
Date:   Fri, 7 Aug 2020 21:12:08 +0200
Message-Id: <B13B4293-8DF4-4FC7-A48F-60A5A9121B61@xenosoft.de>
References: <202008071043.2EABB8D24B@keescook>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>
In-Reply-To: <202008071043.2EABB8D24B@keescook>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

Thanks a lot for your patch! I think your patch works because I can patch th=
e Git source code but the kernel doesn=E2=80=99t boot. In my point of view y=
our modifications aren=E2=80=99t responsible for this second issue. The kern=
el can=E2=80=99t initialize the graphics card anymore. I think the latest DR=
M updates are responsible for the second issue. Because of this second issue=
 I can=E2=80=99t test your patch.

Please test the latest Git kernel.

Thanks,
Christian

> On 7. Aug 2020, at 19:45, Kees Cook <keescook@chromium.org> wrote:
>=20
> =EF=BB=BFOn Fri, Aug 07, 2020 at 04:45:14PM +0200, Christian Zigotzky wrot=
e:
>> But Xorg works on Ubuntu 10.04.4 (PowerPC 32-bit), openSUSE Tumbleweed
>> 20190722 PPC64 and on Fedora 27 PPC64 with the latest Git kernel.
>>=20
>> I bisected today [4].
>>=20
>> Result: net/scm: Regularize compat handling of scm_detach_fds()
>> (c0029de50982c1fb215330a5f9d433cec0cfd8cc) [5] is the first bad commit.
>>=20
>> This commit has been merged with the seccomp updates v5.9-rc1 on 2020-08-=
04
>> 14:11:08 -0700 [1]. Since these updates, Xorg doesn't start anymore on so=
me
>> Linux distributions.
>=20
> Hi! Thanks for bisecting; yes, sorry for the trouble (I'm still trying
> to understand why my compat tests _passed_...). Regardless, can you try
> this patch:
>=20
> https://lore.kernel.org/lkml/20200807173609.GJ4402@mussarela/
>=20
> --=20
> Kees Cook
