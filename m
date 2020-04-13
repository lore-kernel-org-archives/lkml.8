Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463AFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248B520731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkKPLLGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbgDMSBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387535AbgDMSBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:01:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6792EC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:01:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o81so4525530wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5Z8dE6ImcAXCyeDIiVasuREmY3KTQoR9IpkKMh44/4=;
        b=LkKPLLGnKbN6uNj8eGVWgc58SBnatJbKP+wJAlc3m98nOdSKl2ouCtfNLXlAtkth12
         GFkXHBlZt8QmbmV+JxT8w4Kif9hmFtGAFZ0k0GvZ/EjEYKbXJcw/p5K2hVODx9321Vhw
         RjMjMvcdrq0TEnUc+3UvDsF6v3vQWcTTK3eNM/6VKyuK3dRM6MceGY7YDy/kJCjlholR
         TuaqoDN6aSgUa/t8yTm5rMKdJHdbN6xbFMNi4C6l2u+/iP43DYWvCDetXVk6Pz29/arU
         krMsHVHEAEaXp/jVCpipG/nu603a428AlmHK8sQiZ4PAKjhA9PWlQcHT8HExUW8e8psS
         vBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5Z8dE6ImcAXCyeDIiVasuREmY3KTQoR9IpkKMh44/4=;
        b=ENl0HCztfjwpR5ACfvd7vxPAyEmHKK6UcJNq2PDGthTTlTPJawimyqGLTPFeVE46zs
         6fVkKY2sS0ppC8GpyHu9oWXNIknaW65Pdqb5c/67zXRYDT2+UxuyRUdnobWrhS0qLWg/
         RVq1x33W0bXQVPfGlGViMb5anNHfxdEoIwWZAA3jCPQlgEx3H/KAiArwbW23tpaFVYXx
         M9rtLha5j83DhNYZt1/7eVyM23VYuahWP7Z+fn39pJvp3n6NyIUYQJnqA4X7OrXRztt/
         zowWmS6ZBqrEbKP4WeXNDWDLS1eLaeXuLI2sZ3tejBLtzDrRP+KmykeXb4966pjPcxff
         arUQ==
X-Gm-Message-State: AGi0PubQsDIRdX9f9bFPeYrOptXUBHbRrXHrsBm3ON29iJ2Czo2jPVzp
        jZzZAoqAJbe9rnH+wX3LOGI=
X-Google-Smtp-Source: APiQypJHyeTWGfUue3wbfzPGKb804c1ZjjAg1iFK5H3NhowtMKoC5CFnuvNJYZmxrslpuL3de8EmKA==
X-Received: by 2002:a1c:4409:: with SMTP id r9mr20365172wma.165.1586800899152;
        Mon, 13 Apr 2020 11:01:39 -0700 (PDT)
Received: from localhost.localdomain (dslb-092-073-054-241.092.073.pools.vodafone-ip.de. [92.73.54.241])
        by smtp.gmail.com with ESMTPSA id u3sm6476181wrt.93.2020.04.13.11.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 11:01:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: rename define to upper case
Date:   Mon, 13 Apr 2020 19:59:55 +0200
Message-Id: <20200413175957.30165-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200413175957.30165-1-straube.linux@gmail.com>
References: <20200413175957.30165-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 'FWDL_ChkSum_rpt' to 'FWDL_CHKSUM_RPT' as defines are normaly
named all upper case. Also clears a camel case checkpatch warning.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/fw.c                | 4 ++--
 drivers/staging/rtl8188eu/include/rtl8188e_spec.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/fw.c b/drivers/staging/rtl8188eu/hal/fw.c
index 486ee4bd4744..dbf7883f9ed7 100644
--- a/drivers/staging/rtl8188eu/hal/fw.c
+++ b/drivers/staging/rtl8188eu/hal/fw.c
@@ -111,7 +111,7 @@ static int _rtl88e_fw_free_to_go(struct adapter *adapt)
 
 	do {
 		value32 = usb_read32(adapt, REG_MCUFWDL);
-		if (value32 & FWDL_ChkSum_rpt)
+		if (value32 & FWDL_CHKSUM_RPT)
 			break;
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
 
@@ -192,7 +192,7 @@ int rtl88eu_download_fw(struct adapter *adapt)
 		rtl88e_firmware_selfreset(adapt);
 	}
 	_rtl88e_enable_fw_download(adapt, true);
-	usb_write8(adapt, REG_MCUFWDL, usb_read8(adapt, REG_MCUFWDL) | FWDL_ChkSum_rpt);
+	usb_write8(adapt, REG_MCUFWDL, usb_read8(adapt, REG_MCUFWDL) | FWDL_CHKSUM_RPT);
 	_rtl88e_write_fw(adapt, download_data, download_size);
 	_rtl88e_enable_fw_download(adapt, false);
 
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_spec.h b/drivers/staging/rtl8188eu/include/rtl8188e_spec.h
index dd943c831d91..be30c9434a29 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_spec.h
@@ -817,7 +817,7 @@ So the following defines for 92C is not entire!!!!!!
 /* 2 MCUFWDL */
 #define MCUFWDL_EN			BIT(0)
 #define MCUFWDL_RDY			BIT(1)
-#define FWDL_ChkSum_rpt			BIT(2)
+#define FWDL_CHKSUM_RPT			BIT(2)
 #define MACINI_RDY			BIT(3)
 #define BBINI_RDY			BIT(4)
 #define RFINI_RDY			BIT(5)
-- 
2.26.0

