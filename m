Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43319C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A6F2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916204;
	bh=vYJNt8qJJXdiZcQitykIAGvJKVyQZqZYeSoHi0kVUEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gnalkHd9cQPYKJ3ceKkY03zfF9gg0/ma62M05LT6EG6Qll0sdAUjHLy+IF9tsawOK
	 /3kpBv5tM5rWBa3C9EOv7OuC7hBEBx0r6qKKMZbvQlgZq8gHqeC7XU9Lqi2tabxno2
	 3szraxRgi45dwwJAXNKfvuZYOLuOyRKhV2w7/DbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgHTJgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbgHTJgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:36:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94B30208E4;
        Thu, 20 Aug 2020 09:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916184;
        bh=vYJNt8qJJXdiZcQitykIAGvJKVyQZqZYeSoHi0kVUEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9gv7GB8CuF0qbm/t0ycqxKSXT4nSLI5/qPVSZBmHsjFGmRXjrZyg6KUhkeRYUtXZ
         BgWvK7/0GRdD3JDflAPaPH7993ZI/decTmmHCs6d9f0kKg7cByTxnfsFFRS5OmSGJX
         MYZ7dpG+4G2xpy2yeU2dpss8J97xxetlAyIdsLo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.7 040/204] iio: imu: st_lsm6dsx: reset hw ts after resume
Date:   Thu, 20 Aug 2020 11:18:57 +0200
Message-Id: <20200820091608.274773836@linuxfoundation.org>
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

From: Lorenzo Bianconi <lorenzo@kernel.org>

commit a1bab9396c2d98c601ce81c27567159dfbc10c19 upstream.

Reset hw time samples generator after system resume in order to avoid
disalignment between system and device time reference since FIFO
batching and time samples generator are disabled during suspend.

Fixes: 213451076bd3 ("iio: imu: st_lsm6dsx: add hw timestamp support")
Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |    3 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |   23 +++++++++++++++--------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   |    2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -436,8 +436,7 @@ int st_lsm6dsx_update_watermark(struct s
 				u16 watermark);
 int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable);
 int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
-int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
-			     enum st_lsm6dsx_fifo_mode fifo_mode);
+int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val);
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -184,8 +184,8 @@ static int st_lsm6dsx_update_decimators(
 	return err;
 }
 
-int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
-			     enum st_lsm6dsx_fifo_mode fifo_mode)
+static int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
+				    enum st_lsm6dsx_fifo_mode fifo_mode)
 {
 	unsigned int data;
 
@@ -302,6 +302,18 @@ static int st_lsm6dsx_reset_hw_ts(struct
 	return 0;
 }
 
+int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw)
+{
+	int err;
+
+	/* reset hw ts counter */
+	err = st_lsm6dsx_reset_hw_ts(hw);
+	if (err < 0)
+		return err;
+
+	return st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
+}
+
 /*
  * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN/ST_LSM6DSX_MAX_TAGGED_WORD_LEN
  * in order to avoid a kmalloc for each bus access
@@ -675,12 +687,7 @@ int st_lsm6dsx_update_fifo(struct st_lsm
 		goto out;
 
 	if (fifo_mask) {
-		/* reset hw ts counter */
-		err = st_lsm6dsx_reset_hw_ts(hw);
-		if (err < 0)
-			goto out;
-
-		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
+		err = st_lsm6dsx_resume_fifo(hw);
 		if (err < 0)
 			goto out;
 	}
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2451,7 +2451,7 @@ static int __maybe_unused st_lsm6dsx_res
 	}
 
 	if (hw->fifo_mask)
-		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
+		err = st_lsm6dsx_resume_fifo(hw);
 
 	return err;
 }


