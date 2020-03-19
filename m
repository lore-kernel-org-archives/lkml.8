Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D54EC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9010214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623384;
	bh=8LF/TtF4aX1kJVWTrhTdRdKARRMVWsPJAm5F9NZi6pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FrmHUoBaoYTGJ5TidZkJGsnScpPM86x1fMVsoLBdHNw9LmaMkpRgSq/OQGVOg7rBe
	 ypnA7rMxnc9iW4FhyGA/sMizVwj2Xq3KhAGRumcGvKTuANp6MUtOl8cK/XaRFAz0yp
	 7UrQOlYAd4Pif2qP7admyDFSCLLMQfAkwSOCObMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgCSNJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgCSNJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:09:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3CFF208D6;
        Thu, 19 Mar 2020 13:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623378;
        bh=8LF/TtF4aX1kJVWTrhTdRdKARRMVWsPJAm5F9NZi6pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuR2g2rPKPmmXOvjXt0pnidEc+VqahxI1e438ErRYLwkMr2cDUVQsc//7ldVkGHlQ
         meGel3fZC0IvCIWir+qlf7NIGWGVnqhTdalIaIXD2BNJ7CukeOoh33723XXjATn+VP
         cvGgtzQUDZak5U/oDsbLvXyjQvAYyOgtrPRYDMnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
        Matteo Croce <mcroce@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 93/93] ipv4: ensure rcu_read_lock() in cipso_v4_error()
Date:   Thu, 19 Mar 2020 14:00:37 +0100
Message-Id: <20200319123953.796484125@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

commit 3e72dfdf8227b052393f71d820ec7599909dddc2 upstream.

Similarly to commit c543cb4a5f07 ("ipv4: ensure rcu_read_lock() in
ipv4_link_failure()"), __ip_options_compile() must be called under rcu
protection.

Fixes: 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Matteo Croce <mcroce@redhat.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/cipso_ipv4.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1809,6 +1809,7 @@ void cipso_v4_error(struct sk_buff *skb,
 {
 	unsigned char optbuf[sizeof(struct ip_options) + 40];
 	struct ip_options *opt = (struct ip_options *)optbuf;
+	int res;
 
 	if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
 		return;
@@ -1820,7 +1821,11 @@ void cipso_v4_error(struct sk_buff *skb,
 
 	memset(opt, 0, sizeof(struct ip_options));
 	opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
-	if (__ip_options_compile(dev_net(skb->dev), opt, skb, NULL))
+	rcu_read_lock();
+	res = __ip_options_compile(dev_net(skb->dev), opt, skb, NULL);
+	rcu_read_unlock();
+
+	if (res)
 		return;
 
 	if (gateway)


