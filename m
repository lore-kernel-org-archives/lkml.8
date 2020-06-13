Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62688C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 17:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0072078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 17:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK3+qRQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgFMRhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 13:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMRhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 13:37:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E393DC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 10:37:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh7so5025171plb.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7hwEyyxwUYdF2Guu+e/vMTnzyE7eAhVBBsibSIizD8I=;
        b=ZK3+qRQ9MEgzaQnN0sw5cx1VU8LUSl6sYcO1FgxX0/z+6z4802WNxcKc1SToc+Dpdx
         Oa3hXj2d+tz9W4Yo9N9WfOwy4jR54GMTrsYzTrazR/MCA1T2/f0fXuMADHlEfv8aboFH
         zLZxrJGblUY3cuiGsske4xmoJTgpBCprbZVhplNFzdnaCXMwfyYMXlGme8HVI+Sk6uv4
         AoOTT5pytSEx8cBR4hsjIy1uXARh5PNEfeBn25YWaVDevjuPIP59EW36ilfbCgfQxm5j
         QQIZzlcV7DlSleYRzGoWJ8nhld0I0HtVnPPgz3c8UqZElPKaMUBAE1WGHuyza58tGghk
         CuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7hwEyyxwUYdF2Guu+e/vMTnzyE7eAhVBBsibSIizD8I=;
        b=mbsDSE1oYEFwFNYm1M+Z7nPX3+XjBu+VwaoVp8bahjKnM4Td3Gduh+sUJOIZyYUVkU
         xcvuXmT4BUYseC0zGcjCLaA6CC0AM5U5JbRNwXZowurpBXOkADLw2HzqIla6D/g9k21k
         nx7f+OKsQ/zPMfDnvG52w4VMrvl4Rs7tgElW0daTBD5uHTp3/KQcLNkBLJ+cRKVe1OPi
         Xu6WveEeXlyHokggSm2EK8DSbHmPo1jlc93A1fDj7XLaeP+HyJVSLlaM12TwOk9vGpfV
         ZxndEwURH+ubIyymf5IcCPOvaMRxLq889C5bDYvw39FlfhlY0iPq0y5sCwtEG+3nfkcP
         oDbw==
X-Gm-Message-State: AOAM530NULxW7xsOwaKqVp5MmG/qzHopNHv+YzLmbqvj8Ny1sruvdb6/
        cb7j0YrRzsh5e1owlkFGOX4xxFTz
X-Google-Smtp-Source: ABdhPJxYsfjAFdm78oynRBxtOMyhELttPaW0N0G0PuldldL+YPOprKPLiuk5Bl3IXWBnbWB6DhakbA==
X-Received: by 2002:a17:90a:aa8f:: with SMTP id l15mr4546515pjq.211.1592069835215;
        Sat, 13 Jun 2020 10:37:15 -0700 (PDT)
Received: from ASMDT.1 ([114.125.253.62])
        by smtp.gmail.com with ESMTPSA id y7sm9321768pfq.43.2020.06.13.10.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 10:37:14 -0700 (PDT)
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From:   Dio Putra <dioput12@gmail.com>
Subject: [PATCH] staging: android: ashmem.c: Cleanup
Message-ID: <4ba43a70-c29f-6c41-9c81-66a25b0432af@gmail.com>
Date:   Sun, 14 Jun 2020 00:37:09 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup to make file_operations const once again.

Signed-off-by: Dio Putra <dioput12@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

base-commit: aa5af974127d317071d6225a0f3678c5f520e7ce
diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 8044510d8ec6..fbb6ac9ba1ab 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
