Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD4FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC9C20756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=footclan-ninja.20150623.gappssmtp.com header.i=@footclan-ninja.20150623.gappssmtp.com header.b="P1whmoGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgEUAot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgEUAor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:44:47 -0400
Received: from mail-pl1-x663.google.com (mail-pl1-x663.google.com [IPv6:2607:f8b0:4864:20::663])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4DC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:44:46 -0700 (PDT)
Received: by mail-pl1-x663.google.com with SMTP id d3so2096479pln.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=footclan-ninja.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nTqT9e/lYi7CWqmsfUDfNOjOqBcrcy3sSng5fzPf7og=;
        b=P1whmoGt+oOre6zBU+YSnyAKHCd0/8AbIXgtLghFjWvLv3zaGtDLsRQPgY3zdlRzO+
         BPeeN/hgsR5aOzODohjtZViJGZT/Y6UefyHS7R3+eSjXYPnsMOxuaSIVIRAEiNV8664d
         QL/negXKQIIOK/Crr+zBj7pvYEfqZJf2j25gOgDU1uPLM1nE+7wM8hX/eutKzON/KTwo
         +45JknhlsQc6OMIRJE9TaH5pSYHbpFvUCoE2EpOezpeAxnDdLjE3XNOQL87lGZeFsKlD
         9NglwR6VlTqOmWReuFLI/q2TCyxNTjHx4Rx1vf11xcKee38DjyO8YycRAFCL8HNYDvhK
         PPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nTqT9e/lYi7CWqmsfUDfNOjOqBcrcy3sSng5fzPf7og=;
        b=hDT4Ym2S4aQmmCw4L5LCUEC3gib84yEYuXPaeby07LxJHJzC3K69Lff33Ao9pcuZEM
         BNS1fNjFRaVBa3caPbXuxZovY1mCVRf/gCt5lvP2oA5Z6kUoYtOpCrstNDUIUNiqVdqn
         Zt1u7IN0gCPHEQW4UMG/vWN0+wyzuhTnxnPUqKEGd1ZX9B5C5xub1rRFbeUA1OVM9ocK
         q6pCGRPFHE/2FWK9WqR7LO17BWGiqs2dSzFjSoFSLsVF8dMeAFEWop+PMvueOGDtNLTC
         wKGlaVdagyuiVNwHQNR9N/WvoRXsLOp3PVeF3MIFCnn4jF+Byv0MvPPyEgVDlOtyW2tS
         o0sQ==
X-Gm-Message-State: AOAM532/RBUsSAdaz3UVNAWOfYVNg3nS9D5xlRKK4+5KSQsbp8sfglCA
        OiP9DZr/jsEWfSF1jX5Mrlxu18FgAGJV6MtlDUpsrh10G0bgAQ==
X-Google-Smtp-Source: ABdhPJwmDrTz4WLsPaduVP88NHbuVaBuRTRSIwmcrxmyBZLbGRhiOGMiSgP73qSPhWC/SJvuNEU8FQZPCflr
X-Received: by 2002:a17:90a:a102:: with SMTP id s2mr8173088pjp.94.1590021885339;
        Wed, 20 May 2020 17:44:45 -0700 (PDT)
Received: from localhost.localdomain (pa49-180-69-106.pa.nsw.optusnet.com.au. [49.180.69.106])
        by smtp-relay.gmail.com with ESMTPS id v1sm454634pju.8.2020.05.20.17.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:44:45 -0700 (PDT)
X-Relaying-Domain: footclan.ninja
From:   Matt Jolly <Kangie@footclan.ninja>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Jolly <Kangie@footclan.ninja>
Subject: [PATCH v2] USB: serial: qcserial: Add DW5816e QDL support
Date:   Thu, 21 May 2020 10:43:58 +1000
Message-Id: <20200521004358.8949-1-Kangie@footclan.ninja>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Dell Wireless 5816e Download Mode (AKA boot & hold mode /
QDL download mode) to drivers/usb/serial/qcserial.c

This is required to update device firmware.

Signed-off-by: Matt Jolly <Kangie@footclan.ninja>
---
v2 changes: typo.
---
drivers/usb/serial/qcserial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index ce0401d3137f..d147feae83e6 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -173,6 +173,7 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x413c, 0x81b3)},	/* Dell Wireless 5809e Gobi(TM) 4G LTE Mobile Broadband Card (rev3) */
 	{DEVICE_SWI(0x413c, 0x81b5)},	/* Dell Wireless 5811e QDL */
 	{DEVICE_SWI(0x413c, 0x81b6)},	/* Dell Wireless 5811e QDL */
+	{DEVICE_SWI(0x413c, 0x81cb)},	/* Dell Wireless 5816e QDL */
 	{DEVICE_SWI(0x413c, 0x81cc)},	/* Dell Wireless 5816e */
 	{DEVICE_SWI(0x413c, 0x81cf)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d0)},   /* Dell Wireless 5819 */
-- 
2.26.2

