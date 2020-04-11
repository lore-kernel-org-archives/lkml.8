Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345D0C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F389720692
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgDKIKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 04:10:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:3484 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgDKIKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 04:10:38 -0400
IronPort-SDR: BbxX/Gm3xpbUF6RkpEMhLDUsLcTT8vgp4qf8XfNA3tc9r+X9mL6k8uBw0OJj80DSN3GxG5nBW7
 JEF5klVrOCgw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2020 01:10:38 -0700
IronPort-SDR: OFYLeGWSwmGr57fU7XE5QbyLNfxls8VJu67utXeO/4BUkHhUq/V1H2MUOT+mR5Hs5wP56WVtxp
 nP4N26ZcUS6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,370,1580803200"; 
   d="scan'208";a="287404806"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Apr 2020 01:10:36 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jNBDn-0009Vj-V4; Sat, 11 Apr 2020 16:10:35 +0800
Date:   Sat, 11 Apr 2020 16:10:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: fs/btrfs/root-tree.c:259:7: warning: Variable 'err' is reassigned a
 value before the old one has been used. [redundantAssignment]
Message-ID: <202004111601.8gRSOGoQ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ab6f762f0f53162d41497708b33c9a3236d3609e
commit: e59d18b45d081d66a2fb1a9d144fa82d4807b18d btrfs: make btrfs_find_orphan_roots use btrfs_get_fs_root
date:   3 weeks ago

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> fs/btrfs/root-tree.c:259:7: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
     err = PTR_ERR_OR_ZERO(root);
         ^
   fs/btrfs/root-tree.c:242:9: note: err is assigned
       err = ret;
           ^
   fs/btrfs/root-tree.c:259:7: note: err is overwritten
     err = PTR_ERR_OR_ZERO(root);
         ^
   fs/btrfs/root-tree.c:212:24: warning: The scope of the variable 'leaf' can be reduced. [variableScope]
    struct extent_buffer *leaf;
                          ^
   fs/btrfs/root-tree.c:218:6: warning: The scope of the variable 'ret' can be reduced. [variableScope]
    int ret;
        ^
   fs/btrfs/root-tree.c:451:22: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
    if (!(inode_flags & BTRFS_INODE_ROOT_ITEM_INIT)) {
                        ^
   fs/btrfs/root-tree.c:452:18: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
     inode_flags |= BTRFS_INODE_ROOT_ITEM_INIT;
                    ^

vim +/err +259 fs/btrfs/root-tree.c

3768f3689fc76e Chris Mason  2007-03-13  208  
6bccf3ab1e1f09 Jeff Mahoney 2016-06-21  209  int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
76dda93c6ae2c1 Yan, Zheng   2009-09-21  210  {
6bccf3ab1e1f09 Jeff Mahoney 2016-06-21  211  	struct btrfs_root *tree_root = fs_info->tree_root;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  212  	struct extent_buffer *leaf;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  213  	struct btrfs_path *path;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  214  	struct btrfs_key key;
d68fc57b7e3245 Yan, Zheng   2010-05-16  215  	struct btrfs_key root_key;
d68fc57b7e3245 Yan, Zheng   2010-05-16  216  	struct btrfs_root *root;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  217  	int err = 0;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  218  	int ret;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  219  
76dda93c6ae2c1 Yan, Zheng   2009-09-21  220  	path = btrfs_alloc_path();
76dda93c6ae2c1 Yan, Zheng   2009-09-21  221  	if (!path)
76dda93c6ae2c1 Yan, Zheng   2009-09-21  222  		return -ENOMEM;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  223  
76dda93c6ae2c1 Yan, Zheng   2009-09-21  224  	key.objectid = BTRFS_ORPHAN_OBJECTID;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  225  	key.type = BTRFS_ORPHAN_ITEM_KEY;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  226  	key.offset = 0;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  227  
d68fc57b7e3245 Yan, Zheng   2010-05-16  228  	root_key.type = BTRFS_ROOT_ITEM_KEY;
d68fc57b7e3245 Yan, Zheng   2010-05-16  229  	root_key.offset = (u64)-1;
d68fc57b7e3245 Yan, Zheng   2010-05-16  230  
76dda93c6ae2c1 Yan, Zheng   2009-09-21  231  	while (1) {
76dda93c6ae2c1 Yan, Zheng   2009-09-21  232  		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
76dda93c6ae2c1 Yan, Zheng   2009-09-21  233  		if (ret < 0) {
76dda93c6ae2c1 Yan, Zheng   2009-09-21  234  			err = ret;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  235  			break;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  236  		}
76dda93c6ae2c1 Yan, Zheng   2009-09-21  237  
76dda93c6ae2c1 Yan, Zheng   2009-09-21  238  		leaf = path->nodes[0];
76dda93c6ae2c1 Yan, Zheng   2009-09-21  239  		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
76dda93c6ae2c1 Yan, Zheng   2009-09-21  240  			ret = btrfs_next_leaf(tree_root, path);
76dda93c6ae2c1 Yan, Zheng   2009-09-21  241  			if (ret < 0)
76dda93c6ae2c1 Yan, Zheng   2009-09-21  242  				err = ret;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  243  			if (ret != 0)
76dda93c6ae2c1 Yan, Zheng   2009-09-21  244  				break;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  245  			leaf = path->nodes[0];
76dda93c6ae2c1 Yan, Zheng   2009-09-21  246  		}
76dda93c6ae2c1 Yan, Zheng   2009-09-21  247  
76dda93c6ae2c1 Yan, Zheng   2009-09-21  248  		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
b3b4aa74b58bde David Sterba 2011-04-21  249  		btrfs_release_path(path);
76dda93c6ae2c1 Yan, Zheng   2009-09-21  250  
76dda93c6ae2c1 Yan, Zheng   2009-09-21  251  		if (key.objectid != BTRFS_ORPHAN_OBJECTID ||
76dda93c6ae2c1 Yan, Zheng   2009-09-21  252  		    key.type != BTRFS_ORPHAN_ITEM_KEY)
76dda93c6ae2c1 Yan, Zheng   2009-09-21  253  			break;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  254  
d68fc57b7e3245 Yan, Zheng   2010-05-16  255  		root_key.objectid = key.offset;
d68fc57b7e3245 Yan, Zheng   2010-05-16  256  		key.offset++;
d68fc57b7e3245 Yan, Zheng   2010-05-16  257  
e59d18b45d081d Josef Bacik  2020-01-24  258  		root = btrfs_get_fs_root(fs_info, &root_key, false);
886322e8e78760 Sachin Kamat 2014-02-17 @259  		err = PTR_ERR_OR_ZERO(root);
68a7342c51c950 Josef Bacik  2013-06-27  260  		if (err && err != -ENOENT) {
68a7342c51c950 Josef Bacik  2013-06-27  261  			break;
68a7342c51c950 Josef Bacik  2013-06-27  262  		} else if (err == -ENOENT) {
68a7342c51c950 Josef Bacik  2013-06-27  263  			struct btrfs_trans_handle *trans;
68a7342c51c950 Josef Bacik  2013-06-27  264  
68a7342c51c950 Josef Bacik  2013-06-27  265  			btrfs_release_path(path);
68a7342c51c950 Josef Bacik  2013-06-27  266  
68a7342c51c950 Josef Bacik  2013-06-27  267  			trans = btrfs_join_transaction(tree_root);
68a7342c51c950 Josef Bacik  2013-06-27  268  			if (IS_ERR(trans)) {
68a7342c51c950 Josef Bacik  2013-06-27  269  				err = PTR_ERR(trans);
0b246afa62b0cf Jeff Mahoney 2016-06-22  270  				btrfs_handle_fs_error(fs_info, err,
5d163e0e68ce74 Jeff Mahoney 2016-09-20  271  					    "Failed to start trans to delete orphan item");
cb517eabba4f10 Miao Xie     2013-05-15  272  				break;
cb517eabba4f10 Miao Xie     2013-05-15  273  			}
68a7342c51c950 Josef Bacik  2013-06-27  274  			err = btrfs_del_orphan_item(trans, tree_root,
68a7342c51c950 Josef Bacik  2013-06-27  275  						    root_key.objectid);
3a45bb207ee2c5 Jeff Mahoney 2016-09-09  276  			btrfs_end_transaction(trans);
68a7342c51c950 Josef Bacik  2013-06-27  277  			if (err) {
0b246afa62b0cf Jeff Mahoney 2016-06-22  278  				btrfs_handle_fs_error(fs_info, err,
5d163e0e68ce74 Jeff Mahoney 2016-09-20  279  					    "Failed to delete root orphan item");
68a7342c51c950 Josef Bacik  2013-06-27  280  				break;
68a7342c51c950 Josef Bacik  2013-06-27  281  			}
68a7342c51c950 Josef Bacik  2013-06-27  282  			continue;
68a7342c51c950 Josef Bacik  2013-06-27  283  		}
cb517eabba4f10 Miao Xie     2013-05-15  284  
e59d18b45d081d Josef Bacik  2020-01-24  285  		WARN_ON(!test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state));
78c52d9eb6b7ac Josef Bacik  2019-02-06  286  		if (btrfs_root_refs(&root->root_item) == 0) {
78c52d9eb6b7ac Josef Bacik  2019-02-06  287  			set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
14927d95464956 Miao Xie     2013-09-25  288  			btrfs_add_dead_root(root);
76dda93c6ae2c1 Yan, Zheng   2009-09-21  289  		}
78c52d9eb6b7ac Josef Bacik  2019-02-06  290  	}
76dda93c6ae2c1 Yan, Zheng   2009-09-21  291  
76dda93c6ae2c1 Yan, Zheng   2009-09-21  292  	btrfs_free_path(path);
76dda93c6ae2c1 Yan, Zheng   2009-09-21  293  	return err;
76dda93c6ae2c1 Yan, Zheng   2009-09-21  294  }
76dda93c6ae2c1 Yan, Zheng   2009-09-21  295  

:::::: The code at line 259 was first introduced by commit
:::::: 886322e8e787604731e782d36c34327a8970bda9 btrfs: Use PTR_ERR_OR_ZERO

:::::: TO: Sachin Kamat <sachin.kamat@linaro.org>
:::::: CC: Josef Bacik <jbacik@fb.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
