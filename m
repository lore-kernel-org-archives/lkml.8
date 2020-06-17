Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9063C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5D22089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKwSbx15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgFQQsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgFQQsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D3C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:48:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dp18so3116796ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7npwx+OVVnlTEpHUjG7c4pc1dMCFFQmOZjMVjejs+4=;
        b=IKwSbx15Kn5bdDrYn5y6+zFIka1nUTARbxOfBPUf8KptdpHEWQUvOvMldbG8OGH9Qv
         GUPopILnJnHYSj6LXzWOTg9vVgcOTNsIwRBDODO9gQmeNbCLBDQcYs1wURQVy8S73USD
         kcjuUFSM8zrWq85lDj7Ug2Q5Xnl8TbhMPGWJXO4DRqAMR0SLgHU0rnCi9iAc/+bBWEz+
         PxtF18d6Ax8CAWbK9oI1nNbVwVRBSJ2qS67iOFjmH4soVapkJfhqLq/bX+O2tw7vkPcP
         kQx3/Vb3hD3t3BMbCk8nZHB7GRds/UuI5/oehYItcHrXyTSrEUf8vwqzyvGh0LaRIyk1
         dBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7npwx+OVVnlTEpHUjG7c4pc1dMCFFQmOZjMVjejs+4=;
        b=HXIHU71toLGTbHPez3oNWyyCpJoAiuAdMJDX8sIczRC066QEuvpJOu4G6SwN6Cqe3C
         5cdQKlI88sbBEErjPnBQadlag3hyz9unMkLk/u3N2tRcugSpVnJEKmUhHPB9dfr6mTl2
         YDCstpbTG57SGeYz8aPO/Jb0KSw2tGW22MSKqzMY8khovokgnkZfwCIoqA1LzPhHytuJ
         xdhWe6TxY7F2qmmy9ZfnFsLeCVGPW8aLQqySLY7qZGt12lg73WnH46/14pQqogXlSqcm
         lbPkHkATVPOETNP5wBlJ05ht7QtJAR8luQXnyVJYB5hhzD6tRgKOEeqRpY8r/ZdcwrQm
         2Ubg==
X-Gm-Message-State: AOAM5334YDxKkNFo4gN0CG4gz/f2bN2vpau+RZ9Ci+j3IPR3Qi2t4934
        5I5sxI8kaMXDABXRIADeess=
X-Google-Smtp-Source: ABdhPJz2p0gr4+MQhTEDwwr3BbQs+BB9x8fdF1XV28ji/EInZnrjuv2O/VBITafBkBcRMetjTmwh6g==
X-Received: by 2002:a17:906:f0c6:: with SMTP id dk6mr43384ejb.157.1592412509863;
        Wed, 17 Jun 2020 09:48:29 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id v3sm127124edj.89.2020.06.17.09.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:29 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-actions@lists.infradead.org
Subject: [PATCH 11/11] MAINTAINERS: Add reset binding entry for Actions Semi Owl SoCs
Date:   Wed, 17 Jun 2020 19:48:11 +0300
Message-Id: <1ebb8525992d68186a148ae222b085d3c5416f37.1592407030.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reset binding entry to match all members of Actions Semi Owl SoCs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..f1ba24ee0eae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1533,6 +1533,7 @@ F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
+F:	include/dt-bindings/reset/actions,*-reset.h
 F:	include/linux/soc/actions/
 N:	owl
 
-- 
2.27.0

