Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82800C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543372245C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHEHkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:40:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:13869 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgHEHkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:40:02 -0400
IronPort-SDR: 5Pj+z316ODsSk87C/MycvjGPrrrRVOXPlqhpPn9zLTAgjTW45iyAuEY/p104VVmHZ8EJxQ/5R0
 ETwyp4YxylBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="214018100"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="214018100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 00:40:00 -0700
IronPort-SDR: kH1XijtNeKIHpD61Gnb+2ewAXmBQr/n3jigN5KVE59oJSabs/SoMUdGDP1Wyc4JG8HkbKjNuAn
 dBasimdJfj6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="332760739"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2020 00:39:46 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3E1Z-0000eW-Vy; Wed, 05 Aug 2020 07:39:45 +0000
Date:   Wed, 5 Aug 2020 15:38:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: fs/notify/fanotify/fanotify_user.c:370:3: warning: Assignment of
 function parameter has no effect outside the function. Did you forget
 dereferencing
Message-ID: <202008051540.zMO6UY7G%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4da9f3302615f4191814f826054846bf843e24fa
commit: 44d705b0370b1d581f46ff23e5d33e8b5ff8ec58 fanotify: report name info for FAN_DIR_MODIFY event
date:   4 months ago
compiler: nds32le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> fs/notify/fanotify/fanotify_user.c:370:3: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
     buf += ret;
     ^
>> fs/notify/fanotify/fanotify_user.c:371:3: warning: Assignment of function parameter has no effect outside the function. [uselessAssignmentArg]
     count -= ret;
     ^
   fs/notify/fanotify/fanotify_user.c:426:8: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
      ret = -ERESTARTSYS;
          ^
   fs/notify/fanotify/fanotify_user.c:422:8: note: Variable 'ret' is reassigned a value before the old one has been used.
      ret = -EAGAIN;
          ^
   fs/notify/fanotify/fanotify_user.c:426:8: note: Variable 'ret' is reassigned a value before the old one has been used.
      ret = -ERESTARTSYS;
          ^
   fs/notify/fanotify/fanotify_user.c:613:7: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
     ret = -ENOTDIR;
         ^
   fs/notify/fanotify/fanotify_user.c:609:7: note: Variable 'ret' is reassigned a value before the old one has been used.
     ret = -EBADF;
         ^
   fs/notify/fanotify/fanotify_user.c:613:7: note: Variable 'ret' is reassigned a value before the old one has been used.
     ret = -ENOTDIR;
         ^
   fs/notify/fanotify/fanotify_user.c:637:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = inode_permission(path->dentry->d_inode, MAY_READ);
        ^
   fs/notify/fanotify/fanotify_user.c:613:7: note: Variable 'ret' is reassigned a value before the old one has been used.
     ret = -ENOTDIR;
         ^
   fs/notify/fanotify/fanotify_user.c:637:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = inode_permission(path->dentry->d_inode, MAY_READ);
        ^
   fs/notify/fanotify/fanotify_user.c:945:5: warning: Variable 'fd' is reassigned a value before the old one has been used. [redundantAssignment]
    fd = anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_flags);
       ^
   fs/notify/fanotify/fanotify_user.c:922:6: note: Variable 'fd' is reassigned a value before the old one has been used.
     fd = -EPERM;
        ^
   fs/notify/fanotify/fanotify_user.c:945:5: note: Variable 'fd' is reassigned a value before the old one has been used.
    fd = anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_flags);
       ^
   fs/notify/fanotify/fanotify_user.c:945:5: warning: Variable 'fd' is reassigned a value before the old one has been used. [redundantAssignment]
    fd = anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_flags);
       ^
   fs/notify/fanotify/fanotify_user.c:931:6: note: Variable 'fd' is reassigned a value before the old one has been used.
     fd = -EPERM;
        ^
   fs/notify/fanotify/fanotify_user.c:945:5: note: Variable 'fd' is reassigned a value before the old one has been used.
    fd = anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_flags);
       ^
   fs/notify/fanotify/fanotify_user.c:945:5: warning: Variable 'fd' is reassigned a value before the old one has been used. [redundantAssignment]
    fd = anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_flags);
       ^
   fs/notify/fanotify/fanotify_user.c:940:6: note: Variable 'fd' is reassigned a value before the old one has been used.
     fd = -EPERM;
        ^
   fs/notify/fanotify/fanotify_user.c:945:5: note: Variable 'fd' is reassigned a value before the old one has been used.
    fd = anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_flags);
       ^
   fs/notify/fanotify/fanotify_user.c:1086:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = -EINVAL;
        ^
   fs/notify/fanotify/fanotify_user.c:1077:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = -EINVAL;
        ^
   fs/notify/fanotify/fanotify_user.c:1086:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = -EINVAL;
        ^
   fs/notify/fanotify/fanotify_user.c:1114:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = fanotify_find_path(dfd, pathname, &path, flags,
        ^
   fs/notify/fanotify/fanotify_user.c:1086:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = -EINVAL;
        ^
   fs/notify/fanotify/fanotify_user.c:1114:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = fanotify_find_path(dfd, pathname, &path, flags,
        ^

vim +370 fs/notify/fanotify/fanotify_user.c

   301	
   302	static ssize_t copy_event_to_user(struct fsnotify_group *group,
   303					  struct fanotify_event *event,
   304					  char __user *buf, size_t count)
   305	{
   306		struct fanotify_event_metadata metadata;
   307		struct path *path = fanotify_event_path(event);
   308		struct file *f = NULL;
   309		int ret, fd = FAN_NOFD;
   310	
   311		pr_debug("%s: group=%p event=%p\n", __func__, group, event);
   312	
   313		metadata.event_len = FAN_EVENT_METADATA_LEN +
   314						fanotify_event_info_len(event);
   315		metadata.metadata_len = FAN_EVENT_METADATA_LEN;
   316		metadata.vers = FANOTIFY_METADATA_VERSION;
   317		metadata.reserved = 0;
   318		metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
   319		metadata.pid = pid_vnr(event->pid);
   320	
   321		if (path && path->mnt && path->dentry) {
   322			fd = create_fd(group, path, &f);
   323			if (fd < 0)
   324				return fd;
   325		}
   326		metadata.fd = fd;
   327	
   328		ret = -EFAULT;
   329		/*
   330		 * Sanity check copy size in case get_one_event() and
   331		 * fill_event_metadata() event_len sizes ever get out of sync.
   332		 */
   333		if (WARN_ON_ONCE(metadata.event_len > count))
   334			goto out_close_fd;
   335	
   336		if (copy_to_user(buf, &metadata, FAN_EVENT_METADATA_LEN))
   337			goto out_close_fd;
   338	
   339		buf += FAN_EVENT_METADATA_LEN;
   340		count -= FAN_EVENT_METADATA_LEN;
   341	
   342		if (fanotify_is_perm_event(event->mask))
   343			FANOTIFY_PERM(event)->fd = fd;
   344	
   345		if (f)
   346			fd_install(fd, f);
   347	
   348		/* Event info records order is: dir fid + name, child fid */
   349		if (fanotify_event_name_len(event)) {
   350			struct fanotify_name_event *fne = FANOTIFY_NE(event);
   351	
   352			ret = copy_info_to_user(fanotify_event_fsid(event),
   353						fanotify_event_dir_fh(event),
   354						fne->name, fne->name_len,
   355						buf, count);
   356			if (ret < 0)
   357				return ret;
   358	
   359			buf += ret;
   360			count -= ret;
   361		}
   362	
   363		if (fanotify_event_object_fh_len(event)) {
   364			ret = copy_info_to_user(fanotify_event_fsid(event),
   365						fanotify_event_object_fh(event),
   366						NULL, 0, buf, count);
   367			if (ret < 0)
   368				return ret;
   369	
 > 370			buf += ret;
 > 371			count -= ret;
   372		}
   373	
   374		return metadata.event_len;
   375	
   376	out_close_fd:
   377		if (fd != FAN_NOFD) {
   378			put_unused_fd(fd);
   379			fput(f);
   380		}
   381		return ret;
   382	}
   383	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
