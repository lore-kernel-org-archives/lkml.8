Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2571BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5C0206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="Jfv9QkFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGBEya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBEy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 00:54:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3DAC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 21:54:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g17so10800646plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 21:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=c4ZY+KBrUiqE7hKU7U5jCIHmx9RVu+3pKzZBaIVD28I=;
        b=Jfv9QkFWbkiV3rWqr0mzkXKK5pxO8QpF2guVXmfA2QI307ux7YkKxM/0u/TjN33y7i
         dXzQr9U2Xd1L8M8FTNWGleetqHhuQnUnksHvm3H9rontzgOoH/lRBRIdYQxtclq+0uQe
         zluqKAHahibcGLLrfTKZgjoXY6vFn+vXoTrwjvfFLyi2XExw0PCSgRIvJtbL+g3cdi/u
         5a7DMLBBkLe6DkaFr93/WkZRyMx4ulAMpQjMhUQtnch3wUX81di/abW5la9ebQtafLh2
         lB/RBzGVVYzmqhRQtSfEFWW3R9WOtqZC2Jr2SYiDoYfSaKAxvfi4IUiiMDyPKGSDSolv
         MDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=c4ZY+KBrUiqE7hKU7U5jCIHmx9RVu+3pKzZBaIVD28I=;
        b=HDjYwtTmH4Txp2+jSwPs+XD6k1/4gUIIoR/O5rEz8xh6TjGEasom8wgJ4icczLQLvi
         +sqiX3JqhqqztOoVhVNCJ4rUEalJeWDmCtpMsVtto2lKaf5oJS0R1hSZfYmYn/ZGOaQj
         wRWGuKcNZhFpJNCORy6xT4oE0U4UWnt+QkwEFc1YmwVeK/0SHhs+N/oH7xJnzmzEM9f8
         IhJQsuHOukp6dFuXtIWdFSv1KFbzKeYLONcllYwj+1HHAksPrWYYkNSDqATuFpo1vNxu
         w2GLUuIjoYY5Po68Z4NpHAUcAjo/ZFrJ/dShtLiBHkp9mKJ7pJmEnE5eFdPg1Tjo425F
         lxUA==
X-Gm-Message-State: AOAM533NfPJYSW/fTFZ8r5EFgu5CF2+CQnWGOS0opa8VUajKTPV/jHxq
        3vBQfSPRcFveSudw8f3bYry7Xw==
X-Google-Smtp-Source: ABdhPJxkodt+bF1jpzMbrhq5utYnPCW0/q19I4RBd8/NAN6IgXJXgtrUqkNSMNRjjIrKf0SWPUlQ+Q==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6mr25186526plx.287.1593665668799;
        Wed, 01 Jul 2020 21:54:28 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id q29sm7290417pfl.77.2020.07.01.21.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 21:54:27 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 2 Jul 2020 00:54:20 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: include: rtw_recv.h: fixed a blank space
 coding style issue.
Message-ID: <20200702045420.tdbxeonfby7xytw4@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="prm3plxrhabn5k3o"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--prm3plxrhabn5k3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

added blank spaces to improve code readability.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8188eu/include/rtw_recv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_recv.h b/drivers/staging/rtl8188eu/include/rtw_recv.h
index e383cb119e1b..b281b9e7fcea 100644
--- a/drivers/staging/rtl8188eu/include/rtw_recv.h
+++ b/drivers/staging/rtl8188eu/include/rtw_recv.h
@@ -13,7 +13,7 @@
 #define NR_RECVFRAME 256

 #define RXFRAME_ALIGN	8
-#define RXFRAME_ALIGN_SZ	(1<<RXFRAME_ALIGN)
+#define RXFRAME_ALIGN_SZ	(1 << RXFRAME_ALIGN)

 #define MAX_RXFRAME_CNT	512
 #define MAX_RX_NUMBLKS		(32)
--
2.20.1


--prm3plxrhabn5k3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79aHwACgkQ471Q5AHe
Z2qZ4AwAiBqZnVjnWebi5VaCN7um86RMj/Bz8i0kSjFsngccXIacshQDJjiGqVxI
+68ILT1LJXZALyeS1PdHySLt/DXR57yDJtZZ8df3/2EQWGl1LZc4cgDt1c4okKtJ
zWJeuHoOGgtgpGpLVOU5qPb5EyRSYJtqO/xPBPYtjZKqwBy7xOpEVPyUFuYzDhC/
oJlzPlC+s1PFcFD4wN+zJ7Z+pXhWXNNJJSDYLxqdoD2sI5cvzDKYtqvXChrhVFS5
B+AX8xEfIA8ZnEDJatoM5DdAoqo8f99f/Zt6akzYr3He9KU+esCX9Q8dx1iAveDt
st+RmzQ7lRDVGZD1RKpjqs8ZjzD1kEYhZjrJwwf38DdrNu5w2mJcKD0cNGSgbz5H
7QA6/qAdxG79cFVxN0rui3JYefXYV7zq69//tPwzXCIkQj6xxTU88XlWjE6xGfcq
fLIWS1EM9Yxy6hC+gjtbRnShIJ2cPT5XAxT2ar1IZevgGA6tGNIZNxdHkuN3KD6j
hUzSpJeP
=ZLM1
-----END PGP SIGNATURE-----

--prm3plxrhabn5k3o--
