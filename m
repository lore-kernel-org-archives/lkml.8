Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739CDC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5473D20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bidouilliste.com header.i=@bidouilliste.com header.b="kcXfTlk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgD3PlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:41:24 -0400
Received: from mx.blih.net ([212.83.155.74]:28049 "EHLO mx.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgD3PlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:41:23 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 11:41:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bidouilliste.com;
        s=mx; t=1588260880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=siSc+wVCx92pO4nia33BDv08pe+zzvG5bnkde4Ef3hA=;
        b=kcXfTlk8jeWIUSRjFrlM1hLlaNQ+UzY1clgxUrwxs77nW0P4bPIpQOiyS/Gq0/Q/ofMfZW
        jSYNHrh0No9Ku3Og660SQ+pU3e4h5FM4vb2Zvkm1qylrZxk2pH/C28ywxDzg199NuECgTv
        5oBUbiuhidnkf8U/cMVTT4Iie8xbGjI=
Received: from tails.home (lfbn-idf2-1-900-181.w86-238.abo.wanadoo.fr [86.238.131.181])
        by mx.blih.net (OpenSMTPD) with ESMTPSA id 9728d90d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 30 Apr 2020 15:34:40 +0000 (UTC)
Date:   Thu, 30 Apr 2020 17:34:40 +0200
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Emmanuel Vadot <manu@freebsd.org>,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@linux.ie, daniel@ffwll.ch, matthew.d.roper@intel.com,
        noralf@tronnes.org, kraxel@redhat.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 2/2] drm/format_helper: Dual licence the header in
 GPL-2 and MIT
Message-Id: <20200430173440.c006bbf57e70671dc4c324db@bidouilliste.com>
In-Reply-To: <20200430150634.42zna3xwhj4cwsnd@gilmour.lan>
References: <20200430145537.31474-1-manu@FreeBSD.org>
        <20200430150634.42zna3xwhj4cwsnd@gilmour.lan>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd13.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 17:06:34 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

> On Thu, Apr 30, 2020 at 04:55:37PM +0200, Emmanuel Vadot wrote:
> > Source file was dual licenced but the header was omitted, fix that.
> > Contributors for this file are:
> > Noralf Tr=F8nnes <noralf@tronnes.org>
> > Gerd Hoffmann <kraxel@redhat.com>
> > Thomas Gleixner <tglx@linutronix.de>
> >=20
> > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > Acked-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> > Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
> > ---
> >  include/drm/drm_format_helper.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_h=
elper.h
> > index ac220aa1a245..7c5d4ffb2af2 100644
> > --- a/include/drm/drm_format_helper.h
> > +++ b/include/drm/drm_format_helper.h
> > @@ -1,4 +1,4 @@
> > -/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/* SPDX-License-Identifier: GPL-2.0 or MIT */
>=20
> You changed the GPL license there, was that intentional?
>=20
> Maxime

 No sorry, fixed in v2.
 Thanks for noticing that.

--=20
Emmanuel Vadot <manu@bidouilliste.com>
