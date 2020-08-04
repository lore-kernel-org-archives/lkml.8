Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CFFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0A32086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDorCLzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgHDAOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgHDAOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:14:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EDDC06174A;
        Mon,  3 Aug 2020 17:14:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so35713528wrh.3;
        Mon, 03 Aug 2020 17:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLqa6iIagQjdsqMYxByjjjyKCkbWqHO5m3vOPF/8+wU=;
        b=cDorCLzbE0Mncpqq+Tg1mP3VivfjCvwGyaEizymXnx/LbHd5cQ8A7SHR015B1w2fNg
         JHg2+TaD68iHuuCTzsTy54O/ng49d6Fqq/PN9OMlhfAeaioqJQL6ORcedDdUPaO9Np7J
         nwF7SEacmVdWecgetwUTpDwVIWS9Q006PRgxPMxtnUrvJhYPOrhSBOBXA7AxqkbC/EYw
         W/QFt17yPz9CnRdWNj8mj17qzLNAMLdCtr8bQjFa0BwnyoAv91ivhuRFozvR2Zy0f+0b
         5PclOAew8eNUGu30g4D9NpZnRjyrhzwaFS31WzOcBP9GhIbIPEJqS3NyyAux/WP9azSq
         XSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLqa6iIagQjdsqMYxByjjjyKCkbWqHO5m3vOPF/8+wU=;
        b=mQNVDT4EH6JHmOpWzrVQLDly9swljhrDECgEYRdcDPnbLlZSmoUqFrnh2By/+vJTBT
         INIRR8YvXRnNHnHcjn2lSrpshCVBsZAbVZwr09kuzxFhWL0dJOBo5vlg5HhaB4QK457t
         K06Sg0KPt2hs/4Pg9XiWUNFTmWSp0MP2HsFZALkgfc5giy2YcpY3LHElxbIlL1h2EVpQ
         PUyKImrpM3oEAeqvNjuqsLnxKinQOnxFQezH+IDaAu/Uh5AoL07rAB8Fg7LfLC0/0SGs
         VpnGD4dCt6vS9l4IeXE2/Py2j0uldklb2rPtVjEFEd1eH3jp+w0UsnFAsUABQ3RjUeUq
         uuug==
X-Gm-Message-State: AOAM531NB5K3t4YOkqbp8Ae9xxg2w5IxAONlyfg4eyJ8uTTD9IrQDg+K
        436egyKmDNwJaxidI5TADkU=
X-Google-Smtp-Source: ABdhPJwdsH0pMYRMGanAKEVY9CpKqzquGlGl+O7Q0vlHq/3gfASusHGCqhrWnnyEMu7Sd3KigtzhwA==
X-Received: by 2002:adf:de91:: with SMTP id w17mr16979218wrl.108.1596500080802;
        Mon, 03 Aug 2020 17:14:40 -0700 (PDT)
Received: from localhost (55d43e89.access.ecotel.net. [85.212.62.137])
        by smtp.gmail.com with ESMTPSA id f63sm2064620wmf.9.2020.08.03.17.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 17:14:40 -0700 (PDT)
From:   Timo Witte <timo.witte@gmail.com>
To:     timo.witte@gmail.com
Cc:     jlee@suse.com, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:ACER WMI LAPTOP EXTRAS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] platform/x86: acer-wmi: add automatic keyboard background light toggle key as KEY_LIGHTS_TOGGLE
Date:   Tue,  4 Aug 2020 02:14:23 +0200
Message-Id: <20200804001423.36778-1-timo.witte@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got a dmesg message on my AMD Renoir based Acer laptop:
"acer_wmi: Unknown key number - 0x84" when toggling keyboard
background light

Signed-off-by: Timo Witte <timo.witte@gmail.com>
---
 drivers/platform/x86/acer-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 60c18f21588d..87797f785d6a 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -111,6 +111,7 @@ static const struct key_entry acer_wmi_keymap[] __initconst = {
 	{KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} },	/* Display Switch */
 	{KE_IGNORE, 0x81, {KEY_SLEEP} },
 	{KE_KEY, 0x82, {KEY_TOUCHPAD_TOGGLE} },	/* Touch Pad Toggle */
+	{KE_IGNORE, 0x84, {KEY_LIGHTS_TOGGLE} }, /* Automatic Keyboard background light toggle */
 	{KE_KEY, KEY_TOUCHPAD_ON, {KEY_TOUCHPAD_ON} },
 	{KE_KEY, KEY_TOUCHPAD_OFF, {KEY_TOUCHPAD_OFF} },
 	{KE_IGNORE, 0x83, {KEY_TOUCHPAD_TOGGLE} },
-- 
2.27.0

