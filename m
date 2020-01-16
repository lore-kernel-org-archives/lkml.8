Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11921C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D021F2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216870;
	bh=bXFsXErmTU0RHFsTUtN1BFeKG8t2TfnNs2yzB+0lUyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FwSPsuGBPn9JfNIdKrq8F8ylIxDPtpvMAMgGJyJkKMz8kq8V6gMsx+nO71MOWSeEa
	 4TD6DiOEQFEwBBJZJycWfG118XMU9oZ+3KXog9AtN1TkgpW4rMZ9UbDrDHTtoLAHGS
	 mFvD6QgzGEO+Ui5uJc/nYIspyMQDZzt25hrC6Ek4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbgAPXVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:21:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390767AbgAPXVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:21:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05072072B;
        Thu, 16 Jan 2020 23:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216865;
        bh=bXFsXErmTU0RHFsTUtN1BFeKG8t2TfnNs2yzB+0lUyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALysjcPG5wiI3OvXD+pM+tIvwqf0b7qjetRDXKurEKgrQMRPsQeZhqYD2G57fbxFm
         4409fFpRndo9XudgZ1uify7Wsp17sEfZVKgWG/dM2vvKKHZRgea7bB8SOt6UPDIInS
         LVnTmFNqa9etcwB2hTJ0uQ0D0oRxsv7FcLcsorvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 035/203] s390/qeth: Fix vnicc_is_in_use if rx_bcast not set
Date:   Fri, 17 Jan 2020 00:15:52 +0100
Message-Id: <20200116231747.227808508@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandra Winter <wintera@linux.ibm.com>

commit e8a66d800471e2df7f0b484e2e46898b21d1fa82 upstream.

Symptom: After vnicc/rx_bcast has been manually set to 0,
	bridge_* sysfs parameters can still be set or written.
Only occurs on HiperSockets, as OSA doesn't support changing rx_bcast.

Vnic characteristics and bridgeport settings are mutually exclusive.
rx_bcast defaults to 1, so manually setting it to 0 should disable
bridge_* parameters.

Instead it makes sense here to check the supported mask. If the card
does not support vnicc at all, bridge commands are always allowed.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/net/qeth_l2_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1983,8 +1983,7 @@ int qeth_l2_vnicc_get_timeout(struct qet
 /* check if VNICC is currently enabled */
 bool qeth_l2_vnicc_is_in_use(struct qeth_card *card)
 {
-	/* if everything is turned off, VNICC is not active */
-	if (!card->options.vnicc.cur_chars)
+	if (!card->options.vnicc.sup_chars)
 		return false;
 	/* default values are only OK if rx_bcast was not enabled by user
 	 * or the card is offline.


