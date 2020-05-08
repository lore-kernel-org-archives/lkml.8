Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843D1C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE53208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BVCEG8eD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEHA2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 20:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727768AbgEHA2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 20:28:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D6C05BD0E
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 17:28:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so2781281plk.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d89QrDod8n3DS0mHAWOT8Nhxmdw/BYJeM/jPsxOJaUA=;
        b=BVCEG8eDlA86Kc3DaKoVApgyVNNVTpgY8y4vx9gcEnguJ1dEe7z5lgDTbTzC/qjCq2
         x+gJ7f7GxT27U+R8QKnfUV/JlbVxgcsBnP+mH8K3KG6LYrmVtMpih45iOxwrNuMXbsND
         i9pBLGXqA5iNRT7gde+iRZ/9z6Um+IIGKGmZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d89QrDod8n3DS0mHAWOT8Nhxmdw/BYJeM/jPsxOJaUA=;
        b=udruNwy7I6n7PfcV/yyKUL3BZkJ8TsN09fkStPDD/xwK2AJEXbQkdXerxqgD9LsWuh
         hewWyGU6L0ygH7ob9AuOI2+XetvhwmSxW/Pz+QyLMhcRGywHKjNAqpzKlciWDgxxD4u4
         O2lpUCLt0lggxKOsYBa0EltgfY7nZvkE/M5KvMFbcJ9iQ/IvROG5rIlmHOsF/os2b5IR
         GzsOUpEGnUugCBJVziWz3G+Nta4ErjiTIw65LKq8kkzymfg0Tq489DM059WRbkAzXGII
         Hr2nBZlCrUNSwMyizN9jno0b7HVqJHeF4XMmoLWtyRVtAVE+36FrY1/Hy1ic291WD9nz
         qz7Q==
X-Gm-Message-State: AGi0PuYbPASyEc0Gq6B/UEKaXBXSVFOOq0UooNFvb9nzHIrbhIuMBRHl
        /iVsnhfUfns8XGsYY3TukP1AHw==
X-Google-Smtp-Source: APiQypL9yg+UTfakfAY/PGrCH8wWW3n8ccPxXXOpi3O6KW2uN1JVvwO4pJpQK+Wqdfoa82/pMFJAYQ==
X-Received: by 2002:a17:902:361:: with SMTP id 88mr15726849pld.279.1588897694996;
        Thu, 07 May 2020 17:28:14 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id gz14sm882677pjb.42.2020.05.07.17.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 17:28:14 -0700 (PDT)
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
Subject: [PATCH v5 7/7] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Thu,  7 May 2020 17:27:39 -0700
Message-Id: <20200508002739.19360-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508002739.19360-1-scott.branden@broadcom.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
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
index 88bf36ab2b22..63eec54250f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3612,6 +3612,13 @@ L:	netdev@vger.kernel.org
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

