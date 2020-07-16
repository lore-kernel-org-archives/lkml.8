Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF82C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5913620825
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jv6cEZz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgGPOBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgGPN7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE8C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so7162053wrl.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fG8RCQ1K6Z0ZD4fhah06tp/GYuGMejEtwlGsSpFMXOU=;
        b=Jv6cEZz6qHBVpSVOcwxAwzMDLFTHVAMLrP4A4D4V+FHDXZFAj1flc7YVNIRB0ee/WE
         aGwz1qvHH5ne6KtO0pimqv30XyEUFcAkU23rYpnzcim2sUiERnCh6IOKBB5AawvDrf8C
         ehF69Fh15rdZX9cZB3/5QsQtMFIlc6Z/K5pwABNbOJZ3J9yl9OmDxcPn1ZmNQ73UBVdd
         1nd8eBuxEXNCHdgG3vNdNRXpWRlvHe1EONC1e4r2cMKbEMXWTcWXpn3M4bomO7+Qtk0Q
         f9bBWRoxYeSNIHsBfDB6eeNBmtIY/JWwik6Dn/F/JwVAb7FmkeG6bI8x/+y8B8xVwthK
         o+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fG8RCQ1K6Z0ZD4fhah06tp/GYuGMejEtwlGsSpFMXOU=;
        b=FSZ/rdJzSbhNIvS88CWl8VCLt+YxbJmLGThrp7Ju286Aw68oAKkxiAArDpk9EtT96o
         384JCJhkat4fq56Q8PKtmC/oNxQlUj2DyJtFvFKvgl8niia9JbB59tYkXBBSGwNeemJ2
         KXq7n/0j8PJRcKmJYmh3qiaI9yvKdKe6mJYLLwONA4EQLd7GKQbnwAkDNiO3YZN5v7Oy
         fCSN+0qnnTgNrHjbL/byIX2qiC2sSeD67ZgPmBFgJTjtb0Fior5jT5QRaVUFQoBRH/3O
         mac3fCD3McVJTGPV0p3CD3NmT/yvfnl7vK6/nAc9hO1PR3+vFr01LXtXImLfapkKVpjg
         C4Zg==
X-Gm-Message-State: AOAM5335sFQHYZUaZa4rAPijNR8FGZaW3RGYFCM4nKLxr5gqkqmWcME6
        oaRbjW2Ovj67w70EN/aEOufEUA==
X-Google-Smtp-Source: ABdhPJyvpcH8qjv3cJarACK1MheVg11n29CkbWUPLk1zd4I4RoIeswrSswn++4ZubNJ1s43pi5gpJQ==
X-Received: by 2002:a5d:60c7:: with SMTP id x7mr4966047wrt.138.1594907977935;
        Thu, 16 Jul 2020 06:59:37 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andreas Brauchli <a.brauchli@elementarea.net>,
        Pascal Sachs <pascal.sachs@sensirion.com>
Subject: [PATCH 05/30] iio: chemical: sgp30: Add description for sgp_read_cmd()'s 'duration_us'
Date:   Thu, 16 Jul 2020 14:59:03 +0100
Message-Id: <20200716135928.1456727-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/chemical/sgp30.c:236: warning: Function parameter or member 'duration_us' not described in 'sgp_read_cmd'

Cc: Andreas Brauchli <a.brauchli@elementarea.net>
Cc: Pascal Sachs <pascal.sachs@sensirion.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/chemical/sgp30.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index 403e8803471a9..82e407d48a0aa 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -227,6 +227,7 @@ static int sgp_verify_buffer(const struct sgp_data *data,
  * @cmd:         SGP Command to issue
  * @buf:         Raw data buffer to use
  * @word_count:  Num words to read, excluding CRC bytes
+ * @duration_us: Time to sleep in microseconds
  *
  * Return:       0 on success, negative error otherwise.
  */
-- 
2.25.1

