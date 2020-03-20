Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6A7C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BF420739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYQ26eE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCTFiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:38:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37041 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbgCTFiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 01:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584682698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZEKOl37iHz0FSwXOzROJ3kG19xR7xu6X68GlLT/jja8=;
        b=dYQ26eE3NHW5ijgqfQfCfFM5TRg3cxlPRRkqQ+QhLAgcT9MjZGTXpm6Ufhm+4H07tHijgR
        IWyByHhvbmhY9F0xc6xdKyFPhUbtCgJnJMpkwrNtkZqwlpWKKquozGIyCGfvP1+qEnrIJq
        eO68SpYC5Ssvx08mz9UjzzI6xXfVb24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-6xFPO9jgMlKuFY4syYesog-1; Fri, 20 Mar 2020 01:38:16 -0400
X-MC-Unique: 6xFPO9jgMlKuFY4syYesog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA7BD1857BE3;
        Fri, 20 Mar 2020 05:38:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com [10.36.112.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E397D60BF1;
        Fri, 20 Mar 2020 05:38:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D97E09DB3; Fri, 20 Mar 2020 06:38:11 +0100 (CET)
Date:   Fri, 20 Mar 2020 06:38:11 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Emmanuel Vadot <manu@FreeBSD.org>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        matthew.d.roper@intel.com, noralf@tronnes.org, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/format_helper: Dual licence the header in GPL-2
 and MIT
Message-ID: <20200320053811.od7wsoebalw3fwxi@sirius.home.kraxel.org>
References: <20200320022114.2234-1-manu@FreeBSD.org>
 <20200320022114.2234-2-manu@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200320022114.2234-2-manu@FreeBSD.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 03:21:14AM +0100, Emmanuel Vadot wrote:
> Source file was dual licenced but the header was omitted, fix that.
> Contributors for this file are:
> Noralf Tr=F8nnes <noralf@tronnes.org>
> Gerd Hoffmann <kraxel@redhat.com>
> Thomas Gleixner <tglx@linutronix.de>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
> ---
>  include/drm/drm_format_helper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_h=
elper.h
> index ac220aa1a245..7c5d4ffb2af2 100644
> --- a/include/drm/drm_format_helper.h
> +++ b/include/drm/drm_format_helper.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
>  /*
>   * Copyright (C) 2016 Noralf Tr=F8nnes
>   */
> --=20
> 2.25.1
>=20

