Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C8BC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60658214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860328;
	bh=BWXwgTC96yH7/4lNOVVuyOOwuCEhDNyxq4OtgQUKj9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IvqJ4V254/jyd0Zhvym8W5cQgdCl7QrvUivGY5wB03rNwgEhHSWn15l87QnW4uAkp
	 VVczmhI5Ut7zNnjeYOxfvMCffstjM3J202ALCBDYVEVIjOsjLxqlQLYZ1gnfKbFCF5
	 hnXBZTBWkX0lCsM7T+mJK0QUAweTLdincGwYhOqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbgAXKF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388957AbgAXKF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:05:26 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4EAA214DB;
        Fri, 24 Jan 2020 10:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860325;
        bh=BWXwgTC96yH7/4lNOVVuyOOwuCEhDNyxq4OtgQUKj9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5ed7i/89Fp/8zrnB84hlr5J/4NqvsvuvGfKUBoQbSnkT922TAX9gDeST7nyLt8A5
         jJlwxGKHu14M071Br3YSOplzEBZDCkX1NdgLO3XG/CF4+vuuNMpkIHUVPlyAxbtU6a
         9D5xKC8vtnrv3CRyuM8JZv/rJkUG9T+A6vp8HgwI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 291/343] iio: dac: ad5380: fix incorrect assignment to val
Date:   Fri, 24 Jan 2020 10:31:49 +0100
Message-Id: <20200124092958.283297701@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit b1e18768ef1214c0a8048327918a182cabe09f9d ]

Currently the pointer val is being incorrectly incremented
instead of the value pointed to by val. Fix this by adding
in the missing * indirection operator.

Addresses-Coverity: ("Unused value")
Fixes: c03f2c536818 ("staging:iio:dac: Add AD5380 driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/ad5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 97d2c5111f438..8bf7fc626a9d4 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -221,7 +221,7 @@ static int ad5380_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		*val >>= chan->scan_type.shift;
-		val -= (1 << chan->scan_type.realbits) / 2;
+		*val -= (1 << chan->scan_type.realbits) / 2;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 2 * st->vref;
-- 
2.20.1



