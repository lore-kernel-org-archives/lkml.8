Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F874C33CB8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AB32468F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686711;
	bh=0oVE52zL6GJ9e+7w58+ti/f/AmU2UEGHs4+W8Fw55n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YibgHyWSLZ78odFqElm9X+yQpPUj3LFqPFP9Ke2bQuToelNDrIxTAWZvXaF0Hn8uT
	 RkmFg2PKnqODRUlvB1Z8Xi1wNTVjR8d3nmclsfbz+UCB3f/t+apZmg4XTWOKtDprdY
	 zPtkn81Vf30Hofwvf4DybYbSg+xzC5Tr15Ww/GYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbgAVJhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:37:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732274AbgAVJg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:36:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A3924687;
        Wed, 22 Jan 2020 09:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685819;
        bh=0oVE52zL6GJ9e+7w58+ti/f/AmU2UEGHs4+W8Fw55n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaHBeMvyrEkN65/lC4fcZKDZ6UkLcOy8dRTKRumsuCLqqV/XU33K67gDE1zzV2FuQ
         De3v2FpQj/CS/K0zx4Zk9Kba2lYuA9ZRCBj76twTY8n3gbmgiyYFSfspSaVBWAcZ7l
         E3Ul/SSFEnAjEovlqFdRQ2GhxAmcOAkQDBzvjJNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Lars=20M=C3=B6llendorf?= <lars.moellendorf@plating.de>,
        Lars-Peter Clausen <lars@metafoo.de>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.9 56/97] iio: buffer: align the size of scan bytes to size of the largest element
Date:   Wed, 22 Jan 2020 10:29:00 +0100
Message-Id: <20200122092805.443292933@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Möllendorf <lars.moellendorf@plating.de>

commit 883f616530692d81cb70f8a32d85c0d2afc05f69 upstream.

Previous versions of `iio_compute_scan_bytes` only aligned each element
to its own length (i.e. its own natural alignment). Because multiple
consecutive sets of scan elements are buffered this does not work in
case the computed scan bytes do not align with the natural alignment of
the first scan element in the set.

This commit fixes this by aligning the scan bytes to the natural
alignment of the largest scan element in the set.

Fixes: 959d2952d124 ("staging:iio: make iio_sw_buffer_preenable much more general.")
Signed-off-by: Lars Möllendorf <lars.moellendorf@plating.de>
Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/industrialio-buffer.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -546,7 +546,7 @@ static int iio_compute_scan_bytes(struct
 				const unsigned long *mask, bool timestamp)
 {
 	unsigned bytes = 0;
-	int length, i;
+	int length, i, largest = 0;
 
 	/* How much space will the demuxed element take? */
 	for_each_set_bit(i, mask,
@@ -554,13 +554,17 @@ static int iio_compute_scan_bytes(struct
 		length = iio_storage_bytes_for_si(indio_dev, i);
 		bytes = ALIGN(bytes, length);
 		bytes += length;
+		largest = max(largest, length);
 	}
 
 	if (timestamp) {
 		length = iio_storage_bytes_for_timestamp(indio_dev);
 		bytes = ALIGN(bytes, length);
 		bytes += length;
+		largest = max(largest, length);
 	}
+
+	bytes = ALIGN(bytes, largest);
 	return bytes;
 }
 


