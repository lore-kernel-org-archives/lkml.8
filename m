Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F922C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B68021D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgFSW4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:56:52 -0400
Received: from smtp.uniroma2.it ([160.80.6.16]:33335 "EHLO smtp.uniroma2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbgFSW4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:56:46 -0400
Received: from localhost.localdomain ([160.80.103.126])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 05JMuRJE014086
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 20 Jun 2020 00:56:29 +0200
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Donald Sharp <sharpd@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Dinesh Dutt <didutt@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@cnit.it>,
        Ahmed Abdelsalam <ahabdels@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [net-next,v1,4/5] vrf: add l3mdev registration for table to VRF device lookup
Date:   Sat, 20 Jun 2020 00:54:46 +0200
Message-Id: <20200619225447.1445-5-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200619225447.1445-1-andrea.mayer@uniroma2.it>
References: <20200619225447.1445-1-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the initialization phase of the VRF module, the callback for table
to VRF device lookup is registered in l3mdev.

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 drivers/net/vrf.c | 59 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index c53e57354d2c..46599606ff10 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -183,6 +183,19 @@ static struct vrf_map *netns_vrf_map_by_dev(struct net_device *dev)
 	return netns_vrf_map(dev_net(dev));
 }
 
+static int vrf_map_elem_get_vrf_ifindex(struct vrf_map_elem *me)
+{
+	struct list_head *me_head = &me->vrf_list;
+	struct net_vrf *vrf;
+
+	if (list_empty(me_head))
+		return -ENODEV;
+
+	vrf = list_first_entry(me_head, struct net_vrf, me_list);
+
+	return vrf->ifindex;
+}
+
 static struct vrf_map_elem *vrf_map_elem_alloc(gfp_t flags)
 {
 	struct vrf_map_elem *me;
@@ -384,6 +397,34 @@ static void vrf_map_unregister_dev(struct net_device *dev)
 	vrf_map_unlock(vmap);
 }
 
+/* return the vrf device index associated with the table_id */
+static int vrf_ifindex_lookup_by_table_id(struct net *net, u32 table_id)
+{
+	struct vrf_map *vmap = netns_vrf_map(net);
+	struct vrf_map_elem *me;
+	int ifindex;
+
+	vrf_map_lock(vmap);
+
+	if (!vmap->strict_mode) {
+		ifindex = -EPERM;
+		goto unlock;
+	}
+
+	me = vrf_map_lookup_elem(vmap, table_id);
+	if (!me) {
+		ifindex = -ENODEV;
+		goto unlock;
+	}
+
+	ifindex = vrf_map_elem_get_vrf_ifindex(me);
+
+unlock:
+	vrf_map_unlock(vmap);
+
+	return ifindex;
+}
+
 /* by default VRF devices do not have a qdisc and are expected
  * to be created with only a single queue.
  */
@@ -1847,14 +1888,24 @@ static int __init vrf_init_module(void)
 	if (rc < 0)
 		goto error;
 
+	rc = l3mdev_table_lookup_register(L3MDEV_TYPE_VRF,
+					  vrf_ifindex_lookup_by_table_id);
+	if (rc < 0)
+		goto unreg_pernet;
+
 	rc = rtnl_link_register(&vrf_link_ops);
-	if (rc < 0) {
-		unregister_pernet_subsys(&vrf_net_ops);
-		goto error;
-	}
+	if (rc < 0)
+		goto table_lookup_unreg;
 
 	return 0;
 
+table_lookup_unreg:
+	l3mdev_table_lookup_unregister(L3MDEV_TYPE_VRF,
+				       vrf_ifindex_lookup_by_table_id);
+
+unreg_pernet:
+	unregister_pernet_subsys(&vrf_net_ops);
+
 error:
 	unregister_netdevice_notifier(&vrf_notifier_block);
 	return rc;
-- 
2.20.1

