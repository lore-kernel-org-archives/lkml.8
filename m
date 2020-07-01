Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1810C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE25E20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQfCb1ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgGAVsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGAVsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:48:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF2C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 14:48:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f8so16762537ljc.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 14:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axFDwmUrhb02IUraOR62rJzCuqXcldOGAtu7bDtO0Uk=;
        b=XQfCb1otxyPFt9biXqz6uNV2LwI0sJ3gE03jZETQ+mbZN69hqpHORRA1juvy6XbIVZ
         k5dRdXA7VGj7pe+JWzGF6QoKqLZ7dXaDjo4y/g5chKj5Ptro7ttCBgxhdY0c4tqtpYd1
         EGd/p66BgyeyEDJr9Vf/JKUuTxUpcvrPjzlquVxywABUZ0zVZi2pq+s6nyNijB3wtSKU
         PiZVo1TfNVoOQSDGTychYP03ItetMuLMb+WhUfSmNXMGIU6W61r5CBeM83RjYSIFFZWM
         /nv6xFphtJBkkBhrRFMb105yuG3cbyjAdlmXGHhrI4e2LgbgC4bPAwMnXF9bfatZEzUu
         DEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axFDwmUrhb02IUraOR62rJzCuqXcldOGAtu7bDtO0Uk=;
        b=F/9lpIhiym0XlqMOMWlEaa9H/XHfqSsGrgA7q9h5i9QcjTYE2rmWkJLBpQ5a8mFH5N
         w5akFIRXVBLNoux7DpfhyL40cab4/pfxl+VablkcSainbDl8uGMFQFI/9SnTTBL4Ikf1
         SafY9ILejx846I9bk6EJpKYAYp4qSqaF6Ql3t8ztW2k9e8Yk4hbm+7E2HiI32BPrhMX4
         JvxIz3nbn17JEKLzh9u9O47x/xehDyQY/RciEDa+RYz10n/gNMHvXeCqcrRfNvBws8sE
         N85WR0Ac3Tuvd2wUf6YrKr4wN7CzlscsR30MToy7VQMfpQS19djNRgujb9w8IDHEKEzg
         R/NA==
X-Gm-Message-State: AOAM533wfCKR+woUcjNljGzsMD/vAfzOCVqZoo8Chk3WENHTEi7fHDXH
        qzaUK7kTSGHwYmy9ojBDxnw=
X-Google-Smtp-Source: ABdhPJz3sso470+bXN+itUWZ6r1Cq8Fj0poy/kou5+OBT3IO3MZq3tOQiOhIstHXKexpUkKGDXkpFg==
X-Received: by 2002:a2e:9cd5:: with SMTP id g21mr15764799ljj.9.1593640089072;
        Wed, 01 Jul 2020 14:48:09 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-241.NA.cust.bahnhof.se. [98.128.181.241])
        by smtp.gmail.com with ESMTPSA id d3sm2476812lfe.93.2020.07.01.14.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 14:48:08 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ipmi: watchdog: Constify ident
Date:   Wed,  1 Jul 2020 22:09:49 +0200
Message-Id: <20200701200950.30314-5-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
References: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ident is not modified and can be made const to allow the compiler to put
it in read-only memory.

Before:
   text    data     bss     dec     hex filename
  14067    3188      64   17319    43a7 drivers/char/ipmi/ipmi_watchdog.o

After:
   text    data     bss     dec     hex filename
  14115    3148      64   17327    43af drivers/char/ipmi/ipmi_watchdog.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/char/ipmi/ipmi_watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 55986e10a124..3df13c3da5f9 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -654,7 +654,7 @@ static int ipmi_heartbeat(void)
 	return rv;
 }
 
-static struct watchdog_info ident = {
+static const struct watchdog_info ident = {
 	.options	= 0,	/* WDIOF_SETTIMEOUT, */
 	.firmware_version = 1,
 	.identity	= "IPMI"
-- 
2.27.0

