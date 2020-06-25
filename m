Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B20FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C6E206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vy09unAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406201AbgFYQbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406190AbgFYQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:31:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4FBC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so6451807wrj.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxI9BhAfrJpW+cNsrQPMJfGCyd0KQMsn+2Q7Z4q8M9M=;
        b=Vy09unAzWzBm7p/Z8sXAwDBEEE541im9XUsCyfot+2sgPnWxZ2Gk5OrQMMvieY77Os
         n/epknFjcJIi8dhWDYCm48+cKrTSOhhFZFRTka1gidFJj/xEKmZ376Hg68SNO7cxFWwq
         qN1OA9DfITpdWYPfEJzJZkw0NfW0chYPuKe3LzdaFOAXPXshL564Cs/+OjnXg0NrM6jD
         kecVxgzOY6jeUG18XeAXUkQg/YvYL5Qr+YJVNIizm52jJSF3PDN29Xo6olSalcDKCQrB
         3hV8f/H3fYJ5QGtr1oU4rBXp3CTZsyppJIKcLX0Ja6oJ/BLNlTwztfq3p48PSogBaHrm
         Fa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxI9BhAfrJpW+cNsrQPMJfGCyd0KQMsn+2Q7Z4q8M9M=;
        b=CHVnAvkndJKEZfXFhIyl4jhrQ4CLb7n3amIfujr8d6D8MOTNtcdyplfQvGD4Mo3oMy
         sdjloQqSfYx56UYmh4ogq4wgoVLcHoBvfsPfDZhCMSQ09rTpkX9sPLjov0MHYld20YBN
         NPCUfazV93IVr+0G+s4zjjOUtp18U8nOiHmhfU+0yUmaoJL77LP7ZyQdJNTQEouwkRcx
         W7xdCQlV0suYvoXSKS1BTNJ/zrQjsyF5Lgtz+gkrMoup1iaNWf+7ROpwLsEwnrtJG8U8
         EEDRwBjFpH1/3Q7iLHY1jPCpKTYBaguBTYBGuOqsyWsYPtL9qGiEnt+UTaxps/Rbu9cV
         pHsQ==
X-Gm-Message-State: AOAM530YUJ3XkDsGTGZRlplQXLje0M7u/imkQyBdXX8aXskZJi6WINcu
        A/0so+xcdaX6nnTFE+q5Ph0jiQ==
X-Google-Smtp-Source: ABdhPJxQcDZfTw8ATt3Q/S58X6QJDPiWu01vMmoV+iJw+tDAjnCJEPQ+9Ztl2EgWWXsNZTzZ1KeYEg==
X-Received: by 2002:adf:8b5a:: with SMTP id v26mr37295310wra.165.1593102699140;
        Thu, 25 Jun 2020 09:31:39 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l8sm32090847wrq.15.2020.06.25.09.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:31:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] mfd: tps65010: Remove delcared and set, but never used variable 'status'
Date:   Thu, 25 Jun 2020 17:31:22 +0100
Message-Id: <20200625163127.4000462-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163127.4000462-1-lee.jones@linaro.org>
References: <20200625163127.4000462-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'status' hasn't been checked since 2008.

It's probably safe to remove it.

Fixes W=1 warning:

 drivers/mfd/tps65010.c:407:7: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]
 407 | int status;
 | ^~~~~~

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/tps65010.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 65fcc58c02da8..7e7dbee58ca90 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -404,7 +404,6 @@ static void tps65010_work(struct work_struct *work)
 	tps65010_interrupt(tps);
 
 	if (test_and_clear_bit(FLAG_VBUS_CHANGED, &tps->flags)) {
-		int	status;
 		u8	chgconfig, tmp;
 
 		chgconfig = i2c_smbus_read_byte_data(tps->client,
@@ -415,8 +414,8 @@ static void tps65010_work(struct work_struct *work)
 		else if (tps->vbus >= 100)
 			chgconfig |= TPS_VBUS_CHARGING;
 
-		status = i2c_smbus_write_byte_data(tps->client,
-				TPS_CHGCONFIG, chgconfig);
+		i2c_smbus_write_byte_data(tps->client,
+					  TPS_CHGCONFIG, chgconfig);
 
 		/* vbus update fails unless VBUS is connected! */
 		tmp = i2c_smbus_read_byte_data(tps->client, TPS_CHGCONFIG);
-- 
2.25.1

