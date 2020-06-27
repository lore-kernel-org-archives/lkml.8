Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF423C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935DC2081A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="TbpQiRi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgF0IEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 04:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgF0IED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 04:04:03 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CFBC03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 01:04:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f2so5151074plr.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 01:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UsRF0j4rrxRKvA1UyS8rhzR/RWgKiuyQcFsgvNg9glY=;
        b=TbpQiRi8NY0HFitXaKdcmNBluTQudFq1u/tH2uayiKU8dVJlJOtd3gwc6Y1QT+I5EG
         fOrNKfvN1l+8mqWTcfmWF5byvMqGYFe/nT3zUAeGzn9b54faJGauy6uIhcXuVPDIXAok
         Hkh9Vv9hmoVSNMmn90OzT0txBUuaTHtgQbQsbToVzLRwSETBqC9XyAxemNEB5ldvs07v
         +A+tT/O9OWWD39TUgfd3Qo5mBoCejJYDUbNa8LZOwB8Qk1ion9pIPM7dyf9ufWEp5yBN
         I6ar0gcbe0RIuv2OPIlLtEC0oEFDmQh1hVuzzoElVfOgSkbbolUNKaOnJEZqjhS4wgRd
         CxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UsRF0j4rrxRKvA1UyS8rhzR/RWgKiuyQcFsgvNg9glY=;
        b=MLE4/nKToTelwwLK/QvTzCRTuWux8QlzOgVGJ9W7JhRVjS+uqn8gj7CdmvRNIZrDyi
         tjSpOvPpAi31YYbNQbTeznMMEZuIRs+LODzeEmd3DPr1GXtA2wiCuaolrBwyphUOcO0M
         azjhLQKztPhreafx1k/fbnnaXvmNnsUJ+DiDFEPg1mCVyo9QL0k335ynnPsBkm3JQcJm
         YO21gBzLNx4TV8pl5i/qr3eBDLb119MuBq6SjDf+DX9mwmSY2uUb17aDbC6WMaxqdrR/
         Ub/AXwZNMa9O97iEntABAZG79mL9Exj+89Uy4mhQ9xIzTPoui1agl2fmq+jr6lbjr76Q
         IGew==
X-Gm-Message-State: AOAM530/jwGi219MIJv3nC4T1D5SBdPwTAShttYkzxKGofogcObWYGUS
        9PxHD+g53YI761QM7ShcCJNU4Q==
X-Google-Smtp-Source: ABdhPJyCmqo+SjeH+EGbrQbqZBnhVubIDT/KAeIFgl+KTsUqRxLet/nO6XHMvIXIYO6xsFJEwQVy3Q==
X-Received: by 2002:a17:90a:fcc:: with SMTP id 70mr7100898pjz.106.1593245043079;
        Sat, 27 Jun 2020 01:04:03 -0700 (PDT)
Received: from localhost ([2406:7400:73:59a9:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id f14sm24865722pgj.62.2020.06.27.01.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 01:04:02 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Sat, 27 Jun 2020 04:03:56 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: rtl8712_recv.h: Removing unnecessary blank
 line
Message-ID: <20200627080356.6xn3ycyl3zgaddmw@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rjfoqw5l3upm3eni"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rjfoqw5l3upm3eni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Removing unnecessary blank line

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8712/rtl8712_recv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.h b/drivers/staging/rtl87=
12/rtl8712_recv.h
index 3e385b2242d8..69d3d5b287d3 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.h
+++ b/drivers/staging/rtl8712/rtl8712_recv.h
@@ -84,7 +84,6 @@ union recvstat {
 	unsigned int value[RXDESC_SIZE>>2];
 };
=20
-
 struct recv_buf {
 	struct list_head list;
 	spinlock_t recvbuf_lock;
--=20
2.20.1


--rjfoqw5l3upm3eni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl72/WwACgkQ471Q5AHe
Z2pHXwv+KY4+qlPWcAThMVWYxSkx8O4R96Z1nCUBRAlZx3VCxUmf9bnSTlWi+6MT
hKE68qKIg4llOfzdaFjTbg4vx6BC3LURgotRHIQSi2XN9zQQbQEWC+/cxIyeDLAj
S1ToLulbFeqiyJLQ749eoAag8C5aEM3q/Gsgy5h9BJMNKCadC1gSC9p/yYgHeX0X
wSxQi2sh7Fu1VNNnYPJ72RguKswDBW0laoTg1nZh568DhRnyYDdIzMghSyHcHRXz
ILX5HyI/RZowpWBtYuAjQdjYIHZhiBTRVDhC+GL3KuYrSsD+Am15BnIGjkWLjv6q
8MQPn/JkgTZ16YocEYLiUUqNtjgoIt1DXapqy7c1xtAZt2OqLKbG/IYsDxq8f+dz
k423wr28iSuFq6GmXi6AaBEgdxXSnbDQVTWAJ251AuT4ftdPzxz2Iuob73DHVrAJ
D7SHgdRXpWM6X0LOdWjI4F+O7UQ1lGIlzUi0sncYR3P5CifN+kjhYveCCRPxqetO
SBguEUOk
=Uso4
-----END PGP SIGNATURE-----

--rjfoqw5l3upm3eni--
