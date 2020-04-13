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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A097C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0AA20731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJexAu2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbgDMSBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387544AbgDMSBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:01:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABA0C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:01:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so10880504wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uV6IGqg+WAl5sD9tlqG1PW+JWwQKMrghYa4BIYKJU24=;
        b=dJexAu2jDuMX0jl4rYd2sdGDwzHIwdvHk/Lhoatp1rprblsm5mi77X2jzzFwr6oeed
         5f37h6elb3RZjVl7KIvhRhC1BLkkEmd8I2VcGikQfxgisUl2s+jd45Rh3TZB3GhlQMUu
         jh8ppMIGVwcoEYd4L5WlMLfc4uRMLP0mukR5qGtVWhgBqVN+jo8qvO6IUIz8sxXCjL2X
         3CbcynVAVoCbM4TYOZvPY/bdiQZR3xluesyV5tAOjS8yErTs1PqqdbPWty6e6b7EpPMI
         2atwzno6Aqt9eW9yqp5eol/knft3rvIzhJ5Fb8U9BWJIIzN5GBb3oQxEcoxHVFguicwN
         1gaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uV6IGqg+WAl5sD9tlqG1PW+JWwQKMrghYa4BIYKJU24=;
        b=InRZ/u5N3yBZoWtAnRfeQUA04V8Sa9eZifOSCOcFuwlMrhSFsxvNayrn3ktNOAtzGN
         ABz78a/rZDx4xOq7U4Im08LNa9bcdyIQBIZLD5/YtDbhlHmVhXTB5ymo9MNJZLPp8X2/
         F8IGc49heAh8Eg+3uedYI3+KqbbIihVkTnQmxmq5cU9em8NiTP+fsJXxO/EzzElRQ4pC
         GDaHEeCpW9xzWTbF8GVHE/SjWb1cAOn+IxbWfUjkr4bd0wtAFhkjd3qh9Fj9YxrYKoU1
         pFGmFiiWMoVwQuGAFr/ptvFHSQXH66M/RoSTY9HNITsdkE06wSjGUR9x2fA+HNweqssC
         FkSw==
X-Gm-Message-State: AGi0PubyFJFTf1PPij7rnKxzvTlw1Ay5tBAwO8Q3KbqvBry7fiO9ZGts
        7VCVU3J05t7m/fyj9b5gZTgfvHgH
X-Google-Smtp-Source: APiQypIoqF43KSnGa6mk8iXCnWjpUFXwZc1RhPx7wMxVw/tfrwty0MU1HN5fHTmbCRvw0ITtznnPEw==
X-Received: by 2002:a1c:147:: with SMTP id 68mr20305503wmb.28.1586800901150;
        Mon, 13 Apr 2020 11:01:41 -0700 (PDT)
Received: from localhost.localdomain (dslb-092-073-054-241.092.073.pools.vodafone-ip.de. [92.73.54.241])
        by smtp.gmail.com with ESMTPSA id u3sm6476181wrt.93.2020.04.13.11.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 11:01:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: make const char array static
Date:   Mon, 13 Apr 2020 19:59:57 +0200
Message-Id: <20200413175957.30165-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200413175957.30165-1-straube.linux@gmail.com>
References: <20200413175957.30165-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make const char array 'fw_name' static. Clears a checkpatch warning
and reduces object file size by 17 bytes (gcc 9.3.1 x86_64).

WARNING: const array should probably be static const

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/fw.c b/drivers/staging/rtl8188eu/hal/fw.c
index 432e6bea5ea1..3d1d29e9f8e0 100644
--- a/drivers/staging/rtl8188eu/hal/fw.c
+++ b/drivers/staging/rtl8188eu/hal/fw.c
@@ -146,7 +146,7 @@ int rtl88eu_download_fw(struct adapter *adapt)
 	struct dvobj_priv *dvobj = adapter_to_dvobj(adapt);
 	struct device *device = dvobj_to_dev(dvobj);
 	const struct firmware *fw;
-	const char fw_name[] = "rtlwifi/rtl8188eufw.bin";
+	static const char fw_name[] = "rtlwifi/rtl8188eufw.bin";
 	struct rtl92c_firmware_header *pfwheader = NULL;
 	u8 *download_data, *fw_data;
 	size_t download_size;
-- 
2.26.0

