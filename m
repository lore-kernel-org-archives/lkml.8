Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C141C54FFD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541C524656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813939;
	bh=W4/xiG4eiTXSVrIJ6XH12CjYjNUG6YQO84OF6694ykI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h0zGNahp+IvsPJt1HmKMHzjCocg0fvYIwXRdbqTsA7EB6k9y36xGTtL4vVgv++g1X
	 Pm7dQJW8Iw1doPo3uFj5fRWN6ZXqyZxLtP82tBwYCYcD/c+p4pwl1d3VMfw4EE5WFx
	 pSGj5wuke1Wc1U45pSkU0yevf4rIWHUm4lN9pfEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733095AbgB0OCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:02:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733078AbgB0OCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:02:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3F3C20801;
        Thu, 27 Feb 2020 14:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812136;
        bh=W4/xiG4eiTXSVrIJ6XH12CjYjNUG6YQO84OF6694ykI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vwiJHYlRi0NRFgKlGun5xX4Fgw3a09Uvm//3Qd4egMwPuMkgvtPtUGxQGCm/26x0K
         AYYLE5obbBoceShBXthiY89C75jDYTjeqI/9efqBSBpMqLW+FnHQ/PeryqF6GcPMGY
         kbgcyLu3tKo3p7j/tEYIxWVGS2iquwflz3PXFI80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        syzbot+adf6c6c2be1c3a718121@syzkaller.appspotmail.com
Subject: [PATCH 4.14 234/237] netfilter: xt_hashlimit: limit the max size of hashtable
Date:   Thu, 27 Feb 2020 14:37:28 +0100
Message-Id: <20200227132313.292102759@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 8d0015a7ab76b8b1e89a3e5f5710a6e5103f2dd5 upstream.

The user-specified hashtable size is unbound, this could
easily lead to an OOM or a hung task as we hold the global
mutex while allocating and initializing the new hashtable.

Add a max value to cap both cfg->size and cfg->max, as
suggested by Florian.

Reported-and-tested-by: syzbot+adf6c6c2be1c3a718121@syzkaller.appspotmail.com
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/xt_hashlimit.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -845,6 +845,8 @@ hashlimit_mt(const struct sk_buff *skb,
 	return hashlimit_mt_common(skb, par, hinfo, &info->cfg, 3);
 }
 
+#define HASHLIMIT_MAX_SIZE 1048576
+
 static int hashlimit_mt_check_common(const struct xt_mtchk_param *par,
 				     struct xt_hashlimit_htable **hinfo,
 				     struct hashlimit_cfg3 *cfg,
@@ -855,6 +857,14 @@ static int hashlimit_mt_check_common(con
 
 	if (cfg->gc_interval == 0 || cfg->expire == 0)
 		return -EINVAL;
+	if (cfg->size > HASHLIMIT_MAX_SIZE) {
+		cfg->size = HASHLIMIT_MAX_SIZE;
+		pr_info_ratelimited("size too large, truncated to %u\n", cfg->size);
+	}
+	if (cfg->max > HASHLIMIT_MAX_SIZE) {
+		cfg->max = HASHLIMIT_MAX_SIZE;
+		pr_info_ratelimited("max too large, truncated to %u\n", cfg->max);
+	}
 	if (par->family == NFPROTO_IPV4) {
 		if (cfg->srcmask > 32 || cfg->dstmask > 32)
 			return -EINVAL;


