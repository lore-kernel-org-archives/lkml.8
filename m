Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FBFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD212080D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U9lxy3jE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbgFOTmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbgFOTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:42:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A221C08C5C8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:42:26 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 64so8257811pfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EN1IhuHOwzgoOcWyZIy9cQLF20jppiOEN2CrFnDInH8=;
        b=U9lxy3jE22JUx9l9TV8z9qLuPgIwP3ylxQU8Oumrvr9oyBQsLce9TnB7+K5bfye5Rt
         uSfK6xnQ0iLu3hF2G/vBHdDn/bbuiTEXKjRZhRPX4Oe5f9f7l4y/eKqXwqR0BaJFJ6Kg
         yVYKCNCf6yBQoC4Q5z7/kPeFqVPc4lPPSW40Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EN1IhuHOwzgoOcWyZIy9cQLF20jppiOEN2CrFnDInH8=;
        b=uMj5vPfWtPuZBfoS+X2YJjUUMZAdNNapbHJz3n18xKgsjAPj1x7D3hsLxYHT+mpa4n
         R9CfoHdgMkEVb4R8pAqEewwbwgMpl4yRySIu+1/3Rg6xoc/apsQmZLgIb6TvvtdznFCj
         lHDx9oRNd26Kimzdqk3vw9hh488h/tRBOWVtloGWYI5gkE3+IQW6w+DGAqyJkmW1d5/A
         hm026JR4JjNm9EsgBh7bzYIb/h/JpTbTDmyFBlbk9H4uvgQRPThErCYbkkdmXYAApNMb
         r0tsPNt7VVs8MXp1pBqup9yW2hKyhbBlDN7bahDf6FVnzO/xs5tyIOs2tjTFk02V4DJQ
         B91w==
X-Gm-Message-State: AOAM532zsKLVS09ySxT7qGC/MrBzsM4EUbrs0S8ErH3WtELnSy7w3mb2
        uifkn+B669m6kXXYC1M2e++9rw==
X-Google-Smtp-Source: ABdhPJyBz/jS9zEuqkK2ql9UA5VzjypmIVHnFoC/77SXnpjE2nUSYBpVs6rkRwL2bVBYYLvYR9xePA==
X-Received: by 2002:a63:214d:: with SMTP id s13mr21585779pgm.277.1592250145955;
        Mon, 15 Jun 2020 12:42:25 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id gq8sm293663pjb.14.2020.06.15.12.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 12:42:25 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v9 7/8] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Mon, 15 Jun 2020 12:41:50 -0700
Message-Id: <20200615194151.7011-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200615194151.7011-1-scott.branden@broadcom.com>
References: <20200615194151.7011-1-scott.branden@broadcom.com>
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
index 83078661cd2b..ce29c7d0b228 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3657,6 +3657,13 @@ L:	netdev@vger.kernel.org
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

