Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B43C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 13:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AE720823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590326896;
	bh=gJTSLYRW+2rx99s8hbfszTFJABJKrpxA1GXRlTnBwO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d9TCJeLDcMBhloBsPiQoutCBkEdU0HsJdzrFAiMB0WseERE2VjKdNL3BS85LMID4q
	 6DqhlQXbMGa/XJtoxRWnjhD1NxwNba5ztv6z/ZpME1l86nebUyiECPQpkwNsQhPIPx
	 bVoAFNbzdHZFE6heeK8piGR0t5nAExOIXAAzIzzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgEXN2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 09:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:32806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgEXN2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 09:28:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C04207FB;
        Sun, 24 May 2020 13:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590326894;
        bh=gJTSLYRW+2rx99s8hbfszTFJABJKrpxA1GXRlTnBwO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=epBMyA7oX3D69xEByPAPRLqnjd6WkI6JmL87hss1ZCnPkhShoIXJvJmYB85YRxAYF
         P4gztPr99Aniu3f7+9vw84T5xLqRkIo+QQwbkq+nxCVRKLmbPmmWEFDXtfEexq4VRC
         n3RzXD+qUgTvOZWpGfjhQA9ikYAWRS8ogiL1ivZw=
Date:   Sun, 24 May 2020 15:28:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
Message-ID: <20200524132812.GA2401@kroah.com>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
 <20200523153643.GA226270@kroah.com>
 <7a5e4740-8099-ef70-776f-0d92ce84ab3d@infradead.org>
 <20200524125727.GA2430@kroah.com>
 <20200524131405.GA24073@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524131405.GA24073@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 03:14:05PM +0200, Greg Kroah-Hartman wrote:
> On Sun, May 24, 2020 at 02:57:27PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, May 23, 2020 at 08:44:06AM -0700, Randy Dunlap wrote:
> > > On 5/23/20 8:36 AM, Greg Kroah-Hartman wrote:
> > > > On Wed, May 13, 2020 at 06:18:40PM +0300, Heikki Krogerus wrote:
> > > >> In the function kobject_cleanup(), kobject_del(kobj) is
> > > >> called before the kobj->release(). That makes it possible to
> > > >> release the parent of the kobject before the kobject itself.
> > > >>
> > > >> To fix that, adding function __kboject_del() that does
> > > >> everything that kobject_del() does except release the parent
> > > >> reference. kobject_cleanup() then calls __kobject_del()
> > > >> instead of kobject_del(), and separately decrements the
> > > >> reference count of the parent kobject after kobj->release()
> > > >> has been called.
> > > >>
> > > >> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > > >> Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > >> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> > > >> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> > > >> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > >> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > > >> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> > > >> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > > >> ---
> > > >>  lib/kobject.c | 30 ++++++++++++++++++++----------
> > > >>  1 file changed, 20 insertions(+), 10 deletions(-)
> > > > 
> > > > Stepping back, now that it turns out this patch causes more problems
> > > > than it fixes, how is everyone reproducing the original crash here?
> > > 
> > > Just load lib/test_printf.ko and boom!
> > 
> > Thanks, that helps.
> > 
> > Ok, in messing around with the kobject core more, originally we thought
> > this was an issue of the kobject uevent happening for the parent pointer
> > (when the parent was invalid).  so, moving things around some more, and
> > now I'm crashing in software_node_release() when we are trying to access
> > swnode->parent->child_ids as parent is invalid there.
> > 
> > So I feel like this is a swnode bug, or a use of swnode in a way it
> > shouldn't be that the testing framework is exposing somehow.
> > 
> > Let me dig deeper...
> 
> Ah, ick, static software nodes trying to be cleaned up in the totally
> wrong order.  You can't just try to randomly clean up a kobject anywhere
> in the middle of the hierarchy, that's flat out not going to work
> properly.  let me unwind it...

Ok, the patch below fixes the test, there's not really anything wrong
with the kobject core, except maybe the kobject uevent for removal,
which I'll send a patch for.

I'll write these up as a real set of patches after a bit.

thanks,

greg k-h

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index de8d3543e8fe..34bc2bbb3ada 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -715,14 +715,10 @@ EXPORT_SYMBOL_GPL(software_node_register_nodes);
  */
 void software_node_unregister_nodes(const struct software_node *nodes)
 {
-	struct swnode *swnode;
 	int i;
 
-	for (i = 0; nodes[i].name; i++) {
-		swnode = software_node_to_swnode(&nodes[i]);
-		if (swnode)
-			fwnode_remove_software_node(&swnode->fwnode);
-	}
+	for (i = 0; nodes[i].name; i++)
+		software_node_unregister(&nodes[i]);
 }
 EXPORT_SYMBOL_GPL(software_node_unregister_nodes);
 
@@ -741,6 +737,20 @@ int software_node_register(const struct software_node *node)
 }
 EXPORT_SYMBOL_GPL(software_node_register);
 
+/**
+ * software_node_unregister - Unregister static software node
+ * @node: The software node to be unregistered
+ */
+void software_node_unregister(const struct software_node *node)
+{
+	struct swnode *swnode;
+
+	swnode = software_node_to_swnode(node);
+	if (swnode)
+		fwnode_remove_software_node(&swnode->fwnode);
+}
+EXPORT_SYMBOL_GPL(software_node_unregister);
+
 struct fwnode_handle *
 fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent)
diff --git a/include/linux/property.h b/include/linux/property.h
index d86de017c689..0d4099b4ce1f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -441,6 +441,7 @@ int software_node_register_nodes(const struct software_node *nodes);
 void software_node_unregister_nodes(const struct software_node *nodes);
 
 int software_node_register(const struct software_node *node);
+void software_node_unregister(const struct software_node *node);
 
 int software_node_notify(struct device *dev, unsigned long action);
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 6b1622f4d7c2..b320c733af70 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -637,7 +637,9 @@ static void __init fwnode_pointer(void)
 	test(second_name, "%pfwP", software_node_fwnode(&softnodes[1]));
 	test(third_name, "%pfwP", software_node_fwnode(&softnodes[2]));
 
-	software_node_unregister_nodes(softnodes);
+	software_node_unregister(&softnodes[2]);
+	software_node_unregister(&softnodes[1]);
+	software_node_unregister(&softnodes[0]);
 }
 
 static void __init
