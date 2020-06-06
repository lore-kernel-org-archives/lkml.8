Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765B9C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 22:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DC9207DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 22:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="VqfPcIN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgFFWGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 18:06:11 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:63954 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbgFFWGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 18:06:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id E1B41407B9;
        Sun,  7 Jun 2020 00:06:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1591481165; x=1593295566; bh=dyX9DvLsSYBOsgK3WI7TcbDQj5A+EpzkvRh
        0jzuyU5s=; b=VqfPcIN9AOAWLW9Mbn98dnKLKg6Zx8s9UgmasM9CISHRCk4vwil
        F67X+Id/moe6J5jdVcs9I2A8zCM/WNDwKZ/wLAZAHT+hSCha886kaB4HamjGUloL
        lhiKTbdeteqZKEY6iAq8Usnihqd5vK4DwG9gs0ZIq9+ekJQzn/R9feb+b97FfVPs
        9X35hjaBDbPaRd4iHzTWWneHsQfmfbBpfY38qH0uGCVxFTF2XyMdqYPtl5qWJi4H
        MiRJS6f9f2WOdAkH/9h4Axmreq+czpkD8S3aw2oSq/CKZJXShEKqElsbXbhbENnQ
        QKorQAaTHrPyGDfOBQs65HOjBLk7V0TKDK/z2b7b2gWtW9lr5kzk99Py91Dyh3B4
        xskeBLopXZ3F7JIymgmkdRWAevKVMgPVcUrpiE7nzUcvyOlUwBnjvlxnG+yg3ATb
        uxDKO9sI2GTHLBtSGq5MTgmEQu/kqEZ1ypvQGFSz7Ae7nGvquttDuLucKs+VVyS9
        uZynxGVyzZfiOwVl1t5uuHt5P/xmMfjXJ94xMrx1Br3fjeblm+9KYK0D5bBCJ0e7
        MsGreTCCTAeBd+AesGVIwG21XQ9A4xT18Tlv92fBE6qF7LgC+P3ftwAkEgy8X/Qh
        BBDiEpcVBPr274KgEf3vH0JIdN++zZ2rRRxaYihARaouXC74dOgIh06o=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l5Vsk_TJD0xR; Sun,  7 Jun 2020 00:06:05 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 7F059403F7;
        Sun,  7 Jun 2020 00:06:04 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 109022D9E;
        Sun,  7 Jun 2020 00:06:04 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: it_IT: address invalid reference warnings
Date:   Sun, 07 Jun 2020 00:06:02 +0200
Message-ID: <11587824.O9o76ZdvQC@harkonnen>
In-Reply-To: <3060760.44csPzL39Z@harkonnen>
References: <20200531185618.7099-1-lukas.bulwahn@gmail.com> <3060760.44csPzL39Z@harkonnen>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I re-read the documents with the full context.

Moving to the directive :doc: for only those two references (like I was=20
arguing in the previous email) will make the document inconsistent.
So, the patch is fine for me as it is.

I will finish and push the translation for ../core-api/symbol-namespace.rst
and move the link again

On Tuesday, June 2, 2020 10:37:21 AM CEST Federico Vaga wrote:
> On Sunday, May 31, 2020 8:56:18 PM CEST Lukas Bulwahn wrote:
> > Documentation generation warns:
> >   it_IT/kernel-hacking/hacking.rst:
> >     WARNING: unknown document: ../core-api/symbol/namespaces
> >  =20
> >   it_IT/process/5.Posting.rst:
> >     WARNING: undefined label: it_email_clients
> >  =20
> >   it_IT/process/submitting-patches.rst:
> >     WARNING: undefined label: it_email_clients
> >  =20
> >   it_IT/process/howto.rst:
> >      WARNING: undefined label: it_managementstyle
> >=20
> > Refer to English documentation, as Italian translation does not exist,
> > and
>=20
> The file exists! On my disk :D
> My mistake, I have an almost done translation for that and of course I do
> not see the warning.
>=20
> > add labels for Italian process documents to resolve label references.
>=20
> I think we have agreed to not use labels but instead to sue the directive
>=20
> :doc: instead. This fix should happen in the document that points here. W=
hen
> :I
> posted the new translations I removed those labels but forgot to fix:
> it_IT/process/5.Posting.rst, it_IT/process/submitting-patches.rst and it_=
IT/
> process/howto.rst
>=20
> :doc:`../process/email-clients`
> :doc:`../process/management-style`
>=20
> I should be more meticulous and regenerate the full translation every tim=
e.
> Lesson learned. Sorry for that and thanks
>=20
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Jonathan, please pick this quick fix of warnings.
> >=20
> > applies on doc-next and next-20200529
> >=20
> >  Documentation/translations/it_IT/kernel-hacking/hacking.rst   | 4 ++--
> >  Documentation/translations/it_IT/process/email-clients.rst    | 2 ++
> >  Documentation/translations/it_IT/process/management-style.rst | 2 ++
> >  3 files changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> > b/Documentation/translations/it_IT/kernel-hacking/hacking.rst index
> > 6aab27a8d323..e9a2e92134f0 100644
> > --- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> > +++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> > @@ -634,7 +634,7 @@ Definita in ``include/linux/export.h``
> >=20
> >  Questa =E8 una variate di `EXPORT_SYMBOL()` che permette di specificar=
e uno
> >  spazio dei nomi. Lo spazio dei nomi =E8 documentato in
> >=20
> > -:doc:`../core-api/symbol-namespaces`
> > +:doc:`../../../core-api/symbol-namespaces`
> >=20
> >  :c:func:`EXPORT_SYMBOL_NS_GPL()`
> > =20
> >  --------------------------------
> >=20
> > @@ -643,7 +643,7 @@ Definita in ``include/linux/export.h``
> >=20
> >  Questa =E8 una variate di `EXPORT_SYMBOL_GPL()` che permette di specif=
icare
> >=20
> > uno spazio dei nomi. Lo spazio dei nomi =E8 documentato in
> > -:doc:`../core-api/symbol-namespaces`
> > +:doc:`../../../core-api/symbol-namespaces`
> >=20
> >  Procedure e convenzioni
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > diff --git a/Documentation/translations/it_IT/process/email-clients.rst
> > b/Documentation/translations/it_IT/process/email-clients.rst index
> > 89abf6d325f2..66d3d65776f7 100644
> > --- a/Documentation/translations/it_IT/process/email-clients.rst
> > +++ b/Documentation/translations/it_IT/process/email-clients.rst
> > @@ -3,6 +3,8 @@
> >=20
> >  :Original: :doc:`../../../process/email-clients`
> >  :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
> >=20
> > +.. _it_email_clients:
> > +
> >=20
> >  Informazioni sui programmi di posta elettronica per Linux
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > diff --git a/Documentation/translations/it_IT/process/management-style.=
rst
> > b/Documentation/translations/it_IT/process/management-style.rst index
> > c709285138a7..76ed074082ea 100644
> > --- a/Documentation/translations/it_IT/process/management-style.rst
> > +++ b/Documentation/translations/it_IT/process/management-style.rst
> > @@ -3,6 +3,8 @@
> >=20
> >  :Original: :doc:`../../../process/management-style`
> >  :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
> >=20
> > +.. _it_managementstyle:
> > +
> >=20
> >  Il modello di gestione del kernel Linux
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




