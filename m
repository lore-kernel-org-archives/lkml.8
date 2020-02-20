Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C48C11D81
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E17824670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZeNCpCRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBTAtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:49:08 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33976 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgBTAs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:48:59 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so602096pjq.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 16:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3w9edU0bQTA/j4i1GZ5kCMLx5L0gk76mGZ2Jl2DPJv8=;
        b=ZeNCpCRGcYvQriOrG7nnRAwG2HLKcfUbnNuky4kQOtRD0bn59Hvqtia7UjS5EL1wtm
         JrkWjvzl+mC614o7v8XfG8+JPEmBrAnWb79QYFg2id7JqxhegfEV05kzAUZv+YfGH2TG
         oohrRRL84DOMAWaN+EK4SCqh6Sx4owhTbcqhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3w9edU0bQTA/j4i1GZ5kCMLx5L0gk76mGZ2Jl2DPJv8=;
        b=fPnwiMKjnBptl2XSH4IXDyyRqLc2rEu3iX69NCSLdjmJF7ssflc1APRH07nk0M5/2k
         +fyCDnjmYNsHxXhj/ElAdvIwAfoUrycSaa37NpabKWEBbMVr5TT32XbyWvPijUIDznoG
         rxL2AC/WOBxmFirVCwpKSFazjZB7e+voQ/+4by1IxBBTpR37hkoFyXsobyMeNwqk26pQ
         Z5LYYM4h6BYhbI6f6Mh4xjpGrNhcTJ/TLgIpm5m0DVv6RF9SSCPrdFl95s/Q4Bl31Nqv
         n0cACsGPP96pKJ5aD6/s8l8XxPdOWoY0HQ7jHdm1PQjn2Z3dFdYwVI4mTFwlem8BbbL0
         ZHKA==
X-Gm-Message-State: APjAAAVZfDxume/twSv5H9V6GpdEJCWqJOiv1GD66Uryq/makpyS7Wgf
        zIUgGAVMt0t7SiH+EzPcBl+TZw==
X-Google-Smtp-Source: APXvYqxvwfYCexceHmLY8+2NVNDKj2k6UoiRx/YzDmwMEI2NjRSexRZ7sLY6QpdZDmP32eZBMJa/tw==
X-Received: by 2002:a17:90a:8d81:: with SMTP id d1mr462100pjo.63.1582159738999;
        Wed, 19 Feb 2020 16:48:58 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 64sm816323pfd.48.2020.02.19.16.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:48:58 -0800 (PST)
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
Subject: [PATCH v2 7/7] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Wed, 19 Feb 2020 16:48:25 -0800
Message-Id: <20200220004825.23372-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220004825.23372-1-scott.branden@broadcom.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
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
index 4beb8dc4c7eb..c55f34f00b85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3564,6 +3564,13 @@ L:	netdev@vger.kernel.org
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

