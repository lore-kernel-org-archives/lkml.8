Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBFAC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2C2206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0uP5apu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgGXNNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgGXNNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:13:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10787C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:13:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so5189815pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=z3pjaW36cogKEyknKNckTQL/q8Z1xXLJ/5WkBR5tYmQ=;
        b=S0uP5apuijcyF3rIenzN46xRP/z0k17iE4rT7zBDGMSbEcSLZZs5ccO6yPSfU+9PZF
         Z6COOoC6omjF0P32mwDCNv2UXWo2aHq+5MjIQzmvtG2uoGXbgCVM+lH7Vym/yyOvNBLo
         QeCRAgzB4clEUdpjDhVML8pXWeQYnbboEWmgHvfUOiVKv5anaPNnPaMpN2hce+f3wWPf
         vj1rS+n17gdPxFXru7RJ1BKjSuSaF79cvwBQzq2nilKiOZzSqTal0jxGXsIY1WCWlzb+
         4nEpqrCEsvfJA7pO80onwZZq/aRSyVxYN7Wo/wryyTJwqQVRlbTQxAs1waaWmQullcZE
         eRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=z3pjaW36cogKEyknKNckTQL/q8Z1xXLJ/5WkBR5tYmQ=;
        b=Er2SjUiZltfmQPHl4UI5MEnM5vg99hBLoQ48KtGARRbotQ5wLwx4nJygCHXBqN8BOZ
         PU9G6rSJruKPcGZO7EDFYKh3e4l+TiMLLLkmJkwia357s01JgL/QmZ+UcNr+NjaxwiDi
         13lFfayWL6a+9MZhrvxl8SvSfZTf7e2J+uTqZDjKpOcLl+LnakAmHXtWyfFxuM8xhb1J
         +5RxcaGmpmtffWNJxH6c/lNgIdCfG6H8dnaqnu4tM4kzL5xit4E+R9QBMUCTFUG9aZUB
         h9KwrZNCyuOvjhAd984eCBy2FLrJN7lmykGfsbgGkVXC64B0wMsKueG9CcRJx3kptvGr
         6EsQ==
X-Gm-Message-State: AOAM531H+EPHbdBWlYZr3/8BBB5XTk26PmnNxHb3fDtSk3AgmG62wTRf
        rh+qv4i7GYk7vg1dPm0U1tNsaloSMi4w+Q==
X-Google-Smtp-Source: ABdhPJxLo0fWK9a2kLjDqdHBvoEZWi9RA5vpybQeN9mmD/SMiu1TNkUytgTA2bW0TukSbmOyOFwgow==
X-Received: by 2002:a63:5d1:: with SMTP id 200mr8675939pgf.59.1595596433510;
        Fri, 24 Jul 2020 06:13:53 -0700 (PDT)
Received: from localhost ([1.22.41.181])
        by smtp.gmail.com with ESMTPSA id az13sm5737837pjb.34.2020.07.24.06.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:13:52 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:43:48 +0530
From:   Mrinal Pandey <mrinalmni@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        mrinalmni@gmail.com
Subject: [PATCH 2/6] drivers: android: Remove the use of else after return
Message-ID: <20200724131348.haz4ocxcferdcsgn@mrinalpandey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fojb7p5fnf3uaodi"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fojb7p5fnf3uaodi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Remove the unnecessary else branch after return statement as suggested by
checkpatch.

Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
---
 drivers/android/binder.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f50c5f182bb5..5fdf982ec83b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1969,9 +1969,8 @@ static void binder_send_failed_reply(struct binder_tr=
ansaction *t,
 			binder_thread_dec_tmpref(target_thread);
 			binder_free_transaction(t);
 			return;
-		} else {
-			__release(&target_thread->proc->inner_lock);
 		}
+		__release(&target_thread->proc->inner_lock);
 		next =3D t->from_parent;
=20
 		binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
--=20
2.25.1


--fojb7p5fnf3uaodi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8DwCG1PwaC2uTI99xIwpEWwxhGQFAl8a3owACgkQxIwpEWwx
hGSLjRAAiX9TAAqD7YLFOyEuodwxQdHbmyAiQINV+t1cXXm0pXOCnpcZqxf9do9F
7lm6siMyDHoPQNG4xlV0NU8Xbabhk6pFs7QUykq456MgaLm1tQ8Ks+GylPHaQNNz
HQKRHhUhAwjC5U+iY7JZkdKcA9/xBpt35jVOpOAJ7zgsmq0J71pJwN36AFsHtUiH
GIKFS1R6kmNcKyUFGLo+J5lZAS4xQwpDrF0QlwUbK141Z5K15ewNX+JSb/Litek9
O9f8qk3kBEtdug1BuLiG62GQMyf1KRlvPau0of8qM+WhcXbnZqeJNkqwEDrK3ep/
oL0VNYNh310z5n6JGKQ5GtTOgN9wcgO4HCw99b7+DfAYO2u1tc3EhcWkHr9PU2fC
g2gqrvzCkhNcCsHdzZ40NnVnIliiukrHbANv1w+juAGr+gGaLxr/YB519IedoiHY
Q5KTNraQaNAvT9y6XjLkYwAJggFxB/vsbnpgpkVQOHQdOlpdzkK6zDXr7ybffX60
FH0pThGfyjJZGg0lxWBPScJDpJast3PndtqekFANh9VfZc9TRMswEgMImifH45M6
BY2BtdX5DMcV2xUN8dW8ZbzFy67wzJKbzk1FmWU3mt3/fh6oacyDS/FIVNPBtYPq
YodppEXlLmOe760wK30x84ccv+1RpKzJNyHK5h8+TFn9JpVl60o=
=KV2L
-----END PGP SIGNATURE-----

--fojb7p5fnf3uaodi--
