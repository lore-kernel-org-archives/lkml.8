Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2A8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE5D2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389286AbgE0Oem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:34:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55792 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389220AbgE0Oem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:34:42 -0400
Received: from 89-64-84-221.dynamic.chello.pl (89.64.84.221) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 05cf7ad9a5729f91; Wed, 27 May 2020 16:34:39 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] kobject: send KOBJ_REMOVE uevent when the object is removed from sysfs
Date:   Wed, 27 May 2020 16:34:38 +0200
Message-ID: <122364223.sG7U4uvVph@kreacher>
In-Reply-To: <2407984.idRd5kzSG0@kreacher>
References: <20200524153041.2361-1-gregkh@linuxfoundation.org> <CAJZ5v0h0Xjovm-eVyiOG+j7kNEPxB=PZF4rLVEgwUW+H+61DFg@mail.gmail.com> <2407984.idRd5kzSG0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 27, 2020 11:01:16 AM CEST Rafael J. Wysocki wrote:
> On Wednesday, May 27, 2020 10:34:51 AM CEST Rafael J. Wysocki wrote:
> > On Wed, May 27, 2020 at 9:50 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > On Tue, May 26, 2020 at 10:26:23AM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, May 26, 2020 at 7:58 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, May 25, 2020 at 03:49:01PM -0700, Dmitry Torokhov wrote:
> > > > > > On Sun, May 24, 2020 at 8:34 AM Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > It is possible for a KOBJ_REMOVE uevent to be sent to userspace way
> > > > > > > after the files are actually gone from sysfs, due to how reference
> > > > > > > counting for kobjects work.  This should not be a problem, but it would
> > > > > > > be good to properly send the information when things are going away, not
> > > > > > > at some later point in time in the future.
> > > > > > >
> > > > > > > Before this move, if a kobject's parent was torn down before the child,
> > > > > >
> > > > > > ^^^^ And this is the root of the problem and what has to be fixed.
> > > > >
> > > > > I fixed that in patch one of this series.  Turns out the user of the
> > > > > kobject was not even expecting that to happen.
> > > > >
> > > > > > > when the call to kobject_uevent() happened, the parent walk to try to
> > > > > > > reconstruct the full path of the kobject could be a total mess and cause
> > > > > > > crashes.  It's not good to try to tear down a kobject tree from top
> > > > > > > down, but let's at least try to not to crash if a user does so.
> > > > > >
> > > > > > One can try, but if we keep proper reference counting then kobject
> > > > > > core should take care of actually releasing objects in the right
> > > > > > order. I do not think you should keep this patch, and instead see if
> > > > > > we can push call to kobject_put(kobj->parent) into kobject_cleanup().
> > > > >
> > > > > I tried that, but there was a _lot_ of underflow errors reported, so
> > > > > there's something else happening.  Or my attempt was incorrect :)
> > > >
> > > > So it looks like there is something in there that's been overlooked so far.
> > > >
> > > > I'll try to look at the Guenter's traces and figure out what went
> > > > wrong after the Heikki's patch.
> > >
> > > At least one problem with that patch was that I was releasing the
> > > parent reference unconditionally.
> > 
> > That actually may be sufficient to explain all of the problems introduced by it.
> 
> So Guenter, can you please test the patch below

Which can also be done without adding the second local var in kobject_cleanup(),
as follows.

> to see if it still introduces the problems seen by you on ARM?

---
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] kobject: Make sure the parent does not get released before its children

In the function kobject_cleanup(), kobject_del(kobj) is
called before the kobj->release(). That makes it possible to
release the parent of the kobject before the kobject itself.

To fix that, adding function __kboject_del() that does
everything that kobject_del() does except release the parent
reference. kobject_cleanup() then calls __kobject_del()
instead of kobject_del(), and separately decrements the
reference count of the parent kobject after kobj->release()
has been called.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
[ rjw: Drop parent reference only when called __kobject_del() ]
Signed-off-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
---
 lib/kobject.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

Index: linux-pm/lib/kobject.c
===================================================================
--- linux-pm.orig/lib/kobject.c
+++ linux-pm/lib/kobject.c
@@ -599,14 +599,7 @@ out:
 }
 EXPORT_SYMBOL_GPL(kobject_move);
 
-/**
- * kobject_del() - Unlink kobject from hierarchy.
- * @kobj: object.
- *
- * This is the function that should be called to delete an object
- * successfully added via kobject_add().
- */
-void kobject_del(struct kobject *kobj)
+static void __kobject_del(struct kobject *kobj)
 {
 	struct kernfs_node *sd;
 	const struct kobj_type *ktype;
@@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
 
 	kobj->state_in_sysfs = 0;
 	kobj_kset_leave(kobj);
-	kobject_put(kobj->parent);
 	kobj->parent = NULL;
 }
+
+/**
+ * kobject_del() - Unlink kobject from hierarchy.
+ * @kobj: object.
+ *
+ * This is the function that should be called to delete an object
+ * successfully added via kobject_add().
+ */
+void kobject_del(struct kobject *kobj)
+{
+	struct kobject *parent = kobj->parent;
+
+	__kobject_del(kobj);
+	kobject_put(parent);
+}
 EXPORT_SYMBOL(kobject_del);
 
 /**
@@ -663,6 +670,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
  */
 static void kobject_cleanup(struct kobject *kobj)
 {
+	struct kobject *parent = kobj->parent;
 	struct kobj_type *t = get_ktype(kobj);
 	const char *name = kobj->name;
 
@@ -684,7 +692,10 @@ static void kobject_cleanup(struct kobje
 	if (kobj->state_in_sysfs) {
 		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
 			 kobject_name(kobj), kobj);
-		kobject_del(kobj);
+		__kobject_del(kobj);
+	} else {
+		/* avoid dropping the parent reference unnecessarily */
+		parent = NULL;
 	}
 
 	if (t && t->release) {
@@ -698,6 +709,8 @@ static void kobject_cleanup(struct kobje
 		pr_debug("kobject: '%s': free name\n", name);
 		kfree_const(name);
 	}
+
+	kobject_put(parent);
 }
 
 #ifdef CONFIG_DEBUG_KOBJECT_RELEASE



