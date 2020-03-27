Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998BDC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320352082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUh66KIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgC0NEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:04:34 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:40368 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0NEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:04:33 -0400
Received: by mail-pl1-f172.google.com with SMTP id h11so3421761plk.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:date:message-id
         :cc:to;
        bh=q44r5Q+/YW0pPASFunSH8/is4AigD9w8fhoq4iObmf8=;
        b=FUh66KIRSsyppgFCztklvDnxVUlsFFj7xwV8t7uOBfqRHZKLOrYFXaVTQ/YId9bbwQ
         kon9samDNmyPhm+TDNUVuzBveqiVo7lnEiizwYTVGLFP8W8t6uJRms3HWjqAzrUbRS4W
         BPucVc+6xtDsQwtauIxQNIRqrHcP4EjgE6jCc1k3wI3pciykDoh5KJvsUg8UCiqtNUl1
         GkukySkHQR5nOHmjr+voXbH885iVi7Yi5jy7ppfIpz+NmuPE0pgpUkoVVBNXOwWmfTHP
         oivO2NF6BDJDcYnJdLGzDFio3oCDDo4kQIgoTui+XEfpJ1FCZhYnm4CYbUx+72Oo5Vtj
         BK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:message-id:cc:to;
        bh=q44r5Q+/YW0pPASFunSH8/is4AigD9w8fhoq4iObmf8=;
        b=jwC9UOggWYmSi1nWREZSxpup/yFwCKV40Hj1ATUQOF8s7sd4IN4h3Hg2AYihVNX9Cm
         gt9YWVN3dN7jWk7l7iqVhE7EPbByjUh+D90enM18FPCcM3vVUWVt3Gb76cSjP9aVWuYm
         cuyrMgCzAUvCXsyjxRWaPTMfvlO9yS6DJLorENUDnQjFJTH09c3cystBxIpOJMsBjX3O
         7Wjk2yjrn3/xKEHdG/ng2H+hWWkw7MfWPPHnzfGJgruc6QHmxWo5SavIPkHpfvwvD4Yh
         /LUYiSBq4yoFp8SRBtHl10U37TzFEMm+lUYuJjINmPum0fcsJUtAdgvKQXZleWPtZrgU
         +Qog==
X-Gm-Message-State: ANhLgQ3JdAhZRHXCykXcz6lAw2Ia6UMd7cRHq1sMq9axofxyf36clbpq
        0QJ984S1bEo4l/rCCI7iUIU=
X-Google-Smtp-Source: ADFU+vu34BMCCtFfrb13IfOiRfruxVrmzSTDA0w4QJGIBvogwAy1YMY9bKy7bPI06eaF2oLUk1s9/A==
X-Received: by 2002:a17:902:9890:: with SMTP id s16mr12219469plp.77.1585314272338;
        Fri, 27 Mar 2020 06:04:32 -0700 (PDT)
Received: from ?IPv6:2600:6c52:7300:a0a:e9aa:10c3:6793:9b8d? ([2600:6c52:7300:a0a:e9aa:10c3:6793:9b8d])
        by smtp.gmail.com with ESMTPSA id i124sm4091826pfg.14.2020.03.27.06.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 06:04:31 -0700 (PDT)
From:   Billie Teall <billiejteall@gmail.com>
X-Google-Original-From: Billie Teall <BilliejTeall@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/7] arm64: Introduce system_capabilities_finalized() marker
Date:   Fri, 27 Mar 2020 06:04:30 -0700
Message-Id: <279F99EB-1957-4A46-87CA-506CC749EC7F@gmail.com>
Cc:     ard.biesheuvel@linaro.org, christoffer.dall@arm.com,
        dave.martin@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, will.deacon@arm.com, will@kernel.org
To:     catalin.marinas@arm.com
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zz

Sent from my iPhone
