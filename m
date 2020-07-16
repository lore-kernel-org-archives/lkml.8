Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AE7C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25A820849
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFHjdhb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgGPOAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgGPOAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:00:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ADFC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:00:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so7214236wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhAlYdV5Ne68CM+OfBERNX54x9vjQJ2ipPF8jNzEsTE=;
        b=YFHjdhb3nz8ipEzJ5Z806+yAFjm+JnCtifCj6oH7xDw7KtUOJ803J24ZjjOOOhC5SY
         If9NQFbI1uNzn53+X4WA3nqiVRBvRaKaoXJM9NtJWkvQn6GgpyaJHFkcYmUdivz4Tnak
         9LrnSDlGMHCPbNeUqzcR7y1eiZCJI+3+i3g5AesZsCYEfEPIAHZ9Sv80NNIflvXhbZFF
         trvIALQsI4z7xNXWhb5jZsiTVhHjN8z6ugz7+X67NnBZ9XEH0+HKETaP+WHDLLkgd96L
         fUqTlXxcQ0wjCzXjsdNA8mYUHYEPIJRbgB6GQfu3GsNkpy1pZcuZXu/pEzf7o+2i5du9
         xBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhAlYdV5Ne68CM+OfBERNX54x9vjQJ2ipPF8jNzEsTE=;
        b=e67I4vFR+9jj+r1SqT+p2zmgk5zer09Gi2CD2wIXKEqgAaHewghlbrq4olUa/FwFfZ
         zLOWlYmyFrB/oTXxwj3IoxL0IlxYgAMPNeGyms9ZWWTEDAvt2Sk1yK7rl4dEuwJENvd4
         0iHEwPpfEJxUAia/Pen0ifq56s+G/yczhb4hJsSP25i2aEF96sDr1QLH7FK581Z2iNR9
         cOBxRtaGiVqoZUMyx/IXznIySZdjQeZmE65HMTr3fzpk9KMpUloTwh9VYR/bUWkB9531
         VO2s+i28w9i316gKpbIbNyYjGSRHjXDbDrgmS6Uo5DIs1tL5OaNEENxyLTKNfPHMiQpC
         pKrw==
X-Gm-Message-State: AOAM533VubqWbytcvtz6uV/D2cca1sx/o7lKfZmzmLGM7B7uNpmuHMaZ
        42MkKD7EemhN8tIGVrCKsN5Sqw==
X-Google-Smtp-Source: ABdhPJwCAMel7xrEfrRY7L+G7+cweQnfelaWTowsT3p/jtlurNSyRj2+Bif0CrPV/qz9AQShAUeY8Q==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr5144810wru.310.1594907999384;
        Thu, 16 Jul 2020 06:59:59 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 22/30] iio: dac: ad5755: Fix kerneldoc attribute formatting for 'lock'
Date:   Thu, 16 Jul 2020 14:59:20 +0100
Message-Id: <20200716135928.1456727-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5755.c:105: warning: Function parameter or member 'lock' not described in 'ad5755_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5755.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 7723bd313fc6e..bee4ed0ce91a8 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -82,7 +82,7 @@ struct ad5755_chip_info {
  * @pwr_down:	bitmask which contains  hether a channel is powered down or not
  * @ctrl:	software shadow of the channel ctrl registers
  * @channels:	iio channel spec for the device
- * @lock	lock to protect the data buffer during SPI ops
+ * @lock:	lock to protect the data buffer during SPI ops
  * @data:	spi transfer buffers
  */
 struct ad5755_state {
-- 
2.25.1

