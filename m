Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A557C25477
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWXp42iJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIDSHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:07:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25303 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726047AbgIDSG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599242817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ZgNkYrXayCXVqunlsQHYlfke0k0uTa2/dq5wz4jdf0U=;
        b=JWXp42iJ5jirKaEb8/Zc3Cxaen3f/Q6n/BFMoQ+9qBU1J16QSWXlP3ROqMmGtqllfLxfzA
        GeDlath/UrdZKDBHgXZzg/HYsOyBKDyOstLEGp0HVp9e3XYsbR2X+SoFpvUzTnTHFNVopW
        1hplOU9veUkJ8aMpw7LJx2jdEnoVoz4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-UhS_OZuCM4q7k8E4RWxZLQ-1; Fri, 04 Sep 2020 14:06:53 -0400
X-MC-Unique: UhS_OZuCM4q7k8E4RWxZLQ-1
Received: by mail-qt1-f200.google.com with SMTP id e14so4877249qtm.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 11:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZgNkYrXayCXVqunlsQHYlfke0k0uTa2/dq5wz4jdf0U=;
        b=l24ESA4gaat2iUqh8SbV2CBswPGKmMJ4270AIQFO89ATLu1KDHgplvWh7ROxVAzFmN
         jYoAiVi4XMJdqGO1cwgzfEQ8wO8ke12CPBSLeIuf2xP1vpP19+wlbNz9AuSMHfTyLWQI
         Hr4M+s6ehW5J8ogIIBY6b2F4a5PZwKRcPD3mbhybyQGntRC2Y7LhQZ0LcC5+dw3JrIHZ
         RaV4eIQ/VqL46kLqTL5Xq+1GfiS0lhp2mpP3qCVozxCCBNZNIfnnAe0pGRgZNeSKjx23
         r4FuVuaINa69wniJ8b/sHQvShvJcGl35Llwx3ASjlPXoflrMkr2n2ouRgDiUWs0AN30T
         B8LQ==
X-Gm-Message-State: AOAM530kOeMioUx4t5oQQohXnFWlTcj3gg/5lpD12xueYguaOgHzL//d
        ZrbhFXmm4LJJwbAFZq+g7OBhib4iDgVSMkUn1WdkFxKFnv39xhfrTQZ8j/H0XNX8zkPZNUvPYkG
        eGmuQbcESq3IhcHbIfeNDK+6V
X-Received: by 2002:ac8:6141:: with SMTP id d1mr9801724qtm.170.1599242813492;
        Fri, 04 Sep 2020 11:06:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWhBlbyE5VCadyyCOxenZ/m0J+9H6xdaEWBkgVjqJvelX1jGZb3lv+vRmA3FJV8b2LL6X7cA==
X-Received: by 2002:ac8:6141:: with SMTP id d1mr9801702qtm.170.1599242813220;
        Fri, 04 Sep 2020 11:06:53 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t69sm4879928qka.73.2020.09.04.11.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 11:06:52 -0700 (PDT)
From:   trix@redhat.com
To:     syniurge@gmail.com, nehal-bakulchandra.shah@amd.com,
        shyam-sundar.s-k@amd.com, natechancellor@gmail.com,
        ndesaulniers@google.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] i2c: amd_mp2: handle num is 0 input for i2c_amd_xfer
Date:   Fri,  4 Sep 2020 11:06:47 -0700
Message-Id: <20200904180647.21080-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analyzer reports this problem

i2c-amd-mp2-plat.c:174:9: warning: Branch condition evaluates
  to a garbage value
        return err ? err : num;
               ^~~

err is not initialized, it depends on the being set in the
transfer loop which will not happen if num is 0.  Surveying
other master_xfer() implementations show all handle a 0 num.

Because returning 0 is expected, initialize err to 0.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/i2c/busses/i2c-amd-mp2-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-amd-mp2-plat.c b/drivers/i2c/busses/i2c-amd-mp2-plat.c
index 17df9e8845b6..506433bc0ff2 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-plat.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-plat.c
@@ -155,7 +155,7 @@ static int i2c_amd_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	struct amd_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
 	int i;
 	struct i2c_msg *pmsg;
-	int err;
+	int err = 0;
 
 	/* the adapter might have been deleted while waiting for the bus lock */
 	if (unlikely(!i2c_dev->common.mp2_dev))
-- 
2.18.1

