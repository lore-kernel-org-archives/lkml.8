Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2FDC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2300220702
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEhlXiHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgF1OuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgF1OuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:50:06 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D2DC03E979;
        Sun, 28 Jun 2020 07:50:05 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so9621692eje.7;
        Sun, 28 Jun 2020 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1zigYgRRO0ONYXURNqrQgGhLyNX6ERoSrFBybbOwfo=;
        b=nEhlXiHrnPi4V+nRv+KfSN0zz+t0kobmoVztNqOuEcqjB0YXMoCl4YvSWMXwPdGl6i
         yPUpIpSEKcY/8VnhpN/hfEmphkSeDqRsYayaFW1T75UgjfGPmS6MjSLYueBCVsvxba5p
         GTdfa66dYHoOC3pmmfKuxJQyDTAZPl2BTl7f7nHC0crQ0QF68OUlmLjFttVxO4akMS2L
         R7RWnQJLeok2CoN5du4eCArkihMxwe+U10fy4L2+99fbZKRzY5awlIm+gG52BwD9ctVT
         jyziXCK+kXpY5YI3YGpbt7XMGR1CMB0JVMrGRDzX6JORv8foEbl09SFFcrxLu8s3taT4
         2T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1zigYgRRO0ONYXURNqrQgGhLyNX6ERoSrFBybbOwfo=;
        b=Zlq6aETGMWKsaJq9kSM/Nx+75gIDmfUepyJlDHBeRFNXgBF3nR3xevA8KvX4U1jn+a
         Qgn6+uz3slkNzcgHtqu+4ylcbYM5z9bZFuv09PQ4/QmqaTQSMv4APgMd0LCieupu6ukO
         vWIx8emsZuL9zG+NZuWEbIEviGCn4CYWg7iy86vhDTvkTjgl22OjC0wZ1KtiWrgLiq6g
         QT2z8xkQRHkjoWklTdYjbeSEr83gCHcTBTff829CmPJShi+6ry2lvq2jLqVL9mbIKIv7
         X9oD7PfW6gavsZjDp7V7DS0CKYwVyKdnoDky8PiPBSCdyGoxwYTCq7IOj8FjpXaJX1Iu
         3Buw==
X-Gm-Message-State: AOAM5309FSh1ckO6qAPihAB6hnmauW87HD0re9gFsi6olW3o9j9f8w3K
        80tDONl31DgO/21ptO2tBzLskaZa
X-Google-Smtp-Source: ABdhPJyhbKCsNh6t45fFwW3y8KDtdmQRNureOQv/4kYFR7sVB4xgCZel1lwDUkEMYtfHoiohspnBNQ==
X-Received: by 2002:a17:906:1db1:: with SMTP id u17mr4994044ejh.72.1593355804429;
        Sun, 28 Jun 2020 07:50:04 -0700 (PDT)
Received: from localhost.localdomain ([188.26.56.128])
        by smtp.gmail.com with ESMTPSA id qc16sm6859768ejb.33.2020.06.28.07.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 07:50:03 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH net] lib: packing: add documentation for pbuflen argument
Date:   Sun, 28 Jun 2020 17:49:35 +0300
Message-Id: <20200628144935.700891-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes sparse warning:

Function parameter or member 'pbuflen' not described in 'packing'

Fixes: 554aae35007e ("lib: Add support for generic packing operations")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Hi David, since the original "packing" submission went in through your
tree, could you please take this patch as well?

 lib/packing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/packing.c b/lib/packing.c
index 50d1e9f2f5a7..6ed72dccfdb5 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -73,6 +73,7 @@ static void adjust_for_msb_right_quirk(u64 *to_write, int *box_start_bit,
  * @endbit: The index (in logical notation, compensated for quirks) where
  *	    the packed value ends within pbuf. Must be smaller than, or equal
  *	    to, startbit.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
  * @op: If PACK, then uval will be treated as const pointer and copied (packed)
  *	into pbuf, between startbit and endbit.
  *	If UNPACK, then pbuf will be treated as const pointer and the logical
-- 
2.25.1

