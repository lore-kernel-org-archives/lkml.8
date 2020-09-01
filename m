Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06121C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64D12151B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599004184;
	bh=dfcpHebh1zisjZHusBLDM0il2QaGm8evd9hzuKeAFbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VsHyuRbsQuJkqxdkZ9pwotNn62DATO/cZHco97M3lFQVJp7IrJR5TRU/NdPz0fMZ/
	 cfszbHceEYMPBpMmMfz7k7/a/qJLk7etua/K0+iL5mnAubABfXem1uVSKuzCi+EDby
	 9EcS0NYhjkGe3C/7Jd3h8nH8tVzPe8FmVcVHGda4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgIAXtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 19:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgIAXtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 19:49:41 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C48C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 16:49:41 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id c6so3375057ilo.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 16:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEs0aJjvLRofvx5BLuIuaM2VIGLLqoZwRYQsqipmaUY=;
        b=Fi0YMKU/Yzlm+ZK1SVYMLYJ1Fa7bnWrky4iZ65Z36cmAU6HCh7iQ6pY5lGmNZs0yaa
         SRV6fWWBHk99sp/7uQxmhd7/ek/w58sRfw1lBja7+s411QU+rj577gfSIl6H4X4Kwh4k
         fXxyNITpBXrEmLcAYZQ/jeVxZyT8+ZfFeyutU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEs0aJjvLRofvx5BLuIuaM2VIGLLqoZwRYQsqipmaUY=;
        b=G7nRoc5G27Ne5sEOhTY2+7gREYoQo8zO10qh14Ol11FQLs2KFEY0Q9811cwJdQFk+7
         r2WYXnI0I83dlpLjNpblV5FWdBU+3kwdpyGPbkMEoeR0qMWXwSsgbrOODrEKz3gtlQ+y
         XLWlkPgSwEm727gsuocIn2go6Yao8P8ky/D8XuiE8FVwZpbTIc7+HV9kmYJ0srQ4EiIg
         JG7izSiy+Uv+NSBA2VvpjSBLa3fqBbks6sEtCzee03+/vyUI0J70T+waLYJCxX6KTsKQ
         4YQVf911q4CUiqipcsfOV1elSc9S/SdSgNN48X+QrPhZZfajvIXdiF50zs0b+Eo2ZeQb
         lDVA==
X-Gm-Message-State: AOAM531TkPBOD92Yc6o3zuGp6rJQR2i7P46o1NBJ/Q6Q8OPNDAhcp5NS
        apvgldef4Po3uincSVA8B3jJ2+7owPsQfA==
X-Google-Smtp-Source: ABdhPJwzA9Q59GddExipXURfjpgwoNSLVRSJzMim8GrUh8kYwPedesNNjr7EtpHAXYi756sX4Y5mqA==
X-Received: by 2002:a92:6f0a:: with SMTP id k10mr1287002ilc.5.1599004180682;
        Tue, 01 Sep 2020 16:49:40 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k18sm1253713ils.42.2020.09.01.16.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 16:49:40 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     tglx@linutronix.de, qais.yousef@arm.com, peterz@infradead.org,
        cai@lca.pw, mingo@kernel.org, ethp@qq.com, tyhicks@canonical.com,
        arnd@arndb.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: Use scnprintf() in show_smt_*() instead of snprintf()
Date:   Tue,  1 Sep 2020 17:49:30 -0600
Message-Id: <20200901234930.359126-2-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901234930.359126-1-skhan@linuxfoundation.org>
References: <20200901234930.359126-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() returns would-be-output size instead of the actual
output size, replace it with scnprintf(), so the show_smt_control(),
and show_smt_active() routines return the actual size.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578ecf17..29a5ceb93cda 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2334,7 +2334,7 @@ show_smt_control(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	const char *state = smt_states[cpu_smt_control];
 
-	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
+	return scnprintf(buf, PAGE_SIZE - 2, "%s\n", state);
 }
 
 static ssize_t
@@ -2348,7 +2348,7 @@ static DEVICE_ATTR(control, 0644, show_smt_control, store_smt_control);
 static ssize_t
 show_smt_active(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
+	return scnprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
 }
 static DEVICE_ATTR(active, 0444, show_smt_active, NULL);
 
-- 
2.25.1

