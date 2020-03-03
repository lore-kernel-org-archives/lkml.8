Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66205C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFF6208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258870;
	bh=9kFRiKQMxCYsH+san8ZR4DvZjUuoV5evHH59jKA2ls4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VJb4Vf3PHxE2lwGUHBS7MXVOQ+H0GE3d+wQRBBAWMzEMzObTvhMLsP5FX4wfYJFnX
	 XroMTBu0g3dXi1/w0RsbZvoMNimoZjEmTPM/XM5tUxqFcLE8RhCY+PBUXYrBCu7eU/
	 YZy6kh8qUKeiIfC3CF5plZHs+ppwKNJRQlF8m1Mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbgCCSHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:07:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732319AbgCCRyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:54:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA42F206D5;
        Tue,  3 Mar 2020 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258062;
        bh=9kFRiKQMxCYsH+san8ZR4DvZjUuoV5evHH59jKA2ls4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXDqe7PNWOg08kjxZ8MiwSi8yIidDw2wJKXXUUfnoaswmjPS1yolt/W7Nm62q3xuj
         S/jfE4tj8qbiQ3bC0Nq0nuADNBA4310OZkSCVRaohygfr4LHgHgHne7hV2nmtP9IC4
         Qu5MZGnUz6Pd9ySzyzme3x4DX0s6BwKO/Ui7LTGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rohit Maheshwari <rohitm@chelsio.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 009/152] net/tls: Fix to avoid gettig invalid tls record
Date:   Tue,  3 Mar 2020 18:41:47 +0100
Message-Id: <20200303174303.574514775@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rohit Maheshwari <rohitm@chelsio.com>

[ Upstream commit 06f5201c6392f998a49ca9c9173e2930c8eb51d8 ]

Current code doesn't check if tcp sequence number is starting from (/after)
1st record's start sequnce number. It only checks if seq number is before
1st record's end sequnce number. This problem will always be a possibility
in re-transmit case. If a record which belongs to a requested seq number is
already deleted, tls_get_record will start looking into list and as per the
check it will look if seq number is before the end seq of 1st record, which
will always be true and will return 1st record always, it should in fact
return NULL.
As part of the fix, start looking each record only if the sequence number
lies in the list else return NULL.
There is one more check added, driver look for the start marker record to
handle tcp packets which are before the tls offload start sequence number,
hence return 1st record if the record is tls start marker and seq number is
before the 1st record's starting sequence number.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Rohit Maheshwari <rohitm@chelsio.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_device.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -581,7 +581,7 @@ struct tls_record_info *tls_get_record(s
 				       u32 seq, u64 *p_record_sn)
 {
 	u64 record_sn = context->hint_record_sn;
-	struct tls_record_info *info;
+	struct tls_record_info *info, *last;
 
 	info = context->retransmit_hint;
 	if (!info ||
@@ -593,6 +593,24 @@ struct tls_record_info *tls_get_record(s
 						struct tls_record_info, list);
 		if (!info)
 			return NULL;
+		/* send the start_marker record if seq number is before the
+		 * tls offload start marker sequence number. This record is
+		 * required to handle TCP packets which are before TLS offload
+		 * started.
+		 *  And if it's not start marker, look if this seq number
+		 * belongs to the list.
+		 */
+		if (likely(!tls_record_is_start_marker(info))) {
+			/* we have the first record, get the last record to see
+			 * if this seq number belongs to the list.
+			 */
+			last = list_last_entry(&context->records_list,
+					       struct tls_record_info, list);
+
+			if (!between(seq, tls_record_start_seq(info),
+				     last->end_seq))
+				return NULL;
+		}
 		record_sn = context->unacked_record_sn;
 	}
 


