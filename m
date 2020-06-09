Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC942C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9B420734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725402;
	bh=tJ7i3gI0/ijEe7QVglU/MZNhpV1Jc+al4aF2FGTCKJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pl8nv8Lnoi9z8kP0FaHrpxkHS/Jb2N4vXLBCE/WIccghtnA+DLf+PQ5OMiFdsvvaR
	 k5pqexyeqvLufyj4br3rREHnZs4ZKZFiYOBXNhn/MP1qWwel8uJPvBcIi3InmSCkp5
	 gdkrlMKk9Dd+ycNlX5yWtLzGE0kyfiDfwQryK8G0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgFIR4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733214AbgFIRzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:55:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEC70206D5;
        Tue,  9 Jun 2020 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725316;
        bh=tJ7i3gI0/ijEe7QVglU/MZNhpV1Jc+al4aF2FGTCKJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6yg4MSKdkVkVyqg67IAuUJ60fs09iEbb//H8cEWYazXuLDAB1aTqR3uaXAstPMVF
         lp0stQUBJkMZGypspxBp5H4tQaqXdT4VM5H3lfL8hcWV07sVC1TfY8zNzsMOTGpB9Z
         D0vPTs1rmFtduFJQiDvrMVQFRsmH+R/CyiFNCg7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stable@vger.kernel.org,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 5.7 08/24] iio:chemical:pms7003: Fix timestamp alignment and prevent data leak.
Date:   Tue,  9 Jun 2020 19:45:39 +0200
Message-Id: <20200609174149.993708614@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174149.255223112@linuxfoundation.org>
References: <20200609174149.255223112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

commit 13e945631c2ffb946c0af342812a3cd39227de6e upstream.

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses an array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak appart from previous readings.

Fixes: a1d642266c14 ("iio: chemical: add support for Plantower PMS7003 sensor")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <Stable@vger.kernel.org>
Acked-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/chemical/pms7003.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -73,6 +73,11 @@ struct pms7003_state {
 	struct pms7003_frame frame;
 	struct completion frame_ready;
 	struct mutex lock; /* must be held whenever state gets touched */
+	/* Used to construct scan to push to the IIO buffer */
+	struct {
+		u16 data[3]; /* PM1, PM2P5, PM10 */
+		s64 ts;
+	} scan;
 };
 
 static int pms7003_do_cmd(struct pms7003_state *state, enum pms7003_cmd cmd)
@@ -104,7 +109,6 @@ static irqreturn_t pms7003_trigger_handl
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct pms7003_state *state = iio_priv(indio_dev);
 	struct pms7003_frame *frame = &state->frame;
-	u16 data[3 + 1 + 4]; /* PM1, PM2P5, PM10, padding, timestamp */
 	int ret;
 
 	mutex_lock(&state->lock);
@@ -114,12 +118,15 @@ static irqreturn_t pms7003_trigger_handl
 		goto err;
 	}
 
-	data[PM1] = pms7003_get_pm(frame->data + PMS7003_PM1_OFFSET);
-	data[PM2P5] = pms7003_get_pm(frame->data + PMS7003_PM2P5_OFFSET);
-	data[PM10] = pms7003_get_pm(frame->data + PMS7003_PM10_OFFSET);
+	state->scan.data[PM1] =
+		pms7003_get_pm(frame->data + PMS7003_PM1_OFFSET);
+	state->scan.data[PM2P5] =
+		pms7003_get_pm(frame->data + PMS7003_PM2P5_OFFSET);
+	state->scan.data[PM10] =
+		pms7003_get_pm(frame->data + PMS7003_PM10_OFFSET);
 	mutex_unlock(&state->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &state->scan,
 					   iio_get_time_ns(indio_dev));
 err:
 	iio_trigger_notify_done(indio_dev->trig);


