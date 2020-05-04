Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB0BC47258
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89972073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IEU5IwMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgEDTJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgEDTI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:08:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BD6C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:08:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v63so5997166pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Zrx3KcYEt5bVqdNCWLI716yOCASV0eftVoL6kM8jlEE=;
        b=IEU5IwMxFtRk3KIEubc7CSarG2e5aA3KYJVCBlu5RFT6cG8AIhTu/rNtCCVcZhY5Mc
         6psUHFRL28vexVfV1Tp5r/wPpyt9Hv9eV4SW3rmUcmmF0Nj+SDXwV9JJpUl8SbDeFl4s
         X+OaxkcLd2hZyiZtGCIkCm8VLdQE1QArMAS8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Zrx3KcYEt5bVqdNCWLI716yOCASV0eftVoL6kM8jlEE=;
        b=cJUfzBnVP6KfD/9lIhTAZuma2L2Rq/qWDS0VxYkFNF6W+NFpq/Ky55ShYp0ZuQBnfW
         2uVwU/4IiyCxq2JHIzugb5U9zZxe0khUVDCecEffd2yyJo4j8m2jfSH17dnRveFqoA0A
         W8uh84pZTmdIucTD2zsAPJAyGf8tL2mFji56mduVhS2W8UN6JkmyhvHS4nmYGMw5T7sk
         sZBrKzJd8FLc/+TwMwu5EfepyiciF2ANHEXDKSsvze27JXPtTf8ApQUCK7vGAaBCMbHD
         /cX/aHxi5yzpkHupaDI3kASY+v2gi0wh0/iGKtI8dtjkd/VGZDrucxjfHm/FqG+Ongjn
         IK8g==
X-Gm-Message-State: AGi0PuZpla6qLnyaYAelR/X0VomZBX1XDpxRt5u3OfK9PfMSdZFxKaYN
        H/GQEYpWXIVLhveWu5DknRfIzw==
X-Google-Smtp-Source: APiQypK4ozjl+LdphG8sRjiK+3521UTvXFxbtTSfBtQdVv4J5SnSauPrkUIQ1A1bSi3nL/QSZDKBJA==
X-Received: by 2002:a63:df0a:: with SMTP id u10mr410764pgg.79.1588619337719;
        Mon, 04 May 2020 12:08:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d18sm9498013pfq.177.2020.05.04.12.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:08:56 -0700 (PDT)
Date:   Mon, 4 May 2020 12:08:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: Make sure proc handlers can't expose heap memory
Message-ID: <202005041205.C7AF4AF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as a precaution, make sure that proc handlers don't accidentally
grow "count" beyond the allocated kbuf size.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
This applies to hch's sysctl cleanup tree...
---
 fs/proc/proc_sysctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 15030784566c..535ab26473af 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -546,6 +546,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 	struct inode *inode = file_inode(filp);
 	struct ctl_table_header *head = grab_header(inode);
 	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	size_t count_max = count;
 	void *kbuf;
 	ssize_t error;
 
@@ -590,6 +591,8 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 
 	if (!write) {
 		error = -EFAULT;
+		if (WARN_ON(count > count_max))
+			count = count_max;
 		if (copy_to_user(ubuf, kbuf, count))
 			goto out_free_buf;
 	}
-- 
2.20.1


-- 
Kees Cook
