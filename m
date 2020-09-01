Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546ACC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29934206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599004181;
	bh=8I2/6S4NA8g5BwcpaqIkpbR2yNhiDL7XvOsIWSi4uO8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OQ1iMN2pDxlAV5gt0PuAuJrSMLk8qZpdXlDobFKP0w5iqzCOP0ujjgPnP/yJtbBn/
	 QGiFPES5gfYwGZ0Xn0g6hW0ZAUVYzgibGWPy06vDVQq7L/77AGqC6hnvFFt5wkW5aj
	 g/wxf86jnaesjxFpFpsmPp+5Q5pv4x8KiehceOp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgIAXtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 19:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgIAXti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 19:49:38 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E1C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 16:49:38 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p13so3393384ils.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 16:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oaGFlzegAhzhObOl5ystm/DE+ZWlJnH7f4raEDT5VgA=;
        b=SYmu3CGwjJrXjtImMPUk+qehy+oczAv8rFWqya5Pc7ywWZ122YhrlfyszAcdOkl8bO
         ARjvWrPrOaVCNrIEM8gT8YFImQ3Ll4mLGgvkXlKBPCM3Y+jzQKeb52QUFfsP1FmF1EcQ
         g/3axD9+hchplrqSOZhYZBY8slu8yCA9SvLeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oaGFlzegAhzhObOl5ystm/DE+ZWlJnH7f4raEDT5VgA=;
        b=NPJit9F65AblTcq9Z0I9fNTBwaXKzREmZb+KHAPpSg+9X9FuhGZmGzkzk5Sy/9H2Ix
         uZf98cTXktEDkmd/2h8GJ94eC5VELutbBqm+OwjBD2Fa+Ip34/DkHWPHqfFAak7v91mC
         qqEg8+kNztq2t3wYwzIoVTHxHQcuA0oIuf45atS9suNXqU9+Vki9lJDPUzoHM4NaEAxf
         sZbtFTDqIoCLXWQ4NK22X/48kbb5a9mk2QpNML+DtNLRDRgF282OpC5Vs/zTL2hF8xMj
         415ceYJzklUBtFz+MzNNlVxk8YkZBGcfeFUA0v/Xl7GP0D+jiCl5KHe/N+F80RkWPbjW
         2ieA==
X-Gm-Message-State: AOAM533ZUzaGVTPgDKiXK0fkWdrhPCYygqpqKn9j2qFKMVuvlLtWwBTs
        FxK4x3wiSJl4pD8JVh4lAlmE9Q==
X-Google-Smtp-Source: ABdhPJyUI6z8e3EY6AvQ136Y4DXv1DRlvrvUJufRVcDnL/aQih9dHa1XpfJaqO4k0jFJo64Vv3sZMA==
X-Received: by 2002:a92:dac1:: with SMTP id o1mr1427220ilq.86.1599004177375;
        Tue, 01 Sep 2020 16:49:37 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k18sm1253713ils.42.2020.09.01.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 16:49:36 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: events: Use scnprintf() in show_pmu_*() instead of snprintf()
Date:   Tue,  1 Sep 2020 17:49:29 -0600
Message-Id: <20200901234930.359126-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() returns would-be-output size instead of the actual
output size, replace it with scnprintf(), so the nr_addr_filters_show(),
type_show(), and perf_event_mux_interval_ms_show() routines return the
actual size.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7ed5248f0445..5f4236c84940 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10571,7 +10571,7 @@ static ssize_t nr_addr_filters_show(struct device *dev,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE - 1, "%d\n", pmu->nr_addr_filters);
+	return scnprintf(page, PAGE_SIZE - 1, "%d\n", pmu->nr_addr_filters);
 }
 DEVICE_ATTR_RO(nr_addr_filters);
 
@@ -10582,7 +10582,7 @@ type_show(struct device *dev, struct device_attribute *attr, char *page)
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE-1, "%d\n", pmu->type);
+	return scnprintf(page, PAGE_SIZE-1, "%d\n", pmu->type);
 }
 static DEVICE_ATTR_RO(type);
 
@@ -10593,7 +10593,7 @@ perf_event_mux_interval_ms_show(struct device *dev,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE-1, "%d\n", pmu->hrtimer_interval_ms);
+	return scnprintf(page, PAGE_SIZE-1, "%d\n", pmu->hrtimer_interval_ms);
 }
 
 static DEFINE_MUTEX(mux_interval_mutex);
-- 
2.25.1

