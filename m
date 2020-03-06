Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567E3C10F26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CED42072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="Mo5EhILj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgCFIIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:08:23 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:30522 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgCFIIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:08:23 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 3E96B6BE;
        Fri,  6 Mar 2020 09:08:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1583482098; x=1585296499; bh=zjFxbFMg6zjLw7+euUvfK/141HdAfBUqTrp
        GbamgKCs=; b=Mo5EhILjTIBt03Rq/861akwN2vNQhYaplKJnGa+qBKpI4dVTFvF
        uNZnNVEz34LwGRJYcggf7bbSPoSu3JVJWFXfCeqrABszCgwExBwuVN6x+ZvO50cX
        hB5x3S0qxyF/aJavIPxSywjOu2ZKrNiAmKXz9Nn4/78Qcb8bi8bBYWqVrlOj5Puy
        ekhOHMc62oQofFyfq2okgV3C5fcjWkKu8pb7hvItbR2SyUVB9yjC9/S0pD9RRnMh
        030z2tmP5+Dow7kz+Mr1xksgBTWkHCZQWC1OonSKm8T268L+hOaMG2rLVwSPZHkZ
        TNmwLfLFelVyCHmqbu2+d5D6sE+9RPD+76iOIGqkNYubT8BXyMBPnlMrN5Xha7n/
        WFquiKehs5xub0W1vbp7b5k/WMFl5S73pUa2E+g6/FosAjP9yRLv4ABDIH9MUnou
        zucT38AgimtYW9eTZRCpZRGS9bywkfjTWAWo88JjrsXb8pjw46EfUFNJ4kjqwIX/
        LdURhcTGTElz/k5OLwsgEIug8PZONuBuWbojMowWAcr6LIO+LH8Cig98j8hHxMf3
        ySG7bsvg2ka8yOH5PDQ2OsmD0jdGwqOs7b21KeYr06XAJK+JRBSgGfi/GRK+9Qdg
        4MXyiqu/kF1wbHmxWdGlM3Sxs+L9QIiHFoF43HknzL21eEkBZDMlOOok=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iovzI00V9jIo; Fri,  6 Mar 2020 09:08:18 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 06CE656E;
        Fri,  6 Mar 2020 09:08:17 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 9F51F2401;
        Fri,  6 Mar 2020 09:08:17 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: it_IT: netdev-FAQ: Fix link to original document
Date:   Fri, 06 Mar 2020 09:08:16 +0100
Message-ID: <2924047.tcjekT7ZY2@pcbe13614>
In-Reply-To: <20200305205123.8569-1-j.neuschaefer@gmx.net>
References: <20200305205123.8569-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed a copy'n'paste error, thanks

Reviewed-by: Federico Vaga <federico.vaga@vaga.pv.it>

On Thursday, March 5, 2020 9:51:21 PM CET Jonathan Neusch=E4fer wrote:
> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/translations/it_IT/networking/netdev-FAQ.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/translations/it_IT/networking/netdev-FAQ.rst
> b/Documentation/translations/it_IT/networking/netdev-FAQ.rst index
> 8489ead7cff1..7e2456bb7d92 100644
> --- a/Documentation/translations/it_IT/networking/netdev-FAQ.rst
> +++ b/Documentation/translations/it_IT/networking/netdev-FAQ.rst
> @@ -1,6 +1,6 @@
>  .. include:: ../disclaimer-ita.rst
>=20
> -:Original: :ref:`Documentation/process/stable-kernel-rules.rst
> <stable_kernel_rules>` +:Original:
> :ref:`Documentation/networking/netdev-FAQ.rst <netdev-FAQ>`
>=20
>  .. _it_netdev-FAQ:
>=20
> --
> 2.20.1


=2D-=20
=46ederico Vaga
http://www.federicovaga.it/


