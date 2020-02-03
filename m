Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57013C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CA22051A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747195;
	bh=biqmE0tUJGFWbbL8Rgzt39uwI0/WVF4cK/SxguVyDuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DbW5o66FuuwRVwxGFOxos0XiujvgPxuPEmuL9v0rb+gKoYx92/l5vWlj8p3oE0HhJ
	 VBxMlR/hA7OKG3Uf4spIps8JUISwoCI+eqG7aqUNhSlQXbM5M25iMgt3dHns+L/6ga
	 BXr8409Okln4B26apChStwbiKECfEeOMk0dwb1zU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgBCQ0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:26:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbgBCQ03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:26:29 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 332732051A;
        Mon,  3 Feb 2020 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747188;
        bh=biqmE0tUJGFWbbL8Rgzt39uwI0/WVF4cK/SxguVyDuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcO6DU3I+Mlk4HbveBQBA/MjUZHgedr03Ka83zZmmJsG/iZdc/p5UuG7/ezfpHDYC
         xOcL2ECh1h1cYEENNcZgI9dWesSm+I6zcqYf3Yh3c9u9LdseVnO2VPr9Paw6MrZjgR
         EmGdkoq0wuAg9RcJnjCPBTwVkgnaKYG4NqD/PCAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Shvetsov <andrey.shvetsov@k2l.de>
Subject: [PATCH 4.9 07/68] staging: most: net: fix buffer overflow
Date:   Mon,  3 Feb 2020 16:19:03 +0000
Message-Id: <20200203161906.087442296@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161904.705434837@linuxfoundation.org>
References: <20200203161904.705434837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Shvetsov <andrey.shvetsov@k2l.de>

commit 4d1356ac12f4d5180d0df345d85ff0ee42b89c72 upstream.

If the length of the socket buffer is 0xFFFFFFFF (max size for an
unsigned int), then payload_len becomes 0xFFFFFFF1 after subtracting 14
(ETH_HLEN).  Then, mdp_len is set to payload_len + 16 (MDP_HDR_LEN)
which overflows and results in a value of 2.  These values for
payload_len and mdp_len will pass current buffer size checks.

This patch checks if derived from skb->len sum may overflow.

The check is based on the following idea:

For any `unsigned V1, V2` and derived `unsigned SUM = V1 + V2`,
`V1 + V2` overflows iif `SUM < V1`.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrey Shvetsov <andrey.shvetsov@k2l.de>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200116172238.6046-1-andrey.shvetsov@microchip.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/most/aim-network/networking.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/staging/most/aim-network/networking.c
+++ b/drivers/staging/most/aim-network/networking.c
@@ -87,6 +87,11 @@ static int skb_to_mamac(const struct sk_
 	unsigned int payload_len = skb->len - ETH_HLEN;
 	unsigned int mdp_len = payload_len + MDP_HDR_LEN;
 
+	if (mdp_len < skb->len) {
+		pr_err("drop: too large packet! (%u)\n", skb->len);
+		return -EINVAL;
+	}
+
 	if (mbo->buffer_length < mdp_len) {
 		pr_err("drop: too small buffer! (%d for %d)\n",
 		       mbo->buffer_length, mdp_len);
@@ -134,6 +139,11 @@ static int skb_to_mep(const struct sk_bu
 	u8 *buff = mbo->virt_address;
 	unsigned int mep_len = skb->len + MEP_HDR_LEN;
 
+	if (mep_len < skb->len) {
+		pr_err("drop: too large packet! (%u)\n", skb->len);
+		return -EINVAL;
+	}
+
 	if (mbo->buffer_length < mep_len) {
 		pr_err("drop: too small buffer! (%d for %d)\n",
 		       mbo->buffer_length, mep_len);


