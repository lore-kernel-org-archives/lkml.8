Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826F5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F2A20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="hH8W2oJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgGBLUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgGBLUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:20:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D20C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:20:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bf7so1874917plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=w32r7hP9DyDdYKhcgit4fHbtLWUQgHNgxb3Y7c+rxpY=;
        b=hH8W2oJbiuals+PcHNVm7hmYsiZVfkIogdIqUTC/fcLnRcsKxm0SLQ0Aw0GPyUEQvD
         DFGHstWxhDzx/isFWh3bBA6DI6XGcr9l3O6eKLR/KVJ/xawPke0g5fkaowESqirepd/e
         ljSR8p+931wEQpbx5RLhIBPKAsXx/lkiPQPxyiX0z+Lj3cywCoPwBbcQasOB1DZjBThT
         Z/ziutu/3kLUjYccx5OqoevdLU4DQ9eghMNqNXntzBcVrXjGFSivF5RopNbZ2i6RdW87
         z6phHTamPlFf6PrXQfhpCgsqDu0mCfQc/z2aFgfn0VUMrhmXV5QUdJB2XAIapqfuESag
         gvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w32r7hP9DyDdYKhcgit4fHbtLWUQgHNgxb3Y7c+rxpY=;
        b=Or1raO8ua1DzLfTMhSXrAk3y8RMn2bIOVag2lKDGx88kwBYqh+6R2FaLckRO7ZPX4R
         o4hY4GN0DsHsbRpK+gbCJcaP3SpSsQKlvU5iRgKQC5DcCJ5iV0qeypovSi62Xsszck1R
         HUMX0s1xSeA5mfm2K2SU/9ZshN57aYZZAvCV2sWpzQyaRr0N6ogUZzydvyN1nevdQ0fq
         /K2Cq3vDWzD/Biqk5pcmmJvBqJ57T4yLXA3hriQ5leoZEyTCcNFms2HcQxaqaXmoMcl7
         pb3nkSvJx8ozMs1y2/CWljAtBKn4QAlMw0g8ew5ZEhkIHlGl+sJ1YOXcIpYAC0IVgvz5
         6jhA==
X-Gm-Message-State: AOAM531WVEGy40pHF8Eze5CLRpfDbTptq417rFvruoQxGjIqzH/OSqOu
        B2EbbDwu/pPTyoQyHdjXx6g0ENV4fFY=
X-Google-Smtp-Source: ABdhPJxyKrvnwA/G6ip9llUHSVcbD3cH52NH4wYdGk7r+mRgXdFqnKp1QbolGJ5p5x4+nIk9t/TDeg==
X-Received: by 2002:a17:90a:2562:: with SMTP id j89mr29546187pje.218.1593688817973;
        Thu, 02 Jul 2020 04:20:17 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id a68sm7979172pje.35.2020.07.02.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 04:20:17 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 2 Jul 2020 07:20:09 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: include: rtw_recv.h: fixed a blank space
 coding style issue.
Message-ID: <20200702112009.6qe6v3rb5n7jklsh@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ec5skvv4ljvpvhat"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ec5skvv4ljvpvhat
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


--ec5skvv4ljvpvhat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79wukACgkQ471Q5AHe
Z2qzmwv9HGfnIeRPc6bPWSi8yr+D5OnkpdgD8B/keJnaXqqaCWdHHRyko+of2Jlu
xe/xqU3pTln6YyynMYXIx3A+lXmbRKHr269OGMztg9VV2smu8sS3EXODg8G7GnjH
VfHa2vRcyHhyWQnT3TrZ+6rntn15wWuhHRVtTlTCO2BcUX9YPvm3OPL7UPZJk2MI
zZw8vyFwK76dvDZDJl8ZI+7wZefqxKiMXnSOVC2SzKiVUbvn+ExYbXk3BSABquIy
v6gn4/ZBIZTFECdDOxWsqPvzDBoW72KrihP5BFUUMBlF/ZQ2B2zckHXnCYYwyBnl
AIpb5Tk0pkyVDqxWXX4M4GlF6Rmd8NjDN3N4tCEH3ba8duJvWFKkYGoq+sMUkcc0
SKyWziXwBRlE8t8ZICiXYfsOBV0SkVTO3iC8j4lzY38H8V8uP90iNrV0TwY+E+Ra
G9TPLU619Cx1D2J5m0DUkG4F7txUViM7Wgrl10tBGSqQj1SJZXyTSvzQ1wCCBDIx
QvShBdK2
=ukqj
-----END PGP SIGNATURE-----

--ec5skvv4ljvpvhat--
