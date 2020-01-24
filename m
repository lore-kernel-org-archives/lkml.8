Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6B6C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464012077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864798;
	bh=fCQsnPtM9ZRfbPias8TGji/+GGIu4tOHPoDAXc5izl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tvGefbhgll6Co1aUxD/UMpbPqFMez+e3PlFl6agBI/nVb7YUZuT+LxPSKz7TI22vL
	 1m+hYdGW6aEpfJodwlqEPYds3OcuMbnNR311NLC9M03TAChYSsFL3KIYKGffE5bpPN
	 Ez8gFcWpUXuwugWAneGHhnZTsRHA0YYzDmH8PA1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbgAXLTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:19:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390802AbgAXLTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:19:42 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A1E20708;
        Fri, 24 Jan 2020 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864782;
        bh=fCQsnPtM9ZRfbPias8TGji/+GGIu4tOHPoDAXc5izl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EgpkanhiFuelfCWtgmMySkV799a89v36wTARUC0MJMEEBIeobLY6bM/a5U+3AP+Bk
         g+ujI4uua2vPlhmM87UVdFUrYLIDOe5MVifAMYwfhnIIDhFllEbXiVYLKXu6+Oo5IX
         aGxvYWb6TlLkdp/p50aogmlUdmaiez3dgdAEVmQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 364/639] netfilter: ebtables: CONFIG_COMPAT: reject trailing data after last rule
Date:   Fri, 24 Jan 2020 10:28:54 +0100
Message-Id: <20200124093132.717691202@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 680f6af5337c98d116e4f127cea7845339dba8da ]

If userspace provides a rule blob with trailing data after last target,
we trigger a splat, then convert ruleset to 64bit format (with trailing
data), then pass that to do_replace_finish() which then returns -EINVAL.

Erroring out right away avoids the splat plus unneeded translation and
error unwind.

Fixes: 81e675c227ec ("netfilter: ebtables: add CONFIG_COMPAT support")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebtables.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 785e19afd6aaa..f59230e4fc295 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2165,7 +2165,9 @@ static int compat_copy_entries(unsigned char *data, unsigned int size_user,
 	if (ret < 0)
 		return ret;
 
-	WARN_ON(size_remaining);
+	if (size_remaining)
+		return -EINVAL;
+
 	return state->buf_kern_offset;
 }
 
-- 
2.20.1



