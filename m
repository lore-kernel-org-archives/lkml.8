Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8C5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759812071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699644;
	bh=FjVa/TtanWhsbNi+fN2ck1+11LWGxXUxjOdAbshIHZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cQRKB5WKKvnGQvs830bp93smxuhofmCCTVWgZxqmLmOYigS3BSXpcrnCXEwxpZnrU
	 q6Lvv+acGZY/bt2CZrcW/rncdoRkWeZgyoWn0xr4Z/Qe8wTCBPXtyiJd79UZ9iulOo
	 HzjMu/BCb5DRKd364WS9q76qWFfRtUSarsD+piRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgAVN1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:27:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbgAVN1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:27:17 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E682324690;
        Wed, 22 Jan 2020 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699636;
        bh=FjVa/TtanWhsbNi+fN2ck1+11LWGxXUxjOdAbshIHZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zYrUfLeEUx7N/GYJq9y40Zb/ktPMbKyUsbbY5NcY09QRYBk+xrGjWs06vb7xkitMK
         IY2JxD8z4Nt1XZWbZfmrQqafsS9OP8HizHXjRdG7/1Y0x6R+CKq8LWVAxeswZGx5eL
         ENnOHsnMfH7HZbvtwbWETowafeJJV0SMcJXmHM+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 204/222] scsi: target: core: Fix a pr_debug() argument
Date:   Wed, 22 Jan 2020 10:29:50 +0100
Message-Id: <20200122092848.308412177@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
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
@@ -118,7 +118,7 @@ static int srp_get_pr_transport_id(
 	memset(buf + 8, 0, leading_zero_bytes);
 	rc = hex2bin(buf + 8 + leading_zero_bytes, p, count);
 	if (rc < 0) {
-		pr_debug("hex2bin failed for %s: %d\n", __func__, rc);
+		pr_debug("hex2bin failed for %s: %d\n", p, rc);
 		return rc;
 	}
 


