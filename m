Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB990C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8443820706
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kzf8kWkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgDVAm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbgDVAm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:42:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D86C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:42:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f20so204263pgl.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=un8H474QNqq9mh1Fli1mXz/+xpNjOExFpRjKSjnMqjw=;
        b=kzf8kWkhX2BHoz/5S3IIj8vMuAjNeiv0HPear2pSraFd7aEaAxRP4HTuc88OeTp4qd
         SXFuzDHFn2GoqNN9fFtnDCxLF62wJ1KvUDOrH1NFB6+Zkt7C8sWqz4ygWoZLy/glM6gX
         rcwJzK49O+nah7/d97CzDLdT7elz52vRRrwWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=un8H474QNqq9mh1Fli1mXz/+xpNjOExFpRjKSjnMqjw=;
        b=aRkA4F3MkLtXqnf/V+EQPSsdmoIMkGERH+RK2yuwLm0wTz+oFfZaujPcwuJe9gz6je
         gbKQh/eWM09hnZLjT42bEm9uKbdbeNDAjh5ZOowq6BM/yh1KKLHMx0Kf8crbdM3ZlN4t
         e0MxCiGNFP7zb06/w9YcmmaVDnaJCH66F0CvRjOwGYqeObtmRDUKxiDj/Gbk15jg5kzv
         +i2cGEHobfcRFqFPSRxwiRNzKUp0OYpeJ7Q0a/mQb7appWJdx56Lwbsfl1/jXQ8DsiL7
         Vbtj52DjKhejhfplOOOVUo7BzltybGraUchA7k0Afao1pyV0TiHeI+qDxCUHcGn+fBdR
         pFkw==
X-Gm-Message-State: AGi0Pua1xzInqAu1tSxGm1gGWfQv1OtE/UQnThMSzKnpOJZ4ZDQqOUj9
        EfS3cbB8i3V8W/Syj4r6Be8MoVfEcRE=
X-Google-Smtp-Source: APiQypIlMLdyvYdY2/U7CgcvU8u+BTWpLxLtDf0B4Kv+d/U2K6WFq0PwSs/pz8Qr6Dr/9xu1c9D9Tw==
X-Received: by 2002:a63:554c:: with SMTP id f12mr19298211pgm.163.1587516147052;
        Tue, 21 Apr 2020 17:42:27 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id o185sm3576066pfg.197.2020.04.21.17.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 17:42:26 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] platform/chrome: typec: Fix ret value check error
Date:   Tue, 21 Apr 2020 17:41:51 -0700
Message-Id: <20200422004151.116323-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_typec_add_partner() returns 0 on success, so check for "ret"
instead of "!ret" as an error.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Fixes: 9d33ea331032 ("platform/chrome: cros_ec_typec: Register port partner")
---
 drivers/platform/chrome/cros_ec_typec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index eda57db26f8d..66b8d21092af 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -263,7 +263,7 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
 
 		pd_en = resp->enabled & PD_CTRL_RESP_ENABLED_PD_CAPABLE;
 		ret = cros_typec_add_partner(typec, port_num, pd_en);
-		if (!ret)
+		if (ret)
 			dev_warn(typec->dev,
 				 "Failed to register partner on port: %d\n",
 				 port_num);
-- 
2.26.1.301.g55bc3eb7cb9-goog

