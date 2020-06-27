Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1216DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C338B2080C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="jf1dEOdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgF0EuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 00:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgF0EuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:50:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62664C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 21:50:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so5868557pge.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 21:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tM82nN98PD/iFRUwc7s9SC6I4w+oHpo70UtnZbaWoFQ=;
        b=jf1dEOdAeA5EcCIR8qObQ/wbPHUqoVwwBs6kEVZMFsHVe4a17OlVzSNKDxqqqa5aYn
         FjULqXMPqT1uvOwx8jPezGuPvJ5zwfbSw8QL9UmJw6gE0iOO/UKDUZinUQK9LLbxJfrp
         g+TG2B+tmxymKLzCF12h1D3CdAczXMERXHEg4eDyaGSkz6i5Q7hXrW2dIkUtELRXyrkZ
         iIbX0WlZVRisshR9HXWIqx7BlVlF3n3uc6sN0YFH8U0jXPZyZR7nyDJW5oNN+w+5jX5N
         rbXcV0vu7mb4Q5dfJU7hwfT6kQJua2tPETOeLe7cqEA3ywsYOFPRXq++0SMSZenzWwPo
         gDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tM82nN98PD/iFRUwc7s9SC6I4w+oHpo70UtnZbaWoFQ=;
        b=OoTCEJcvTIFguIFg6kZqISp3Nw5c5IEQBYXL+q8VY+F+08umaEZkky2hxmEvGjByHc
         Dhna3mSTGdArR8bwxACi66jp+vacHJMCDXD+h3Fi3i8UmcLc2aYa4GOWrLtN6xbBnDdD
         PEyTUyxWltmyTNAdHg+RVkvHig5RX2fo7FjxwTm0TiUG/eGR26gvBIuOp2esBvIt1CFJ
         jYioY5CcHNac/6YlUDwTk+YTjTjK3JmTJHoAXOFtJt7Ve5E5lAP/Y+cUd/AwSTZchNVr
         ZIc/QmxIPgmSk+webX6fNWTdU02aGwbqUvR9WQA1KhNnhJksoAx1TssJgQz1A8W8xQ4I
         hK7Q==
X-Gm-Message-State: AOAM533y7iAwkmg554urAapzaP1cnLkVNjzzN9hQdH4Vww4aAiwr9ByR
        CyQBedIvmdFm2FXUmeYebq6ot2Qy5oATUw==
X-Google-Smtp-Source: ABdhPJw1T404vfNkBJqJi3CGby6UB/ljdx3K1oZ0OfkL5W4D7XFob76v7f8JkPz+QzojRx/fiIsWXg==
X-Received: by 2002:a62:8342:: with SMTP id h63mr5467050pfe.183.1593233410769;
        Fri, 26 Jun 2020 21:50:10 -0700 (PDT)
Received: from localhost ([2406:7400:73:59a9:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id 7sm13692079pgh.80.2020.06.26.21.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 21:50:09 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Sat, 27 Jun 2020 00:50:04 -0400
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Sebastian =?utf-8?B?R8O2dHRl?= <linux@jaseg.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbtft-bus.c:
Message-ID: <20200627045004.a46jbqtbiintu2nt@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wcjbyctbs2w26lm4"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wcjbyctbs2w26lm4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fbtft-bus.c:

fixing ERROR: space prohibited before that close parenthesis ')' by removin=
g that space and ',' in line 65 and 67.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtf=
t-bus.c
index 63c65dd67b17..847cbfbbd766 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                         =
    \
 EXPORT_SYMBOL(func);
=20
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
=20
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
--=20
2.20.1


--wcjbyctbs2w26lm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl72z/wACgkQ471Q5AHe
Z2o05Qv9ElUD8lscq3RLdrWxDC3fGK3n7kQZTWCQEFU+K0muQXceEX0JRhGy9N1F
8aGgIb3wumF0ZaWhX8b4HW7tivAQTkmJoKhWcYDzjrkfvFv/9viCvUw5A3SqUFoA
X919WgEO4epopUMRpK97SRksK1L6RACBVjTttO3BOX31i550BUSH53PCLtbdbiPm
F30wh0jIBPykPOSJXcctTTOYZXco03xpQ8J8POmfIGQVyluM/ZOjOL10PbQvJXlZ
SpqGUTwu3VRyPnSRCtBvvNHUNHUUNOMhhN1uG7Scrt4SONQJWe4trYHDSFaA838q
8QUXzwWFVRGYy9paUzdYPKH/B++F3xJ1//kySDxsSfYuZOaJIUc33gjOCCs+pkvU
sXzHAQdUPDKYm2S0WaZJqHHUDj1PRcJfIuHVxZCPegs5hcd5J6TECzhYrURzBadb
odcMJCHYpy/bt78inyLdi0CK8rseZDCJkHCfndjoWBVSclHqVlc9eGZ7X/xypu0L
r8Vq99ni
=7vSF
-----END PGP SIGNATURE-----

--wcjbyctbs2w26lm4--
