Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE806C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23A520CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942639;
	bh=CrgVa/Gc9vKnKaRjzNJoH5yqlCiMSJw0IgPSlPn42iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jB+mefhQTGcVziuLI7y0CAgxR3fFurvS8zTfaFOoi3XCvSPHcfC0occf0KYTHte9d
	 WdyMW4BPFMWrYR/cz8EnPblhXp0QMakek9RYk5hIXcB73LO2Cp4o+TAq3tUOpO9L7q
	 Y2q2cFczqO7VBWh2DgfaJykW+NQqyBlS9qWqzfd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbgFWUD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388111AbgFWUDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:03:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D49B20EDD;
        Tue, 23 Jun 2020 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942630;
        bh=CrgVa/Gc9vKnKaRjzNJoH5yqlCiMSJw0IgPSlPn42iM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EggLVt0tyOUrFxzbtIYPUFyWlMSmOC5SX1363+2tLQRzaFvg3Dj2dmWXKbTHlMo5N
         0oxLoYGcIQkWEAvxb/7WG3RXje6vLfFqL4Wg77iFWIMn3JgFIY3g0i6inb2EQlDHyl
         BcQji47Hq6UZ3pSPnICzjij7DNBLIXiWAiQMxt+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 033/477] iio: bmp280: fix compensation of humidity
Date:   Tue, 23 Jun 2020 21:50:30 +0200
Message-Id: <20200623195409.164817493@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Klinger <ak@it-klinger.de>

[ Upstream commit dee2dabc0e4115b80945fe2c91603e634f4b4686 ]

Limit the output of humidity compensation to the range between 0 and 100
percent.

Depending on the calibration parameters of the individual sensor it
happens, that a humidity above 100 percent or below 0 percent is
calculated, which don't make sense in terms of relative humidity.

Add a clamp to the compensation formula as described in the datasheet of
the sensor in chapter 4.2.3.

Although this clamp is documented, it was never in the driver of the
kernel.

It depends on the circumstances (calibration parameters, temperature,
humidity) if one can see a value above 100 percent without the clamp.
The writer of this patch was working with this type of sensor without
noting this error. So it seems to be a rare event when this bug occures.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/bmp280-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 2540e7c2358c1..973264a088f98 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -271,6 +271,8 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 		+ (s32)2097152) * calib->H2 + 8192) >> 14);
 	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)calib->H1) >> 4;
 
+	var = clamp_val(var, 0, 419430400);
+
 	return var >> 12;
 };
 
-- 
2.25.1



