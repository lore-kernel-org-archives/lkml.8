Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30C2C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F0620731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="g6mJ7QVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgD3RnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgD3RnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:43:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C7C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 10:43:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t3so6624984qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IW4+oneEvAWkOsDviGfjkPQapL7Lb3e5T9feItSCKYI=;
        b=g6mJ7QVf09kvhuPzY4IiFoJ560v7yeRDHnCM6ZDWbwpnOsBo6+7zv2pLbUVAtITFYn
         L8IR6eY/EKZ43dH1uJAPmzmHdhWo1leFYokPatkGCK2ME88QeGdMAIxuUQZowt7fjPlQ
         Ru+G16lSTJ9ZtG0NcWbRQ5SOvoEVLbzA2FfCU733ko6a0e7CJP4ywgUYG4fML6Bb5elU
         6ysT4ofgB03RpIyfKQjmoNDXSO81wJetkTN3w4aSkvBWNqwWwwV+f0W7B0RdkLhzpCiX
         +Xn2l9RgGlpsDYYPpzzB89icqS+vBR1dbQl/ZOJx0eQbRr/zjfjANj3Hhqkv7x1PqqbP
         g0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IW4+oneEvAWkOsDviGfjkPQapL7Lb3e5T9feItSCKYI=;
        b=ukhSGjlcsu9wYVOIEdk3D6uIYwllNq1RdodpNiwhT15QT2KhvaaxhSkg4u1CtMPIPY
         4HseF0Bq8InU3M7DfQKs7XqVCADvqkp8JxbjqI9UXaEBNnj6pKoLaTd16p0gFugyqUT/
         ZYGI+Nt/UIVXW6Xk/gs1+UpdwAgiWlhrBBT9rCiVB/fuDYY5uA4hDnL/uzAdsDvM4Z8j
         i6eWNPXRhWwak6Tco5SldPvfFCPVoPU2NJAbM6ABaBQIMI37K2C1kmm73SXSVYPHynEe
         LRzRREW3EtN8MQPk0ZjyAP1ZG2gUdN7DKXmz1sP+4BGYcZ9Khsl5djadsizReJyFyjN/
         u0gQ==
X-Gm-Message-State: AGi0PuZj6iq0aBUatEiFEEqY5AlOGAtrdTcMHxIXdffXFypZl9xxsNzA
        vr1kE0lBoWoUrLIKUxeAZnPURHxL8DDDlw==
X-Google-Smtp-Source: APiQypK/FFlu9lluECG70Gz5FZSzggGL9pU5PcR/BvR8UNS5AToOVyS3gQQR53A0LgpUKwccIF/4mA==
X-Received: by 2002:a37:b3c1:: with SMTP id c184mr4761166qkf.194.1588268591752;
        Thu, 30 Apr 2020 10:43:11 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id j76sm537531qke.114.2020.04.30.10.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 10:43:11 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] scsi: mptfusion: fix `make htmldocs` Warning
Date:   Thu, 30 Apr 2020 14:43:07 -0300
Message-Id: <20200430174307.69233-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make htmldocs
./drivers/message/fusion/mptbase.c:5057: WARNING: Definition list ends without a blank line; unexpected unindent.

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 drivers/message/fusion/mptbase.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index c2dd322691d1..8e583c4873ac 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -5054,6 +5054,7 @@ GetLanConfigPages(MPT_ADAPTER *ioc)
  *
  *	MPI_SAS_OP_CLEAR_NOT_PRESENT - Free all persist TargetID mappings for
  *		devices not currently present.
+ *
  *	MPI_SAS_OP_CLEAR_ALL_PERSISTENT - Clear al persist TargetID mappings
  *
  *	NOTE: Don't use not this function during interrupt time.
-- 
2.25.1

