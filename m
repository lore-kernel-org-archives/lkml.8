Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F295C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C8320675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608135;
	bh=IzQ6xyG7OVKJTpEyVdt5ZW6WXPzpifb6DD9cEoFHN8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hkhHxrkVX1iyCvZhM1DntqJXdz2sEmQs+0Psb/tRW6dIoygqlxdfnQ81qQOzi4wy1
	 ptkrlZbtOtGH9eFvW67v6V2xdPRMki5uHKbYgYURvwHS0xQEX4W97e/4i6FuQnAstT
	 96umfZ5KsZYxA22ZdOtAxbsnYZpb0cr+h5f3iWBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgBMPbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:31:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729545AbgBMP2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:04 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25A0C218AC;
        Thu, 13 Feb 2020 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607684;
        bh=IzQ6xyG7OVKJTpEyVdt5ZW6WXPzpifb6DD9cEoFHN8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nsuev0SURuq5ouMWOLcCTD7/RVA8h7XLFpAZY8wzSXr/nqN5m3KmwKFaQp/ZRJ5iA
         xiLAR3djwDmU8u5h5Nm3wTWntJes3CZ8eJawdWbxuWmV3Cp02sUDpEn06NNMFqIUGq
         mZV2zrmUcmeT4lgrbR1yFop4YBMf0rm3CzstMhhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Guralnik <michaelgur@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.5 008/120] RDMA/uverbs: Verify MR access flags
Date:   Thu, 13 Feb 2020 07:20:04 -0800
Message-Id: <20200213151904.370359735@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

commit ca95c1411198c2d87217c19d44571052cdc94725 upstream.

Verify that MR access flags that are passed from user are all supported
ones, otherwise an error is returned.

Fixes: 4fca03778351 ("IB/uverbs: Move ib_access_flags and ib_read_counters_flags to uapi")
Link: https://lore.kernel.org/r/1578506740-22188-6-git-send-email-yishaih@mellanox.com
Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/rdma/ib_verbs.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4300,6 +4300,9 @@ static inline int ib_check_mr_access(int
 	    !(flags & IB_ACCESS_LOCAL_WRITE))
 		return -EINVAL;
 
+	if (flags & ~IB_ACCESS_SUPPORTED)
+		return -EINVAL;
+
 	return 0;
 }
 


