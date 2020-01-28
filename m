Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A25C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD15024681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgA1SNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:13:47 -0500
Received: from gentwo.org ([3.19.106.255]:56214 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgA1SNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:13:47 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 916443F25D; Tue, 28 Jan 2020 18:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 9043D3F25C;
        Tue, 28 Jan 2020 18:13:46 +0000 (UTC)
Date:   Tue, 28 Jan 2020 18:13:46 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     =?ISO-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
In-Reply-To: <20200128085107.GF17425@blackbody.suse.cz>
Message-ID: <alpine.DEB.2.21.2001281813130.745@www.lameter.com>
References: <alpine.DEB.2.21.1912041652410.29709@www.lameter.com> <20191204173224.GN25242@dhcp22.suse.cz> <20200106115733.GH12699@dhcp22.suse.cz> <alpine.DEB.2.21.2001061550270.23163@www.lameter.com> <20200109145236.GS4951@dhcp22.suse.cz>
 <20200109114415.cf01bd3ad30c5c4aec981653@linux-foundation.org> <20200117171331.GA17179@blackbody.suse.cz> <20200118161528.94dc18c074aeaa384200486b@linux-foundation.org> <20200127173336.GB17425@blackbody.suse.cz> <alpine.DEB.2.21.2001272304080.25307@www.lameter.com>
 <20200128085107.GF17425@blackbody.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="531401748-1203551302-1580235226=:745"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--531401748-1203551302-1580235226=:745
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 28 Jan 2020, Michal Koutný wrote:

> On Mon, Jan 27, 2020 at 11:04:53PM +0000, Christopher Lameter <cl@linux.com> wrote:
> > The patch exposes details of cgroup caches? Which patch are we talking
> > about?
> Sorry, that's misunderstanding. I mean the current state (sending
> uevents) exposes the internals (creation of caches per cgroup). The
> patch [1] removing uevent notifications is rectifying it.


From: Christoph Lameter <cl@linux.com>
Subject: slub: Remove userspace notifier for cache add/remove

Kmem caches are internal kernel structures so it is strange that
userspace notifiers would be needed. And I am not aware of any use
of these notifiers. These notifiers may just exist because in the
initial slub release the sysfs code was copied from another
subsystem.

Signed-off-by: Christoph Lameter <cl@linux.com>

Index: linux/mm/slub.c
===================================================================
--- linux.orig/mm/slub.c	2020-01-28 18:13:02.134506141 +0000
+++ linux/mm/slub.c	2020-01-28 18:13:02.134506141 +0000
@@ -5632,19 +5632,6 @@ static struct kobj_type slab_ktype = {
 	.release = kmem_cache_release,
 };

-static int uevent_filter(struct kset *kset, struct kobject *kobj)
-{
-	struct kobj_type *ktype = get_ktype(kobj);
-
-	if (ktype == &slab_ktype)
-		return 1;
-	return 0;
-}
-
-static const struct kset_uevent_ops slab_uevent_ops = {
-	.filter = uevent_filter,
-};
-
 static struct kset *slab_kset;

 static inline struct kset *cache_kset(struct kmem_cache *s)
@@ -5712,7 +5699,6 @@ static void sysfs_slab_remove_workfn(str
 #ifdef CONFIG_MEMCG
 	kset_unregister(s->memcg_kset);
 #endif
-	kobject_uevent(&s->kobj, KOBJ_REMOVE);
 out:
 	kobject_put(&s->kobj);
 }
@@ -5770,7 +5756,6 @@ static int sysfs_slab_add(struct kmem_ca
 	}
 #endif

-	kobject_uevent(&s->kobj, KOBJ_ADD);
 	if (!unmergeable) {
 		/* Setup first alias */
 		sysfs_slab_alias(s, s->name);
@@ -5851,7 +5836,7 @@ static int __init slab_sysfs_init(void)

 	mutex_lock(&slab_mutex);

-	slab_kset = kset_create_and_add("slab", &slab_uevent_ops, kernel_kobj);
+	slab_kset = kset_create_and_add("slab", NULL, kernel_kobj);
 	if (!slab_kset) {
 		mutex_unlock(&slab_mutex);
 		pr_err("Cannot register slab subsystem.\n");
--531401748-1203551302-1580235226=:745--
