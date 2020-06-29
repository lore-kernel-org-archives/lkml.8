Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F26C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2A02158C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDYv3J+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390959AbgF2VWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbgF2Swm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03E4C02E2D7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so16673823wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFhbgCKNRxFbloxjm7n8+8nB92/O/AE2sBwMkN1jQVY=;
        b=rDYv3J+t/fvTXVYSLvlXorZNbHhUQ/6y/asw1e95tUgjbuzJJ22wOs5jgNEXZ9aCFw
         7nENOeDtyDLGMIcPXDx4J6RpgY0J72cV3yU9pJyBzsKwUHo5ax6PbSWYW3A0F0yg5poM
         yrnzqIS/FqzMaroXxLXo+0M2YedfnRYdVtYyO882ipkmlwYEGNM5n0IX7fASjRbyJRhX
         qNjGbqr4NAX+OrG9kHVAeWj4xRrT+Piiiq+v8IaiWO+R1O1vthsB8/QlFEKVLAQYZvzM
         NsKP8ih9Vk3CTfeB4RzJyjQ0jdxLswX27P9M+U41Yd8vx4H2FQERi0c+7/F7l5VcEEpi
         kJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFhbgCKNRxFbloxjm7n8+8nB92/O/AE2sBwMkN1jQVY=;
        b=MI7H+j76FWcEkW4J1kXujEMU/4E/Zq0iZYtZMnbsm77+sHQ0IbonFMOueBNta6+K5e
         I1YwSD+K+OQxnjPWbe5kwqPFyAXW38bpTYM2b3aKYCE283ieVUoen+7lq40S/SJ+NDSl
         brvz7TxYOiDXTo3FRm3fKyGFd/IrPyih03IgLaX2M4+e19tOU1SoMQjlycS0VadsWz0b
         CmX7hVMqe3n4Mp+XGmmMidiAlI4AFBGRiG0kxtaGTXR6MJOaX789EGHPIgAYVihFMJRI
         W8Sp57ncOpDoN4sI9rB857FiRIRMDN2I6iPr+OoTesSxfefiaqY7PbJfh4BJBvI4n60b
         zr3Q==
X-Gm-Message-State: AOAM531hL0/71tYmgmyOKfZRPm+UNxPHtzV5Dbne7IHH+xKmb91v2/2z
        GXiAqV2AJyeJxLUQFXIYMc3W6g==
X-Google-Smtp-Source: ABdhPJzyDyJpP65nJE9M2B1HioZi4XCaFMuMdtxDSjSoHMRbycyagIcp+yN52R7KVxHSkjFw7Jr9QA==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr16461671wrs.270.1593439504476;
        Mon, 29 Jun 2020 07:05:04 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:05:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 15/20] misc: enclosure: Update enclosure_remove_device() documentation to match reality
Date:   Mon, 29 Jun 2020 15:04:37 +0100
Message-Id: <20200629140442.1043957-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enclosure_remove_device() hasn't taken an 'int component for over a decade.
Instead use kerneldoc to describe the 'struct device' actually passed in.

Fixes the following W=1 kernel build warning(s):

 drivers/misc/enclosure.c:400: warning: Function parameter or member 'dev' not described in 'enclosure_remove_device'
 drivers/misc/enclosure.c:400: warning: Excess function parameter 'num' description in 'enclosure_remove_device'

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/enclosure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index e8eba52750b34..f950d0155876a 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -391,7 +391,7 @@ EXPORT_SYMBOL_GPL(enclosure_add_device);
 /**
  * enclosure_remove_device - remove a device from an enclosure
  * @edev:	the enclosure device
- * @num:	the number of the component to remove
+ * @dev:	device to remove/put
  *
  * Returns zero on success or an error.
  *
-- 
2.25.1

