Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20313C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FB7206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="PdV1Xag3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFBIh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:37:29 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:1684 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgFBIh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:37:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 067BE7D9;
        Tue,  2 Jun 2020 10:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1591087043; x=1592901444; bh=aXuHszoJnoP9XecP7cTxxo8VTO/bUbMxro0
        q0tZWxDo=; b=PdV1Xag3o/C5se763EMpdFsZnwOMERQXl4SsIexlPR/8MktCk8u
        bpfgrho89u8NL4RiBNBEgYXIhK1/CxIJ9aL4wcQe17xiIzMKYkkS3je6YSsnasYx
        I2yoXMi55yTnGRqhBx4g+VNEmrGRMIU783lAe/ZSUHeJDHZkrtC2MICS+2B/R03O
        OK1oJ+PmfPdnm8UdDgOBFqTT9UPm42YBf2PI/z2+q8DCgVvhfLnHRhzq1vtYEONq
        zcw+PPbTxypv0igFWMgTPqvM1ncfplrnWF78bN7dHVcI4zDuk76Wp3QzomwRcTnW
        ks1+2HAIOt7fjpvc73Ahac87j799u3d9+oMnF2AdWTuO67Rr1AW+HjjzddRq35RC
        xgXNgZ8EkGqj/r+lzpgQxAsXcqncbFv8bNjK9A5y1GWjMQVkAbNqE2ILOVJiFPrK
        zNJu1o7vJt+wtl31aatTHi8WzUypQsUaZuDuUBLjPHba4cfcqfaBJzB5D2Kens3d
        Hjt9+b5goTDv8v9lg5RCdNEAhLp+/yKUeb5afmtnEpnBJB3Fpt7fFB/ui9Z28IQr
        QOuH8HsOtLfhccSgHCG/diyRVDRz1MQkkIhIFsg0Y4xeQVPY7Z1GPg0XjCkHWOpu
        ewZa65nT+eo2WqFIMGwmB4pX5tJsM1tBqqX53RQ/IYfsewtC2ifjaJ3I=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1VoB5yfiLj0m; Tue,  2 Jun 2020 10:37:23 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id B2B5D339;
        Tue,  2 Jun 2020 10:37:23 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 50AD84772;
        Tue,  2 Jun 2020 10:37:23 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: it_IT: address invalid reference warnings
Date:   Tue, 02 Jun 2020 10:37:21 +0200
Message-ID: <3060760.44csPzL39Z@harkonnen>
In-Reply-To: <20200531185618.7099-1-lukas.bulwahn@gmail.com>
References: <20200531185618.7099-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, May 31, 2020 8:56:18 PM CEST Lukas Bulwahn wrote:
> Documentation generation warns:
>=20
>   it_IT/kernel-hacking/hacking.rst:
>     WARNING: unknown document: ../core-api/symbol/namespaces
>=20
>   it_IT/process/5.Posting.rst:
>     WARNING: undefined label: it_email_clients
>=20
>   it_IT/process/submitting-patches.rst:
>     WARNING: undefined label: it_email_clients
>=20
>   it_IT/process/howto.rst:
>      WARNING: undefined label: it_managementstyle
>=20
> Refer to English documentation, as Italian translation does not exist,
> and=20

The file exists! On my disk :D
My mistake, I have an almost done translation for that and of course I do n=
ot=20
see the warning.

> add labels for Italian process documents to resolve label references.

I think we have agreed to not use labels but instead to sue the directive=20
:doc: instead. This fix should happen in the document that points here. Whe=
n I=20
posted the new translations I removed those labels but forgot to fix:
it_IT/process/5.Posting.rst, it_IT/process/submitting-patches.rst and it_IT/
process/howto.rst

:doc:`../process/email-clients`
:doc:`../process/management-style`

I should be more meticulous and regenerate the full translation every time.=
=20
Lesson learned. Sorry for that and thanks

>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Jonathan, please pick this quick fix of warnings.
>=20
> applies on doc-next and next-20200529
>=20
>  Documentation/translations/it_IT/kernel-hacking/hacking.rst   | 4 ++--
>  Documentation/translations/it_IT/process/email-clients.rst    | 2 ++
>  Documentation/translations/it_IT/process/management-style.rst | 2 ++
>  3 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> b/Documentation/translations/it_IT/kernel-hacking/hacking.rst index
> 6aab27a8d323..e9a2e92134f0 100644
> --- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> +++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> @@ -634,7 +634,7 @@ Definita in ``include/linux/export.h``
>=20
>  Questa =E8 una variate di `EXPORT_SYMBOL()` che permette di specificare =
uno
>  spazio dei nomi. Lo spazio dei nomi =E8 documentato in
> -:doc:`../core-api/symbol-namespaces`
> +:doc:`../../../core-api/symbol-namespaces`
>=20
>  :c:func:`EXPORT_SYMBOL_NS_GPL()`
>=20
>  --------------------------------
> @@ -643,7 +643,7 @@ Definita in ``include/linux/export.h``
>=20
>  Questa =E8 una variate di `EXPORT_SYMBOL_GPL()` che permette di specific=
are
> uno spazio dei nomi. Lo spazio dei nomi =E8 documentato in
> -:doc:`../core-api/symbol-namespaces`
> +:doc:`../../../core-api/symbol-namespaces`
>=20
>  Procedure e convenzioni
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/translations/it_IT/process/email-clients.rst
> b/Documentation/translations/it_IT/process/email-clients.rst index
> 89abf6d325f2..66d3d65776f7 100644
> --- a/Documentation/translations/it_IT/process/email-clients.rst
> +++ b/Documentation/translations/it_IT/process/email-clients.rst
> @@ -3,6 +3,8 @@
>=20
>  :Original: :doc:`../../../process/email-clients`
>  :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
>=20
> +.. _it_email_clients:
> +
>  Informazioni sui programmi di posta elettronica per Linux
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> diff --git a/Documentation/translations/it_IT/process/management-style.rst
> b/Documentation/translations/it_IT/process/management-style.rst index
> c709285138a7..76ed074082ea 100644
> --- a/Documentation/translations/it_IT/process/management-style.rst
> +++ b/Documentation/translations/it_IT/process/management-style.rst
> @@ -3,6 +3,8 @@
>=20
>  :Original: :doc:`../../../process/management-style`
>  :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
>=20
> +.. _it_managementstyle:
> +
>  Il modello di gestione del kernel Linux
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



