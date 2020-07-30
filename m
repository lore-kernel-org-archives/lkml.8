Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671AEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA7820829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgG3MBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:01:16 -0400
Received: from relay.sw.ru ([185.231.240.75]:57134 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728665AbgG3MBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:01:09 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17Eu-0002zq-Q1; Thu, 30 Jul 2020 15:00:48 +0300
Subject: [PATCH 19/23] uts: Add uts namespaces into ns_idr
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:01:02 +0300
Message-ID: <159611046266.535980.16940792342033728104.stgit@localhost.localdomain>
In-Reply-To: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now they are exposed in /proc/namespace/ directory.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 kernel/utsname.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/utsname.c b/kernel/utsname.c
index aebf4df5f592..883855ca16cd 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -70,8 +70,16 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 	memcpy(&ns->name, &old_ns->name, sizeof(ns->name));
 	ns->user_ns = get_user_ns(user_ns);
 	up_read(&uts_sem);
+
+	err = ns_idr_register(&ns->ns);
+	if (err)
+		goto fail_put;
+
 	return ns;
 
+fail_put:
+	put_user_ns(user_ns);
+	ns_free_inum(&ns->ns);
 fail_free:
 	kmem_cache_free(uts_ns_cache, ns);
 fail_dec:
@@ -113,6 +121,7 @@ static void free_uts_ns_rcu(struct rcu_head *head)
 
 void free_uts_ns(struct uts_namespace *ns)
 {
+	ns_idr_unregister(&ns->ns);
 	dec_uts_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
@@ -182,4 +191,5 @@ void __init uts_ns_init(void)
 			offsetof(struct uts_namespace, name),
 			sizeof_field(struct uts_namespace, name),
 			NULL);
+	WARN_ON(ns_idr_register(&init_uts_ns.ns) < 0);
 }


