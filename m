Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F0AC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37CB206DA
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737196;
	bh=94hAH9NlWUCGPC3/bxmyNYELJcLDeZ9hO8DfsagdILU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C1qgiRcOqtQaPR2Nm5EqWdLNnKGZ9JTFm0r7V1m4Q/ivhh4MnQ1kTkEE5wdPHramu
	 +vspJ1WAD72Gm2eh5VwUtZ+ZtEYbxKY7IojZ0p86Tkn/yPRw+X4zkvzV683pCkzaCy
	 tVjx08JcvrP2VcUZ8u80ybkwd6bbUwZWLXhip8G0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgAKKGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:06:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbgAKKGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:06:33 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 225B42084D;
        Sat, 11 Jan 2020 10:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737193;
        bh=94hAH9NlWUCGPC3/bxmyNYELJcLDeZ9hO8DfsagdILU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isgQklSF3LkHNmWy8TZo+ywq8ojfoeUNDMfI6jh632ea+GlIcLfTEqSAUg/BJKbel
         MfzEfjYJun4TN/nAbLu45I2kvFjP0tncJJjA9eKpD2B8lCXr4RumabwFicD9mo/3Gv
         TLdiTDgvr4iMtHJIcgwlPScZNtmLPpgKA4xvHnNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 87/91] vlan: vlan_changelink() should propagate errors
Date:   Sat, 11 Jan 2020 10:50:20 +0100
Message-Id: <20200111094913.063690740@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
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
@@ -92,11 +92,13 @@ static int vlan_changelink(struct net_de
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
@@ -107,7 +109,9 @@ static int vlan_changelink(struct net_de
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


