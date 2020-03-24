Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B78C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE1F208D6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055899;
	bh=fgCakXjwGY+rUhPIQxjVi1O2wIJkX+bF8EbPDUz0qfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0ibI/F3wRRNEEAfPz1C9PjWVonlHh7WeCWNle0PAF+oQr3p2G1RKkXmKKCW3BaHTd
	 cXdYv0It9TFt7FdzSbgc8v5JK0QpyD2UaNoahjTQ4qCdvOxGIiD4kRhz0S5cLxyG/F
	 SjPRXFUeqUFOfC0Gp9DLlLo1KRLX1/AkxODosRU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgCXNSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbgCXNSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:18:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAE6D208CA;
        Tue, 24 Mar 2020 13:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055894;
        bh=fgCakXjwGY+rUhPIQxjVi1O2wIJkX+bF8EbPDUz0qfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLfvnR1GURgpfapItce9trVLHOv+8ql6cbbdVAapUtr/qzMDMEef3iMDFtxMoohiA
         zSMKObCbDWgZU69dvF99JloTF4U2Va8zrgmD0+4+NhFKHM9rEJGUzGLrHjOaAJG3Ye
         yBsrdKjt8pHV/Qzo9K7kXupF5ueISreCJSqWWXUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Linus Waleij <linus.walleij@linaro.org>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.4 060/102] iio: magnetometer: ak8974: Fix negative raw values in sysfs
Date:   Tue, 24 Mar 2020 14:10:52 +0100
Message-Id: <20200324130812.757689015@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
References: <20200324130806.544601211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

commit b500c086e4110829a308c23e83a7cdc65b26228a upstream.

At the moment, reading from in_magn_*_raw in sysfs tends to return
large values around 65000, even though the output of ak8974 is actually
limited to ±32768. This happens because the value is never converted
to the signed 16-bit integer variant.

Add an explicit cast to s16 to fix this.

Fixes: 7c94a8b2ee8c ("iio: magn: add a driver for AK8974")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Linus Waleij <linus.walleij@linaro.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/magnetometer/ak8974.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -564,7 +564,7 @@ static int ak8974_read_raw(struct iio_de
 		 * We read all axes and discard all but one, for optimized
 		 * reading, use the triggered buffer.
 		 */
-		*val = le16_to_cpu(hw_values[chan->address]);
+		*val = (s16)le16_to_cpu(hw_values[chan->address]);
 
 		ret = IIO_VAL_INT;
 	}


