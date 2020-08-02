Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F04EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 15:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB2F2072A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 15:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQytedup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHBPCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 11:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgHBPCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 11:02:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8BBC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 08:02:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 9so12189724wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dc2jyTne/kuOt10YK4BrvGoPmKDCRbld5Cypz0CqkIo=;
        b=dQytedupL1Ato/YOt0Z4EAa9bXc950kyiFjxlL/mDb+wIUfHuqZJvTyE3aAnOkeXHg
         rUeUVp+d4FN8moPYv1jWXKUWMnSW03aun3n++uQgnf+6XHB76TFwinGFS9mmDOpf1o0A
         J8xSABqjqFNYDd3jMIQ9Bhgd3T4lT070y+0I1Y9S+9JagyXpcuZTTQsfVkKfupN/Om+6
         7Ncb/0hyB6Bgavhgwcd2W0dUH4TygSbBboF5puRp1WmEp+p92pycFXtr2wJ3TjcIltmI
         esD301F1sf2I/e+Mm8m1LA+LPCvlTIU92c0n8lBmXu8n7aa4BDlzAFu/69EYmQB60y1I
         k78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dc2jyTne/kuOt10YK4BrvGoPmKDCRbld5Cypz0CqkIo=;
        b=W58f4q8T84M1swQ372d2yjJhMs6X19rj8zJn0/OiXxSdf7DbhtjIOsBBfDNGLCZhpu
         +bBkzHXJgqMTWI3/4VNu1RHWyeRdL+AmJv6dHCrD8dlqV4Nu3MR+HfYlnQQ/O67HvWn7
         tsvFZwftmf2nmNk1/Nx5hyMtYFDeIywlx0qfVmtwjZT3uD8es9RxzOEwA2oA5K44Kyzv
         kCBF9FUHtHlEFc0DdCLLQVveDTSTc5OFOafIfTeA3BhdHCyZzK8/EsdU3DUWbfZEZbuL
         d7wQwt1m8QngIPjQFL+TuvJsyvTmJiJz0DpTUuJJfKwoVbznWRS2+dqEkZmQTYvKZxwB
         80Jw==
X-Gm-Message-State: AOAM532lQMsrgQFtdQ1ww/OQsm19otsX+yHQy/nMLtsVQOtjLUtV6u0W
        Qw0wr2yIunAufbUBBQ8hc1o=
X-Google-Smtp-Source: ABdhPJxjuHi2vABSz1QxlAE3aRTQbOREPQTDPOFpvYm9Cdwlq20qiL4SvUQ04KJ1lR7qTGLCn3sXvA==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr12511026wmg.66.1596380524100;
        Sun, 02 Aug 2020 08:02:04 -0700 (PDT)
Received: from tsnow (IGLD-83-130-60-139.inter.net.il. [83.130.60.139])
        by smtp.gmail.com with ESMTPSA id z63sm21165821wmb.2.2020.08.02.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 08:02:03 -0700 (PDT)
Date:   Sun, 2 Aug 2020 18:01:57 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wfx: clear alignment style issues
Message-ID: <20200802150157.GA3052@tsnow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Clear checkpatch alignment style issues in debug.c.
  CHECK: Alignment should match open parenthesis

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/wfx/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/debug.c b/drivers/staging/wfx/debug.c
index 3f1712b7c919..83ccbab50899 100644
--- a/drivers/staging/wfx/debug.c
+++ b/drivers/staging/wfx/debug.c
@@ -32,7 +32,7 @@ static const struct trace_print_flags wfx_reg_print_map[] = {
 };
 
 static const char *get_symbol(unsigned long val,
-		const struct trace_print_flags *symbol_array)
+			      const struct trace_print_flags *symbol_array)
 {
 	int i;
 
-- 
2.25.1

