Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95883C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675DE207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="mGIKW6k4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgGPORz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGPORy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:17:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CA6C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:17:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md7so4753767pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rEeIaOldDGNkjFcOuft9AGbgxpRWfSHpKo4JvfAcXn8=;
        b=mGIKW6k4TxGGkzHtFF3wKDWKOgsrV88cP5ed7M9sUknwmJYa5D3/6enGw4Yq8NPu0U
         CSHGb2CfNe8wexNxP7KNcPBQwMAuQt80Wiz6T77N72qf1mGK8Vc1O9P/m7iFU/Kuo1jL
         HtssFEpKxPwtZIeXCV8kdmaFNkPOmIvXfnjahFC1xMf4d8VEc/352ajCnQkMg3kEv+kq
         YbO5qpze6zf3rL4tjo4sTBzfVThYBiBU1v9MP8MruTnvwgkE2uHACdCaAY2RC02TChn/
         oO+JWuuvnksVzZLzRXJv/c3ylbavlzfzAKJSdy9lfIsAc0tkwv0DUc28uEhjjiwq3in4
         wWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rEeIaOldDGNkjFcOuft9AGbgxpRWfSHpKo4JvfAcXn8=;
        b=aVd48irUZ3EKIyqf88YsD4QyiDCgkrkgRYX+HPN3sM/l9V1QHlfuoaHvxPyJHaB5Z+
         w68pZ9qYLf6DjIsm9A6CJDCOmFS26TmW6FZ78bzNfB1t5+QO/NEUJMe3Rk2KyrpSJNeB
         tCCuNB7xxM4bEk5cekeiscnjoyH3kF8BOvkjeqnr+o8Xu0I4w5VQbOB3tJ1NJNszsrw/
         3QZOrHG1Kp0p/7J89ZyRZsUmtEycm+F6uNSpGd/MGTkyTXlWaQ15LjvmwToN78xVZoPR
         jMjJHv0mGk0HcV3bxqWCi1PAA4uTY17xg/L5VEudtcZw6uouEqMABs3cWQrH9cUAbw17
         K81g==
X-Gm-Message-State: AOAM531BhOtJN/DdZmAFjHzM/gZ13lu5i4cISiQJ3fc4xNrdbIuoOcxi
        nJWJ2FT+HzEfHnc5JL2b8RfuTQ==
X-Google-Smtp-Source: ABdhPJzorlas012rUFUtmkee7W89cvDYC8KxwWfBaT4RjUZgzUmMOY2Z847ju5xrQvvZN1XAg1ho/Q==
X-Received: by 2002:a17:902:bd90:: with SMTP id q16mr3536713pls.54.1594909074008;
        Thu, 16 Jul 2020 07:17:54 -0700 (PDT)
Received: from localhost ([2406:7400:73:bebb:9750:968d:7cd5:3ec7])
        by smtp.gmail.com with ESMTPSA id n15sm315045pjf.12.2020.07.16.07.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:17:52 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 16 Jul 2020 10:17:47 -0400
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: comedi: comedi_fops.c: added casts to get rid of
 sparse warnings
Message-ID: <20200716141747.wewrnejrygosqhd5@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zyxfsogd63ii4ru7"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zyxfsogd63ii4ru7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fixed sparse warnings by adding a cast in assignment from
void [noderef] __user * to unsigned int __force *
and a reverse cast in argument from
unsigned int * to  unsigned int __user * .

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/comedi/comedi_fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/=
comedi_fops.c
index 3f70e5dfac39..9cdc1e8a022d 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
 	cmd->scan_end_arg =3D v32.scan_end_arg;
 	cmd->stop_src =3D v32.stop_src;
 	cmd->stop_arg =3D v32.stop_arg;
-	cmd->chanlist =3D compat_ptr(v32.chanlist);
+	cmd->chanlist =3D (unsigned int __force *)compat_ptr(v32.chanlist);
 	cmd->chanlist_len =3D v32.chanlist_len;
 	cmd->data =3D compat_ptr(v32.data);
 	cmd->data_len =3D v32.data_len;
@@ -2983,7 +2983,7 @@ static int put_compat_cmd(struct comedi32_cmd_struct =
__user *cmd32,
 	v32.stop_src =3D cmd->stop_src;
 	v32.stop_arg =3D cmd->stop_arg;
 	/* Assume chanlist pointer is unchanged. */
-	v32.chanlist =3D ptr_to_compat(cmd->chanlist);
+	v32.chanlist =3D ptr_to_compat((unsigned int __user *)cmd->chanlist);
 	v32.chanlist_len =3D cmd->chanlist_len;
 	v32.data =3D ptr_to_compat(cmd->data);
 	v32.data_len =3D cmd->data_len;
--=20
2.20.1


--zyxfsogd63ii4ru7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl8QYYsACgkQ471Q5AHe
Z2pdswv/eH6bR7z/dfqHeEvgMCkUBSMsHEZwIofJ73sEiS9x4p9iEdVHIRDo9CQ/
O5mOXQWbdAd5LH34YahhT07MV7W5CLFC0/t0qLm9qMeDdIMwJBz8ZI3kgkJZ+Gfm
tSK/CEF3wgglkhuD1OxPWPZJZzyUVbGOwsBcWQdR1vpf1CXatE10T5niZr9QEhZS
QjoguQEHmjpuUfJoYJHH/29sQwi7uDgzVjEGCwB+fzBRt2nOwf6kGNd5B55q7DNn
bFfaAk6Xx8K9TNFBpFoFnEefbjOL7ew3OIO60aF1A0SqqJ5vW18rUnWe3EeF+Bp3
hmwGCc2usRLifx2pgQ3FVUUX64G6EaBms1YO3ok+j+KBazM6HiE+TrTjA+CSbhv2
vnwVCDu6n7cck675mNEypjCoQgdBcQ3rGCbaOxe1SyB07ZwvZGyqXwEZCC33wmDw
rEYTAWc1q2QKhhTfk3Z+oDcc1jcrNOvTyKTSHPqYMZj0AUcXIBUoZ+EvVbexOD6f
BtUoBfk+
=5tym
-----END PGP SIGNATURE-----

--zyxfsogd63ii4ru7--
