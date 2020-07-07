Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4806C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B039C2064C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWRbvYte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgGGQhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:37:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5852DC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:37:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so16953170plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tpEtStuuUNWaWcekpXbmRCYVDWUKEoN9UQEytlQoMNA=;
        b=QWRbvYtevNLOJmeGxBSDFY/eZo0dxB88Fw+NOjvbcuLjnb2aN8bcstBwmsWGU2QmT3
         bUIa+giaNRn/VH7kWiLSlRL8mgf53PrGeb60Sv0ItMCtzgI0iA6rMAD1lVELGSk8sb+O
         IerbrlsJ7wtoXca1DWg6hoGaR/fRhF3IsU3AioBIz7XCwp2rJ4uvdcUtw+ta4/GdpbOm
         k4HAltctMITLK/M/Iv+aF4VgWr3ft2YJrwRpZ9mN0DTZd/HmhPU26VBTpfEkcs/EroYf
         WpwkBjc7P/BRwmptWey+3u3JYXZh0z42Ep4hHXa3X4MYwynXAmzN0uKgyg7L5blw6XfS
         0Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tpEtStuuUNWaWcekpXbmRCYVDWUKEoN9UQEytlQoMNA=;
        b=uWdkOPFsQA3H9tIWX7y/hFCkOIJMv0YvG9Q0oaLKYyCM8jV9KYPR2ZeAtyomXQ+aLo
         D+ad+E4QHBySi64j9Qdr5xEMPOmVkv1iEszK+zDB0ls6V0mZsmvyfzlUk0LW63ygdLcY
         WvLBeVCmJWKYRXjlScy2tlzFHk6M/BHu8XP/fbzjPMduOgRfeWELXrLYY9yqwOSNhcmQ
         nrA1YAonxqijvqDcBm5OMWe21vizgoGw5q1nD6xwrDcmb7ubue9Um7GSUy8rdsub8yAi
         3t5PF+KHXxvOEyJf0MSViyDoT69i2Y6r/PM48e3IGjwDWNjDZ3oZUKpM3O2ngYtlcWlI
         Yjsg==
X-Gm-Message-State: AOAM531Z/FnfHBNrgn2SEf2ZY6hv2vs/VMZIoSErXAihHUHlfa/qWmwN
        L9UjjA26aeyaK+pU1R9ujpc=
X-Google-Smtp-Source: ABdhPJyKNjCHH0BDQw7FOxBdvPceKxDKXyVEYqxXgLDCOvH4AHh3me2dvG8A5G8TgIJzbm7tZKXHOQ==
X-Received: by 2002:a17:90b:388d:: with SMTP id mu13mr5007252pjb.187.1594139856893;
        Tue, 07 Jul 2020 09:37:36 -0700 (PDT)
Received: from blackclown ([103.88.82.137])
        by smtp.gmail.com with ESMTPSA id q1sm23990690pfk.132.2020.07.07.09.37.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jul 2020 09:37:35 -0700 (PDT)
Date:   Tue, 7 Jul 2020 22:07:21 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 4/4] drm: fb-helper: Convert logging to drm_* functions.
Message-ID: <0d37c7a614eb0885f0f0bed18e48a4d26b345a8e.1594136880.git.usuraj35@gmail.com>
References: <cover.1594136880.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <cover.1594136880.git.usuraj35@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Change logging information from dev_info() to drm_info().

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helpe=
r.c
index 5609e164805f..88146f7245c5 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1819,7 +1819,7 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_=
fb_helper *fb_helper,
 	if (ret < 0)
 		return ret;
=20
-	dev_info(dev->dev, "fb%d: %s frame buffer device\n",
+	drm_info(dev, "fb%d: %s frame buffer device\n",
 		 info->node, info->fix.id);
=20
 	mutex_lock(&kernel_fb_helper_lock);
--=20
2.17.1


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8EpMEACgkQ+gRsbIfe
745CqhAAm5+jRz2BryGJAhQ63JjwoV23MMrHqFbdj/ZFEvf/ZHfS/f1byk7GNGng
geCq6RU5c4bzNhMTYMHcsk4A5RnY81v4Yi2HJQBlroPJW+j4lrQu7QGVot/0YUJc
SxL/WXNhkZz8tDt+IaWPSEuQGIR+u91Or0sMqJDS07qbmRc4tG9C8IWHdOVUV6fB
+9SJpq0OHj8BCEW7P4RPJe9kW0TSDpAQ6OMSIujzBlEQUYtdDIn1xOG6w1T0w9Ev
j6ltqMuuFhO+XTFTZSSQ3in/sL76/SwJcO5vS7YvhEWsXR6yJf60hRtviCosikgr
jiAjJNxX3VQdSM5rA4rlib9FKYD4tmOocNs+tGQ23rW597BfA4RfihYpgym0pTrt
tVoJV7M4W2NP3Js2uFljX7sfJSL/SMRtl0608KFzLH+3flop/RRsPDbMicbwpkbo
ekZYaNF7Bu4Atbd3G7yikBnPRg2h3HI1ZVKrl+kVgkForjCn5lvlEJgMWHQe73Po
8bK1a7bFdYJ9j9cMxiLkdFIQNBtVMuBYeLwcJIZymzMoNkT0CqgQaY8YH4lz2pMH
IL+cY3wIWdWIoXdpHNlSi0eTZxRd1D4SaqVuT/qtnIZfSXYErBeA/UjuoLBOpyN5
5MgWkGZejTCYt3eiMJNNWIuqnbAI/kIv3zH0wppbJF2A5kAKRng=
=P6hX
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
