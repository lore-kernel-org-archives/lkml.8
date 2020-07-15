Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002A2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF150206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="G/qxY342"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgGOEsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 00:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgGOEsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 00:48:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74E8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 21:48:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w2so2355042pgg.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 21:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ucz8GbnPJF4zpNltFDDoIlnK5RPRDiSbEKeMvIDNSms=;
        b=G/qxY342vJe0TGREY3YmbBetGnnrWnYSMmwtMiu1E1yW5Q5crieV0sU2SkdHMzW0Zm
         9gIEsyWvRKIURZHMCvBXhuhAnKVtiX3Nl6+tVZuhs73soWS77lUp9wMeNlf/gZ9sjsKY
         RT1WWIZNFYIH6AXDEt3JQMg7sNkbjS2JZTMfNs3MmC2jgrWUP5G3CqGtbL41Ic3J8yM2
         6T7WS5EiY0T/Nyym6YQOFYay/46bTJdcmG+yAawqz716GKwD9n0Ca2LHFGC50ukOvkiD
         zrOkfVX+Fiu7EaBNQnk0qXc1ZUNfQZac9zM0+2rnkg7QDV0XlNFXtwW1k6aSlajzKNwV
         dlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ucz8GbnPJF4zpNltFDDoIlnK5RPRDiSbEKeMvIDNSms=;
        b=IiqXYkRheWaO52dPop7YdEc0q1QY/P3HqoZHj/UJl/J52CXFvBPeDUdLN9ntUZ7acN
         eftccM2ahHKQKzhemkyxzu6t5z2irD2TFDZ0AwKl1By1haROkIBP6cpWBlnLIy9Fh7Yf
         HISLi+QZlnMK6FwtZZ+Njs/hlZbZdWQ2UxT2E2eiSyujNA4l/ErhUR/z7CChkLwv97lc
         0k75isQq83J2TKM46thBUPxUBOKDsombZ1S/mcUsHupVNQW4CH0/SqBeiQ2NdgjZ53Fy
         umskK/DS6mlcfngFt6724NK0tKoTIfpjGwaxq87/Y6oW3cwgPaffeu5yL3WsRo8u0VQ5
         XRAA==
X-Gm-Message-State: AOAM531kHsMgll3e5hQOHFVmOLz0yO5PXoQB2enreU0clIBP0wupnT7v
        S+WfCRKc106I9a3HfelowbT9WA==
X-Google-Smtp-Source: ABdhPJwhxsdWIPA0yjJiDKhAiqbCVublwsYTTGrB9SfJ7Gbn06a2TZiNwmlaBW6lpN29tcgxAhs+cQ==
X-Received: by 2002:aa7:9ec2:: with SMTP id r2mr7263307pfq.265.1594788500190;
        Tue, 14 Jul 2020 21:48:20 -0700 (PDT)
Received: from localhost ([2406:7400:73:524b:c130:77cd:11f8:53c3])
        by smtp.gmail.com with ESMTPSA id a11sm584795pjw.35.2020.07.14.21.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 21:48:19 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Wed, 15 Jul 2020 00:48:13 -0400
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: comedi_fops.c: changed type in assignment
 to unsigned int *
Message-ID: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xc3ogj6of4zis4qg"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xc3ogj6of4zis4qg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fixed a sparse warning by changing the type in
assignment from void [noderef] __user * to unsigned int *
(different address space)

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/comedi/comedi_fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/=
comedi_fops.c
index 3f70e5dfac39..4cc012e231b7 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
 	cmd->scan_end_arg =3D v32.scan_end_arg;
 	cmd->stop_src =3D v32.stop_src;
 	cmd->stop_arg =3D v32.stop_arg;
-	cmd->chanlist =3D compat_ptr(v32.chanlist);
+	cmd->chanlist =3D (unsigned int *) compat_ptr(v32.chanlist);
 	cmd->chanlist_len =3D v32.chanlist_len;
 	cmd->data =3D compat_ptr(v32.data);
 	cmd->data_len =3D v32.data_len;
--=20
2.20.1


--xc3ogj6of4zis4qg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl8Oio0ACgkQ471Q5AHe
Z2pzTgv/bcR7Jh7Awo66b4++4R0Rse5QDht5KJ4JwMALghXs0bUeKiIILQJ42zDO
wmpv/4hNFndKAB2QOWbE8gdTV/MQCLlWzOCT7g0o7JMk9DZfa6ZQJsRQ+bcChj7c
FLEOXx4kTuX7TY5YiEy5v8xGv8y5CScIg3t8ZndHb11Rem54nyE1d6EkdNBT6jfO
BDAX2eLv6AT68brxcIUYpj+ZN1Ak0a1krSmfeVqXirf8m5taeOdf7FmZwU35VwjY
wS3+U0fvjo+2oCnzsUYEmhNbA99fZCuOk4ZnvIvnHlvyWmFaP40Qa7hiSZmYwpaA
vlQU6ugQ41RsrUVmyuWXqa4k7oo2SsaSDABRzEUrjgQzunNQOJQ+lFQEoMCUBi5u
3qtPnxMqe89qMV4BHhZOBzT9NRu5n6h5nfPKOwPC2eaU0kzJPFDeIzDsBScp9neq
hm39BGXzIZzWMxhZcHWD3XuBtR/WxdLaSjZn5Cl0Xsp4s1QfGBf9pjgOntbUC/JC
OjTP/gje
=WlRW
-----END PGP SIGNATURE-----

--xc3ogj6of4zis4qg--
