Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFC2C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBBF214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586608120;
	bh=pJNv+CG/2FEsqgq69UaXmxV9zczulRKLMvJHVyKDbQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pTZhJX3u8Uy+Kfr8AVsYoIpYRZsR8tBSrd/t1fQwJy568o2rKdfqZrN4Ozhrwe6DA
	 xguMU62tC5qkdge8iPzDw5AzxsbN/6yJqPvjaHSVCQNaW7DMWD7FHTB4UpzOtJGqSr
	 lAfIvQV7+b1ftDiBuYeGk4IE+EGZuClmTR/ZS5KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgDKMMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgDKMMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:12:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70D0220787;
        Sat, 11 Apr 2020 12:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607133;
        bh=pJNv+CG/2FEsqgq69UaXmxV9zczulRKLMvJHVyKDbQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9Pd6Xsw/Vytz+2M5aioPWnR3po/kqtbFFTictnOdc0AOhI1t9b39Dciu42JIievU
         +q+wHbJGFAWRrx8kdf+2pRGfCxNsqCzMMx/rkyI5Gk1/Zn3Ls0sgAub3Lw+k3nGmtz
         naELC2VzQxKjCUURcs0YMQP9aybQx0JubFQooAJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Shailabh Nagar <nagar@watson.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 20/32] tools/accounting/getdelays.c: fix netlink attribute length
Date:   Sat, 11 Apr 2020 14:08:59 +0200
Message-Id: <20200411115421.341669636@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115418.455500023@linuxfoundation.org>
References: <20200411115418.455500023@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@kernel.org>

commit 4054ab64e29bb05b3dfe758fff3c38a74ba753bb upstream.

A recent change to the netlink code: 6e237d099fac ("netlink: Relax attr
validation for fixed length types") logs a warning when programs send
messages with invalid attributes (e.g., wrong length for a u32).  Yafang
reported this error message for tools/accounting/getdelays.c.

send_cmd() is wrongly adding 1 to the attribute length.  As noted in
include/uapi/linux/netlink.h nla_len should be NLA_HDRLEN + payload
length, so drop the +1.

Fixes: 9e06d3f9f6b1 ("per task delay accounting taskstats interface: documentation fix")
Reported-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Tested-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200327173111.63922-1-dsahern@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/accounting/getdelays.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -135,7 +135,7 @@ static int send_cmd(int sd, __u16 nlmsg_
 	msg.g.version = 0x1;
 	na = (struct nlattr *) GENLMSG_DATA(&msg);
 	na->nla_type = nla_type;
-	na->nla_len = nla_len + 1 + NLA_HDRLEN;
+	na->nla_len = nla_len + NLA_HDRLEN;
 	memcpy(NLA_DATA(na), nla_data, nla_len);
 	msg.n.nlmsg_len += NLMSG_ALIGN(na->nla_len);
 


