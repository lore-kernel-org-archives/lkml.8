Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953D5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CED20842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnM9pS32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgCCJCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:02:24 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39766 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbgCCJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:02:23 -0500
Received: by mail-yw1-f67.google.com with SMTP id x184so2687596ywd.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 01:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Z8TtSYaM0J0heqUPazLwZSPdzKTGtelUp+YBmcCSOQI=;
        b=MnM9pS32/iYrMbegTeIK+iyVXPUNLKdQxkpq5eI6Sv6EUnfO/ZkIXy4Qbl1lNHldPO
         KD+vCznjkDwYm46Z3MyozMoHasSAJUjIBdIOoCheV5xGnilazjAC7rvfFqpO04bwk3OU
         5lU2Yzw5LpF2361OpyQ5M4k+GfEH5j8ejPu4WdJOVmoonCojZw5SmTsxIH68jGMLMmuY
         tnZMOPPqm0b0diCLdpBzGa9ySOfZTy0dAG1mHBE+Ep5vVWOQkFFCm6apMRmANYsnHMQp
         bX8tebD+bmGzH2QyVJ36gqeijyCCa6Dic0vcoUz8acktmMCYrtmtHMGqMd+1TdA0Q7hh
         i1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Z8TtSYaM0J0heqUPazLwZSPdzKTGtelUp+YBmcCSOQI=;
        b=tOWPOoCGbawiajBNDazAN0Wk7GpoT2iHxj8MDcW6D58+D+Vdr1fhlsWbGhw7lqZ2TB
         ORRtvGwLXfqGbu7FpehgBof604PXFiN8w5DBJ73WjhfX9D0kmoHxUlDJv1vBVYWCnuYC
         JxivXITpb4QSwW81t1kM991rMAX+HVIrRfVyxflxKjMTYM/V5vluB4JmQCiY8uqzjN55
         IyOjc+32kKxchviS0oJY/Xm9VfuTPmpe2ZtbVSkUetyKjIjRRdBEdZ5bdZpUq5nmi3O+
         hqbDlScFzkm9hwTPTFY8Vnv9yRtqlFM3ZhadWi5X6zelpGzVZ1l0C1GBgDXj86+0RNds
         Zr1g==
X-Gm-Message-State: ANhLgQ2aNVD1yMba8fJsbLc1fk7Dg26x8utw1dexRuUdsSnFhWmlgdNV
        VjUaQNQXeH2wUnonpRzI7gE=
X-Google-Smtp-Source: ADFU+vuTquiZw2d05QpD/xexuO38xTrAyEL2a62gMYu0gILWXmxUXFEvLVXVmGfVk1iVqw6YX5YTDQ==
X-Received: by 2002:a81:50d6:: with SMTP id e205mr3287301ywb.208.1583226142941;
        Tue, 03 Mar 2020 01:02:22 -0800 (PST)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id 63sm7821080ywg.54.2020.03.03.01.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 01:02:22 -0800 (PST)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [10.88.0.2])
        by vps.qemfd.net (Postfix) with ESMTP id CC7192B283;
        Tue,  3 Mar 2020 04:02:21 -0500 (EST)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id A83DF6003DA; Tue,  3 Mar 2020 04:02:21 -0500 (EST)
Date:   Tue, 3 Mar 2020 04:02:21 -0500
From:   Nick Black <dankamongmen@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] serial-console.rst: break up code chunks
Message-ID: <20200303090221.GA1081508@schwarzgerat.orthanc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: there are two code sections here, not one.
Break up the RST backticks.

Signed-off-by: Nick Black <dankamongmen@gmail.com>

---
 Documentation/admin-guide/serial-console.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git Documentation/admin-guide/serial-console.rst Documentation/admin-guide/serial-console.rst
index a8d1e36b627a..b8c803afae2f 100644
--- Documentation/admin-guide/serial-console.rst
+++ Documentation/admin-guide/serial-console.rst
@@ -96,7 +96,7 @@ Replace the sample values as needed.
    open ``/dev/console``. If you have created the new ``/dev/console`` device,
    and your console is NOT the virtual console some programs will fail.
    Those are programs that want to access the VT interface, and use
-   ``/dev/console instead of /dev/tty0``. Some of those programs are::
+   ``/dev/console`` instead of ``/dev/tty0``. Some of those programs are::
 
      Xfree86, svgalib, gpm, SVGATextMode
 
-- 
2.25.1

