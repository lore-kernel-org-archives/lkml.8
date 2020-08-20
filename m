Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D335AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4D920738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931844;
	bh=Ee5Xl4plfpnoG2TwGxHJePFJ8XV8d4vHdO5DuBTacYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z5rh2JzriF4WY14hy2dsjRK714HRAalsNA51Hd5tvdP9XGlE6Mk26vzZNUjGjYIom
	 DI5KdqRranhz06k1v4stL9etPt5N+HsGmlcKysTfntXx05TZs481K/y0TGl1GWH0I+
	 ZcWOG1FVfpthIlWrMEMUETX1bSy9DdV5GEb9/vlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgHTN5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgHTJZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:25:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D1C222D00;
        Thu, 20 Aug 2020 09:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915525;
        bh=Ee5Xl4plfpnoG2TwGxHJePFJ8XV8d4vHdO5DuBTacYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzElbNTPo4zP/LrxWmFOp1KToLrLShjgNuS1dwBA8Msv60Kn54waW8VPvEMGjTi7B
         S4gYum3D9XZYjEHoCOu5SQSs9RssYBjnlh021P70gDb+NmKwyLu4C0AAPcAl/X69ib
         WP2eSc16ahf1UycqSDxmKid8rNa1405Bjn7461Kg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Stanhope <charles.stanhope@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.8 045/232] iio: dac: ad5592r: fix unbalanced mutex unlocks in ad5592r_read_raw()
Date:   Thu, 20 Aug 2020 11:18:16 +0200
Message-Id: <20200820091614.962747060@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

commit 65afb0932a81c1de719ceee0db0b276094b10ac8 upstream.

There are 2 exit paths where the lock isn't held, but try to unlock the
mutex when exiting. In these places we should just return from the
function.

A neater approach would be to cleanup the ad5592r_read_raw(), but that
would make this patch more difficult to backport to stable versions.

Fixes 56ca9db862bf3: ("iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs")
Reported-by: Charles Stanhope <charles.stanhope@gmail.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/dac/ad5592r-base.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -413,7 +413,7 @@ static int ad5592r_read_raw(struct iio_d
 			s64 tmp = *val * (3767897513LL / 25LL);
 			*val = div_s64_rem(tmp, 1000000000LL, val2);
 
-			ret = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_VAL_INT_PLUS_MICRO;
 		} else {
 			int mult;
 
@@ -444,7 +444,7 @@ static int ad5592r_read_raw(struct iio_d
 		ret =  IIO_VAL_INT;
 		break;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
 
 unlock:


