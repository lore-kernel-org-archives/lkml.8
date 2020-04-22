Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A5AC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4424D2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552592;
	bh=5NMuyZWCmZliclrYSh0KvOo0b4ZlLH5yjLm2O9vAJtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FgwoReNandK6QK4y6AR/lrujeNzaVN0YtTsicugsFg1ty6qXZLNcdNM/N2W65PMEs
	 q36MK4wNvrFkTr/yrSZCsAIY+Uit4RTc6X/ugjoLU+KoiYJBAja3KPgLx282Ox/VLX
	 b8J5ypOZP+CrQxj9Sdere4YSBHkArs9RWnekrwQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbgDVKtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbgDVKNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:13:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C218E2077D;
        Wed, 22 Apr 2020 10:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550381;
        bh=5NMuyZWCmZliclrYSh0KvOo0b4ZlLH5yjLm2O9vAJtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M89UoZFSAw8TUlBcV4WmEXNM006fTbFfdp+jbQGEzUkkoAnj45VIGubgHSzo9xKkN
         +fdtIVl88br9+Gmdm3WFhl8rlxzfzPbJ4UnBbyd1UysPIGb2SPOWqpHf5cBTbjv6VC
         UlDYdXr+ngl9lN2n1LIlC4vN7mqSOHOZzEdGAe1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6693adf1698864d21734@syzkaller.appspotmail.com,
        syzbot+a4aee3f42d7584d76761@syzkaller.appspotmail.com,
        stable@kernel.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 123/199] mac80211_hwsim: Use kstrndup() in place of kasprintf()
Date:   Wed, 22 Apr 2020 11:57:29 +0200
Message-Id: <20200422095109.817494465@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>

commit 7ea862048317aa76d0f22334202779a25530980c upstream.

syzbot reports a warning:

precision 33020 too large
WARNING: CPU: 0 PID: 9618 at lib/vsprintf.c:2471 set_precision+0x150/0x180 lib/vsprintf.c:2471
 vsnprintf+0xa7b/0x19a0 lib/vsprintf.c:2547
 kvasprintf+0xb2/0x170 lib/kasprintf.c:22
 kasprintf+0xbb/0xf0 lib/kasprintf.c:59
 hwsim_del_radio_nl+0x63a/0x7e0 drivers/net/wireless/mac80211_hwsim.c:3625
 genl_family_rcv_msg_doit net/netlink/genetlink.c:672 [inline]
 ...
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Thus it seems that kasprintf() with "%.*s" format can not be used for
duplicating a string with arbitrary length. Replace it with kstrndup().

Note that later this string is limited to NL80211_WIPHY_NAME_MAXLEN == 64,
but the code is simpler this way.

Reported-by: syzbot+6693adf1698864d21734@syzkaller.appspotmail.com
Reported-by: syzbot+a4aee3f42d7584d76761@syzkaller.appspotmail.com
Cc: stable@kernel.org
Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Link: https://lore.kernel.org/r/20200410123257.14559-1-tuomas.tynkkynen@iki.fi
[johannes: add note about length limit]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mac80211_hwsim.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3134,9 +3134,9 @@ static int hwsim_new_radio_nl(struct sk_
 		param.no_vif = true;
 
 	if (info->attrs[HWSIM_ATTR_RADIO_NAME]) {
-		hwname = kasprintf(GFP_KERNEL, "%.*s",
-				   nla_len(info->attrs[HWSIM_ATTR_RADIO_NAME]),
-				   (char *)nla_data(info->attrs[HWSIM_ATTR_RADIO_NAME]));
+		hwname = kstrndup((char *)nla_data(info->attrs[HWSIM_ATTR_RADIO_NAME]),
+				  nla_len(info->attrs[HWSIM_ATTR_RADIO_NAME]),
+				  GFP_KERNEL);
 		if (!hwname)
 			return -ENOMEM;
 		param.hwname = hwname;
@@ -3175,9 +3175,9 @@ static int hwsim_del_radio_nl(struct sk_
 	if (info->attrs[HWSIM_ATTR_RADIO_ID]) {
 		idx = nla_get_u32(info->attrs[HWSIM_ATTR_RADIO_ID]);
 	} else if (info->attrs[HWSIM_ATTR_RADIO_NAME]) {
-		hwname = kasprintf(GFP_KERNEL, "%.*s",
-				   nla_len(info->attrs[HWSIM_ATTR_RADIO_NAME]),
-				   (char *)nla_data(info->attrs[HWSIM_ATTR_RADIO_NAME]));
+		hwname = kstrndup((char *)nla_data(info->attrs[HWSIM_ATTR_RADIO_NAME]),
+				  nla_len(info->attrs[HWSIM_ATTR_RADIO_NAME]),
+				  GFP_KERNEL);
 		if (!hwname)
 			return -ENOMEM;
 	} else


