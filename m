Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC21C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534F32468B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685988;
	bh=30Llptjkv81UuTF2qcVnmpm5qLWYNlDC5akjxsg2eEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g+2Pe/X3Wp5EQ1WvATkREAYuUt/OMEXFIhBBBGcNcc4Cz+c8eIKH6J9vVLJWlGhob
	 2xpTdofewUHjjS9Ge6vCjID7Ufp1ESrZ9AFDP/I8Tl+NDMEpZG7d9wocXUkfnaXfYE
	 vwc6dpLs/x5yOJH5X7RrhOjyVtwi1QVQfjC7Ezsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbgAVJjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:39:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733041AbgAVJjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:39:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A38424686;
        Wed, 22 Jan 2020 09:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685982;
        bh=30Llptjkv81UuTF2qcVnmpm5qLWYNlDC5akjxsg2eEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdCwojRhVJbXC3DYOyb/BN4MYIhV6XrQFR52LkCkw8nIzHfxs5aGvfeHG1VXiXmpf
         JmrT6D7QFO6rS9uXyg5jxfd8RtWaohFVR6ktFbPZ5Lph7lhPUDCYufj/O3LoGXtCmg
         3TaHfrfcJF0oKq4IMWK2Gnu879R4+l+lhMZtVzds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 60/65] scsi: target: core: Fix a pr_debug() argument
Date:   Wed, 22 Jan 2020 10:29:45 +0100
Message-Id: <20200122092800.439427579@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit c941e0d172605731de9b4628bd4146d35cf2e7d6 upstream.

Print the string for which conversion failed instead of printing the
function name twice.

Fixes: 2650d71e244f ("target: move transport ID handling to the core")
Cc: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20191107215525.64415-1-bvanassche@acm.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/target_core_fabric_lib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/target/target_core_fabric_lib.c
+++ b/drivers/target/target_core_fabric_lib.c
@@ -131,7 +131,7 @@ static int srp_get_pr_transport_id(
 	memset(buf + 8, 0, leading_zero_bytes);
 	rc = hex2bin(buf + 8 + leading_zero_bytes, p, count);
 	if (rc < 0) {
-		pr_debug("hex2bin failed for %s: %d\n", __func__, rc);
+		pr_debug("hex2bin failed for %s: %d\n", p, rc);
 		return rc;
 	}
 


