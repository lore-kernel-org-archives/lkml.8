Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA61AC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A125208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055897;
	bh=C6V82WfR0WiPhesQkqIHwf7eUT1pzEcPp6KnE4TR6zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GKVbvmpWQGNDyFM5997axVrWX3AJpUYr3BTw/B4jRngdhDNVmnriS4qxkWg59i1rC
	 tq9E5z0J3hcXn0gO1xPTf/ao2XhKCa/YL41feknh12/fwVq43qM9Qxit361SNV5fC+
	 OiOUa5FeDTXy5/rTJmTiMBZwTFskaX/5COzfEq8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgCXNSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbgCXNSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:18:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BFE2206F6;
        Tue, 24 Mar 2020 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055891;
        bh=C6V82WfR0WiPhesQkqIHwf7eUT1pzEcPp6KnE4TR6zY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XaF8Bx72C45xTvXhz83aRnd/ZVfwSusTO0O0zbzFqrFWDp9cNVHZ0NccyAAAbYum6
         V+uBg1ox5J+UQ8f6HoNyUiqGdScLWzdE0d/ei+6bjNYvW0h5W5wea4AtHBOwiRf2kK
         QNqNt6vKfL0oLFr11eKfbFzgcCDu3X2htwfuxkuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.4 059/102] iio: accel: adxl372: Set iio_chan BE
Date:   Tue, 24 Mar 2020 14:10:51 +0100
Message-Id: <20200324130812.670928703@linuxfoundation.org>
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

From: Alexandru Tachici <alexandru.tachici@analog.com>

commit cb2116ff97859d34fda6cb561ac654415f4c6230 upstream.

Data stored in the iio-buffer is BE and this
should be specified in the iio_chan_spec struct.

Fixes: f4f55ce38e5f8 ("iio:adxl372: Add FIFO and interrupts support")
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/adxl372.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -237,6 +237,7 @@ static const struct adxl372_axis_lookup
 		.realbits = 12,						\
 		.storagebits = 16,					\
 		.shift = 4,						\
+		.endianness = IIO_BE,					\
 	},								\
 }
 


