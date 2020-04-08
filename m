Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BDDC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D582076D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360823;
	bh=GBQ42WduO9LKEa8yh8lyAwUHUKj7t7azogibn/qTlBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qLiaUSj8erbnIj6TXtCQ9g9sseyx6MI4tyFCZyMXs0/fWlQkc0B94ZKYaRDAIXZX9
	 5J9FJqX/wUHsyH8SIO8bQw3spHsOvvBhKbBQxFJTN6brw8e+M+Zjm5VfPTKKgqsPqu
	 zcYZBRX+rg2T+7jqEC/W+6hBRmp74EFBMf8ue1e8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgDHPqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgDHPqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:31 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE33F206F5;
        Wed,  8 Apr 2020 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=GBQ42WduO9LKEa8yh8lyAwUHUKj7t7azogibn/qTlBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jp/apwHvIl/iTvGkmdnmQ+Vrje8GW/kOvwjmzQU2yEjBkpUo0umzVEJNfacVJQXCN
         K+7BBQkc70whGw8Ij2Pl6T+dErFYYK6Ixi5yRpsZItp74uPRSVaDnmYELz/2R3LoWH
         1IqrmvK6nWlUHRzznE78W+bMO/SfcfqcN3dkVJVI=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cAK-0e; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 01/35] MAINTAINERS: dt: update display/allwinner file entry
Date:   Wed,  8 Apr 2020 17:45:53 +0200
Message-Id: <2947485bafc4e8807eb635518408b9f6dbf0111b.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset f5a98bfe7b37 ("dt-bindings: display: Convert Allwinner display pipeline to schemas")
split Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
into several files. Yet, it kept the old place at MAINTAINERS.

Update it to point to the new place.

Fixes: f5a98bfe7b37 ("dt-bindings: display: Convert Allwinner display pipeline to schemas")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 62a56ba0be4d..67e52e9d630c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5573,7 +5573,7 @@ M:	Chen-Yu Tsai <wens@csie.org>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 F:	drivers/gpu/drm/sun4i/
-F:	Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+F:	Documentation/devicetree/bindings/display/allwinner*
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DRM DRIVER FOR ALLWINNER DE2 AND DE3 ENGINE
-- 
2.25.2

