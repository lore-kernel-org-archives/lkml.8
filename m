Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC97C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95FBF2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262241;
	bh=Np+j03ykyif20VWP1W2T8FI6kv/Xhb/bRgfjC8cnNxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1DokDhOirYMNK9kENMTcu9Pu+O6JrRY49uEmM13FzJUohHn4Lt+hlhXo7hNn+1MX2
	 V/dwNeT7HJFxywESxQwnnEDeiJFzeEb+JvrE6HxsSIIKMtvAQFfJ87e8VBhK6mPbFi
	 xmUDIAJavDgPKZOxN7lpI3aek0Le5+CovLtcCvrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbgGTQE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732831AbgGTQER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:04:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD292176B;
        Mon, 20 Jul 2020 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261057;
        bh=Np+j03ykyif20VWP1W2T8FI6kv/Xhb/bRgfjC8cnNxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AEzziJXP9TlaT6zLe/1f5VVVqH7qpHmR7D260zTxEZxUXM+5VgfTXVDex0n4N6ZJX
         HJGfzd43j56Mly4vnz0/JlCEtgu1IC7fzvjWPr5J1t7dM/y3CcOyJz+JR2JIr65kjY
         MRuyzLZaSyHt/8rv/+GOduIcihr1bjRKYXNAKtHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH 5.4 192/215] intel_th: Fix a NULL dereference when hub driver is not loaded
Date:   Mon, 20 Jul 2020 17:37:54 +0200
Message-Id: <20200720152829.323060306@linuxfoundation.org>
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

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit e78e1fdb282726beaf88aa75943682217e6ded0e upstream.

Connecting master to an output port when GTH driver module is not loaded
triggers a NULL dereference:

> RIP: 0010:intel_th_set_output+0x35/0x70 [intel_th]
> Call Trace:
>  ? sth_stm_link+0x12/0x20 [intel_th_sth]
>  stm_source_link_store+0x164/0x270 [stm_core]
>  dev_attr_store+0x17/0x30
>  sysfs_kf_write+0x3e/0x50
>  kernfs_fop_write+0xda/0x1b0
>  __vfs_write+0x1b/0x40
>  vfs_write+0xb9/0x1a0
>  ksys_write+0x67/0xe0
>  __x64_sys_write+0x1a/0x20
>  do_syscall_64+0x57/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Make sure the module in question is loaded and return an error if not.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 39f4034693b7c ("intel_th: Add driver infrastructure for Intel(R) Trace Hub devices")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: Ammy Yi <ammy.yi@intel.com>
Tested-by: Ammy Yi <ammy.yi@intel.com>
Cc: stable@vger.kernel.org # v4.4
Link: https://lore.kernel.org/r/20200706161339.55468-5-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/core.c |   21 ++++++++++++++++++---
 drivers/hwtracing/intel_th/sth.c  |    4 +---
 2 files changed, 19 insertions(+), 6 deletions(-)

--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -1021,15 +1021,30 @@ int intel_th_set_output(struct intel_th_
 {
 	struct intel_th_device *hub = to_intel_th_hub(thdev);
 	struct intel_th_driver *hubdrv = to_intel_th_driver(hub->dev.driver);
+	int ret;
 
 	/* In host mode, this is up to the external debugger, do nothing. */
 	if (hub->host_mode)
 		return 0;
 
-	if (!hubdrv->set_output)
-		return -ENOTSUPP;
+	/*
+	 * hub is instantiated together with the source device that
+	 * calls here, so guaranteed to be present.
+	 */
+	hubdrv = to_intel_th_driver(hub->dev.driver);
+	if (!hubdrv || !try_module_get(hubdrv->driver.owner))
+		return -EINVAL;
 
-	return hubdrv->set_output(hub, master);
+	if (!hubdrv->set_output) {
+		ret = -ENOTSUPP;
+		goto out;
+	}
+
+	ret = hubdrv->set_output(hub, master);
+
+out:
+	module_put(hubdrv->driver.owner);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(intel_th_set_output);
 
--- a/drivers/hwtracing/intel_th/sth.c
+++ b/drivers/hwtracing/intel_th/sth.c
@@ -161,9 +161,7 @@ static int sth_stm_link(struct stm_data
 {
 	struct sth_device *sth = container_of(stm_data, struct sth_device, stm);
 
-	intel_th_set_output(to_intel_th_device(sth->dev), master);
-
-	return 0;
+	return intel_th_set_output(to_intel_th_device(sth->dev), master);
 }
 
 static int intel_th_sw_init(struct sth_device *sth)


