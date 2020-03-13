Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EB9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B61620663
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hackerdom.ru header.i=@hackerdom.ru header.b="i6Sda7uW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgCMVkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:40:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38626 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbgCMVkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:40:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so12205896ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackerdom.ru; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HtY5oImSA0+4YSNm6q/VHicARFJFbzmTkofRiaqhhKc=;
        b=i6Sda7uWBOD2K3vqcHwo7xd1p8sMeqiNPXsPFKYrcdGRCEdfq4sGW+sfz+6DtEY5ng
         CPG8Ksg9tqUzaZSW2/MpGEQHtBxkkjwEDR8hSP7vfSeXmmIWCgup8KWccyLJyd3ZoYeg
         hfc6zDthQwpj8jCV1Q2VN2YHdvr/jVU+TFWxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HtY5oImSA0+4YSNm6q/VHicARFJFbzmTkofRiaqhhKc=;
        b=r5vh8sFwJi3h1PbJLpud+vQ6vr1uHTw+6cuDFwY0irc2Sav6pX0qfL//6t4Zb8kZOX
         7fiC74M8iiZeV9O5ypXPojyTSUejdp6DSUyLjsxe2BlYqZwmN7yUpI5+AQOb0e5PCyUB
         In9uBKA8EK6AGriyWTJONEV0cmDiuj/+O8F4PE9FXHM+RepUdRRdC7pqA3kEWNCkqiq6
         qdyQudmANx29k+vqme4taRoUa0/qJCYGg8Noy4GDxWWuTbxXKCyFI2ycIUJumJAgSlNl
         biuhK3x8eXFEpe3g/6+s2xiquEW1/zar4mc1znjWniAOQGwBzk5G3lMhZpj+TQQdwnxz
         a8Aw==
X-Gm-Message-State: ANhLgQ2QOyV4M0xAmwyAUrB71nRD0FH2jwrKkLA7oBGX4voK61zdOS6Q
        20pBrycFM9b3upCw4wk2hp53cQ==
X-Google-Smtp-Source: ADFU+vs0A/qJqrv937YyDOkFvvA1JoZQ9oheGaTY/TOQzzjwt31KNy+BHUUk/NPpRaEoBJe/cjI0Kg==
X-Received: by 2002:a2e:9b44:: with SMTP id o4mr5047746ljj.63.1584135598069;
        Fri, 13 Mar 2020 14:39:58 -0700 (PDT)
Received: from localhost.localdomain ([83.169.216.4])
        by smtp.googlemail.com with ESMTPSA id 3sm11178101ljq.18.2020.03.13.14.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:39:57 -0700 (PDT)
From:   Alexander Bersenev <bay@hackerdom.ru>
To:     bay@hackerdom.ru
Cc:     Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cdc_ncm: Fix the build warning
Date:   Sat, 14 Mar 2020 02:38:21 +0500
Message-Id: <20200313213823.178435-2-bay@hackerdom.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313213823.178435-1-bay@hackerdom.ru>
References: <20200313213823.178435-1-bay@hackerdom.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ndp32->wLength is two bytes long, so replace cpu_to_le32 with cpu_to_le16.
---
 drivers/net/usb/cdc_ncm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5569077bd5b8..8929669b5e6d 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1172,7 +1172,7 @@ static struct usb_cdc_ncm_ndp32 *cdc_ncm_ndp32(struct cdc_ncm_ctx *ctx, struct s
 		ndp32 = ctx->delayed_ndp32;
 
 	ndp32->dwSignature = sign;
-	ndp32->wLength = cpu_to_le32(sizeof(struct usb_cdc_ncm_ndp32) + sizeof(struct usb_cdc_ncm_dpe32));
+	ndp32->wLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_ndp32) + sizeof(struct usb_cdc_ncm_dpe32));
 	return ndp32;
 }
 
-- 
2.25.1

