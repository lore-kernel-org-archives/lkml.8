Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A10C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEFF2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgBNX2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:28:50 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43014 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728143AbgBNX2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:28:50 -0500
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 01ENSnGA026543
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 18:28:49 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 01ENSh4E019961
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 18:28:49 -0500
Received: by mail-qt1-f198.google.com with SMTP id l25so6982783qtu.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 15:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=vINktuQgp+PRYkidQo2UTOSF0ZZjvGjPM2QLr9Gqgms=;
        b=IVpGuJhnGay7oAvfJDLesGlabRxZBv9rQ9VVTQtFRPZwtD8h6jbNxsZAziYa8nmDxg
         omkfBfknyr0TLigZX7VOsVaHgRyzH7IuVgldEUMBcExx+88ShdzX2IWo814Op13j+Tzm
         1gKf5vOwK8JzfqHquPmxqsnbOA4w+PQxJ1q6Egw0TNOn+yDzpzRsuH9rMRuLmYs5baUq
         upxZq/F/36U0BhtBKZJt9IhyQqAHb5t1EydHRw4mTUG6dlnUoIApWIuqsANTTCPGyN7w
         WPY4aUiFB95sY3/B2yUNjcLbQydMBeunWwYkesPSR7haGTZTB9V3QNsppOdBbmSIsCRG
         LplQ==
X-Gm-Message-State: APjAAAWmaCIcSZyBXz047zRqO86ccOXdFTHkN80syrTXAlNhO9bmkSED
        r4UI3qcM+ivmveElPwu053hk8KR1/iLXe7zbm6lKkQTF5LKNLKecfQWivZNckTs0IDQkjlYg9un
        oEyCK1IZ3IvQ7Dk/56d6nK63fugrTjX+D974=
X-Received: by 2002:ac8:7b9a:: with SMTP id p26mr4569752qtu.281.1581722923726;
        Fri, 14 Feb 2020 15:28:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCMAu3tbJMuGYjLKFMmp41nmTLTE48ratNYze090QXvU8CiiTs4aAMLRW0ldADjsw9582KWw==
X-Received: by 2002:ac8:7b9a:: with SMTP id p26mr4569744qtu.281.1581722923426;
        Fri, 14 Feb 2020 15:28:43 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id b7sm4211541qtj.78.2020.02.14.15.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 15:28:42 -0800 (PST)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Namjae Jeon <linkinjeon@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, sj1557.seo@samsung.com,
        pali.rohar@gmail.com, arnd@arndb.de, namjae.jeon@samsung.com,
        viro@zeniv.linux.org.uk
Subject: [PATCH] exfat: tighten down num_fats check
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1581722921_27211P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Feb 2020 18:28:41 -0500
Message-ID: <89603.1581722921@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1581722921_27211P
Content-Type: text/plain; charset=us-ascii

Change the test for num_fats from != 0 to a check for specifically 1.

Although it's theoretically possible that num_fats == 2 for a TexFAT volume (or
an implementation that doesn't do the full TexFAT but does support 2 FAT
tables), the rest of the code doesn't currently DTRT if it's 2 (in particular,
not handling the case of ActiveFat pointing at the second FAT area), so we'll
disallow that as well, as well as dealing with corrupted images that have a
trash non-zero value.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--- a/fs/exfat/super.c	2020-02-14 17:45:02.262274632 -0500
+++ b/fs/exfat/super.c	2020-02-14 17:46:37.200343723 -0500
@@ -450,7 +450,7 @@ static int __exfat_fill_super(struct sup
 	}

 	p_bpb = (struct pbr64 *)p_pbr;
-	if (!p_bpb->bsx.num_fats) {
+	if (p_bpb->bsx.num_fats  != 1) {
 		exfat_msg(sb, KERN_ERR, "bogus number of FAT structure");
 		ret = -EINVAL;
 		goto free_bh;






--==_Exmh_1581722921_27211P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXkctKAdmEQWDXROgAQKUcg//SK4Oh8O9nWTtwhEQehIvDaoVWDePrXvW
3qpFT3YIwUe0xYR6Hv9rHItrsnBxmLukieAcL3TWQPLAQEryrUf1TStLJiGNssLw
lYZWnTQKrttQ2DA0QBf51WPHjvY0kvtoLihQzI7hdd6lKPQnd2kJ2DmM1r+eG2J5
HQExoCOYpsCQEjiCqBg0YUGB7po3Om0ZTNJWGjy9G79KdVBmtYJ07Qvv06UpBLiR
gW8h7uAkqMRU5oBohd3Wm1MQaaLfp50hDqQ4StHEYgngd88e3rtXt2Q2TN9mqEyH
AB0c0ruN8hDN3wuydo2iewV2K8oaPaxuG3X+9WY//1qOlE3BU1LB6lULx4Q9Ui1X
Du/TIM/fotPOMX+TKqZuMwz334a5qVNfbnLQ76bpoTxAMPuvyJi3k4GfvRFWIDCQ
GYZzj1TCY/aqgucLH/X7Se4FIdBhVKZaoWWiN0isQQ5kokBEFM3+ZGMbIRvxRcU2
XYZ4S8rPyoGytX6WLimzqVOJvNhfZCio7VTJq1JACNbgGIzc1dbqQkI4vW4NtmUe
0Y8LOviFu4FA/VomTIiK8AMKByWuCUrRqX2FtKZR6mLxm7fp8wOms6G7jW490MBW
zoi2IpFFgMRVjoSpX+uDbs7OpJSrrI3Alr6GBgqdq4anSpRhNNQz0o3abBVm4XTz
6FK4oOHqZ28=
=Tcix
-----END PGP SIGNATURE-----

--==_Exmh_1581722921_27211P--
