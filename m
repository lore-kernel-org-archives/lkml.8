Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983D0C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C3A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rohdewald.de header.i=@rohdewald.de header.b="cVrovoho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgBKQET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:04:19 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:24114 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgBKQES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:04:18 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 11:04:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581437056;
        s=strato-dkim-0002; d=rohdewald.de;
        h=Date:To:From:Subject:Message-ID:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=qJmySs6qQV9IutXAi+VuRvohRb5yxnhpN42gg+YHbGQ=;
        b=cVrovohoPSMQdDEUeudPZ/5VXUc4OEVzoX01iOUZwxWz1L1HRmGms4JqnyQcfW5usQ
        Serxz2KWfDkD7rl/b6XFnbZBfMEXrZ+X6VYR2fecrYeVE5265gBlrKSboU0IZB7++SmT
        CwCQSrqMLhbB3p2MV1xN/dQqf/ImTUNo5EbrGLwyoa7Hv0ONQ4NyLa8DqieTDBbbXBJG
        s9fvTcViMxFsHaI3P5vQs3ASDE2sx7SGUG4Fa8hAGaHqg5vZcKc6qyj+YwPntAehuE9s
        iWJzrANyRW0KPIJvcqfTA91PZ2yAkZTwKZPAGK1fikUwyCCr0x9cHHTDOUj+wo7fc4YH
        UWbg==
X-RZG-AUTH: ":O2MIc0epdfgAjoV+frHI3UhxNCLBO5P+YT7khnlEbwYQlWfkbhtsmC7w4vbjaDWHXQAjCw=="
X-RZG-CLASS-ID: mo00
Received: from skull
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id e01925w1BFwGgUs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
        for <linux-kernel@vger.kernel.org>;
        Tue, 11 Feb 2020 16:58:16 +0100 (CET)
Message-ID: <22d66e6fe7439db9c29f6715cdc3290680b6598d.camel@rohdewald.de>
Subject: iwlwifi trigger 15 fired.
From:   Wolfgang Rohdewald <wolfgang.kde@rohdewald.de>
To:     linux-kernel@vger.kernel.org
Date:   Tue, 11 Feb 2020 16:58:11 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 5.5.2 on an Intel NUC Skull Canyon

Happened today for the first time when booting. 
Worked again after rmmod / modprobe iwlmvm and iwlwifi

# dmesg |grep iwlwifi
[    3.762226] iwlwifi 0000:03:00.0: enabling device (0000 -> 0002)
[    3.776264] iwlwifi 0000:03:00.0: loaded firmware version 36.8fd77bb3.0 op_mode iwlmvm
[    3.962808] iwlwifi 0000:03:00.0: Detected Intel(R) Dual Band Wireless AC 8260, REV=0x208
[    5.017086] iwlwifi 0000:03:00.0: Collecting data: trigger 15 fired.
[    5.265221] iwlwifi 0000:03:00.0: Not valid error log pointer 0x00000000 for Init uCode
[    5.265931] iwlwifi 0000:03:00.0: Fseq Registers:
[    5.266633] iwlwifi 0000:03:00.0: 0x252030D9 | FSEQ_ERROR_CODE
[    5.267340] iwlwifi 0000:03:00.0: 0x745346CD | FSEQ_TOP_INIT_VERSION
[    5.268026] iwlwifi 0000:03:00.0: 0x66904604 | FSEQ_CNVIO_INIT_VERSION
[    5.268732] iwlwifi 0000:03:00.0: 0x0000A052 | FSEQ_OTP_VERSION
[    5.269499] iwlwifi 0000:03:00.0: 0xFC308367 | FSEQ_TOP_CONTENT_VERSION
[    5.270179] iwlwifi 0000:03:00.0: 0xD74D5BB1 | FSEQ_ALIVE_TOKEN
[    5.270884] iwlwifi 0000:03:00.0: 0xE4092179 | FSEQ_CNVI_ID
[    5.271559] iwlwifi 0000:03:00.0: 0x54DEAD4D | FSEQ_CNVR_ID
[    5.272260] iwlwifi 0000:03:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
[    5.272957] iwlwifi 0000:03:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
[    5.273713] iwlwifi 0000:03:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[    5.274407] iwlwifi 0000:03:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[    5.275931] iwlwifi 0000:03:00.0: SecBoot CPU1 Status: 0x3090001, CPU2 Status: 0x0
[    5.276525] iwlwifi 0000:03:00.0: Failed to start INIT ucode: -110
[    5.277182] iwlwifi 0000:03:00.0: Firmware not running - cannot dump error
[    5.290893] iwlwifi 0000:03:00.0: Failed to run INIT ucode: -110

-- 
mit freundlichen Grüssen

Wolfgang Rohdewald

