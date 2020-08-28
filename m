Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73454C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43ECD2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=platform.sh header.i=@platform.sh header.b="CTuRu/o7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgH1Ukr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgH1Ukp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:40:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8354DC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:40:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a65so370040wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platform.sh; s=google;
        h=from:to:subject:date:message-id:mime-version;
        bh=q2pQKfeaOzWSi6CUHIJMwHXcKtH5pCrULL5ZDMKlkRI=;
        b=CTuRu/o7mxYTbRzRFrx+DT/dTspoLQEaddP/r3CR0c3Fm2JXWdGC2jK1O3KzE2Bk7J
         8HvPlMVUPW98ArCYanE3wGH1d0trM926i9jFwgds5qycJM7ODTQCnP5RJwWq8gl217bT
         5eReL6kPDPUqW4Xcu90OPZU0iB+XG6dGCkr5DG9vN5AGrH4ZPnGqj+BlIfD/+Fzq2NLr
         JwgsmuPF775a26gMTLnnTNcZMRYoyop8xBTLgDvxti7DBZxJpIADABp78GSdeRJUv7eG
         GbDHVh/cEGNOyQK9tAqHfp84q0pV80OvMKNbT/3YWvuHPI3m+EDV0zSF/Gr/ygTxV8x7
         8xuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
        bh=q2pQKfeaOzWSi6CUHIJMwHXcKtH5pCrULL5ZDMKlkRI=;
        b=aBQRbvz8PHpLXaY6c1la5y8OJcFt8+JB4QZCENWEMTQvUHdF2PeyRSkBJ54Br8ZiCH
         JpZDj4JTHPx5OYEVYk9ACBoEUL4iue/uhur6KLTUqaZ9piIWXQiQEj8T+hjLqKhhQmFT
         MBHMTK2h38dkaYD1z1Isd7DR8wLymAX+gy5U0r326AMwFNHcogb7FMgbzyfktA+rwdRa
         V+M8Tfgsaq6SYBrXxdALWthvuW8/cFof2renFI3V36e+Nx9GKKDEcILdOnei3RQ6oFvg
         Znd3JnPK5w2ScnYrozmYtw84+MwFi4Zg1GttXt71Ulq2g8fqp3ErvUkFvwaGfHug8fgq
         f98A==
X-Gm-Message-State: AOAM532FqUyvaBU4LrhTa3xYAalWLqKZ/Ab/UtYGQ3ax85O4d6IEGo8V
        pUJbWZfNxppa1qaHB8zKq7pVkw==
X-Google-Smtp-Source: ABdhPJyAChRL7WbnFOCeBZUTUUrTFcIIVciCOE2kL7KZk0KYgf9j9JXAvCE+3vlCKBaukZC5uTtcQA==
X-Received: by 2002:a1c:e1d6:: with SMTP id y205mr411788wmg.92.1598647242980;
        Fri, 28 Aug 2020 13:40:42 -0700 (PDT)
Received: from localhost ([2a01:cb1c:111:4a00:dec6:dcf6:5621:172d])
        by smtp.gmail.com with ESMTPSA id i4sm906085wrw.26.2020.08.28.13.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:40:41 -0700 (PDT)
From:   Florian Margaine <florian@platform.sh>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: allow do_renameat2() over bind mounts of the same filesystem.
Date:   Fri, 28 Aug 2020 22:40:35 +0200
Message-ID: <871rjqh5bw.fsf@platform.sh>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

There's currently this seemingly unnecessary limitation that rename()
cannot work over bind mounts of the same filesystem, because the
current check is against the vfsmount, not over the superblock. Given
that the path in do_renameat2() is using dentries, the rename is
properly supported across different mount points, because it is
supported as it is the same superblock.
=2D--
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index e99e2a9da0f7..863e5be88278 100644
=2D-- a/fs/namei.c
+++ b/fs/namei.c
@@ -4386,7 +4386,7 @@ static int do_renameat2(int olddfd, const char __user=
 *oldname, int newdfd,
 	}
=20
 	error =3D -EXDEV;
=2D	if (old_path.mnt !=3D new_path.mnt)
+	if (old_path.mnt->mnt_sb !=3D new_path.mnt->mnt_sb)
 		goto exit2;
=20
 	error =3D -EBUSY;
=2D-=20
2.26.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWcDV2nrrM20UJL9WhD9tdT2UlyoFAl9Ja8MACgkQhD9tdT2U
lypwJwf9EREx2WxfBtFjpa7yNEjDYbIOodiFbryItKgq6N15qEbjknxg/y9za8VU
ZNu3VCspRP0SbONIgp/ITWxSQwvUqwVn8w/HW0Pva4kv76H2bHp6lKpL256qYTJP
9hMpUTeONNvJXaxhicZ/nh7XysBIFwzLwKY1JzkkCpbZ7GcBR8gX32d1llMYxPi8
Is5kjsbjNCibv79Gikh4bIf1YYtSPQKkGNW9CrFwFwIwN9HFhAomhP2T0Bby6+dB
6+ZT7ikGg78SmMYS9toARYtRtIQEhM8XD3Uvje/iyMXf1aYaNKAYWOEbE5CXb7K8
HFZVQX0OIQuFnE92hDs416581OU4mw==
=6CII
-----END PGP SIGNATURE-----
--=-=-=--
