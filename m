Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46232C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5552080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746924;
	bh=driQI74juRlWjbeHR3D7qXZjRFn1SWZmS4/285l1dhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OwXRHA3/1lIXpb5U1d7hOsVBNQnUSJaZNrmgizKKi7jlVkb426AEfNYvIItap0eee
	 Lj+NljfyOFmbCGJXrtQ+f3Z4Cm8an2AtixmlwkO4sFNhnod60CLO0r55WAIXZljK7r
	 xYhP+EPE3YKNJaH6usVoe8ahH0KhRiTWyeoH685o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgBCQWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:22:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbgBCQVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:21:55 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E034E2082E;
        Mon,  3 Feb 2020 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746914;
        bh=driQI74juRlWjbeHR3D7qXZjRFn1SWZmS4/285l1dhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQHdU/2aXRRVoewn+cEkUpFQG8D6O1rHaywO+6goyZ43+NEstFH3zlHrb/wkS2b95
         cx5NB4mi70E89sJigJa5qmWugFNTkiWUlG6wLJZywT7i3wO0fEQ3rphFVnmTrjZlwR
         ZyHB0ITvIRNEwDUGzmycx0b5Y+6WQWnlLOBDW+RM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 43/53] airo: Add missing CAP_NET_ADMIN check in AIROOLDIOCTL/SIOCDEVPRIVATE
Date:   Mon,  3 Feb 2020 16:19:35 +0000
Message-Id: <20200203161910.505286658@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 78f7a7566f5eb59321e99b55a6fdb16ea05b37d1 ]

The driver for Cisco Aironet 4500 and 4800 series cards (airo.c),
implements AIROOLDIOCTL/SIOCDEVPRIVATE in airo_ioctl().

The ioctl handler copies an aironet_ioctl struct from userspace, which
includes a command. Some of the commands are handled in readrids(),
where the user controlled command is converted into a driver-internal
value called "ridcode".

There are two command values, AIROGWEPKTMP and AIROGWEPKNV, which
correspond to ridcode values of RID_WEP_TEMP and RID_WEP_PERM
respectively. These commands both have checks that the user has
CAP_NET_ADMIN, with the comment that "Only super-user can read WEP
keys", otherwise they return -EPERM.

However there is another command value, AIRORRID, that lets the user
specify the ridcode value directly, with no other checks. This means
the user can bypass the CAP_NET_ADMIN check on AIROGWEPKTMP and
AIROGWEPKNV.

Fix it by moving the CAP_NET_ADMIN check out of the command handling
and instead do it later based on the ridcode. That way regardless of
whether the ridcode is set via AIROGWEPKTMP or AIROGWEPKNV, or passed
in using AIRORID, we always do the CAP_NET_ADMIN check.

Found by Ilja by code inspection, not tested as I don't have the
required hardware.

Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/airo.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index 94df9ddfb7eb1..a44496d8423ab 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -7808,16 +7808,8 @@ static int readrids(struct net_device *dev, aironet_ioctl *comp) {
 	case AIROGVLIST:    ridcode = RID_APLIST;       break;
 	case AIROGDRVNAM:   ridcode = RID_DRVNAME;      break;
 	case AIROGEHTENC:   ridcode = RID_ETHERENCAP;   break;
-	case AIROGWEPKTMP:  ridcode = RID_WEP_TEMP;
-		/* Only super-user can read WEP keys */
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		break;
-	case AIROGWEPKNV:   ridcode = RID_WEP_PERM;
-		/* Only super-user can read WEP keys */
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		break;
+	case AIROGWEPKTMP:  ridcode = RID_WEP_TEMP;	break;
+	case AIROGWEPKNV:   ridcode = RID_WEP_PERM;	break;
 	case AIROGSTAT:     ridcode = RID_STATUS;       break;
 	case AIROGSTATSD32: ridcode = RID_STATSDELTA;   break;
 	case AIROGSTATSC32: ridcode = RID_STATS;        break;
@@ -7831,6 +7823,12 @@ static int readrids(struct net_device *dev, aironet_ioctl *comp) {
 		return -EINVAL;
 	}
 
+	if (ridcode == RID_WEP_TEMP || ridcode == RID_WEP_PERM) {
+		/* Only super-user can read WEP keys */
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+	}
+
 	if ((iobuf = kzalloc(RIDSIZE, GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 
-- 
2.20.1



