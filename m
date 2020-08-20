Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD9BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32BB22C9F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597929293;
	bh=NbPxg4DrX+Argbm0UYsS0qF0BtnrJt/e0QaDiJK0czo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ovkouxnz8xSuIiim0UE0zztZiwCi7v0Aewww2ApK98/exyPj9EWvbn5Ef3fVQOWH/
	 BogOGvHVtmMHRg2XVj2XLCy3/w42qzgLKiw06LQWfNlwbU1E7YQEcSVqAOS2s447mk
	 sJfFt5ax5HUb3ixLSLSJ/mPjn3rjM8DvXuvsVLMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgHTNOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbgHTJgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:36:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7BD12075E;
        Thu, 20 Aug 2020 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916181;
        bh=NbPxg4DrX+Argbm0UYsS0qF0BtnrJt/e0QaDiJK0czo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJrC9bh7PBhixIsynD8wJN9whEf0eLSHtty4hLiObHMTa2VLv1My7nxXlEFslTnLg
         yhnc+AzPlKv3RBCXAIVugNORuA7x3GOkfiLqufMSkupbfx4bgOYssx7l0j6dMjEV+q
         a4V76rtjic18N7ccFHVwFP6jkxlHj8CNn1eDaMKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Stanhope <charles.stanhope@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.7 039/204] iio: dac: ad5592r: fix unbalanced mutex unlocks in ad5592r_read_raw()
Date:   Thu, 20 Aug 2020 11:18:56 +0200
Message-Id: <20200820091608.224733269@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
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
@@ -415,7 +415,7 @@ static int ad5592r_read_raw(struct iio_d
 			s64 tmp = *val * (3767897513LL / 25LL);
 			*val = div_s64_rem(tmp, 1000000000LL, val2);
 
-			ret = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_VAL_INT_PLUS_MICRO;
 		} else {
 			int mult;
 
@@ -446,7 +446,7 @@ static int ad5592r_read_raw(struct iio_d
 		ret =  IIO_VAL_INT;
 		break;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
 
 unlock:


