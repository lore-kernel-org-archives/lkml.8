Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF779C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC9852071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgHYNi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:38:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:54731 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbgHYNiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:38:03 -0400
IronPort-SDR: hMiXTVRyd85RHAsjSLUOAT90MX9ZAvnsveGCa+gikhnneb04BMCyIcnz8NGvDs0CBXCB8XYJJv
 QugdbkNlmCLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="157151896"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="157151896"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 06:34:46 -0700
IronPort-SDR: yz8n2XjJ/KDQVNm9tC0JFvV+nuz2J3bSwEN22HS/fystrmCdeur94oU46AyVQ6hdo+eRPCP45b
 MxJs4hZNXUZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="331404927"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Aug 2020 06:34:45 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAZ64-0000Pi-Gk; Tue, 25 Aug 2020 13:34:44 +0000
Date:   Tue, 25 Aug 2020 21:34:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: net/netfilter/nft_set_rbtree.c:85:4: warning: Address of local
 auto-variable assigned to a function parameter.
Message-ID: <202008252119.rYDKOyvX%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6a9dc5fd6170d0a41c8a14eb19e63d94bea5705a
commit: e32a4dc6512ce3c1a1920531246e7037896e510a netfilter: nf_tables: make sets built-in
date:   5 months ago
compiler: arc-elf-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> net/netfilter/nft_set_rbtree.c:85:4: warning: Address of local auto-variable assigned to a function parameter. [autoVariables]
      *ext = &rbe->ext;
      ^
   net/netfilter/nft_set_rbtree.c:93:3: warning: Address of local auto-variable assigned to a function parameter. [autoVariables]
     *ext = &interval->ext;
     ^
   net/netfilter/nft_set_rbtree.c:233:5: warning: Address of local auto-variable assigned to a function parameter. [autoVariables]
       *ext = &rbe->ext;
       ^

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e32a4dc6512ce3c1a1920531246e7037896e510a
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout e32a4dc6512ce3c1a1920531246e7037896e510a
vim +85 net/netfilter/nft_set_rbtree.c

e701001e7cbe88 net/netfilter/nft_rbtree.c     Pablo Neira Ayuso 2016-04-12  41  
9b7e26aee7cf27 net/netfilter/nft_set_rbtree.c Florian Westphal  2017-07-28  42  static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
9b7e26aee7cf27 net/netfilter/nft_set_rbtree.c Florian Westphal  2017-07-28  43  				const u32 *key, const struct nft_set_ext **ext,
9b7e26aee7cf27 net/netfilter/nft_set_rbtree.c Florian Westphal  2017-07-28  44  				unsigned int seq)
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  45  {
03e5fd0e9bcc1f net/netfilter/nft_set_rbtree.c Liping Zhang      2017-03-12  46  	struct nft_rbtree *priv = nft_set_priv(set);
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  47  	const struct nft_rbtree_elem *rbe, *interval = NULL;
42a55769132fdf net/netfilter/nft_rbtree.c     Pablo Neira Ayuso 2016-07-08  48  	u8 genmask = nft_genmask_cur(net);
16c45eda96038a net/netfilter/nft_rbtree.c     Patrick McHardy   2015-03-21  49  	const struct rb_node *parent;
e701001e7cbe88 net/netfilter/nft_rbtree.c     Pablo Neira Ayuso 2016-04-12  50  	const void *this;
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  51  	int d;
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  52  
9b7e26aee7cf27 net/netfilter/nft_set_rbtree.c Florian Westphal  2017-07-28  53  	parent = rcu_dereference_raw(priv->root.rb_node);
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  54  	while (parent != NULL) {
9b7e26aee7cf27 net/netfilter/nft_set_rbtree.c Florian Westphal  2017-07-28  55  		if (read_seqcount_retry(&priv->count, seq))
9b7e26aee7cf27 net/netfilter/nft_set_rbtree.c Florian Westphal  2017-07-28  56  			return false;
9b7e26aee7cf27 net/netfilter/nft_set_rbtree.c Florian Westphal  2017-07-28  57  
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  58  		rbe = rb_entry(parent, struct nft_rbtree_elem, node);
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  59  
e701001e7cbe88 net/netfilter/nft_rbtree.c     Pablo Neira Ayuso 2016-04-12  60  		this = nft_set_ext_key(&rbe->ext);
e701001e7cbe88 net/netfilter/nft_rbtree.c     Pablo Neira Ayuso 2016-04-12  61  		d = memcmp(this, key, set->klen);
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  62  		if (d < 0) {
9b7e26aee7cf27 net/netfilter/nft_set_rbtree.c Florian Westphal  2017-07-28  63  			parent = rcu_dereference_raw(parent->rb_left);
f9121355eb6f9b net/netfilter/nft_set_rbtree.c Pablo Neira Ayuso 2017-03-01  64  			if (interval &&
f9121355eb6f9b net/netfilter/nft_set_rbtree.c Pablo Neira Ayuso 2017-03-01  65  			    nft_rbtree_equal(set, this, interval) &&
82e20b44477ffe net/netfilter/nft_set_rbtree.c Taehee Yoo        2018-06-07  66  			    nft_rbtree_interval_end(rbe) &&
f9121355eb6f9b net/netfilter/nft_set_rbtree.c Pablo Neira Ayuso 2017-03-01  67  			    !nft_rbtree_interval_end(interval))
e701001e7cbe88 net/netfilter/nft_rbtree.c     Pablo Neira Ayuso 2016-04-12  68  				continue;
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  69  			interval = rbe;
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  70  		} else if (d > 0)
9b7e26aee7cf27 net/netfilter/nft_set_rbtree.c Florian Westphal  2017-07-28  71  			parent = rcu_dereference_raw(parent->rb_right);
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  72  		else {
cc02e457bb86f7 net/netfilter/nft_rbtree.c     Patrick McHardy   2015-03-25  73  			if (!nft_set_elem_active(&rbe->ext, genmask)) {
9b7e26aee7cf27 net/netfilter/nft_set_rbtree.c Florian Westphal  2017-07-28  74  				parent = rcu_dereference_raw(parent->rb_left);
cc02e457bb86f7 net/netfilter/nft_rbtree.c     Patrick McHardy   2015-03-25  75  				continue;
cc02e457bb86f7 net/netfilter/nft_rbtree.c     Patrick McHardy   2015-03-25  76  			}
db3b665dd77b34 net/netfilter/nft_set_rbtree.c Pablo Neira Ayuso 2019-12-06  77  			if (nft_rbtree_interval_end(rbe)) {
db3b665dd77b34 net/netfilter/nft_set_rbtree.c Pablo Neira Ayuso 2019-12-06  78  				if (nft_set_is_anonymous(set))
db3b665dd77b34 net/netfilter/nft_set_rbtree.c Pablo Neira Ayuso 2019-12-06  79  					return false;
db3b665dd77b34 net/netfilter/nft_set_rbtree.c Pablo Neira Ayuso 2019-12-06  80  				parent = rcu_dereference_raw(parent->rb_left);
db3b665dd77b34 net/netfilter/nft_set_rbtree.c Pablo Neira Ayuso 2019-12-06  81  				interval = NULL;
db3b665dd77b34 net/netfilter/nft_set_rbtree.c Pablo Neira Ayuso 2019-12-06  82  				continue;
db3b665dd77b34 net/netfilter/nft_set_rbtree.c Pablo Neira Ayuso 2019-12-06  83  			}
b2832dd6621bf7 net/netfilter/nft_rbtree.c     Patrick McHardy   2015-03-25  84  
b2832dd6621bf7 net/netfilter/nft_rbtree.c     Patrick McHardy   2015-03-25 @85  			*ext = &rbe->ext;
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  86  			return true;
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  87  		}
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  88  	}
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  89  
c1eda3c6394f80 net/netfilter/nft_rbtree.c     Pablo Neira Ayuso 2016-08-01  90  	if (set->flags & NFT_SET_INTERVAL && interval != NULL &&
c1eda3c6394f80 net/netfilter/nft_rbtree.c     Pablo Neira Ayuso 2016-08-01  91  	    nft_set_elem_active(&interval->ext, genmask) &&
c1eda3c6394f80 net/netfilter/nft_rbtree.c     Pablo Neira Ayuso 2016-08-01  92  	    !nft_rbtree_interval_end(interval)) {
c1eda3c6394f80 net/netfilter/nft_rbtree.c     Pablo Neira Ayuso 2016-08-01  93  		*ext = &interval->ext;
c1eda3c6394f80 net/netfilter/nft_rbtree.c     Pablo Neira Ayuso 2016-08-01  94  		return true;
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  95  	}
db3b665dd77b34 net/netfilter/nft_set_rbtree.c Pablo Neira Ayuso 2019-12-06  96  
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  97  	return false;
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  98  }
20a69341f2d00c net/netfilter/nft_rbtree.c     Patrick McHardy   2013-10-11  99  

:::::: The code at line 85 was first introduced by commit
:::::: b2832dd6621bf73eb8ad38389a94bd83a5983886 netfilter: nf_tables: return set extensions from ->lookup()

:::::: TO: Patrick McHardy <kaber@trash.net>
:::::: CC: Pablo Neira Ayuso <pablo@netfilter.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
