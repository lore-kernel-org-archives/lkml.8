Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4407CC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084382078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UO5xF0FA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbgDAHMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:12:24 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:52145 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgDAHMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:12:23 -0400
Received: by mail-pj1-f53.google.com with SMTP id w9so2313383pjh.1;
        Wed, 01 Apr 2020 00:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hz5qaXSjMSJnZU949MlZ213oDPmzY4IGeJxDJZAJknk=;
        b=UO5xF0FAmdNlzWkKhIdWtLFN78GB1BDya6bho8AuomDbns3qwL9M+SXArfkRTo40t5
         mKuoxznPxAWBjluPbVAtJfyqGWRE7t5moY6wPdxAPc2vtVL60NEX8SJ/3GgoVA5oRCgk
         Dk1XD3h3EmFpXVxl+XYnz3hd8NhXZCneKgC6ZkZksDFYEp3rLEa+eojwCVUZCxabqUIG
         tign7pGNpk3N8gHhPjvrf5tLmRiqr8G4uGabgCPIB9xO0JW6ELuPA4qkLnK7ZyB4Pkkd
         vg8yNr7/szjTy/X4depKHgF9q+Wd0vcTxV5XDFuXzxGnrkm2Ww5THhKRA5LJfKnOJyQh
         IGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hz5qaXSjMSJnZU949MlZ213oDPmzY4IGeJxDJZAJknk=;
        b=U2XMXNvjJX/8L5ZMnhLtio15o77LnYXFkfsvCSmUR79Qh6UnwAPYoRMmtTUI+GabpC
         4zGmOUHHxr+P/F/SIXmXLk4lWki0m81pgAPFd3Umf8bXZU9qbnDBVmLiexn/uhuTSihy
         LNcZn9rpd/1lfK18qKjoHUSfeOumLWBbNUkj1CaGBngOg1mXqFAX23VcwlXWMKKMM79R
         ILTBZHucabjxfNbqHXPVLK3sMs+RUV6OTERR2X9vqdxUIudgHzLLQG25utt1R5/KU2Gq
         2CyHrRCMvDIg+oKoDgbFpY6QXTnyCs9T/t3E6sa3fL0Fgo6x0dujcP5DVAwDaaMXc6Af
         /Qjg==
X-Gm-Message-State: AGi0PuYmNsVW4lZO7hHSsNbgsGOOfR3L/QD7nxQA4xdl+uJpxNSobvz/
        CuPQhbDVsIT8cBGbf4Efskk=
X-Google-Smtp-Source: APiQypIV2fiRm3YAnbewgfM7H6vNYSVxWbm0IfFdgiQwFIIuspNbZmUAmgVIU4iAZXRJ0uU+PXjDQQ==
X-Received: by 2002:a17:90a:d349:: with SMTP id i9mr2991726pjx.180.1585725140868;
        Wed, 01 Apr 2020 00:12:20 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id n7sm784519pgm.28.2020.04.01.00.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 00:12:20 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 0/2] add clock and emmc/sd nodes for SC9863A
Date:   Wed,  1 Apr 2020 15:11:42 +0800
Message-Id: <20200401071144.10424-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

SC9863A clock driver got merged, this patch-set adds clock nodes, emmc and sd card nodes,
so that we can startup debian on SC9863A.

Chunyan Zhang (2):
  arm64: dts: Add SC9863A clock nodes
  arm64: dts: Add SC9863A emmc and sd card nodes

 arch/arm64/boot/dts/sprd/sc9863a.dtsi |  66 +++++++++++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi | 164 ++++++++++++++++++++++++++
 2 files changed, 230 insertions(+)

-- 
2.20.1

