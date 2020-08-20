Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AAAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D4B22D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfW2LIV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHTIv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgHTIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:51:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C074C061757;
        Thu, 20 Aug 2020 01:51:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 17so686511pfw.9;
        Thu, 20 Aug 2020 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i64e4Hw6hiFKIw4E9ywmRcqkHQEUxTrspJYDHXsusTk=;
        b=MfW2LIV48hHDR6/+1vCzQITMjw2E5StyiKIzQTs6Qfx4Xrk8k1zkzaiCsumBJ/k3dc
         NGUgiVb5BxsTAoz00ypfb5gOo2ePv6zR8n7zdDq6oP8YCcs404Wyx4//PRwdIYjlggOO
         I3t3t3iK6RsIsz0s4t1NKaeRPgbJ2LKbs2gT8x9enaZ8KQtFjrBJG3CNd6D7viRo0mT0
         78oVfIrC3V4AwPFVXEfywHk1zjlW8xmtrp6Fb79azoOywQm19gHP+ABCNRrVNEQcOODa
         SlPvVhG9swIoRNfAA3OV8iLLeXfviFwU6eHNgxUG6gZLePbaBB0bxIuHCIQOg1QVYIHR
         lSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i64e4Hw6hiFKIw4E9ywmRcqkHQEUxTrspJYDHXsusTk=;
        b=puG+WWmcPndNmesfPggnvsiSeopZ/JXJNTwOhvhyLLhcS9MijtM2UX3NvuuHrYVdgQ
         hiERq0lL2M/85RiCshaavAtI5Tboxet7ROGPx+18cOs1W9TnsUiDZwb23PpxMtf4X2yg
         wd9iWh8uJE5BUrOFAAu4X0KVF3/8dJv7cCdFhH2oiraCF54AJDRBQaJZZQhK2H3HJY90
         bg3UG/MzZXYMcTK5OA12sF+a84wrRYRtwYG9dm8lGI3dfYiOHlEWiUjN6nYzmXY6LUA0
         IQmdqiNyKKHYyBizRzeKmdtqMlRkcRk0grGTMjHtRArUqyIbU2lf2xBJW4K4WgPJZIRc
         TO+w==
X-Gm-Message-State: AOAM531Ex9IG6FmjF7OQPkfcNDaNzoqeW8G+oZ6OJHKrscE8RL/SuKnp
        bqSKjEdALnqGIS/1kV0QUVQ=
X-Google-Smtp-Source: ABdhPJz+CWaexcHNvcwJsPC0Jb0gRvkVakVRSXCLCQb4AM3hlGGbwlfItdibD4Enz2OstRn6qJSKNQ==
X-Received: by 2002:a63:df10:: with SMTP id u16mr1759689pgg.437.1597913477054;
        Thu, 20 Aug 2020 01:51:17 -0700 (PDT)
Received: from blackclown ([103.88.82.201])
        by smtp.gmail.com with ESMTPSA id l22sm1407820pjy.31.2020.08.20.01.51.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 01:51:16 -0700 (PDT)
Date:   Thu, 20 Aug 2020 14:20:57 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 4/6] staging: wfx/debug.c: Fix spelling mistake "carefull" =>
 "careful"
Message-ID: <ec3e765875adfe59f1d8d8ef2c610d6423116f55.1597913333.git.usuraj35@gmail.com>
References: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/staging/wfx/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/debug.c b/drivers/staging/wfx/debug.c
index 3f1712b7c919..5772e2375370 100644
--- a/drivers/staging/wfx/debug.c
+++ b/drivers/staging/wfx/debug.c
@@ -299,7 +299,7 @@ static ssize_t wfx_send_hif_msg_read(struct file *file, char __user *user_buf,
 		return ret;
 	if (context->ret < 0)
 		return context->ret;
-	// Be carefull, write() is waiting for a full message while read()
+	// Be careful, write() is waiting for a full message while read()
 	// only return a payload
 	if (copy_to_user(user_buf, context->reply, count))
 		return -EFAULT;
-- 
2.17.1

