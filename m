Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668BCC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB8720675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609363;
	bh=wgQjZs1ddBRdFqlffXn/FGMRtYF9eRuUuRtsGAyWpRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V4yb+isbWxYT2CqT1Y3iOtUF4fbbNYtH5yKJC1FpIQKSG+nalGai01PThejCifYBY
	 1/UasMIlqM1rUJWV/USBtSu9N66Y4tsXtrea9KrZECUdeGjb3d83++H6xTWrvqCT08
	 yulGcBve4mH3XgxjWQqxf40xJv5i3tkOJXKw+5Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgBMP4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbgBMPZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:30 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D544324689;
        Thu, 13 Feb 2020 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607530;
        bh=wgQjZs1ddBRdFqlffXn/FGMRtYF9eRuUuRtsGAyWpRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JL4XUPy4caXk4AWI4Sc90zRtRE77BwqPDAKX9m9Q3hp95Qg9kbbBUakFTtnPQJOg3
         VdZTu+VB35qTt9Hw4U65mR/NdZ8CpkhreeqBXvl2oAgcmGSz2sdvU7OfYFo9PB0eV1
         g+fOmkknFZbOJzk5d5frdt79KvgcRghB2PZTAtw4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 101/173] ppp: Adjust indentation into ppp_async_input
Date:   Thu, 13 Feb 2020 07:20:04 -0800
Message-Id: <20200213151958.259769711@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 08cbc75f96029d3092664213a844a5e25523aa35 upstream.

Clang warns:

../drivers/net/ppp/ppp_async.c:877:6: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
                                ap->rpkt = skb;
                                ^
../drivers/net/ppp/ppp_async.c:875:5: note: previous statement is here
                                if (!skb)
                                ^
1 warning generated.

This warning occurs because there is a space before the tab on this
line. Clean up this entire block's indentation so that it is consistent
with the Linux kernel coding style and clang no longer warns.

Fixes: 6722e78c9005 ("[PPP]: handle misaligned accesses")
Link: https://github.com/ClangBuiltLinux/linux/issues/800
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ppp/ppp_async.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -878,15 +878,15 @@ ppp_async_input(struct asyncppp *ap, con
 				skb = dev_alloc_skb(ap->mru + PPP_HDRLEN + 2);
 				if (!skb)
 					goto nomem;
- 				ap->rpkt = skb;
- 			}
- 			if (skb->len == 0) {
- 				/* Try to get the payload 4-byte aligned.
- 				 * This should match the
- 				 * PPP_ALLSTATIONS/PPP_UI/compressed tests in
- 				 * process_input_packet, but we do not have
- 				 * enough chars here to test buf[1] and buf[2].
- 				 */
+				ap->rpkt = skb;
+			}
+			if (skb->len == 0) {
+				/* Try to get the payload 4-byte aligned.
+				 * This should match the
+				 * PPP_ALLSTATIONS/PPP_UI/compressed tests in
+				 * process_input_packet, but we do not have
+				 * enough chars here to test buf[1] and buf[2].
+				 */
 				if (buf[0] != PPP_ALLSTATIONS)
 					skb_reserve(skb, 2 + (buf[0] & 1));
 			}


