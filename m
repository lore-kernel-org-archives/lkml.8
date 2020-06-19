Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC0EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187712186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579627;
	bh=XdvTGOe+mAakrDz9iHlqGo/KRKencvAYF6pv20ttop4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kKnzl27uMIPQ1Kvk4iuHr2WWx3ZOzb2VH6zW0p2TkbEP2eaM5SBcQXx+AfRQNHYp5
	 M5GiQqNCsCT0K6ix7fKJtOVMoA7Z1xvfU7GMMQSR7e3i7FdX23CNINAUK99T1eLtzc
	 xOyhXlsfs48AuMDbRD8h9P2ZUuMYXiTuNB0+j6yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392269AbgFSPNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392240AbgFSPNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:13:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9DC221D7F;
        Fri, 19 Jun 2020 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579617;
        bh=XdvTGOe+mAakrDz9iHlqGo/KRKencvAYF6pv20ttop4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qgqf/UdNWKKlZrWTARvPzwpk3ten4igUpI6RMfWqyU72berypkq16d5W/KBOpNaFA
         tXu+I6bYKfPJ01KIWZDM7y52gs6tjd9PeYBlKHNsBKqk+Npa6KFtmlSQgRmx4t4ziL
         KMsyULT0y4oJFRMQl77s00vjULElxyQFgq/5wtJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.4 203/261] b43legacy: Fix case where channel status is corrupted
Date:   Fri, 19 Jun 2020 16:33:34 +0200
Message-Id: <20200619141659.630801667@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

commit ec4d3e3a054578de34cd0b587ab8a1ac36f629d9 upstream.

This patch fixes commit 75388acd0cd8 ("add mac80211-based driver for
legacy BCM43xx devices")

In https://bugzilla.kernel.org/show_bug.cgi?id=207093, a defect in
b43legacy is reported. Upon testing, thus problem exists on PPC and
X86 platforms, is present in the oldest kernel tested (3.2), and
has been present in the driver since it was first added to the kernel.

The problem is a corrupted channel status received from the device.
Both the internal card in a PowerBook G4 and the PCMCIA version
(Broadcom BCM4306 with PCI ID 14e4:4320) have the problem. Only Rev, 2
(revision 4 of the 802.11 core) of the chip has been tested. No other
devices using b43legacy are available for testing.

Various sources of the problem were considered. Buffer overrun and
other sources of corruption within the driver were rejected because
the faulty channel status is always the same, not a random value.
It was concluded that the faulty data is coming from the device, probably
due to a firmware bug. As that source is not available, the driver
must take appropriate action to recover.

At present, the driver reports the error, and them continues to process
the bad packet. This is believed that to be a mistake, and the correct
action is to drop the correpted packet.

Fixes: 75388acd0cd8 ("add mac80211-based driver for legacy BCM43xx devices")
Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Reported-and-tested by: F. Erhard <erhard_f@mailbox.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200407190043.1686-1-Larry.Finger@lwfinger.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/broadcom/b43legacy/xmit.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/broadcom/b43legacy/xmit.c
+++ b/drivers/net/wireless/broadcom/b43legacy/xmit.c
@@ -558,6 +558,7 @@ void b43legacy_rx(struct b43legacy_wldev
 	default:
 		b43legacywarn(dev->wl, "Unexpected value for chanstat (0x%X)\n",
 		       chanstat);
+		goto drop;
 	}
 
 	memcpy(IEEE80211_SKB_RXCB(skb), &status, sizeof(status));


