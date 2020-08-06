Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89C5C43618
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311FD22EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgHFK04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:26:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:9086 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbgHFKWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:22:04 -0400
IronPort-SDR: OwOrNdKo+gMIDT8Jmopwm7OEug3bhxSv8Ueyin2RSSHiF7vaO1GFCENgBzz3Jqfi2K43KDlqx8
 uK/j+8jfmdtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="152728007"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="152728007"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 03:21:32 -0700
IronPort-SDR: DOibyVrDWa5fh86oYt6dWfcQQ0nIGK3xu3k6eCZUovsBrTmuklRwz8StZwW44b24/mviuVg7xJ
 hOk3ilmZpmKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="289231281"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2020 03:21:30 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3d1d-0001EE-Ud; Thu, 06 Aug 2020 10:21:29 +0000
Date:   Thu, 6 Aug 2020 18:20:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: fs/exfat/namei.c:1297:6: warning: Variable 'ret' is reassigned a
 value before the old one has been used.
Message-ID: <202008061846.4E82tOUR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   47ec5303d73ea344e84f46660fff693c57641386
commit: b9d1e2e6265f5dc25e9f5dbfbde3e53d8a4958ac exfat: add Kconfig and Makefile
date:   5 months ago
compiler: ia64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> fs/exfat/namei.c:1297:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = exfat_resolve_path(new_parent_inode, new_path, &newdir,
        ^
   fs/exfat/namei.c:1260:7: note: Variable 'ret' is reassigned a value before the old one has been used.
     ret = -EIO;
         ^
   fs/exfat/namei.c:1297:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = exfat_resolve_path(new_parent_inode, new_path, &newdir,
        ^

vim +/ret +1297 fs/exfat/namei.c

5f2aa075070cf5 Namjae Jeon 2020-03-02  1214  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1215  /* rename or move a old file into a new file */
5f2aa075070cf5 Namjae Jeon 2020-03-02  1216  static int __exfat_rename(struct inode *old_parent_inode,
5f2aa075070cf5 Namjae Jeon 2020-03-02  1217  		struct exfat_inode_info *ei, struct inode *new_parent_inode,
5f2aa075070cf5 Namjae Jeon 2020-03-02  1218  		struct dentry *new_dentry)
5f2aa075070cf5 Namjae Jeon 2020-03-02  1219  {
5f2aa075070cf5 Namjae Jeon 2020-03-02  1220  	int ret;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1221  	int dentry;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1222  	struct exfat_chain olddir, newdir;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1223  	struct exfat_chain *p_dir = NULL;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1224  	struct exfat_uni_name uni_name;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1225  	struct exfat_dentry *ep;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1226  	struct super_block *sb = old_parent_inode->i_sb;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1227  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1228  	const unsigned char *new_path = new_dentry->d_name.name;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1229  	struct inode *new_inode = new_dentry->d_inode;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1230  	int num_entries;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1231  	struct exfat_inode_info *new_ei = NULL;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1232  	unsigned int new_entry_type = TYPE_UNUSED;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1233  	int new_entry = 0;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1234  	struct buffer_head *old_bh, *new_bh = NULL;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1235  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1236  	/* check the validity of pointer parameters */
5f2aa075070cf5 Namjae Jeon 2020-03-02  1237  	if (new_path == NULL || strlen(new_path) == 0)
5f2aa075070cf5 Namjae Jeon 2020-03-02  1238  		return -EINVAL;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1239  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1240  	if (ei->dir.dir == DIR_DELETED) {
5f2aa075070cf5 Namjae Jeon 2020-03-02  1241  		exfat_msg(sb, KERN_ERR,
5f2aa075070cf5 Namjae Jeon 2020-03-02  1242  				"abnormal access to deleted source dentry");
5f2aa075070cf5 Namjae Jeon 2020-03-02  1243  		return -ENOENT;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1244  	}
5f2aa075070cf5 Namjae Jeon 2020-03-02  1245  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1246  	exfat_update_parent_info(ei, old_parent_inode);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1247  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1248  	exfat_chain_dup(&olddir, &ei->dir);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1249  	dentry = ei->entry;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1250  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1251  	ep = exfat_get_dentry(sb, &olddir, dentry, &old_bh, NULL);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1252  	if (!ep) {
5f2aa075070cf5 Namjae Jeon 2020-03-02  1253  		ret = -EIO;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1254  		goto out;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1255  	}
5f2aa075070cf5 Namjae Jeon 2020-03-02  1256  	brelse(old_bh);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1257  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1258  	/* check whether new dir is existing directory and empty */
5f2aa075070cf5 Namjae Jeon 2020-03-02  1259  	if (new_inode) {
5f2aa075070cf5 Namjae Jeon 2020-03-02  1260  		ret = -EIO;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1261  		new_ei = EXFAT_I(new_inode);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1262  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1263  		if (new_ei->dir.dir == DIR_DELETED) {
5f2aa075070cf5 Namjae Jeon 2020-03-02  1264  			exfat_msg(sb, KERN_ERR,
5f2aa075070cf5 Namjae Jeon 2020-03-02  1265  				"abnormal access to deleted target dentry");
5f2aa075070cf5 Namjae Jeon 2020-03-02  1266  			goto out;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1267  		}
5f2aa075070cf5 Namjae Jeon 2020-03-02  1268  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1269  		exfat_update_parent_info(new_ei, new_parent_inode);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1270  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1271  		p_dir = &(new_ei->dir);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1272  		new_entry = new_ei->entry;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1273  		ep = exfat_get_dentry(sb, p_dir, new_entry, &new_bh, NULL);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1274  		if (!ep)
5f2aa075070cf5 Namjae Jeon 2020-03-02  1275  			goto out;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1276  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1277  		new_entry_type = exfat_get_entry_type(ep);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1278  		brelse(new_bh);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1279  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1280  		/* if new_inode exists, update ei */
5f2aa075070cf5 Namjae Jeon 2020-03-02  1281  		if (new_entry_type == TYPE_DIR) {
5f2aa075070cf5 Namjae Jeon 2020-03-02  1282  			struct exfat_chain new_clu;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1283  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1284  			new_clu.dir = new_ei->start_clu;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1285  			new_clu.size =
5f2aa075070cf5 Namjae Jeon 2020-03-02  1286  				EXFAT_B_TO_CLU_ROUND_UP(i_size_read(new_inode),
5f2aa075070cf5 Namjae Jeon 2020-03-02  1287  				sbi);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1288  			new_clu.flags = new_ei->flags;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1289  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1290  			ret = exfat_check_dir_empty(sb, &new_clu);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1291  			if (ret)
5f2aa075070cf5 Namjae Jeon 2020-03-02  1292  				goto out;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1293  		}
5f2aa075070cf5 Namjae Jeon 2020-03-02  1294  	}
5f2aa075070cf5 Namjae Jeon 2020-03-02  1295  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1296  	/* check the validity of directory name in the given new pathname */
5f2aa075070cf5 Namjae Jeon 2020-03-02 @1297  	ret = exfat_resolve_path(new_parent_inode, new_path, &newdir,
5f2aa075070cf5 Namjae Jeon 2020-03-02  1298  			&uni_name);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1299  	if (ret)
5f2aa075070cf5 Namjae Jeon 2020-03-02  1300  		goto out;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1301  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1302  	exfat_set_vol_flags(sb, VOL_DIRTY);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1303  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1304  	if (olddir.dir == newdir.dir)
5f2aa075070cf5 Namjae Jeon 2020-03-02  1305  		ret = exfat_rename_file(new_parent_inode, &olddir, dentry,
5f2aa075070cf5 Namjae Jeon 2020-03-02  1306  				&uni_name, ei);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1307  	else
5f2aa075070cf5 Namjae Jeon 2020-03-02  1308  		ret = exfat_move_file(new_parent_inode, &olddir, dentry,
5f2aa075070cf5 Namjae Jeon 2020-03-02  1309  				&newdir, &uni_name, ei);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1310  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1311  	if (!ret && new_inode) {
5f2aa075070cf5 Namjae Jeon 2020-03-02  1312  		/* delete entries of new_dir */
5f2aa075070cf5 Namjae Jeon 2020-03-02  1313  		ep = exfat_get_dentry(sb, p_dir, new_entry, &new_bh, NULL);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1314  		if (!ep) {
5f2aa075070cf5 Namjae Jeon 2020-03-02  1315  			ret = -EIO;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1316  			goto del_out;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1317  		}
5f2aa075070cf5 Namjae Jeon 2020-03-02  1318  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1319  		num_entries = exfat_count_ext_entries(sb, p_dir, new_entry, ep);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1320  		if (num_entries < 0) {
5f2aa075070cf5 Namjae Jeon 2020-03-02  1321  			ret = -EIO;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1322  			goto del_out;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1323  		}
5f2aa075070cf5 Namjae Jeon 2020-03-02  1324  		brelse(new_bh);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1325  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1326  		if (exfat_remove_entries(new_inode, p_dir, new_entry, 0,
5f2aa075070cf5 Namjae Jeon 2020-03-02  1327  				num_entries + 1)) {
5f2aa075070cf5 Namjae Jeon 2020-03-02  1328  			ret = -EIO;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1329  			goto del_out;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1330  		}
5f2aa075070cf5 Namjae Jeon 2020-03-02  1331  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1332  		/* Free the clusters if new_inode is a dir(as if exfat_rmdir) */
5f2aa075070cf5 Namjae Jeon 2020-03-02  1333  		if (new_entry_type == TYPE_DIR) {
5f2aa075070cf5 Namjae Jeon 2020-03-02  1334  			/* new_ei, new_clu_to_free */
5f2aa075070cf5 Namjae Jeon 2020-03-02  1335  			struct exfat_chain new_clu_to_free;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1336  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1337  			exfat_chain_set(&new_clu_to_free, new_ei->start_clu,
5f2aa075070cf5 Namjae Jeon 2020-03-02  1338  				EXFAT_B_TO_CLU_ROUND_UP(i_size_read(new_inode),
5f2aa075070cf5 Namjae Jeon 2020-03-02  1339  				sbi), new_ei->flags);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1340  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1341  			if (exfat_free_cluster(new_inode, &new_clu_to_free)) {
5f2aa075070cf5 Namjae Jeon 2020-03-02  1342  				/* just set I/O error only */
5f2aa075070cf5 Namjae Jeon 2020-03-02  1343  				ret = -EIO;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1344  			}
5f2aa075070cf5 Namjae Jeon 2020-03-02  1345  
5f2aa075070cf5 Namjae Jeon 2020-03-02  1346  			i_size_write(new_inode, 0);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1347  			new_ei->start_clu = EXFAT_EOF_CLUSTER;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1348  			new_ei->flags = ALLOC_NO_FAT_CHAIN;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1349  		}
5f2aa075070cf5 Namjae Jeon 2020-03-02  1350  del_out:
5f2aa075070cf5 Namjae Jeon 2020-03-02  1351  		/* Update new_inode ei
5f2aa075070cf5 Namjae Jeon 2020-03-02  1352  		 * Prevent syncing removed new_inode
5f2aa075070cf5 Namjae Jeon 2020-03-02  1353  		 * (new_ei is already initialized above code ("if (new_inode)")
5f2aa075070cf5 Namjae Jeon 2020-03-02  1354  		 */
5f2aa075070cf5 Namjae Jeon 2020-03-02  1355  		new_ei->dir.dir = DIR_DELETED;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1356  	}
5f2aa075070cf5 Namjae Jeon 2020-03-02  1357  	exfat_set_vol_flags(sb, VOL_CLEAN);
5f2aa075070cf5 Namjae Jeon 2020-03-02  1358  out:
5f2aa075070cf5 Namjae Jeon 2020-03-02  1359  	return ret;
5f2aa075070cf5 Namjae Jeon 2020-03-02  1360  }
5f2aa075070cf5 Namjae Jeon 2020-03-02  1361  

:::::: The code at line 1297 was first introduced by commit
:::::: 5f2aa075070cf5b2e6aae011d5a3390408d7d913 exfat: add inode operations

:::::: TO: Namjae Jeon <namjae.jeon@samsung.com>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
