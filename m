Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67F9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17E9207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgHVUjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:39:33 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:35838 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727835AbgHVUjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:39:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 02671100E7B43;
        Sat, 22 Aug 2020 20:39:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: camp61_0b0be6b27044
X-Filterd-Recvd-Size: 4345
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Aug 2020 20:39:29 +0000 (UTC)
Message-ID: <ae154f9a96a710157f9b402ba21c6888c855dd1e.camel@perches.com>
Subject: Re: [PATCH net-next] net: Remove unnecessary intermediate variables
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>, Jianlin.Lv@arm.com
Cc:     netdev@vger.kernel.org, kuba@kernel.org, Song.Zhu@arm.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 22 Aug 2020 13:39:28 -0700
In-Reply-To: <20200822.123315.787815838209253525.davem@davemloft.net>
References: <20200822020431.125732-1-Jianlin.Lv@arm.com>
         <20200822.123315.787815838209253525.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-22 at 12:33 -0700, David Miller wrote:
> From: Jianlin Lv <Jianlin.Lv@arm.com>
> Date: Sat, 22 Aug 2020 10:04:31 +0800
> 
> > It is not necessary to use src/dst as an intermediate variable for
> > assignment operation; Delete src/dst intermediate variables to avoid
> > unnecessary variable declarations.
> > 
> > Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> 
> It keeps the line lengths within reasonable length, so these local
> variables are fine.
> 
> Also, the appropriate subsystem prefix for this patch should be "vxlan: "
> not "net: " in your Subject line.  If someone is skimming the shortlog
> in 'git' how will they tell where exactly in the networking your change
> is being made?
> 
> Anyways, I'm not applying this, thanks.

It _might_ be slightly faster to use inlines
instead so there's less copy of 16 byte structs
on the ipv6 side.

It's slightly smaller object code.
---
 drivers/net/vxlan.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index b9fefe27e3e8..e0ea246b3678 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -95,7 +95,25 @@ static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
 	       ip_tunnel_collect_metadata();
 }
 
+static __always_inline
+void vxlan_use_v4_addrs(struct ip_tunnel_info *info,
+			union vxlan_addr *remote_ip,
+			union vxlan_addr *local_ip)
+{
+	info->key.u.ipv4.src = remote_ip->sin.sin_addr.s_addr;
+	info->key.u.ipv4.dst = local_ip->sin.sin_addr.s_addr;
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
+static __always_inline
+void vxlan_use_v6_addrs(struct ip_tunnel_info *info,
+			union vxlan_addr *remote_ip,
+			union vxlan_addr *local_ip)
+{
+	info->key.u.ipv6.src = remote_ip->sin6.sin6_addr;
+	info->key.u.ipv6.dst = local_ip->sin6.sin6_addr;
+}
+
 static inline
 bool vxlan_addr_equal(const union vxlan_addr *a, const union vxlan_addr *b)
 {
@@ -2724,17 +2742,11 @@ static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		ndst = &rt->dst;
 		err = skb_tunnel_check_pmtu(skb, ndst, VXLAN_HEADROOM,
 					    netif_is_any_bridge_port(dev));
-		if (err < 0) {
+		if (err < 0)
 			goto tx_error;
-		} else if (err) {
-			if (info) {
-				struct in_addr src, dst;
-
-				src = remote_ip.sin.sin_addr;
-				dst = local_ip.sin.sin_addr;
-				info->key.u.ipv4.src = src.s_addr;
-				info->key.u.ipv4.dst = dst.s_addr;
-			}
+		if (err) {	/* newly built encapsulation length */
+			if (info)
+				vxlan_use_v4_addrs(info, &remote_ip, &local_ip);
 			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
 			dst_release(ndst);
 			goto out_unlock;
@@ -2780,17 +2792,11 @@ static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 		err = skb_tunnel_check_pmtu(skb, ndst, VXLAN6_HEADROOM,
 					    netif_is_any_bridge_port(dev));
-		if (err < 0) {
+		if (err < 0)
 			goto tx_error;
-		} else if (err) {
-			if (info) {
-				struct in6_addr src, dst;
-
-				src = remote_ip.sin6.sin6_addr;
-				dst = local_ip.sin6.sin6_addr;
-				info->key.u.ipv6.src = src;
-				info->key.u.ipv6.dst = dst;
-			}
+		if (err) {	/* newly built encapsulation length */
+			if (info)
+				vxlan_use_v6_addrs(info, &remote_ip, &local_ip);
 
 			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
 			dst_release(ndst);


