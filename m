Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8B2C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998082080D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="S9rDLtne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgFNCbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 22:31:32 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:48996 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgFNCbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 22:31:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49kz422rBBz9vHdB
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 02:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vUuEyCPnhlJ6 for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 21:31:30 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49kz421Db4z9vHdV
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 21:31:30 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49kz421Db4z9vHdV
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49kz421Db4z9vHdV
Received: by mail-io1-f72.google.com with SMTP id l22so8865792iob.23
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 19:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oQSJLWnjo3ldT1Uh/5Z6WatclhBP/542tcGFisvI+fU=;
        b=S9rDLtneBsQrH7ioKbbDGehA3XM/KAnjVe+MzWp8Kr+8srAsAg/nQSNdBWJi51lBYI
         Ped9Ppc+NVOP5MexAIxTiclwHAkx0X7BvbbiuoujMcOt6gK36HbsyDz/U/nWQpSu6Iz5
         kkKO9n1jwxP3ZtrhRCJV+zFXQkvHZp9O9xK+7QeCloj3dudOuwy/xmduMDQGL9K34Mwk
         I4yOODQyONssgkuHe7+HgwNF/tmeRQxHc1qGpm1FeLXoD3Gptm3hywyq7JoA+L5/GPMf
         C80QtDnAtG977f3UBVBmbf0g9fV/9OI3NFtkqO94EB3mcXwwp3XEkTak/5upXZPczbWO
         dZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oQSJLWnjo3ldT1Uh/5Z6WatclhBP/542tcGFisvI+fU=;
        b=L7hvybO7KawUTcVzxGHvR+kek5QOPQoxfzfZtV5o4A16IWdbpt0NnWZyer8PsfekoI
         3EYFcy1n5xuvcprw6Kfr9N0XLR0AzRrBS07x44sPybpxIBhIEvFh0IW83z+VzPKULi7Z
         NCZxdMhiJiu41GZtIfTe4wHEv0nr0XIgnc/yiOrCdWHtLSLbiEn7v0+wvK2a8o37IAKp
         vmLuX2/4FxQAD4rilVuba+SoLSRXRJGdpzuWKh8Vj6fYQF++rd++DvngN7VZnQKudARl
         MMPzMfPsBrtKHohsUa5qXmZwnclTPOcJ0ECwgn69oPbSZ7gvz4ggQw5EsNKiYhsSxZzB
         pzyg==
X-Gm-Message-State: AOAM531+3LOpeWLci5cMfwEiu71jJMTbfvGew+gJ7YoAxhdIONfsgbC9
        pSXfrfdjPpuxTh524XcgP9WyqOWBp7JjBk7fQ+G1UHXFEow/BcMjD5BGv85zLczi5TfAysejkCX
        EQoKS2QSjt0+DuU08m2/O2FXz1D7R
X-Received: by 2002:a92:dc89:: with SMTP id c9mr20840489iln.238.1592101889098;
        Sat, 13 Jun 2020 19:31:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLSKF+X0CLsLDT+aW+f1omfkM8E/RHKfsVze8FDZe1KnapiufVD9GjztK1/Y21/gNjDnuPuA==
X-Received: by 2002:a92:dc89:: with SMTP id c9mr20840463iln.238.1592101888761;
        Sat, 13 Jun 2020 19:31:28 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id 18sm5494049ion.17.2020.06.13.19.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 19:31:27 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: s5p-mfc: Fix a reference count leak
Date:   Sat, 13 Jun 2020 21:31:22 -0500
Message-Id: <20200614023122.24656-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, causing incorrect ref count if
pm_runtime_put_noidle() is not called in error handling paths.
Thus call pm_runtime_put_noidle() if pm_runtime_get_sync() fails.

Fixes: c5086f130a77 ("[media] s5p-mfc: Use clock gating only on MFC v5 hardware")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
index 7d52431c2c83..62d2320a7218 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
@@ -79,8 +79,10 @@ int s5p_mfc_power_on(void)
 	int i, ret = 0;
 
 	ret = pm_runtime_get_sync(pm->device);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(pm->device);
 		return ret;
+	}
 
 	/* clock control */
 	for (i = 0; i < pm->num_clocks; i++) {
-- 
2.17.1

