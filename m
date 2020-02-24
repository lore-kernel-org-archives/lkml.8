Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C32DC11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F070820578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nRaItZnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBXNvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:51:37 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55279 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbgBXNvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:51:36 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200224135135euoutp02993c88f843494ccc1a369bf9ca277e2a~2Wu2gDxiN2905129051euoutp02G
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:51:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200224135135euoutp02993c88f843494ccc1a369bf9ca277e2a~2Wu2gDxiN2905129051euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582552295;
        bh=a+1ZrR03pNe3rzc0952jizmxS7VZ+Cze9rghvIqv2M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRaItZnpR7SS4wm9zA/j8mYPuBPd0gX1B8e8Ybq5czwyy3n/xLSWMGHof4Mmsgnhi
         P2GKyRZS2Zyzu6txtI8vzY5UOKwLGhxCqfg2CMyFgT+QPzfHRwAEHgTseYBU5lUhNb
         DVv3XtJQyUMXBPSCeVjU/BEysSfG9ey6rWZJrPF4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200224135135eucas1p1e480937a6fab393983c3f4668eb3e91d~2Wu2NN7mF1388613886eucas1p1d;
        Mon, 24 Feb 2020 13:51:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 85.82.60679.7E4D35E5; Mon, 24
        Feb 2020 13:51:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200224135135eucas1p1a08b34f6329d157c77994965f89a6050~2Wu16DZcq1388613886eucas1p1c;
        Mon, 24 Feb 2020 13:51:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200224135135eusmtrp17a50d0601f4fce20e15cc6cc099e2903~2Wu15dWuF3154231542eusmtrp1N;
        Mon, 24 Feb 2020 13:51:35 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-8c-5e53d4e773c0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D9.6F.08375.6E4D35E5; Mon, 24
        Feb 2020 13:51:34 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200224135134eusmtip1cdaa2480183cde734550715176fbf51a~2Wu1gb7Ef0192801928eusmtip1P;
        Mon, 24 Feb 2020 13:51:34 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/2] mfd: wm8994: Fix unbalanced calls to
 regulator_bulk_disable()
Date:   Mon, 24 Feb 2020 14:51:23 +0100
Message-Id: <20200224135123.27301-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224135123.27301-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djP87rPrwTHGTRsFbO4cvEQk8XGGetZ
        LaY+fMJmcf/rUUaLy7vmsFmsPXKX3eLwm3ZWB3aPDZ+b2Dw2repk87hzbQ+bR9+WVYwenzfJ
        BbBGcdmkpOZklqUW6dslcGXcuX+MqeA/d8Wp7e+ZGhhncHUxcnJICJhI7L04j7GLkYtDSGAF
        o8TUy/dYQRJCAl8YJX7vZIdIfGaUuL2lhxmm4/6HiywQRcsZJX48d4AoAmr4tOseO0iCTcBQ
        outtFxuILSJgK/F6RwMLSBGzwE1GiR13+sC6hQVCJP6dX8EIYrMIqEq8/boFKM7BwQvUcGRG
        LsQyeYnVGw6ALeYUsJN43bGdGWSOhMB7NomVX7czQhS5SDyedJYVwhaWeHV8CzuELSNxenIP
        C0RDM6PEw3Nr2SGcHkaJy00zoLqtJe6c+8UGsplZQFNi/S59iLCjxI4zG9lBwhICfBI33gqC
        hJmBzEnbpjNDhHklOtqEIKrVJGYdXwe39uCFS9DA8pCY0XkCGooTGSVmP13LMoFRfhbCsgWM
        jKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECk8Tpf8e/7GDc9SfpEKMAB6MSD6/E3uA4
        IdbEsuLK3EOMEhzMSiK83oxBcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1O
        TS1ILYLJMnFwSjUwVh9YXLqyQ/+R8YLv+5mCt23m5BeJPejuXTplo4fPHZajBhX/1xxT6+P8
        t9j13Q+PL4U5qsHvDfhv5lXU3VZNmmV0akrnhEnFOW/+hQgy/ha2rxX72XUoQXFDPpvJo/bJ
        nTHdjKHnAyx6vNKjnSc2WQsb32D5kiBkvviSwDPVafE+tTsm8CQrsRRnJBpqMRcVJwIAQgmN
        Xw4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsVy+t/xu7rPrgTHGTy5Z21x5eIhJouNM9az
        Wkx9+ITN4v7Xo4wWl3fNYbNYe+Quu8XhN+2sDuweGz43sXlsWtXJ5nHn2h42j74tqxg9Pm+S
        C2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4
        c/8YU8F/7opT298zNTDO4Opi5OSQEDCRuP/hIksXIxeHkMBSRomju08zQiRkJE5Oa2CFsIUl
        /lzrYoMo+sQo8bXtLhtIgk3AUKLrbReYLSJgL/Hg1z8wm1ngLqPEldd+ILawQJDE/mtvwYay
        CKhKvP26BWgbBwevgK3EkRm5EPPlJVZvOMAMYnMK2Em87tgOZgsBlaw8sollAiPfAkaGVYwi
        qaXFuem5xYZ6xYm5xaV56XrJ+bmbGIEhu+3Yz807GC9tDD7EKMDBqMTDK7E3OE6INbGsuDL3
        EKMEB7OSCK83Y1CcEG9KYmVValF+fFFpTmrxIUZToJsmMkuJJucD4ymvJN7Q1NDcwtLQ3Njc
        2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOjyAe/WMsd6wtf6rq8vfjosoNE5uJOh5VP
        C/yPNW/q5U3+eYPPc4+suPqPyJkiLq1HVSV5d5utzzHWDv9/PthQdvKZ1jI7tpgnu9IFw+a/
        L7jLnST/L/jkEe/d4iHBhxonHp/29bWXuQifY2uFfeUTg2ePLh+1Vd4Q8dr2mfRnr4fqG4WW
        8RUpsRRnJBpqMRcVJwIA9FY0828CAAA=
X-CMS-MailID: 20200224135135eucas1p1a08b34f6329d157c77994965f89a6050
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200224135135eucas1p1a08b34f6329d157c77994965f89a6050
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200224135135eucas1p1a08b34f6329d157c77994965f89a6050
References: <20200224135123.27301-1-m.szyprowski@samsung.com>
        <CGME20200224135135eucas1p1a08b34f6329d157c77994965f89a6050@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When runtime PM is enabled, regulators are being controlled by the
driver's suspend and resume callbacks. They are also unconditionally
enabled at driver's probe(), and disabled in remove() functions. Add
more calls to runtime PM framework to ensure that the device's runtime
PM state matches the regulators state:
1. at the end of probe() function: set runtime PM state to active, so
there will be no spurious call to resume();
2. in remove(), ensure that resume() is called before disabling runtime PM
management and unconditionally disabling the regulators.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mfd/wm8994-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index f15f12d8bccc..f2668f52a6bd 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -591,6 +591,7 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 		goto err_irq;
 	}
 
+	pm_runtime_set_active(wm8994->dev);
 	pm_runtime_enable(wm8994->dev);
 	pm_runtime_idle(wm8994->dev);
 
@@ -610,7 +611,9 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 
 static void wm8994_device_exit(struct wm8994 *wm8994)
 {
+	pm_runtime_get_sync(wm8994->dev);
 	pm_runtime_disable(wm8994->dev);
+	pm_runtime_put_noidle(wm8994->dev);
 	wm8994_irq_exit(wm8994);
 	regulator_bulk_disable(wm8994->num_supplies, wm8994->supplies);
 	regulator_bulk_free(wm8994->num_supplies, wm8994->supplies);
-- 
2.17.1

