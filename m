Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8BCC2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E6420718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMR1EGl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgBQIN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:13:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25961 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727545AbgBQIN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581927206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vacLSAglKCYHubbBh7xR6hS6YnzloO60LNhYv/4yKQM=;
        b=PMR1EGl7xxh7k7btZ15QfW0jisFmW5hRd7XHYRecwzszDFVGEwgoekokepxWcPXoMT5iK0
        C6muK8VyPXgpxyFjqvYY7hnRJqy/pSb0krG/nKFuvDjwlQSNj81ujSmB7bTynUvEiBgqBb
        Q5clRozsGXBvbxURMSCr1niq7Tu/lNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-ybn7gDDcO2SLY2d95luYNg-1; Mon, 17 Feb 2020 03:13:23 -0500
X-MC-Unique: ybn7gDDcO2SLY2d95luYNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5132800D5A;
        Mon, 17 Feb 2020 08:13:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com [10.36.117.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32E01196AE;
        Mon, 17 Feb 2020 08:13:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 80FF416E16; Mon, 17 Feb 2020 09:13:16 +0100 (CET)
Date:   Mon, 17 Feb 2020 09:13:16 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Emmanuel Vadot <manu@FreeBSD.org>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@intel.com,
        efremov@linux.com, tzimmermann@suse.de, noralf@tronnes.org,
        sam@ravnborg.org, chris@chris-wilson.co.uk,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/format_helper: Dual licence the file in GPL 2
 and MIT
Message-ID: <20200217081316.6ndtpdki7yu4uila@sirius.home.kraxel.org>
References: <20200215180911.18299-1-manu@FreeBSD.org>
 <20200215180911.18299-3-manu@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200215180911.18299-3-manu@FreeBSD.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 07:09:11PM +0100, Emmanuel Vadot wrote:
> From: Emmanuel Vadot <manu@FreeBSD.Org>
>=20
> Contributors for this file are :
> Gerd Hoffmann <kraxel@redhat.com>
> Maxime Ripard <mripard@kernel.org>
> Noralf Tr=F8nnes <noralf@tronnes.org>
>=20
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_=
format_helper.c
> index 0897cb9aeaff..3b818f2b2392 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0 or MIT
>  /*
>   * Copyright (C) 2016 Noralf Tr=F8nnes
>   *

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

> --=20
> 2.25.0
>=20

