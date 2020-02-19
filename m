Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1092CC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB12121D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u57rzFA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSJxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:53:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45103 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgBSJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:53:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so12232182pfg.12;
        Wed, 19 Feb 2020 01:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9v8+wIBub2qiLrO6UKbQxc1lcW/tT/d7asx+H//NX30=;
        b=u57rzFA9pzTtMdQVkpEyH91i0vMmE1fKyg+1p5GmPkcbJZXGbx2GxHJTN4+B9DtfQ6
         w1KoHvl5zcNbhWbjXEp/8Wbz23UDVorCbM8TrCS85deP9UG4NXuIB6ltRL4BcQjtUhUN
         jSenzfHBEkVDNcu9q9OeD3DFSseCHgSwcJ9ASJ51uKlaDWKk60oHc8mX6xQHVNOB9Gz0
         fBGry9M86uIgCidu0Ofb18szAinmsjYhHAVkVj3/y6p9v37WnZ5dHvZl9iKtbFfXMGUs
         aSZfJ8mHdKFxy0cOSlAvwmoQ/ah3ORgjqt8AHCBkEXvi9Nt8z+b4KZLmR1ptdAZcC79l
         OwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9v8+wIBub2qiLrO6UKbQxc1lcW/tT/d7asx+H//NX30=;
        b=TUwmY/cutxeUs6+sdFtY2fPxqkioM+pXqwgdwnq9+R+FCEmFhUTQEA05QQxa/zBpqa
         JxHB71NgEgE3g5yhWozdYhtGtcoF44P4c2xZW+yHH6dOeTS5WVMLXr1e1eGn+4Fq1XmM
         ecjK4XlbtMGJCYNQkobLIOUTTZrCNVndhhHLzELq/0kb3339z1PcRSb/3ZeCzOlIgB1u
         5cPIeMKN/a5vas6c5nAPbnlu37UjqOIhzdu6AikFp+L9jtP0PJcF+rYVhwE1AcKBinRQ
         GDSHHu5WeuEStIbtJvFT5wg1Qinki6XntgI1QboEpmT3NSO1kIEvgm8mMDKZPyDBWMe4
         ARLw==
X-Gm-Message-State: APjAAAWilrbeFw3iLGdHK0kF75XsTp4Lf1EyuohkWg4YMuo7Fsc1myvC
        OnW0Y6WM+PWZq0uhP+4NlKc=
X-Google-Smtp-Source: APXvYqyN5sxGSp5lOMX94IBT9XEXhNRJK9Ibb42qfRvKAGp1zdKgDaYVcSh+nz2Zj9q/TECBXgh1+A==
X-Received: by 2002:a63:5f4e:: with SMTP id t75mr26676074pgb.7.1582106003790;
        Wed, 19 Feb 2020 01:53:23 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.220])
        by smtp.googlemail.com with ESMTPSA id t11sm2063907pgi.15.2020.02.19.01.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 01:53:23 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Arvid Brodin <arvid.brodin@alten.se>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     --cc=netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] net: hsr: Pass lockdep expression to RCU lists
Date:   Wed, 19 Feb 2020 15:23:03 +0530
Message-Id: <20200219095302.21987-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

node_db is traversed using list_for_each_entry_rcu
outside an RCU read-side critical section but under the protection
of hsr->list_lock.

Hence, add corresponding lockdep expression to silence false-positive
warnings, and harden RCU lists.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 net/hsr/hsr_framereg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 27dc65d7de67..cc8fcfd3918d 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -156,7 +156,8 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 		new_node->seq_out[i] = seq_out;
 
 	spin_lock_bh(&hsr->list_lock);
-	list_for_each_entry_rcu(node, node_db, mac_list) {
+	list_for_each_entry_rcu(node, node_db, mac_list,
+				lockdep_is_held(&hsr->list_lock)) {
 		if (ether_addr_equal(node->macaddress_A, addr))
 			goto out;
 		if (ether_addr_equal(node->macaddress_B, addr))
-- 
2.24.1

