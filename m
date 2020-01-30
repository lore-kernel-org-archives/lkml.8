Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D08C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7661C205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409845;
	bh=3OppFeTIC5EGVmWme2JxnhZ9O/cxokC45JreOYg3EiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0s9GM7f8ZRgR5qjk9KY72vytymDn3gZw54SZm77b7bbQ0aYQjjKm459fjhfGNqeOH
	 nqUhWPYngDnvO34E+HI3vj/G+liUNcCAPRO+PBzB7lrgCpcDGGBo2Qgs8nwCeM3/48
	 UqdrynADTfdVySZiD+UqYG6MvG1natS8ZxTAzKnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgA3SoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:44:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730738AbgA3SoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:44:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C36205F4;
        Thu, 30 Jan 2020 18:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409839;
        bh=3OppFeTIC5EGVmWme2JxnhZ9O/cxokC45JreOYg3EiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MsF4os16gtROmUytj2LWCfD3Jv6oshYTamnDljeLJNtl9OhTkbxeqPboiBdnzmEsY
         Zl1Q69MENs4cw/Df4Crm24WH+8dqabPNwS3yq+2P6HhWs4a52+kR22ce4YKylXgvGC
         VNcIcZWhJY0jOdwu57jdpXYtbK54ClDPXslGKV9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Shvetsov <andrey.shvetsov@k2l.de>
Subject: [PATCH 5.4 012/110] staging: most: net: fix buffer overflow
Date:   Thu, 30 Jan 2020 19:37:48 +0100
Message-Id: <20200130183615.793039722@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
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
 drivers/staging/most/net/net.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/staging/most/net/net.c
+++ b/drivers/staging/most/net/net.c
@@ -81,6 +81,11 @@ static int skb_to_mamac(const struct sk_
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
@@ -128,6 +133,11 @@ static int skb_to_mep(const struct sk_bu
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


