Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D591C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7567E206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="odw7MW7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgGOLsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgGOLsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:48:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AE6C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 04:48:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k71so2956498pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YYh9K8cJouoOanNJX0CMw+9EzOB1DbASwVmDnH3JRbk=;
        b=odw7MW7iFK3zmx91a4C2xDaTDcR6UlRD2QAZp2XnTclmxathnkyBOnifzt/D+sd/Mv
         eTB8vgKNQ7504P8E5iSg5+ZK7WhbJPYkGkePe4E9e2YlV9O2HQdRYiFPz8mmXZfjWuTe
         QJBcY8+dXOhdiitGuRZxXew79DF4rrSsGbqmh9BzF+yP3klVBX1jEGstuAEpIkS3bjOM
         KZH0qxZNffLwO6RXnGq996M+Nb5UdR6NXb5YgncKa4e/rckTVBhBtMhTelokZW1Rl7dT
         zf9P9ZHTQRKmfrUc1AcDBGOY9b8U02P/Dtd5Yzo0TxUX9lq6ONo0nr63fGDSZe22+RJT
         fOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YYh9K8cJouoOanNJX0CMw+9EzOB1DbASwVmDnH3JRbk=;
        b=rsfobFv4lfZbssp0KPWqzJYfpJmi28bKQDUCfzodwma7QHYfQEY+BJrKsKJTe5NyVY
         V+j5g1HjAS5VDwGzKh09izIKmijytHeiP0K0cBJtHOitKptcN7etY9bD0j6NVxaOcQy+
         nW2sNSQf0Ze4ILMd/pElsWIhItUeR+4dz+9oauNmh4+5TJOv3+CihJ0xktoBEwvj/HgS
         bIlVCWl8BwNvYpoyvqlGRi70Em1RV7PY+omF45C7epLUPSWAXD9/wjNKRUANvI8Y2NrV
         N4WJhym/RnPmeuv2ROrYwuyTZ6LHUx4akqZQpoy8IdsfZGP9MkZu8o3rcCLhD8+rSjYe
         Kj+A==
X-Gm-Message-State: AOAM533tvcaLaCMsy3CeNB5powWc4T0cU+SKJMno5LhBoIte7RWz9lOV
        zYJa2XOLMVYcXgxSwAheWqvETA==
X-Google-Smtp-Source: ABdhPJzbaHWSVCNl0ayrHSTvHmubCUPfeQCQiKCGpmYgmIE892fHY6/zH2nTYHV9cd0t2lrty8DOcQ==
X-Received: by 2002:a17:902:c389:: with SMTP id g9mr7682257plg.317.1594813710204;
        Wed, 15 Jul 2020 04:48:30 -0700 (PDT)
Received: from localhost ([2406:7400:73:f0a7:2c34:cf79:3b68:d4ff])
        by smtp.gmail.com with ESMTPSA id t1sm2071063pje.55.2020.07.15.04.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 04:48:29 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Wed, 15 Jul 2020 07:48:24 -0400
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: comedi: comedi_fops.c: added casts to get rid of
 sparse warnings
Message-ID: <20200715114824.rwqemojowcivbc3z@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sbo5b73lqh4tgbyq"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sbo5b73lqh4tgbyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fixed sparse warnings by adding a cast in assignment from
void [noderef] __user * to unsigned int __force *
and a reverse cast in argument from
void [noderef] __user * to  unsigned int __user * .

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


--sbo5b73lqh4tgbyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl8O7QcACgkQ471Q5AHe
Z2rUcAv+Mv/M4IjR2LBnDKEVt0y5x7f5ni8mu0VrvPhOvSnsRugubeoQAlDw+n/+
dCwDvB7tRwmNazanRsMepcG/2OOBO8iCgCsgckzYFplln0YhkNc1lwGvgn3/0UaZ
hpifMxOOHb5lTquUDRmcywVWVCleQ7Tod4VljlAjcWYLaEK2JSClvjIvxXYpG0FH
L/Ry0okp9qFDa1QLxlHF/K6Ts/MLfaQsQW1Rt8iwzdCC/gfcREp2p7ufQJoUXPPT
A0f12d0ubbd4ZFO02O0lonxr5QpEa7B0HsS6gQmtTjKLGxUm+/YC8O4rElGoL+I/
NzbPmpTchEFQyH9cq2aiICf9yndb/xlUrj3YtiZdjR4MhdOytohF1nI80pUsYADc
QPxf0CrA+IZyrfV27n03F8LKKdi2K7dNUf0a9Al0hnk4ch+dXnX0nxRor6DxpjUA
Q8PtHqTl3m62kWA8CcQDY0XkyadGaIPoIatfLkQAnowqtiCbi3tL9vUnCSBib8Ym
Ix0vBQHQ
=KGUY
-----END PGP SIGNATURE-----

--sbo5b73lqh4tgbyq--
