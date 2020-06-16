Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A46DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB30214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322285;
	bh=8oOdO8G5uDNdbKO90o2ZU39T1Bp6Ti8hqZkMXc9pX6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KYXUcdUkNhxHcAediqTQKyFFZ14bXZO+ZpUclE9jRYfAZ2HZzN2l3PaAbqC8bIu7A
	 QYKexsBXPLv/srFlVEjxjIuBnPb+hbgK8lFaNsu2DsrM9zlysFG2GM9X+qVO0ekcNF
	 EhfgCyIC+SbqMGks8qfo+CpLPmbvsjnAUSL8v4MY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbgFPPom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731974AbgFPPoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:44:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E8FF21475;
        Tue, 16 Jun 2020 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322264;
        bh=8oOdO8G5uDNdbKO90o2ZU39T1Bp6Ti8hqZkMXc9pX6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqPbd67KDP5CyFebEseJUYtJ/DAy2uA3GwoTNOy0BEWXttzx/Zvq2utxXtBAV4+aX
         hnpAN3vQfztLf15lDjx7CERex7+TVuvVV2R8XDP9+3xWfT2mbxr+suZoKorJkuKxZl
         wgiLnktiT7s73yz+jsrtoF7IVexZ1xcPDtzYV2Os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.7 065/163] ALSA: fireface: fix configuration error for nominal sampling transfer frequency
Date:   Tue, 16 Jun 2020 17:33:59 +0200
Message-Id: <20200616153109.957335336@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit bbd6aac3ae15bef762af03bf62e35ace5c4292bd upstream.

128000 and 192000 are congruence modulo 32000, thus it's wrong to
distinguish them as multiple of 32000 and 48000 by modulo 32000 at
first.

Additionally, used condition statement to detect quadruple speed can
cause missing bit flag.

Furthermore, counter to ensure the configuration is wrong and it
causes false positive.

This commit fixes the above three bugs.

Cc: <stable@vger.kernel.org>
Fixes: 60aec494b389 ("ALSA: fireface: support allocate_resources operation in latter protocol")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20200510074301.116224-2-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/fireface/ff-protocol-latter.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/sound/firewire/fireface/ff-protocol-latter.c
+++ b/sound/firewire/fireface/ff-protocol-latter.c
@@ -107,18 +107,18 @@ static int latter_allocate_resources(str
 	int err;
 
 	// Set the number of data blocks transferred in a second.
-	if (rate % 32000 == 0)
-		code = 0x00;
+	if (rate % 48000 == 0)
+		code = 0x04;
 	else if (rate % 44100 == 0)
 		code = 0x02;
-	else if (rate % 48000 == 0)
-		code = 0x04;
+	else if (rate % 32000 == 0)
+		code = 0x00;
 	else
 		return -EINVAL;
 
 	if (rate >= 64000 && rate < 128000)
 		code |= 0x08;
-	else if (rate >= 128000 && rate < 192000)
+	else if (rate >= 128000)
 		code |= 0x10;
 
 	reg = cpu_to_le32(code);
@@ -140,7 +140,7 @@ static int latter_allocate_resources(str
 		if (curr_rate == rate)
 			break;
 	}
-	if (count == 10)
+	if (count > 10)
 		return -ETIMEDOUT;
 
 	for (i = 0; i < ARRAY_SIZE(amdtp_rate_table); ++i) {


