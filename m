Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDEBC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED6E206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="M/m2sloD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgBTTsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:48:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33748 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgBTTsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:48:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so1963443plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 11:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jPFTRNw64J7Laq3myZUsp7zjb6I6nZ3YxdJBnUcsx0s=;
        b=M/m2sloD0m2fBrqMgSVgf5kaZ22n01WNDxYaBnnuT59TWu7EYnXJD7AnA80/LH+oXM
         NPoXc5sl+b5FaVr00p+lMdOmRhk0jVcJsvXqhk/6y3j7dOnYrKJDDaGy6rFBHUAorKWy
         3RIko9cDCWioC90dLHCXM6oycZbCsw8NsVkeWnIqWWZBJilj5xBg2QWep9YB7qFIVxH3
         yRM/4tZMOo9SaoljDB497cCI3VMkxz/20TZxI4sA6ugBMQ7xFYkr1Ra028jUPgFoleKp
         4JPXJorEeJMqe8SLChkqwmbz97xdKvjGF8CaukbtSYuUyhiUUCrlw/UnPZ5i03Zwhtbn
         6VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jPFTRNw64J7Laq3myZUsp7zjb6I6nZ3YxdJBnUcsx0s=;
        b=bLKk+1AV0h8GIBtMa2zjS39UjzRsxh15/l8Ts7VWvmyDqYSzai0Iykt/P/AT2xA9ga
         y0JO0oKI6i1sEfGjb5ERbyyaxnq5TZ5fMSkk/e9oQ3gA0xqBviyjciBZle2mMJcadwiD
         sqMaTqp6OLJpQq2qY9B6roj/pfs/oLSKZ6jnzIi6GPhITvSAWUy4k/tZN+itmRwZDFQ7
         HNUjXi0USvtmp1i4r8SO2yIRuR1L+4HH9bGbU5Nj92Jt1eaUIiJeI8AWiakUhFpsJzas
         yiUKzRIyUjVtLwTriaQoXas7YfGZmemyfeFyw4MA5quWHpKTwR8soVJmrPm2LqmLJ8ni
         5a3g==
X-Gm-Message-State: APjAAAUPYx9CUT9gHa8FBHmU2Fvu54132hzI49/Oq2QPuxJzPLBo2sPw
        kEjQT/BjXC+Ylpxh8NTPiNbS+w==
X-Google-Smtp-Source: APXvYqwEDBMoFhUXkuEbujLErxbJjw4DVap0LrUSEEibjgJ5Nn+zj8JDWIThUGIH5pPldiuqUL41Ew==
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr31849359pls.92.1582228110226;
        Thu, 20 Feb 2020 11:48:30 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id 76sm391082pfx.97.2020.02.20.11.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 11:48:29 -0800 (PST)
Date:   Fri, 21 Feb 2020 01:18:20 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: add space around '+' and parentheses
Message-ID: <20200220194820.GA13689@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl warnings of required spaces around '+' sign in
multiple lines in octeon-stubs.h by adding spaces. Also add space before
parentheses in the same file to fix checkpatch.pl warning.

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/staging/octeon/octeon-stubs.h | 34 +++++++++++++--------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 79213c045504..d2bd379b1fd9 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -11,7 +11,7 @@
 #define octeon_has_feature(x)	0
 #define octeon_get_clock_rate()	0
 
-#define CVMX_SYNCIOBDMA		do { } while(0)
+#define CVMX_SYNCIOBDMA		do { } while (0)
 
 #define CVMX_HELPER_INPUT_TAG_TYPE	0
 #define CVMX_HELPER_FIRST_MBUFF_SKIP	7
@@ -22,11 +22,11 @@
 #define CVMX_FPA_PACKET_POOL_SIZE	    16
 #define CVMX_FPA_WQE_POOL		    (1)
 #define CVMX_FPA_WQE_POOL_SIZE		    16
-#define CVMX_GMXX_RXX_ADR_CAM_EN(a, b)	((a)+(b))
-#define CVMX_GMXX_RXX_ADR_CTL(a, b)	((a)+(b))
-#define CVMX_GMXX_PRTX_CFG(a, b)	((a)+(b))
-#define CVMX_GMXX_RXX_FRM_MAX(a, b)	((a)+(b))
-#define CVMX_GMXX_RXX_JABBER(a, b)	((a)+(b))
+#define CVMX_GMXX_RXX_ADR_CAM_EN(a, b)	((a) + (b))
+#define CVMX_GMXX_RXX_ADR_CTL(a, b)	((a) + (b))
+#define CVMX_GMXX_PRTX_CFG(a, b)	((a) + (b))
+#define CVMX_GMXX_RXX_FRM_MAX(a, b)	((a) + (b))
+#define CVMX_GMXX_RXX_JABBER(a, b)	((a) + (b))
 #define CVMX_IPD_CTL_STATUS		0
 #define CVMX_PIP_FRM_LEN_CHKX(a)	(a)
 #define CVMX_PIP_NUM_INPUT_PORTS	1
@@ -1410,18 +1410,18 @@ static inline void cvmx_pow_work_submit(struct cvmx_wqe *wqp, uint32_t tag,
 					uint64_t qos, uint64_t grp)
 { }
 
-#define CVMX_ASXX_RX_CLK_SETX(a, b)	((a)+(b))
-#define CVMX_ASXX_TX_CLK_SETX(a, b)	((a)+(b))
+#define CVMX_ASXX_RX_CLK_SETX(a, b)	((a) + (b))
+#define CVMX_ASXX_TX_CLK_SETX(a, b)	((a) + (b))
 #define CVMX_CIU_TIMX(a)		(a)
-#define CVMX_GMXX_RXX_ADR_CAM0(a, b)	((a)+(b))
-#define CVMX_GMXX_RXX_ADR_CAM1(a, b)	((a)+(b))
-#define CVMX_GMXX_RXX_ADR_CAM2(a, b)	((a)+(b))
-#define CVMX_GMXX_RXX_ADR_CAM3(a, b)	((a)+(b))
-#define CVMX_GMXX_RXX_ADR_CAM4(a, b)	((a)+(b))
-#define CVMX_GMXX_RXX_ADR_CAM5(a, b)	((a)+(b))
-#define CVMX_GMXX_RXX_FRM_CTL(a, b)	((a)+(b))
-#define CVMX_GMXX_RXX_INT_REG(a, b)	((a)+(b))
-#define CVMX_GMXX_SMACX(a, b)		((a)+(b))
+#define CVMX_GMXX_RXX_ADR_CAM0(a, b)	((a) + (b))
+#define CVMX_GMXX_RXX_ADR_CAM1(a, b)	((a) + (b))
+#define CVMX_GMXX_RXX_ADR_CAM2(a, b)	((a) + (b))
+#define CVMX_GMXX_RXX_ADR_CAM3(a, b)	((a) + (b))
+#define CVMX_GMXX_RXX_ADR_CAM4(a, b)	((a) + (b))
+#define CVMX_GMXX_RXX_ADR_CAM5(a, b)	((a) + (b))
+#define CVMX_GMXX_RXX_FRM_CTL(a, b)	((a) + (b))
+#define CVMX_GMXX_RXX_INT_REG(a, b)	((a) + (b))
+#define CVMX_GMXX_SMACX(a, b)		((a) + (b))
 #define CVMX_PIP_PRT_TAGX(a)		(a)
 #define CVMX_POW_PP_GRP_MSKX(a)		(a)
 #define CVMX_POW_WQ_INT_THRX(a)		(a)
-- 
2.17.1

