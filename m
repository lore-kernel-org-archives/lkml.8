Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3891C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B063E20825
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hd2yo7pm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgGPOBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbgGPN7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168A5C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so7210346wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=prTZ5JEswUnocIpjh51nEpoOPf62BiWU4kn635sFnW8=;
        b=Hd2yo7pmgR53H21ZDQwCTMsS7vmn+wCghqwTrr1p71Vg/do4U9Uh450Dtj7OneNCx5
         bzdI98Lv0aruEcPTEqDPmVbi7xwK6HgkSxaI3WC0iedr2lQQn487UTvM/sdLkDW30iKP
         d5cH1P5Nk/NPDup/jnmfyvKQaDacq/y5UMiZWdpUsEdSaXMc9BUpTHKvbnRDXnYlDOHU
         bofZ043dhHRiP1oIAhQWfWcisZdVSRwr4nZI3GxNDY1iB2r/hiL8emYHW8yojob2Mr8G
         HVe8nxbbvG5IfR8E+z3WnsFXmgZo+gni9zjsrrJ/VwANSAyydO42CpYlgfWJV8vfqiKi
         /dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=prTZ5JEswUnocIpjh51nEpoOPf62BiWU4kn635sFnW8=;
        b=nAxBr3KXQIzplJ+gsznXcvBGXCPZlebRfGNYVIkZUOfAx3mT6/cvp4Ze/ZY+CglapQ
         miEaLCKCoYkRTCSwj8+Zd5Om/nlI1vZZTz/7LNwab7pTDXAcpSK065mpn4xHlTaG3txw
         a19uoGRJQIl1yks8gmj9/oCwlfEW+CtEDSjH6QhMBJLinAN8RM8CQWpbu9N96uyj75Ie
         M+w11gjWGUFt9nku76fDAY7f45V41a63FiZ6rOLMKMdED20w/C5bKKjK+C4yhbtmuNZW
         BHgDzLfLRLJANtmAFQOkcha9p86xB7KH2an0TqIiBn86WrvQV0prKuJuhiAmYO66GHx7
         GB0A==
X-Gm-Message-State: AOAM531f7c9kbMaxkaUVTEUfOSMCARe1TI+busSkYtpRMrWIV71syw/G
        slD2aeIXGfff1YzQiCXLDVGSBw==
X-Google-Smtp-Source: ABdhPJwX3IRYbokI3ZHKxGyWbM/Z7e1QEIkzkfGiBwVXjlu5nBA3i+bXqJiziE4LGWMiuzurDIAHbg==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr5143505wru.310.1594907976855;
        Thu, 16 Jul 2020 06:59:36 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 04/30] iio: adc: ad7298: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Thu, 16 Jul 2020 14:59:02 +0100
Message-Id: <20200716135928.1456727-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document either of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/ad7298.c:106: warning: Function parameter or member 'indio_dev' not described in 'ad7298_update_scan_mode'
 drivers/iio/adc/ad7298.c:106: warning: Function parameter or member 'active_scan_mask' not described in 'ad7298_update_scan_mode'
 drivers/iio/adc/ad7298.c:154: warning: Function parameter or member 'irq' not described in 'ad7298_trigger_handler'
 drivers/iio/adc/ad7298.c:154: warning: Function parameter or member 'p' not described in 'ad7298_trigger_handler'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/ad7298.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index dc8d8c5f6ad36..006b6f63cf4e8 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -98,9 +98,9 @@ static const struct iio_chan_spec ad7298_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
-/**
+/*
  * ad7298_update_scan_mode() setup the spi transfer buffer for the new scan mask
- **/
+ */
 static int ad7298_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *active_scan_mask)
 {
@@ -144,12 +144,12 @@ static int ad7298_update_scan_mode(struct iio_dev *indio_dev,
 	return 0;
 }
 
-/**
+/*
  * ad7298_trigger_handler() bh of trigger launched polling to ring buffer
  *
  * Currently there is no option in this driver to disable the saving of
  * timestamps within the ring.
- **/
+ */
 static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-- 
2.25.1

