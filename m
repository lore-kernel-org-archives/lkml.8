Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C74AC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1987B206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048965;
	bh=6H1V2cPpME8yyZYSE40VWtVW+9eZQ/zpTdh4A8UwM1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=USZnIkCExcIkgDzRq13ykWukUsDth6ICsMJHhkulXh3NfPEWP7I4IMmU8uOXLzxZe
	 jae5U30zF7E6m2WdnSx8l+A/WkKN/MuEm7pSLTOPcCVtLA4GK+K4DyV8jJCiixADlA
	 f4Hrvp0BhWUhZNr8wZ2Yv/e4oF29OctgmStitsh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393475AbgDPO4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732194AbgDPN4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:56:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCE021744;
        Thu, 16 Apr 2020 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045371;
        bh=6H1V2cPpME8yyZYSE40VWtVW+9eZQ/zpTdh4A8UwM1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ok2aOYLDxSXC6817eYX2XWyJLV56O95iScu/a3nLK7WtpIIBJz3QGnC8wcmnowfQQ
         PUx+uQAOR4TAdqowusZ0LOQczv50L0721YnffxYyjmorBQyOBQx+sn/WHV4XwzAnKc
         J6cY2BRNRz4pdxn/fHfauwgq68K3DJBIMXBuMoXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 5.6 108/254] tpm: tpm2_bios_measurements_next should increase position index
Date:   Thu, 16 Apr 2020 15:23:17 +0200
Message-Id: <20200416131339.630609080@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

commit f9bf8adb55cd5a357b247a16aafddf8c97b276e0 upstream.

If .next function does not change position index,
following .show function will repeat output related
to current position index.

For /sys/kernel/security/tpm0/binary_bios_measurements:
1) read after lseek beyound end of file generates whole last line.
2) read after lseek to middle of last line generates
expected end of last line and unexpected whole last line once again.

Cc: stable@vger.kernel.org # 4.19.x
Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/eventlog/tpm2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -94,6 +94,7 @@ static void *tpm2_bios_measurements_next
 	size_t event_size;
 	void *marker;
 
+	(*pos)++;
 	event_header = log->bios_event_log;
 
 	if (v == SEQ_START_TOKEN) {
@@ -118,7 +119,6 @@ static void *tpm2_bios_measurements_next
 	if (((v + event_size) >= limit) || (event_size == 0))
 		return NULL;
 
-	(*pos)++;
 	return v;
 }
 


