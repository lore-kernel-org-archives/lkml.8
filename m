Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215FCC47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 22:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DB820774
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 22:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="j/cqKE2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgD3W5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 18:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727092AbgD3W5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 18:57:10 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8872C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 15:57:09 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di6so3947324qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwaXAKuRd0apGvpDhNCHAFUyDcZ/LeyJTl3LHyQWiwI=;
        b=j/cqKE2I9ySEFXVhi1aXMr5JuwvMm7JmEKZQt9D1LKparoBCiIz9P+hclLYO3dpOK6
         wEnlqwAeq1CjQyzGb7mYaSuxL1S5DmlqXLKRy9DU9YesLL6oQFLCHrGATgtWl0lZjuHA
         8f9Pu+RFSIvkBO1IzH+dfKLlUDQf0/f33yIRIep/p4XsfICyiHk5vYhzM/NZ77znJjeD
         M7aDOETzdkccWELfAyjE1Y2SnynbI0ZnmBaOoUDGuop4Ziv9AVMSsXOxlWn6e+QbQhHm
         S8XwlhdU7DYpNR04zkVp8pzbtjtBKFN1AhOSlbH98Xeua0/yvQ3JaFsRNB2cqLYmokso
         E4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwaXAKuRd0apGvpDhNCHAFUyDcZ/LeyJTl3LHyQWiwI=;
        b=GPsk55qB1uTlRArp78xmwRrVGiUAyl++erz2IICl2PbZJ9Or5AjzmOjG4ZPhOXGUo0
         0u2JyBXqXDjCjhFVSsE524TfWvzsAOjoJfk2yr5p+X4LvSOL8YSQYrYRB+Ul83MeVMAq
         YmLOa9pC8yMLDgIAGzVsrxAJFb5wgXwrV4Eoz09B2ouHEL12YqSky9x4GL6dWA6+gVsu
         4tr8BrjjlgWpoFD7691XJgGGTbeW8KJFNCHGLigBWS01JjsbG15rD4bVnVT51Xu0GHtO
         ipeOxaTa4SNCuqUYc0Q79jSg5DUP5bMHZYqsnLzwFb0ISCtntL71Cifd8VkSCY1l5Kc9
         /80g==
X-Gm-Message-State: AGi0Pub8aNU8wal6Vm+Wp33nHCGzYSeH4IAAnlJRp0YmeywXWQN9Aa2l
        vtRswuZ6p2Sy77ogIGVxfcQfsA==
X-Google-Smtp-Source: APiQypLmKZaE8wkTc6wcMU+OIG30tDXPV6fy6mEI5P2ZFUFQRWrRo5Vo6qL0nK17U8rkzEV1qNLerw==
X-Received: by 2002:a0c:fd8c:: with SMTP id p12mr1343371qvr.163.1588287428897;
        Thu, 30 Apr 2020 15:57:08 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id x194sm1258439qkb.131.2020.04.30.15.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:57:08 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     linux-doc@vger.kernel.org
Cc:     mchehab@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] doc: misc-device: add uaccee to toctree(index)
Date:   Thu, 30 Apr 2020 19:57:03 -0300
Message-Id: <20200430225703.113909-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:

Documentation/misc-devices/uacce.rst: WARNING: document isn't included in any toctree

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 Documentation/misc-devices/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index c1dcd2628911..1ecc05fbe6f4 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -21,4 +21,5 @@ fit into other categories.
    lis3lv02d
    max6875
    mic/index
+   uacce
    xilinx_sdfec
-- 
2.25.1

