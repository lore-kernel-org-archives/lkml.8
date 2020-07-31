Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35372076B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KQ6kscij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbgGaSwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387855AbgGaSwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:52:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6FDC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:52:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so9321215wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VbVXehIaTj8YaGbM3QRDkpcQWUuuD2sDylw5SpuvrVk=;
        b=KQ6kscijHTdrXFRctpZ59XnxwOrVNqqHkDBpm5fCVDMvEmRFJHe53Q4UU20rOYOOua
         0TdCasJT3jBkLOCz8DU/Lw9a7HLEH5GOy8gJW9+lyeN3icPQSVFrMOn9fJBRBB+1tf09
         NHvDliJV8WrucneeP0eU01gShBjQMUUjxKEQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VbVXehIaTj8YaGbM3QRDkpcQWUuuD2sDylw5SpuvrVk=;
        b=FJ9vUPQ7fyhOcHxNy7rVvH/sp/Yo11gT8OJwb0wgolLwyiPKMw8ZZudvntEGTU6Rgj
         k3tB4CdKNKW6agTCZVK0Pd6LuBf8Q3dTEr5dwmBHDW0PRSw8Yl8zVejBU1sdoE4eG850
         82XiyGFidgxEm0DTCwfje1QrONdnarnSVGVg5UAOyW+jI/Mi+jZg8kaWgVvDWZ/X1MUb
         IvbYnpar6P3A74Au8iD1b8tN/nNKnWZr9A9h5ag+7LxcrfLwx6Sx512p+rO1ben3HxBA
         DDUS9+1ikN5mgzFQpfMR2Pf6OpVkARfQJvlnsL8kYVeufrVg5JGt9ShLnChPGbJL9rCW
         e0eQ==
X-Gm-Message-State: AOAM530PmsqRwpH/QzSfLl24dCC3ZCnueh2902O0NOiqZS2W1M7YGNG2
        aA4SOro926FZ2saj327B1jsnfg==
X-Google-Smtp-Source: ABdhPJxzM1L8jbsQgNsPqWF8Mg27uy/o2wgNPm+plEtQo6zJXfBbBVpptEacqgxqmO+w7sU9SW4LfA==
X-Received: by 2002:a1c:ed01:: with SMTP id l1mr5042923wmh.33.1596221557866;
        Fri, 31 Jul 2020 11:52:37 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k204sm14311710wma.21.2020.07.31.11.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:52:37 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 3/3] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Fri, 31 Jul 2020 11:52:18 -0700
Message-Id: <20200731185218.27543-4-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731185218.27543-1-scott.branden@broadcom.com>
References: <20200731185218.27543-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0569cf304ca..10e4e286baeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3658,6 +3658,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

