Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F3DC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E84920880
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738794;
	bh=Dlpxu94Gw2w8+mGmgROP8VFW0qGP7TgxW2vUEk6Kb/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wPKkOPMoooSzes+pgJCqIdYUXJYzyuS3wqdGr9u9yB7O3nICz5NBtYqqJGYnU6ltK
	 CC9TYxCHzZimn/63syIyUoertdQhxWxINnh8j9uTkGEJcgMYlmV6YfYbtSCZIrnvat
	 aWp15jFN3qYwVRjCr+3tfOXmbA2/0jjEEYHNi9nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbgAKKdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:33:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731531AbgAKKdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:33:09 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB09420842;
        Sat, 11 Jan 2020 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738788;
        bh=Dlpxu94Gw2w8+mGmgROP8VFW0qGP7TgxW2vUEk6Kb/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrhCnwqMv8AgMdII7Tk25Fjigt6z5E1OT3qKwkDumblpqcAbjg/1R4kjXD3RbAR7o
         i5myZAdjUHza0N4Fwu7m5TgU2nZCm1e5GiZ9c4Z/FQhBCK8OuJCtlQhrVMRnDFiKWK
         HMn6uF9JhecJhkIFVV9Y9/DcS/wM6awEIpnwvI9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 154/165] vlan: vlan_changelink() should propagate errors
Date:   Sat, 11 Jan 2020 10:51:13 +0100
Message-Id: <20200111094941.406970971@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit eb8ef2a3c50092bb018077c047b8dba1ce0e78e3 ]

Both vlan_dev_change_flags() and vlan_dev_set_egress_priority()
can return an error. vlan_changelink() should not ignore them.

Fixes: 07b5b17e157b ("[VLAN]: Use rtnl_link API")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/8021q/vlan_netlink.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -108,11 +108,13 @@ static int vlan_changelink(struct net_de
 	struct ifla_vlan_flags *flags;
 	struct ifla_vlan_qos_mapping *m;
 	struct nlattr *attr;
-	int rem;
+	int rem, err;
 
 	if (data[IFLA_VLAN_FLAGS]) {
 		flags = nla_data(data[IFLA_VLAN_FLAGS]);
-		vlan_dev_change_flags(dev, flags->flags, flags->mask);
+		err = vlan_dev_change_flags(dev, flags->flags, flags->mask);
+		if (err)
+			return err;
 	}
 	if (data[IFLA_VLAN_INGRESS_QOS]) {
 		nla_for_each_nested(attr, data[IFLA_VLAN_INGRESS_QOS], rem) {
@@ -123,7 +125,9 @@ static int vlan_changelink(struct net_de
 	if (data[IFLA_VLAN_EGRESS_QOS]) {
 		nla_for_each_nested(attr, data[IFLA_VLAN_EGRESS_QOS], rem) {
 			m = nla_data(attr);
-			vlan_dev_set_egress_priority(dev, m->from, m->to);
+			err = vlan_dev_set_egress_priority(dev, m->from, m->to);
+			if (err)
+				return err;
 		}
 	}
 	return 0;


