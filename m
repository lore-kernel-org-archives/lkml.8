Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE7BC4CC9E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9832E2074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzs9yWYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgCKRVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:21:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38065 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgCKRV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:21:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id x7so1560194pgh.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EGHWPlxApQjuktMa4xDP9Q063H+hJfu1b6AJ+NVENyk=;
        b=wzs9yWYIHxuZrh+l83G2npKrDy1oqKA1xypVVS2U3HsnbNYgw41X9lhRBnp5I2yzT1
         g5VgsJUrdt4LeNiaK2vJ/mH7MyOeWmpLGprY3DMJa9CbNM0R9zNZPcoJYAiL9T2Rdcj9
         +LcoDzpvuTgfkwpvij9j9ByGn7+WdlzBB7svWaFuqsRzYYOtH7AnAG602VatDxsx6EF9
         594VtuNPghhGM6IC4h6UAS0/ANrg2roTguqX5Lx8EvmYVVJDXFkKA9wFpYUK84uDLvjJ
         Qk+4ms1LaPNgumDoE2yBA9ihADez2A0VyLMvk8/f567jxhIes7jevL9y497QVZCU0BzV
         poOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EGHWPlxApQjuktMa4xDP9Q063H+hJfu1b6AJ+NVENyk=;
        b=o6x8EIpu45KtJUzDpKOn6V/Z1tDaiV6N5qGCMjrDa8NXDHorpJ7Ud6vXaaUSq7DdBC
         gIHhKn5UN82gErlRnRdy21LWnFVo9VdTYmslQJa6Wn9XFji9MLuu+nNtLDMcjrA7bfbx
         74oaKDXM0gmtZD7hVI81Dept983n4R+Xk0H6f1HhcrKqVcLen9aDev+tto3RFhweMH77
         L1/6ZV+PMczTd84ak9XBpJ6I1hGysEX5SUd3kueqlwqd2TPOO3iE45xRxneXP6NUr5OO
         zufaL627MaLhFAc94OYGpDWVmpEfKO026dbthzju42Qe5ySuTmp4PMVLaTjaqnQAz/js
         dRXw==
X-Gm-Message-State: ANhLgQ2jACs14EbVO2rO7rtQPPjO3/vKHqzS9wAnOWfHlJHbcAFedkb7
        I8n1jkKwJE4SqzcN/mXf2T3grSRa8mk=
X-Google-Smtp-Source: ADFU+vsIQvS6vI9A6/ZJeX7p5NOAE/vGwSitovbBlSU6A/ubzt4w/w/19x/VN1rAPQPkC6KZ7bZHVw==
X-Received: by 2002:a62:382:: with SMTP id 124mr3867452pfd.11.1583947287937;
        Wed, 11 Mar 2020 10:21:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id b24sm14914053pfi.52.2020.03.11.10.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:21:27 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RESEND][PATCH v8 6/6] usb: dwc3: Rework resets initialization to be more flexible
Date:   Wed, 11 Mar 2020 17:21:09 +0000
Message-Id: <20200311172109.45134-7-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311172109.45134-1-john.stultz@linaro.org>
References: <20200311172109.45134-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc3 core binding specifies one reset.

However some variants of the hardware may have more. Previously
this was handled by using the dwc3-of-simple glue driver, but
that resulted in a proliferation of bindings for for every
variant, when the only difference was the clocks and resets
lists.

So this patch reworks the reading of the resets to fetch all the
resets specified in the dts together.

This patch was recommended by Rob Herring <robh@kernel.org>
as an alternative to creating multiple bindings for each variant
of hardware.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Rework dwc3 core rather then adding another dwc-of-simple
    binding.
v6: Re-introduce this patch, on Rob's suggestion
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ba21af5c1204..2afcc04da338 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1465,7 +1465,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
-	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
+	dwc->reset = devm_reset_control_array_get(dev, true, true);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
 
-- 
2.17.1

