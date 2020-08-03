Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72782C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574EA20678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHCKQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:16:19 -0400
Received: from relay.sw.ru ([185.231.240.75]:37694 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbgHCKQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:16:19 -0400
Received: from [192.168.15.50] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k2XVb-0002NL-TL; Mon, 03 Aug 2020 13:15:55 +0300
Subject: [PATCH 1/8] ns: Add common refcount into ns_common add use it as
 counter for net_ns
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Mon, 03 Aug 2020 13:16:16 +0300
Message-ID: <159644977635.604812.1319877322927063560.stgit@localhost.localdomain>
In-Reply-To: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, every type of namespaces has its own counter,
which is stored in ns-specific part. Say, @net has
struct net::count, @pid has struct pid_namespace::kref, etc.

This patchset introduces unified counter for all types
of namespaces, and converts net namespace to use it first.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/ns_common.h     |    3 +++
 include/net/net_namespace.h   |   11 ++++-------
 net/core/net-sysfs.c          |    6 +++---
 net/core/net_namespace.c      |    6 +++---
 net/ipv4/inet_timewait_sock.c |    4 ++--
 net/ipv4/tcp_metrics.c        |    2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 5fbc4000358f..0f1d024bd958 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -2,12 +2,15 @@
 #ifndef _LINUX_NS_COMMON_H
 #define _LINUX_NS_COMMON_H
 
+#include <linux/refcount.h>
+
 struct proc_ns_operations;
 
 struct ns_common {
 	atomic_long_t stashed;
 	const struct proc_ns_operations *ops;
 	unsigned int inum;
+	refcount_t count;
 };
 
 #endif
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 2ee5901bec7a..cb4b33d7834b 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -60,9 +60,6 @@ struct net {
 	refcount_t		passive;	/* To decide when the network
 						 * namespace should be freed.
 						 */
-	refcount_t		count;		/* To decided when the network
-						 *  namespace should be shut down.
-						 */
 	spinlock_t		rules_mod_lock;
 
 	unsigned int		dev_unreg_count;
@@ -245,7 +242,7 @@ void __put_net(struct net *net);
 
 static inline struct net *get_net(struct net *net)
 {
-	refcount_inc(&net->count);
+	refcount_inc(&net->ns.count);
 	return net;
 }
 
@@ -256,14 +253,14 @@ static inline struct net *maybe_get_net(struct net *net)
 	 * exists.  If the reference count is zero this
 	 * function fails and returns NULL.
 	 */
-	if (!refcount_inc_not_zero(&net->count))
+	if (!refcount_inc_not_zero(&net->ns.count))
 		net = NULL;
 	return net;
 }
 
 static inline void put_net(struct net *net)
 {
-	if (refcount_dec_and_test(&net->count))
+	if (refcount_dec_and_test(&net->ns.count))
 		__put_net(net);
 }
 
@@ -275,7 +272,7 @@ int net_eq(const struct net *net1, const struct net *net2)
 
 static inline int check_net(const struct net *net)
 {
-	return refcount_read(&net->count) != 0;
+	return refcount_read(&net->ns.count) != 0;
 }
 
 void net_drop_ns(void *);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 9de33b594ff2..655a88b0071c 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1025,7 +1025,7 @@ net_rx_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
 	while (--i >= new_num) {
 		struct kobject *kobj = &dev->_rx[i].kobj;
 
-		if (!refcount_read(&dev_net(dev)->count))
+		if (!refcount_read(&dev_net(dev)->ns.count))
 			kobj->uevent_suppress = 1;
 		if (dev->sysfs_rx_queue_group)
 			sysfs_remove_group(kobj, dev->sysfs_rx_queue_group);
@@ -1603,7 +1603,7 @@ netdev_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
 	while (--i >= new_num) {
 		struct netdev_queue *queue = dev->_tx + i;
 
-		if (!refcount_read(&dev_net(dev)->count))
+		if (!refcount_read(&dev_net(dev)->ns.count))
 			queue->kobj.uevent_suppress = 1;
 #ifdef CONFIG_BQL
 		sysfs_remove_group(&queue->kobj, &dql_group);
@@ -1850,7 +1850,7 @@ void netdev_unregister_kobject(struct net_device *ndev)
 {
 	struct device *dev = &ndev->dev;
 
-	if (!refcount_read(&dev_net(ndev)->count))
+	if (!refcount_read(&dev_net(ndev)->ns.count))
 		dev_set_uevent_suppress(dev, 1);
 
 	kobject_get(&dev->kobj);
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index dcd61aca343e..5f658cbedd34 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -44,7 +44,7 @@ static struct key_tag init_net_key_domain = { .usage = REFCOUNT_INIT(1) };
 #endif
 
 struct net init_net = {
-	.count		= REFCOUNT_INIT(1),
+	.ns.count	= REFCOUNT_INIT(1),
 	.dev_base_head	= LIST_HEAD_INIT(init_net.dev_base_head),
 #ifdef CONFIG_KEYS
 	.key_domain	= &init_net_key_domain,
@@ -248,7 +248,7 @@ int peernet2id_alloc(struct net *net, struct net *peer, gfp_t gfp)
 {
 	int id;
 
-	if (refcount_read(&net->count) == 0)
+	if (refcount_read(&net->ns.count) == 0)
 		return NETNSA_NSID_NOT_ASSIGNED;
 
 	spin_lock(&net->nsid_lock);
@@ -328,7 +328,7 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 	int error = 0;
 	LIST_HEAD(net_exit_list);
 
-	refcount_set(&net->count, 1);
+	refcount_set(&net->ns.count, 1);
 	refcount_set(&net->passive, 1);
 	get_random_bytes(&net->hash_mix, sizeof(u32));
 	net->dev_base_seq = 1;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index c411c87ae865..437afe392e66 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -272,14 +272,14 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 				continue;
 			tw = inet_twsk(sk);
 			if ((tw->tw_family != family) ||
-				refcount_read(&twsk_net(tw)->count))
+				refcount_read(&twsk_net(tw)->ns.count))
 				continue;
 
 			if (unlikely(!refcount_inc_not_zero(&tw->tw_refcnt)))
 				continue;
 
 			if (unlikely((tw->tw_family != family) ||
-				     refcount_read(&twsk_net(tw)->count))) {
+				     refcount_read(&twsk_net(tw)->ns.count))) {
 				inet_twsk_put(tw);
 				goto restart;
 			}
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 279db8822439..39710c417565 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -887,7 +887,7 @@ static void tcp_metrics_flush_all(struct net *net)
 		pp = &hb->chain;
 		for (tm = deref_locked(*pp); tm; tm = deref_locked(*pp)) {
 			match = net ? net_eq(tm_net(tm), net) :
-				!refcount_read(&tm_net(tm)->count);
+				!refcount_read(&tm_net(tm)->ns.count);
 			if (match) {
 				*pp = tm->tcpm_next;
 				kfree_rcu(tm, rcu_head);


