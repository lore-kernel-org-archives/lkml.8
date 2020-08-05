Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A21C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2642250E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2FwgliS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHEX1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHEX1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 19:27:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CF9C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 16:27:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so39407830ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 16:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DaFDa23MoAA33nkjiTqdED8F8POtDsOIuRG1FZCsEc=;
        b=N2FwgliSso2OZZyijjPWrsBetCdA4TXNVkXLGYoocv4NWNBGBG1lL6BB8Ka3gjvlqB
         45zPfY3QksFzgs9sbAJSjyaRsjAGXtzXDqWH3Sdp1eT4gv9KaNNqg6yaR84AJQeLNEwU
         wEY4aCHjHkUU8c1vIPX/itA98qNw1M6z2bHd7MUj3B149mNq6lN6GzyMFo3mzUIuH873
         ghi6+twfq41q0BDujRJBFuTY1h5Tz8oCXe4erp8Lm00IwudP+unMSw2N+crZkI3xDkbO
         AmtJA5z6MjIl5ll79EaaRTW8yZoTilIoYzRQxt7tTr3vgAl0c4iF2dtp+SR8qUFyhy+J
         kxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DaFDa23MoAA33nkjiTqdED8F8POtDsOIuRG1FZCsEc=;
        b=dMYsHMrlRaecBGB3usxnW4Xqr/SGneaPV1WfHGtYh3TaXOEJlVKvFgFCw7BAMLGErm
         30b6XH5xu7qjMXXTLG75xv4YdgnVskwHtBEMLMCAuavKcqcAKToyMLbvAWVjLblYV54J
         c75aI48YfaSsYRWp3oLHyV2BqOvCXBAgS5k4CbndTEll01ksCSvb3c25vAlcDrA0AXmh
         h+VhynTwefLNuSYi/IVJ4FXpzfV8Xs0J5r49r7X1l5u6R480cTcXtdHrRr7MHTjGVwqN
         kwkc+5wgMMtLNtf0geUiGImJk/tvJcKVUbUVGAsUnWCTmZpOs41yDJALWl+Z+zwu+GYL
         4Heg==
X-Gm-Message-State: AOAM532/p2zpMDcj278IOocTp0Z9iezPB6bGn8wbsFSFXuByk1N60wYI
        H03IcMxifi8j/UfxNjVv+PA=
X-Google-Smtp-Source: ABdhPJyVnESSljv+WCkHKk66+fjOFX/3WFSM43bGT1tYJjX64OTMqxJ5EyKhBGqBQ7n1mBixlhm+fA==
X-Received: by 2002:a2e:5c5:: with SMTP id 188mr2350419ljf.466.1596670021730;
        Wed, 05 Aug 2020 16:27:01 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r16sm1485603ljd.71.2020.08.05.16.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 16:27:00 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, eajames@linux.ibm.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/3] fsi: sbefifo: Constify sbefifo_ids
Date:   Thu,  6 Aug 2020 01:26:23 +0200
Message-Id: <20200805232624.6938-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200805232624.6938-1-rikard.falkeborn@gmail.com>
References: <20200805232624.6938-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of sbefifo_ids is to assign its address to the id_table
field in the fsi_driver struct, which is a const pointer, so make it
const to allow the compiler to put it in read-only memory

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/fsi/fsi-sbefifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index c8ccc99e214f..84cb965bfed5 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -1030,7 +1030,7 @@ static int sbefifo_remove(struct device *dev)
 	return 0;
 }
 
-static struct fsi_device_id sbefifo_ids[] = {
+static const struct fsi_device_id sbefifo_ids[] = {
 	{
 		.engine_type = FSI_ENGID_SBE,
 		.version = FSI_VERSION_ANY,
-- 
2.28.0

