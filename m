Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D80BC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C1B20734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260673;
	bh=uS/VHDOeTqAKB0h1mFUTacmcMs+EdrhTXDggYJ5xUOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JqFzVXW+YbxCWPfGM5JSkSeCX8ixh/iru/+yabQ8EfE088m5l7YOVSy0JCkmSviFT
	 xQxwk7+yrp2gQPqCLJSxQjNdLfSs7xTGlg5IvOoA7y6rkZNawfR/nCNNXgoDvdpxXd
	 Pj4m4RfaSCppmoXK+uTGTCeFr+13xf+oehMXBHvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbgGTP5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731692AbgGTP5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:57:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E072720734;
        Mon, 20 Jul 2020 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260666;
        bh=uS/VHDOeTqAKB0h1mFUTacmcMs+EdrhTXDggYJ5xUOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BP4+aHGXkF685ZeXqoK73QOr6CMOuFofKh2Qn+MbpAAzjl9PBpKlGeQIPhGUU0xHU
         lEVHFJVVopHhKWIP2fdFtNAJWn/rvBA86jfgrZPNOK36k98mP16dXFmMCZY+CgFLLW
         YrarMZlZ+MRttl7IxWMxTctVoSLYaXIA3gRfDi8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.4 050/215] iio: mma8452: Add missed iio_device_unregister() call in mma8452_probe()
Date:   Mon, 20 Jul 2020 17:35:32 +0200
Message-Id: <20200720152822.582269390@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

commit d7369ae1f4d7cffa7574d15e1f787dcca184c49d upstream.

The function iio_device_register() was called in mma8452_probe().
But the function iio_device_unregister() was not called after
a call of the function mma8452_set_freefall_mode() failed.
Thus add the missed function call for one error case.

Fixes: 1a965d405fc6 ("drivers:iio:accel:mma8452: added cleanup provision in case of failure.")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/mma8452.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1685,10 +1685,13 @@ static int mma8452_probe(struct i2c_clie
 
 	ret = mma8452_set_freefall_mode(data, false);
 	if (ret < 0)
-		goto buffer_cleanup;
+		goto unregister_device;
 
 	return 0;
 
+unregister_device:
+	iio_device_unregister(indio_dev);
+
 buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 


