Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4F0C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8183120656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3XCi9Er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgF2SxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbgF2Swx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F53C030F11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:23:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so17131070wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GhKSHECLDuFeHJY8vUxPBROqM29u71f3iQHAAqV4ZeY=;
        b=d3XCi9ErPfjZZzGOiKoVTEWivLclilU9WU3x/dULSKBtcJ3tlUJJK4dHTl/jod/9Nx
         O1J2D14q/YJPMiGSQsBbaoCaELq/33G9TlKwnK6d5LBOGJBcbXGKW/cTN2oUqz5RkZKn
         vAe/EkNmNDgua2s7ldZ+DAQ80A5lYy8+cx9JFaLQA9cUpnZZSwWe89DhahBzl9BaeMva
         +e36O+bGvEXiQr5XNt++BX2FklqKdT00Ri4oCk8ETu1u1KJgqx9pqjVu3H66J3hd8US5
         SeNgHr7I8alG3lPR/NYaB1N55TucU5OgBfktCsfMWP05pR9B8+iIQTf1NCeMi/cpn3lQ
         5csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GhKSHECLDuFeHJY8vUxPBROqM29u71f3iQHAAqV4ZeY=;
        b=nP2EGYFOkCSg1GciqtN4y2y7UjfRsFeIB0sfZMuwAskgpZExi72cpXIRAgHEMt9ZHT
         YZfjVqJN+QpIxIcdIYP8B2NB0dPTKtONwaAsp06+jiEUOqYCTX6pOHjO+JRxVDtxUWTV
         7Pm28DX+rOpVe5u61V9YeoGJLxsH7MxuGkiFXwUgq8YIyzfGHRBkg9C8fWYnTvRho0ml
         G9wZPohdzPICx1MUk7mGVGOF0yRbE3gz/KrRb5v3/ipkzhCwptQ0d1tLsvnw1L+huAJ5
         uxE9BDJVF3M1zEEaejNufMX8qGdREKPNb9GEjfa701AatBaJ6dr6ON5UfuPLxT+caDZG
         Aw3A==
X-Gm-Message-State: AOAM532bnxgqLADBGLGwrp/oh9ujznODBNkzYI6ZY+GIqfA7AR5ENpYr
        rgJBihCAr05uvFajNqsbcBlksw==
X-Google-Smtp-Source: ABdhPJwIXtf8QRvxw7IwfMYFGqBphTHsT2nT6uRKhubaqAyi6CSQlkSGha+yuQjosPu2CJSDsO/DaA==
X-Received: by 2002:adf:f751:: with SMTP id z17mr18557010wrp.114.1593447787420;
        Mon, 29 Jun 2020 09:23:07 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f17sm359690wrq.3.2020.06.29.09.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:23:06 -0700 (PDT)
Date:   Mon, 29 Jun 2020 17:23:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH v2 10/20] misc: habanalabs: gaudi: gaudi_security: Repair
 incorrectly named function arg
Message-ID: <20200629162304.GO177734@dell>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
 <20200629140442.1043957-11-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629140442.1043957-11-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

misc: habanalabs: gaudi: gaudi_security: Repair incorrectly named function arg

gaudi_pb_set_block()'s argument 'base' was incorrectly named 'block' in
its function header.

Fixes the following W=1 kernel build warning(s):

 drivers/misc/habanalabs/gaudi/gaudi_security.c:454: warning: Function parameter or member 'base' not described in 'gaudi_pb_set_block'
 drivers/misc/habanalabs/gaudi/gaudi_security.c:454: warning: Excess function parameter 'block' description in 'gaudi_pb_set_block'

Cc: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>

diff --git a/drivers/misc/habanalabs/gaudi/gaudi_security.c b/drivers/misc/habanalabs/gaudi/gaudi_security.c
index 6a351e31fa6af..abdd5ed8f2cf6 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_security.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_security.c
@@ -447,8 +447,7 @@ static u64 gaudi_rr_hbw_mask_high_ar_regs[GAUDI_NUMBER_OF_RR_REGS] = {
  * gaudi_set_block_as_protected - set the given block as protected
  *
  * @hdev: pointer to hl_device structure
- * @block: block base address
- *
+ * @base: block base address
  */
 static void gaudi_pb_set_block(struct hl_device *hdev, u64 base)
 {
