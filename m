Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A99FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A222072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgETPCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:02:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:35668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETPCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:02:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2E4F8AC37;
        Wed, 20 May 2020 15:02:31 +0000 (UTC)
Date:   Wed, 20 May 2020 17:02:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, davidgow@google.com,
        Heidi Fahim <heidifahim@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] Revert "software node: Simplify
 software_node_release() function"
Message-ID: <20200520150227.GA8397@linux-b0ei>
References: <20200228000001.240428-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228000001.240428-1-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-02-27 16:00:01, Brendan Higgins wrote:
> This reverts commit 3df85a1ae51f6b256982fe9d17c2dc5bfb4cc402.
> 
> The reverted commit says "It's possible to release the node ID
> immediately when fwnode_remove_software_node() is called, no need to
> wait for software_node_release() with that." However, releasing the node
> ID before waiting for software_node_release() to be called causes the
> node ID to be released before the kobject and the underlying sysfs
> entry; this means there is a period of time where a sysfs entry exists
> that is associated with an unallocated node ID.
> 
> Once consequence of this is that there is a race condition where it is
> possible to call fwnode_create_software_node() with no parent node
> specified (NULL) and have it fail with -EEXIST because the node ID that
> was assigned is still associated with a stale sysfs entry that hasn't
> been cleaned up yet.
> 
> Although it is difficult to reproduce this race condition under normal
> conditions, it can be deterministically reproduced with the following
> minconfig on UML:
> 
> CONFIG_KUNIT_DRIVER_PE_TEST=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_OBJECTS=y
> CONFIG_DEBUG_OBJECTS_TIMERS=y
> CONFIG_DEBUG_KOBJECT_RELEASE=y
> CONFIG_KUNIT=y
> 
> Running the tests with this configuration causes the following failure:
> 
> <snip>
> kobject: 'node0' ((____ptrval____)): kobject_release, parent (____ptrval____) (delayed 400)
> 	ok 1 - pe_test_uints
> sysfs: cannot create duplicate filename '/kernel/software_nodes/node0'
> CPU: 0 PID: 28 Comm: kunit_try_catch Not tainted 5.6.0-rc3-next-20200227 #14
> <snip>
> kobject_add_internal failed for node0 with -EEXIST, don't try to register things with the same name in the same directory.
> kobject: 'node0' ((____ptrval____)): kobject_release, parent (____ptrval____) (delayed 100)
> 	# pe_test_uint_arrays: ASSERTION FAILED at drivers/base/test/property-entry-test.c:123
> 	Expected node is not error, but is: -17
> 	not ok 2 - pe_test_uint_arrays
> <snip>
> 
> Reported-by: Heidi Fahim <heidifahim@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/swnode.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 0b081dee1e95c..de8d3543e8fe3 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -608,6 +608,13 @@ static void software_node_release(struct kobject *kobj)
>  {
>  	struct swnode *swnode = kobj_to_swnode(kobj);
>  
> +	if (swnode->parent) {
> +		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
> +		list_del(&swnode->entry);
> +	} else {
> +		ida_simple_remove(&swnode_root_ids, swnode->id);
> +	}
> +
>  	if (swnode->allocated) {
>  		property_entries_free(swnode->node->properties);
>  		kfree(swnode->node);
> @@ -773,13 +780,6 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
>  	if (!swnode)
>  		return;
>  
> -	if (swnode->parent) {
> -		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
> -		list_del(&swnode->entry);
> -	} else {
> -		ida_simple_remove(&swnode_root_ids, swnode->id);
> -	}
> -
>  	kobject_put(&swnode->kobj);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_remove_software_node);


This patch breaks tests for %pfw printk modifier added by the commit
f1ce39df508de4a4abd83da ("lib/test_printf: Add tests for %pfw printk
modifier").

Steps to reproduce:

  + build with CONFIG_TEST_PRINTF
  + boot
  + modprobe test_printf

I get the following:

[   97.604868] test_printf: loaded.
[   97.606153] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   97.606186] #PF: supervisor read access in kernel mode
[   97.606206] #PF: error_code(0x0000) - not-present page
[   97.606227] PGD 0 P4D 0 
[   97.606245] Oops: 0000 [#1] SMP PTI
[   97.606265] CPU: 2 PID: 5125 Comm: modprobe Kdump: loaded Tainted: G            E     5.7.0-rc6-default+ #5064
[   97.606295] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-0-ga698c89-rebuilt.opensuse.org 04/01/2014
[   97.606356] RIP: 0010:ida_free+0x76/0x140
[   97.606376] Code: 00 00 48 c7 44 24 28 00 00 00 00 0f 88 c0 00 00 00 89 f3 e8 3c 13 60 00 48 89 e7 49 89 c5 e8 b1 fd 00 00 a8 01 48 89 c5 75 41 <4c> 0f a3 20 72 74 48 8b 3c 24 4c 89 ee e8 38 0c 60 00 89 de 48 c7
[   97.606428] RSP: 0018:ffffad38c045ba78 EFLAGS: 00010046
[   97.606448] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[   97.606472] RDX: 0000000000000000 RSI: ffff8dc5a6d87280 RDI: 0000000000000046
[   97.606501] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
[   97.606533] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   97.606564] R13: 0000000000000246 R14: ffffffffc0078948 R15: ffffad38c045be88
[   97.606600] FS:  00007f60f1834b80(0000) GS:ffff8dc5bfc00000(0000) knlGS:0000000000000000
[   97.606638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   97.606667] CR2: 0000000000000000 CR3: 0000000066eaa002 CR4: 0000000000360ee0
[   97.606711] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   97.606745] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   97.606780] Call Trace:
[   97.606874]  software_node_release+0x26/0xa0
[   97.606912]  kobject_put+0xa6/0x1b0
[   97.606945]  kobject_del+0x45/0x60
[   97.606974]  kobject_put+0x8b/0x1b0
[   97.607005]  software_node_unregister_nodes+0x25/0x40
[   97.607058]  test_pointer+0xbf6/0xc1e [test_printf]
[   97.607121]  ? test_pointer+0xc1e/0xc1e [test_printf]
[   97.607159]  test_printf_init+0x368/0x100c [test_printf]
[   97.607209]  do_one_initcall+0x5d/0x2f0
[   97.607269]  do_init_module+0x5b/0x226
[   97.607301]  load_module+0x1df5/0x2380
[   97.607373]  ? ima_post_read_file+0xef/0x130
[   97.607429]  ? __do_sys_finit_module+0xe9/0x110
[   97.607460]  __do_sys_finit_module+0xe9/0x110
[   97.607512]  do_syscall_64+0x60/0x280
[   97.607591]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[   97.607627] RIP: 0033:0x7f60f0f0a2a9
[   97.607654] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bf 0b 2c 00 f7 d8 64 89 01 48
[   97.607730] RSP: 002b:00007ffc9e4b37b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   97.607769] RAX: ffffffffffffffda RBX: 0000556a7a7507f0 RCX: 00007f60f0f0a2a9
[   97.607806] RDX: 0000000000000000 RSI: 0000556a79a11688 RDI: 0000000000000003
[   97.607841] RBP: 0000556a79a11688 R08: 0000000000000000 R09: 0000556a7a750410
[   97.607874] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000040000
[   97.607907] R13: 0000556a7a7507a0 R14: 0000000000000000 R15: 0000556a7a7507f0
[   97.607960] Modules linked in: test_printf(E+)
[   97.607995] CR2: 0000000000000000


I have found similar report from a test robot, see
https://lore.kernel.org/lkml/20200303002816.GW6548@shao2-debian/


I was staring into it for a while and do not understand it. The revert
makes sense. I wonder if it somehow changes the order in which
the release methods are called.

Anyway, reverting the revert makes test_printf working.

Best Regards,
Petr
