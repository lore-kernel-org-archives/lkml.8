Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1444EC3F354
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD732084E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811524;
	bh=lA+Q7/UyPRJhukxBIkkVyVHcgiUCTD/suSchesnD4AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jRZDjzt1DnTaXyE7pAhFc+aa3QQEegr/myANgf2KUVK9mefvHHBBLrvOeO3lTihQA
	 kOM3zXIPq2ALpe24JWJQo8ZPqhmN/tk1XFCMSJvBotdrSIApOXy+3/E0XxMmmC3YjE
	 l538j0h0nVqGlHqaA2QXJ/W3UaXArGix9KsmFeBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgB0NwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:52:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731262AbgB0Nv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:51:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 640792084E;
        Thu, 27 Feb 2020 13:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811517;
        bh=lA+Q7/UyPRJhukxBIkkVyVHcgiUCTD/suSchesnD4AY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncvEdgHb9D++k2KTZAYpLE/3+lx8Yq93Y9gMnmI1w65vr05lsew1tQpINQqN3p3MF
         hbW4OBefVPC72to/7s3L/2wG1+krpTqx2YOepagZe6laV/2/zcz+MDYGP8PPdFE4kT
         SLdAG9eCb5SHvlnOUQ26NHtewwPLIVbmzKlQMJrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        syzbot+adf6c6c2be1c3a718121@syzkaller.appspotmail.com
Subject: [PATCH 4.9 162/165] netfilter: xt_hashlimit: limit the max size of hashtable
Date:   Thu, 27 Feb 2020 14:37:16 +0100
Message-Id: <20200227132254.368737525@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
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
@@ -735,6 +735,8 @@ hashlimit_mt(const struct sk_buff *skb,
 	return hashlimit_mt_common(skb, par, hinfo, &info->cfg, 2);
 }
 
+#define HASHLIMIT_MAX_SIZE 1048576
+
 static int hashlimit_mt_check_common(const struct xt_mtchk_param *par,
 				     struct xt_hashlimit_htable **hinfo,
 				     struct hashlimit_cfg2 *cfg,
@@ -745,6 +747,14 @@ static int hashlimit_mt_check_common(con
 
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


