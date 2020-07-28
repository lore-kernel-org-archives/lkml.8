Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71485C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9A22074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fubHBv9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgG1Jw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgG1Jw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:52:27 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FEFC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:52:27 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so3815390pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=8+yogr7brAWLDJcwCnUoYS1XP1412A3Rr26Pt7QIAnY=;
        b=fubHBv9mJNeiLXcv+uUMIW8803OIxmpQWNAr/gsDf7OUHKi5xBaxjtNDf/ALWdMj1L
         vBy24dUxgWAcpVMGLemne8WGuSFQJzKJggJOLoj0j34nfZQ7f1VB0x30sM/U/cRCZEFx
         O/2la/pJY3DYkx2EgAmt6q6+Pd1u0+a9Grxa7cW3Vel7f4jKY5psn22E42Z7ysLGwWuk
         5d93fJzYd/d3s4VD+fnH4ndaJT4i+l5TFlC3tbkp1TSs6zgKRT3oAdkbo+ofyKZWLWgJ
         LCmxLApKpQOebFamu6Jq3ZMlB6h7Z4pMiTS58f+XOer1lbXbWgEjPaUFAGljajAFrZdS
         F2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=8+yogr7brAWLDJcwCnUoYS1XP1412A3Rr26Pt7QIAnY=;
        b=WxzzwGuJY+NHWrYbpcdGnvnReLigoyc4XB9M2psoMsZNxvlK3z51S2Ko0Qac1si+6q
         XI0uiLCvhEkiMXrIzEEoEhpKbP8h4jGeoY+VSAlKpi+kA60pUdK+5rmw/zAwC2xl//I5
         6FPm+bZdMrdU5j+OTdwH7BiCdCgV/lNQwYvwBPGqv3OeQFKsia9IB6jT4u/nXLa6ROEp
         wLCPIQv6EVJdzR/iiF1JfhgO4Cfg+laJfZSZBGPzLZJfiHBHzRc+V+WrW4d+PobH+Fl9
         ATS4uVv8fxoZd2n9H4X5oypqMReju7f44a0f53zumfSMhUIki+cwJ8321AQ7aqaaj5zE
         L0nw==
X-Gm-Message-State: AOAM530aLTA0XTlpvyGOJaR13fZP7W6QHQwRuRXmzAxEv1huyrF2Vqb/
        EKv8wi4zEzLKcIKOwLhzsHc=
X-Google-Smtp-Source: ABdhPJzR+AOe/yKHtO/Jg1QAafqG4SZmbHNxngYkXZP4q/2jiKMACf7/psprPrbRiRL63rC/MWU2bw==
X-Received: by 2002:a17:902:b207:: with SMTP id t7mr22284056plr.135.1595929947023;
        Tue, 28 Jul 2020 02:52:27 -0700 (PDT)
Received: from localhost ([203.90.99.222])
        by smtp.gmail.com with ESMTPSA id b82sm18179014pfb.215.2020.07.28.02.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 02:52:26 -0700 (PDT)
Date:   Tue, 28 Jul 2020 15:22:20 +0530
From:   Mrinal Pandey <mrinalmni@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mrinalmni@gmail.com
Subject: [PATCH] x86: entry: Fix a variable declaration coding style issue
Message-ID: <20200728095220.sik3vkg3mezfacuf@mrinalpandey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aaqgttgog47jc6o2"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aaqgttgog47jc6o2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a line after variable declaration as suggested by checkpatch on
commit 3c73b81a9164 ("x86/entry, selftests: Further improve user entry
sanity checks")

Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
---
 arch/x86/entry/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index f09288431f28..0b094ed0c956 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -55,6 +55,7 @@ static noinstr void check_user_regs(struct pt_regs *regs)
 		 * state, not the interrupt state as imagined by Xen.
 		 */
 		unsigned long flags =3D native_save_fl();
+
 		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
 				      X86_EFLAGS_NT));
=20
--=20
2.25.1


--aaqgttgog47jc6o2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8DwCG1PwaC2uTI99xIwpEWwxhGQFAl8f9U8ACgkQxIwpEWwx
hGQe4A/8CZld1avA07f4Dx2k40P8xF3gODWKQPA7st6F/Z/GHUs8FkSmarrvdH1b
9poNzLpNMfhFuBOGyHhW4FL4Vx0WfC2kT4ijyPawnGCMZ4EYwgxP8M5BpdEwkUjp
xNj/uswnXNTVa8rOzQsrz6AzJrOHZcJZMbXCI6mYcHYL9wVpYgxK/ZEzOUqjgpTy
2H8NyrrvKJx2EuhzWzjilFkjcnTgJNL2U5Sma3VK2o+cT1HUHhWBqDMW39tjuprO
s32NKsALqoS62h5iYfbBAZrS34ollfh1tPabWQY0RIa93tal7rYEQzvD8Mnxtplq
S/K4WyplmOaWhjmsY/H+7uA7UZ46KaZFTXN9HbLdO97qA/uUTv8Lrxg86y3m9Dxu
GYpB6vgcf/W8PPU8O08M1xrz5HAYzn/q03vKxMwsIHHQrF0Pv3wCFcdVewoxjALF
ZkHSo0xcysJL+D+OISYGypl5yhGcP0O1McjvtzBkU5R/z9qqSopidOwoQeNP+Cvv
HnlJyFKOcTPSuOJxyElltaMMGJNQaWNzXMr3aMmi/Zqj1OgN1vgtxnuNghfFzdwj
rqW1SLInTUFpmLyt8MH431YKECavh2FiysmaB1LeapYvICoXxlt60sf3XokD3Kb1
bx7VeSRGbAsnHCqkzr1+f3xc+P+DfBwQ9qBJkdv1NbY9R48CEI0=
=ARve
-----END PGP SIGNATURE-----

--aaqgttgog47jc6o2--
