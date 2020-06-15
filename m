Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4873C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53332067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="Pw1v3Bxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgFOHlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:41:40 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:7638 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgFOHkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:40:20 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 083687D2;
        Mon, 15 Jun 2020 09:39:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1592206792; x=1594021193; bh=AVUUPEux4Kx1vK/R89Ot4pKZah2kg33VBPL
        Woy8ljzY=; b=Pw1v3Bxi+u2nkCbLv9fhtn5ZOsGPKuWaD65aAkk4paWzzE/RQy9
        gshAhSJlgOsVxsBAjjF8JHflvxT1U5iXnILl52xIKE3baA0wa1jPUXHcrzImp8Gf
        nxGOsr4HUQjYZl/7o1ACy9f3L4r/15d5sDbCVZG9GErmfAFjMcHy3OMNyahkMi3A
        Yp80cLtcaxqM3vH81GTIyXx85BfTM1LrdqJm9wHKV1sRRqsyXaRfs29FHc4LuxUj
        l6AL59MpYGbRqyCekyI9GikIfS4m+AucxSHYwWAe3+Ubl3FGA0hsCvCrMcUZZfce
        Tbztrpv9uh8AdgWLzLHCAk23+Pozxt0rHwzsAZnY8qNKnpi7WG8Tnujq0dY1fMYG
        LCaFnNpHJonKNgu8tyCOiFfKYXKB48UKj9qAEXtfToM85EbgAFVoe49r0oc6XOc4
        beJeS5ahnllhmtIsbPxImZlj8DpB3b6x3gTFbYVircWL479LbL6ZuKPJelQWbAr/
        WBO3taVzCEQxZ4s+u4FOE4yijNU730U0r8I6x1vpoDS2+4BGKI9NPc1g3Vj2P0n2
        HJESnNIqwPmpVmhGCAnoOm3Lcjj8YIuJzxe09t2mRJJla2k3ZIFiWhjrLvoorCLV
        ftU37GbFRd5zt9PVfVPKKtAJA4u9lOu7o4kuntWRPUvmxcbrdO88n0L8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9Uc4KvnQHTMs; Mon, 15 Jun 2020 09:39:52 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 945B5626;
        Mon, 15 Jun 2020 09:39:52 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 30440343;
        Mon, 15 Jun 2020 09:39:52 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 22/29] docs: it_IT: add two missing references
Date:   Mon, 15 Jun 2020 09:39:50 +0200
Message-ID: <2534109.mvXUDI8C0e@harkonnen>
In-Reply-To: <e6ac17a4065a892e1b64e447106178a86354796e.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org> <e6ac17a4065a892e1b64e447106178a86354796e.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is already fixed by https://lkml.org/lkml/2020/5/31/260

On Monday, June 15, 2020 8:47:01 AM CEST Mauro Carvalho Chehab wrote:
> there are missing references causing Sphinx warnings:
> 
>     Documentation/translations/it_IT/process/submitting-patches.rst:384:
> WARNING: undefined label: it_email_clients (if the link has no caption the
> label must precede a section header)
> Documentation/translations/it_IT/process/submitting-patches.rst:384:
> WARNING: undefined label: it_email_clients (if the link has no caption the
> label must precede a section header)
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/translations/it_IT/process/management-style.rst   | 2 ++
>  Documentation/translations/it_IT/process/submitting-patches.rst | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/translations/it_IT/process/management-style.rst
> b/Documentation/translations/it_IT/process/management-style.rst index
> 76ed074082ea..f7acee105c05 100644
> --- a/Documentation/translations/it_IT/process/management-style.rst
> +++ b/Documentation/translations/it_IT/process/management-style.rst
> @@ -1,5 +1,7 @@
>  .. include:: ../disclaimer-ita.rst
> 
> +.. _it_managementstyle:
> +
> 
>  :Original: :doc:`../../../process/management-style`
>  :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
> 
> diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst
> b/Documentation/translations/it_IT/process/submitting-patches.rst index
> 7c23c08e4401..94c816b4e8f8 100644
> --- a/Documentation/translations/it_IT/process/submitting-patches.rst
> +++ b/Documentation/translations/it_IT/process/submitting-patches.rst
> @@ -1,3 +1,5 @@
> +.. _it_email_clients:
> +
>  .. include:: ../disclaimer-ita.rst
> 
>  :Original: :ref:`Documentation/process/submitting-patches.rst
>  :<submittingpatches>`




