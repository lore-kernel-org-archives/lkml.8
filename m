Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D1CC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C77321655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjzLEDmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgCKLgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:36:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38479 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgCKLgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:36:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id n2so1717625wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 04:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4dSjMYJm/Ra5sgQShi2pf7+T6koKZ++HOxR0wa0eN84=;
        b=MjzLEDmFJ/aZXSENFbjIyt0KVvyajh+YnB/ueDBs1bz0YgVO03hmugfnPZdvU3vt/6
         BBGbHwfSuITh/mzCoIh3L9H5Xm7GhvVopaYxlbzYHEaFpzzGBm5bpH1E14+QPAQj+/Zi
         oz0hJV8Uo0RnjvYx3X/NcoKRTSUE0mxzyaIKrecwFNg9w6OfLfFVZZFSS3L63oEAv3NN
         M85rjg8MG6w/3q6GdZ3z8lcHkRCHWQCV7MT+N8waXX1F6iOwXpQFA9n/FzKQ98EPl1ZW
         LenVwfClcI7m9C49N7ZiYFpAR+wdIAWAcAfIClt6Na8GpVqOHnsERF9aA/UbB7Dslj4m
         DcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4dSjMYJm/Ra5sgQShi2pf7+T6koKZ++HOxR0wa0eN84=;
        b=rBSlP7tnNJXNVxyZucMAnsl8a7NRUbO96CDcA7EVGIqv2pJvF8UysaFlrFt+2zHB8Z
         UTyjknZ0bVSB2PVz2/k3WOsSYhbe9AF2cV9Ki6azlsC+vvl3QaFgMa8+5o/DLTjIW5q2
         /LjhlK42xpPjiWaZrLD+BnKsMKUKtuW4g6cOuJpTpGgZZi6pcowpOqTukhtycXF0Kva5
         qA40BIL1tyzVkJJFI5vfMDK4mrvu1gfsN32rlGzqwQzZIEJujz9d1vQOg5TP6CsWSAH0
         belYAKktH4IOXKmbH4uZNgtMpuaHEDQRkhJgof9TVN0edL+ViCpw9uIbYSZy3FQQIQtu
         tbfg==
X-Gm-Message-State: ANhLgQ12vTULUUpbbtQTaPVpR7yZjeHMjPGVuU2SZYoAdnmbJ85Hfq86
        AXIXJfSpnWWlYS45bHDWpn/rbQ==
X-Google-Smtp-Source: ADFU+vt+eNgeMdW8z+nYMrd8Bxe7xSf0Y8oplVFQFkTzkOPeN1bEt3y5GLgzl+F32+wHlT+zM65jyA==
X-Received: by 2002:a1c:1d88:: with SMTP id d130mr3473216wmd.138.1583926580522;
        Wed, 11 Mar 2020 04:36:20 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c8sm61650537wru.7.2020.03.11.04.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 04:36:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: wsa881x: mark read_only_wordlength flag
Date:   Wed, 11 Mar 2020 11:35:45 +0000
Message-Id: <20200311113545.23773-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311113545.23773-1-srinivas.kandagatla@linaro.org>
References: <20200311113545.23773-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WSA881x works in PDM mode so the wordlength is fixed, which also makes
the only field "WordLength" in DPN_BlockCtrl1 register a read-only.
Writing to this register will throw up errors with Qualcomm Controller.
So use ro_blockctrl1_reg flag to mark this field as read-only so that
core will not write to this register.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index b59f1d0e7f84..35b44b297f9e 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -394,6 +394,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
+		.read_only_wordlength = true,
 	}, {
 		/* COMP */
 		.num = 2,
@@ -401,6 +402,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
+		.read_only_wordlength = true,
 	}, {
 		/* BOOST */
 		.num = 3,
@@ -408,6 +410,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
+		.read_only_wordlength = true,
 	}, {
 		/* VISENSE */
 		.num = 4,
@@ -415,6 +418,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
+		.read_only_wordlength = true,
 	}
 };
 
-- 
2.21.0

