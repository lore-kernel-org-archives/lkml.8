Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9EFC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AA924957
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588347489;
	bh=LESantMRD/g+tNw9iqgwwJwDazwNEShsTCm1Vmpbw1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qcm5shEVqjcc7LhwNAPIjqIXYrW6ghWVBIRNEWW+UHyuq5V2NNASgVIiCE3c/KdO9
	 gtOIc7zeSPU2ThoH1qsZa5zVA1xteKbZXv2YiTboTcYyavLF2dPiIrAo+nUg+sf8pr
	 n+loTlPSrytv1Acw3hzM6rsI3pP7EgJoGtx4AdbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgEAPiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbgEAPiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:38:03 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC9E2495D;
        Fri,  1 May 2020 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347483;
        bh=LESantMRD/g+tNw9iqgwwJwDazwNEShsTCm1Vmpbw1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGtvnsTPMvymcRmYffBI4H9iKuw9Un9+D9EBzD0u7KVPEA81wNn6ltVs6CixDpPL4
         0SpBT6HZ9DHjd/5k7YjiXcpbkhe3c8BESuyvCM/YVMWE5/5rM9fJ07ltRtOz8puiPT
         ZgJvKhhK6LlleF/LtIF+05ORNuYO69M5O1jD9ZRg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUXjl-00FE4z-6C; Fri, 01 May 2020 17:38:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 09/14] docs: move digsig docs to the security book
Date:   Fri,  1 May 2020 17:37:53 +0200
Message-Id: <6af5365404c7bd9d008e7e3a77ba83587fd33012.1588345503.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/{digsig.txt => security/digsig.rst} | 0
 Documentation/security/index.rst                  | 1 +
 2 files changed, 1 insertion(+)
 rename Documentation/{digsig.txt => security/digsig.rst} (100%)

diff --git a/Documentation/digsig.txt b/Documentation/security/digsig.rst
similarity index 100%
rename from Documentation/digsig.txt
rename to Documentation/security/digsig.rst
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index fc503dd689a7..8129405eb2cc 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -15,3 +15,4 @@ Security Documentation
    self-protection
    siphash
    tpm/index
+   digsig
-- 
2.25.4

