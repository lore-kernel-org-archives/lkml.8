Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947BCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB7B207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgGSCaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 22:30:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:5164 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgGSCaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 22:30:05 -0400
IronPort-SDR: xvFeyC43uA2lW6UQh9PgjYWI2EDE28NXnie7aPq7rT8VE0RZxqcbz5COChQMs0osdltAGF/laJ
 SrIigK0oHkSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="147280826"
X-IronPort-AV: E=Sophos;i="5.75,369,1589266800"; 
   d="scan'208";a="147280826"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 19:30:05 -0700
IronPort-SDR: /kTK814oxi+sM4nrMDXIBaTcaxtMJtVHuYcku2WYpgac900uPx0yFJxL+F8XBnFsxbt+hiLjng
 3oWcX7rVPdqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,369,1589266800"; 
   d="scan'208";a="317687877"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2020 19:30:03 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwz5X-00011D-2P; Sun, 19 Jul 2020 02:30:03 +0000
Date:   Sun, 19 Jul 2020 10:29:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: fs/zonefs/super.c:1110:6: warning: Variable 'ret' is reassigned a
 value before the old one has been used.
Message-ID: <202007191013.4IvvVjHl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6cf7ccba29dcf39ab27630c383a3844078a6d5cd
commit: 8dcc1a9d90c10fa4143e5c17821082e5e60e46a1 fs: New zonefs file system
date:   5 months ago
compiler: gcc-9 (Debian 9.3.0-14) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> fs/zonefs/super.c:1110:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = 0;
        ^
   fs/zonefs/super.c:1045:0: note: Variable 'ret' is reassigned a value before the old one has been used.
    int ret = -ENOMEM;
   ^
   fs/zonefs/super.c:1110:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = 0;
        ^
   fs/zonefs/super.c:1257:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = 0;
        ^
   fs/zonefs/super.c:1210:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = -EINVAL;
        ^
   fs/zonefs/super.c:1257:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = 0;
        ^

vim +/ret +1110 fs/zonefs/super.c

  1031	
  1032	/*
  1033	 * Create a zone group and populate it with zone files.
  1034	 */
  1035	static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
  1036					enum zonefs_ztype type)
  1037	{
  1038		struct super_block *sb = zd->sb;
  1039		struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
  1040		struct blk_zone *zone, *next, *end;
  1041		const char *zgroup_name;
  1042		char *file_name;
  1043		struct dentry *dir;
  1044		unsigned int n = 0;
  1045		int ret = -ENOMEM;
  1046	
  1047		/* If the group is empty, there is nothing to do */
  1048		if (!zd->nr_zones[type])
  1049			return 0;
  1050	
  1051		file_name = kmalloc(ZONEFS_NAME_MAX, GFP_KERNEL);
  1052		if (!file_name)
  1053			return -ENOMEM;
  1054	
  1055		if (type == ZONEFS_ZTYPE_CNV)
  1056			zgroup_name = "cnv";
  1057		else
  1058			zgroup_name = "seq";
  1059	
  1060		dir = zonefs_create_inode(sb->s_root, zgroup_name, NULL, type);
  1061		if (!dir)
  1062			goto free;
  1063	
  1064		/*
  1065		 * The first zone contains the super block: skip it.
  1066		 */
  1067		end = zd->zones + blkdev_nr_zones(sb->s_bdev->bd_disk);
  1068		for (zone = &zd->zones[1]; zone < end; zone = next) {
  1069	
  1070			next = zone + 1;
  1071			if (zonefs_zone_type(zone) != type)
  1072				continue;
  1073	
  1074			/*
  1075			 * For conventional zones, contiguous zones can be aggregated
  1076			 * together to form larger files. Note that this overwrites the
  1077			 * length of the first zone of the set of contiguous zones
  1078			 * aggregated together. If one offline or read-only zone is
  1079			 * found, assume that all zones aggregated have the same
  1080			 * condition.
  1081			 */
  1082			if (type == ZONEFS_ZTYPE_CNV &&
  1083			    (sbi->s_features & ZONEFS_F_AGGRCNV)) {
  1084				for (; next < end; next++) {
  1085					if (zonefs_zone_type(next) != type)
  1086						break;
  1087					zone->len += next->len;
  1088					if (next->cond == BLK_ZONE_COND_READONLY &&
  1089					    zone->cond != BLK_ZONE_COND_OFFLINE)
  1090						zone->cond = BLK_ZONE_COND_READONLY;
  1091					else if (next->cond == BLK_ZONE_COND_OFFLINE)
  1092						zone->cond = BLK_ZONE_COND_OFFLINE;
  1093				}
  1094			}
  1095	
  1096			/*
  1097			 * Use the file number within its group as file name.
  1098			 */
  1099			snprintf(file_name, ZONEFS_NAME_MAX - 1, "%u", n);
  1100			if (!zonefs_create_inode(dir, file_name, zone, type))
  1101				goto free;
  1102	
  1103			n++;
  1104		}
  1105	
  1106		zonefs_info(sb, "Zone group \"%s\" has %u file%s\n",
  1107			    zgroup_name, n, n > 1 ? "s" : "");
  1108	
  1109		sbi->s_nr_files[type] = n;
> 1110		ret = 0;
  1111	
  1112	free:
  1113		kfree(file_name);
  1114	
  1115		return ret;
  1116	}
  1117	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
