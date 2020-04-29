Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17589C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE1F2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hcsCgevW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgD2RKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727799AbgD2RJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:09:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4C4C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:09:57 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so1361938pfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xcQN/WNJ3PKuzjvXhZJ/eOoFGMkNcGIRid3lH/vICig=;
        b=hcsCgevWbfyIOS3Ma5Zc7uCJmmPfS2go8mKkbtKUu8xteho7w++FLL7Ffz4bA6YcZ8
         FGvlufLOfG9YnHegDls4Qs4j6Z32taJJi+zIwlClvPhXiIWgYo0gOzCnCobc0lNn1Qkf
         VPCTGM9kESMs6PeCEbRweRhbksbnb/5EFhRQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xcQN/WNJ3PKuzjvXhZJ/eOoFGMkNcGIRid3lH/vICig=;
        b=A39H15B/0itUN4OJ8ND+qfnT9fhhkC+w89pNyogFHUj6x4TNIKOQPVvgAncJL2YIuR
         +RSZU2i9VzdrB/M+xG4wrEko5tSlGIIRsm82OU8sTvhWctx7kxTTo0jVUfCLiuvCuio2
         x2xjZwMuCOFR37TwTYaXIH4zru3cv8aIDCVR5IdSuHr+quvkP7ROuiaeN0lXXqTd1WP3
         +Rqt1duqF9rwCybglQyRbhLvo+3/W4xVeQFPYlp1WsZOBURzf6+8ZDFfaIg6uUUIm64o
         ohCSPFkqvBhuysIyphPW4IDKf9Ul4mxCcE5CWWLbv/fBBewIgtxUCRMeWMvZTPfFCIZH
         Qrcg==
X-Gm-Message-State: AGi0Pub4TpHzEQKYQ9DdvMhfszJEgD6SpMW+0hr8a9jK9hkeCla5k/4m
        BCEdLQIJuffGgCUwpO2O8mCJ+A==
X-Google-Smtp-Source: APiQypI2r7KKRGsuq3L884nKjCvqNbuMuJC3pzGKQRH2L1+DsPz8xxzAhFZZOxGeTWra83HnQtHhMA==
X-Received: by 2002:a63:1e18:: with SMTP id e24mr31238033pge.296.1588180197178;
        Wed, 29 Apr 2020 10:09:57 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y63sm1574456pfg.138.2020.04.29.10.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:09:56 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v4 7/7] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Wed, 29 Apr 2020 10:09:14 -0700
Message-Id: <20200429170914.30976-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429170914.30976-1-scott.branden@broadcom.com>
References: <20200429170914.30976-1-scott.branden@broadcom.com>
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
index c1175fc0aadb..cbc132a9b766 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3613,6 +3613,13 @@ L:	netdev@vger.kernel.org
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

