Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86428C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D07020678
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dN+OhM8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgA2NNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:13:06 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46847 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgA2NNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:13:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id g195so16869339qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 05:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m52WK5Z5XQq82/j8v4s/y36gQF19HkrLAFVCUl6oUUU=;
        b=dN+OhM8S4hz8ITKdQ8cPe7L1x7Zdw4PDQS7fwn5JmwrcJeZHTbbS/Zy+a7QBRTNvuc
         +GAPWZveujBFHEp8zmkpzMKTzke6B76la96B4kOZ1MMsDCNKoTAIX/7oCJUsbhOkXHXW
         VRG+f0i1n3DfJUAOfe5cDDoZIXBMZCokqqLLRYKGGUzrE6cqS32154wgkoRwe3GIR+5G
         v6Kow0YLG92LHI262SkZb/RR8grOI8tyOvAO4xC4rfzHJ4//xjqlE5mc1Nr7RL1BVsLp
         qcVqyYaf3FelNGfUKC0uldhpctJ1P/mlFcaYxAnUf/WHdMUrS3HsxrMIWs8Dn6lfcRo9
         Gq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m52WK5Z5XQq82/j8v4s/y36gQF19HkrLAFVCUl6oUUU=;
        b=jWx49BEz6GhcQXFQ30H96wtk360fdqud8sWHsYjeWPrYAxg6CrF1kQrqDZT5I8Nwys
         +I3zdXkr0QvLvzPctDdHtZNCLLHjZCHL7OKanBAQ1eFkCG0nNrgI6/7u2G1H0Ts1d+sf
         FcivIz3sJBeXoaNUK7TwuB+Quk6l4Dy0o4XlzA0oHqMY6rmPdKT/dyakTzQMVpTUy0BU
         giWbM+v74DcQ4RGfwYfhEn65HylxOKydbNPS/rAWRbJt7wBtgZ9hW41c65RySo8gi0jA
         bo9ASfkpw4KPid+K+IC1HjRal+/PsaMsPY2PV39coZuE1RHTJlscCSwMQXo+Q/W1jrhc
         Qqvg==
X-Gm-Message-State: APjAAAX7WN/gSO3bhZIWLDOpz5TfxCCT36duDuXPUzBlhIixuG7VBVFc
        qVNjSLx2qZQv/E+W5KeUub70oA==
X-Google-Smtp-Source: APXvYqwcz9xmy2SBNP141x/Q0aIZXP7Do55yli6TYd+VQ3isG5dtxETymcoQhSEBaEJobi2TRuqn0Q==
X-Received: by 2002:a37:5fc2:: with SMTP id t185mr27427944qkb.271.1580303583086;
        Wed, 29 Jan 2020 05:13:03 -0800 (PST)
Received: from ovpn-120-127.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 11sm910293qko.76.2020.01.29.05.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 05:13:02 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     penguin-kernel@i-love.sakura.ne.jp, hannes@cmpxchg.org,
        elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>,
        syzbot+f36cfe60b1006a94f9dc@syzkaller.appspotmail.com
Subject: [PATCH -next] mm/page_counter: annotate an intentional data race
Date:   Wed, 29 Jan 2020 08:12:42 -0500
Message-Id: <20200129131242.4329-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 3e32cb2e0a12 ("mm: memcontrol: lockless page counters") could
had memcg->memsw->failcnt been accessed concurrently as reported by
KCSAN,

BUG: KCSAN: data-race in page_counter_try_charge / page_counter_try_charge

write to 0xffff88809bbf2158 of 8 bytes by task 11782 on cpu 0:
 page_counter_try_charge+0x100/0x170 mm/page_counter.c:129
 try_charge+0x185/0xbf0 mm/memcontrol.c:2405
 __memcg_kmem_charge_memcg+0x4a/0xe0 mm/memcontrol.c:2837
 __memcg_kmem_charge+0xcf/0x1b0 mm/memcontrol.c:2877
 __alloc_pages_nodemask+0x26c/0x310 mm/page_alloc.c:4780

read to 0xffff88809bbf2158 of 8 bytes by task 11814 on cpu 1:
 page_counter_try_charge+0xef/0x170 mm/page_counter.c:129
 try_charge+0x185/0xbf0 mm/memcontrol.c:2405
 __memcg_kmem_charge_memcg+0x4a/0xe0 mm/memcontrol.c:2837
 __memcg_kmem_charge+0xcf/0x1b0 mm/memcontrol.c:2877
 __alloc_pages_nodemask+0x26c/0x310 mm/page_alloc.c:4780

Since the "failcnt" counter is tolerant of some degree of inaccuracy and
is only used to report stats, a data race will not be harmful, thus mark
it as an intentional data races with the data_race() macro.

Reported-by: syzbot+f36cfe60b1006a94f9dc@syzkaller.appspotmail.com
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_counter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index a17841150906..7c82072cda25 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -126,7 +126,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 			 * This is racy, but we can live with some
 			 * inaccuracy in the failcnt.
 			 */
-			c->failcnt++;
+			data_race(c->failcnt++);
 			*fail = c;
 			goto failed;
 		}
-- 
2.21.0 (Apple Git-122.2)

