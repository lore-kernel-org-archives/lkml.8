Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89036C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 02:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A292075E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 02:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="diAsWuOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCTCyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 22:54:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38342 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCTCyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 22:54:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id z12so3833612qtq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 19:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S0/mrn3rzQVBFkzod99RMOB6yGI2xYesLtS40pF0HvY=;
        b=diAsWuOEtzlsKfOfRgUcqOHG9kn8IIUQ6GQqF8gnYrOKQRTXGdVkzcvLdnb5mgmo+4
         /X/ORHQp4Wz8u0/toRiVzhuXNnzl3/fesQFew+4uvHL9Isb6kXxlknmsDA6jcY7cIrpv
         eZqOIirMmeHDxFoEWKpHgdeLcdo3Ot65ukMeoL57m0C8lnOZBdY3GLv4udgjG67LRrVv
         t50GUSgH70zQOzANRFozgT4NPYOs2YNj1O+nfSgKrQsGbCW9B1at/ZQnoEjRa9AT+7xD
         +N40PE9h7FikJxiJa3orhUDsxZw7r3uzLe0/XhbRbe2es5Vkf27tgNppZ+g9XL0Kblf3
         6JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S0/mrn3rzQVBFkzod99RMOB6yGI2xYesLtS40pF0HvY=;
        b=COihDDbacGawsXFCYmJLgGtWL4Nlbo7+PT1gd3rcw6njMKfy1hwwF8CskCvgBdlt5C
         FhX37VGPUdyPvAF8DyO4fzvX8nVYUUiDJxKn6Lem2qBDoguigdFjWPzlVtW5LutfMLCV
         EwTGU1xPHJacvC6Ca2b1Hlz0gOthE6eWbniEtNTSGiYbG1uUwfHaN6crUGsK8fX7msVt
         qGR22WWL/EiBAjpgNygIahrUecJJiADaxg5T2ZqbXhEnArhmX/f3qaoE8UZjGJoSTk3d
         Ahhv8vJrp5cW68p64vIkkUD04MmZWVP76iLa/xMcJ0rc3OpbeLkx3UEGtjr9do3Dp2/t
         MO5g==
X-Gm-Message-State: ANhLgQ1xsiAZe3CNJhqk6dDmj8n8oPzPT4hMQvxCH45bh+UiWdqjH3u6
        Jvd8S7Bx0zpKI/dHwXI+0S7sBw==
X-Google-Smtp-Source: ADFU+vvXJKh1T/KUuUPCH/VMXxunSSn2oqq4GnaqzV1YA7XZi4u4vl3hefMLbEGpHGQBNlgio/39sQ==
X-Received: by 2002:ac8:2d88:: with SMTP id p8mr3126608qta.346.1584672878551;
        Thu, 19 Mar 2020 19:54:38 -0700 (PDT)
Received: from ovpn-66-200.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 16sm3134342qkk.79.2020.03.19.19.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 19:54:38 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     davem@davemloft.net
Cc:     alexander.h.duyck@linux.intel.com, kuznet@ms2.inr.ac.ru,
        kuba@kernel.org, yoshfuji@linux-ipv6.org, dsahern@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] ipv4: fix a RCU-list lock in inet_dump_fib()
Date:   Thu, 19 Mar 2020 22:54:21 -0400
Message-Id: <20200320025421.9216-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a place,

inet_dump_fib()
  fib_table_dump
    fn_trie_dump_leaf()
      hlist_for_each_entry_rcu()

without rcu_read_lock() will trigger a warning,

 WARNING: suspicious RCU usage
 -----------------------------
 net/ipv4/fib_trie.c:2216 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by ip/1923:
  #0: ffffffff8ce76e40 (rtnl_mutex){+.+.}, at: netlink_dump+0xd6/0x840

 Call Trace:
  dump_stack+0xa1/0xea
  lockdep_rcu_suspicious+0x103/0x10d
  fn_trie_dump_leaf+0x581/0x590
  fib_table_dump+0x15f/0x220
  inet_dump_fib+0x4ad/0x5d0
  netlink_dump+0x350/0x840
  __netlink_dump_start+0x315/0x3e0
  rtnetlink_rcv_msg+0x4d1/0x720
  netlink_rcv_skb+0xf0/0x220
  rtnetlink_rcv+0x15/0x20
  netlink_unicast+0x306/0x460
  netlink_sendmsg+0x44b/0x770
  __sys_sendto+0x259/0x270
  __x64_sys_sendto+0x80/0xa0
  do_syscall_64+0x69/0xf4
  entry_SYSCALL_64_after_hwframe+0x49/0xb3

Fixes: 18a8021a7be3 ("net/ipv4: Plumb support for filtering route dumps")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Call rcu_read_unlock() before returning.
    Add a "Fixes" tag per David.

 net/ipv4/fib_frontend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 577db1d50a24..213be9c050ad 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -997,7 +997,9 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 			return -ENOENT;
 		}
 
+		rcu_read_lock();
 		err = fib_table_dump(tb, skb, cb, &filter);
+		rcu_read_unlock();
 		return skb->len ? : err;
 	}
 
-- 
2.21.0 (Apple Git-122.2)

