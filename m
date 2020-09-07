Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1191AC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44A120C09
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgIGVDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 17:03:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:38544 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgIGVDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 17:03:31 -0400
IronPort-SDR: MU8WTKvV28IfFhu71bEkJeUN2Yt1aHOxSNHTZD0tyJd59R3hhEwHnSUn1gJv6IwItm3XfcwYK9
 PNqn+H9T7SPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="145753754"
X-IronPort-AV: E=Sophos;i="5.76,403,1592895600"; 
   d="gz'50?scan'50,208,50";a="145753754"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 13:52:25 -0700
IronPort-SDR: fHflGpVmVKMUjo+CxdhYXLB9urQKOlqzMRhPN1zzfmPlADWOeTwupnNpzZBKRAhW/kPhHj/r5s
 ilKrGp+Tr0bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,403,1592895600"; 
   d="gz'50?scan'50,208,50";a="284284376"
Received: from lkp-server02.sh.intel.com (HELO a98deea729ba) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 07 Sep 2020 13:52:22 -0700
Received: from kbuild by a98deea729ba with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kFO7i-0000GK-9r; Mon, 07 Sep 2020 20:52:22 +0000
Date:   Tue, 8 Sep 2020 04:51:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: drivers/mtd/parsers/bcm47xxpart.c:217:21: sparse: sparse: cast to
 restricted __le32
Message-ID: <202009080452.61u3M2JS%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f4d51dffc6c01a9e94650d95ce0104964f8ae822
commit: 11f74023888f4e50fd33d3428ce473a10e1f1969 mtd: parsers: Move BCM47xx parser
date:   12 months ago
config: mips-randconfig-s032-20200908 (attached as .config)
compiler: mipsel-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout 11f74023888f4e50fd33d3428ce473a10e1f1969
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/mtd/parsers/bcm47xxpart.c:217:21: sparse: sparse: cast to restricted __le32

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=11f74023888f4e50fd33d3428ce473a10e1f1969
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 11f74023888f4e50fd33d3428ce473a10e1f1969
vim +217 drivers/mtd/parsers/bcm47xxpart.c

89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10   85  
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30   86  static int bcm47xxpart_parse(struct mtd_info *master,
b9adf469f8abb8 drivers/mtd/bcm47xxpart.c Brian Norris    2015-12-04   87  			     const struct mtd_partition **pparts,
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30   88  			     struct mtd_part_parser_data *data)
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30   89  {
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30   90  	struct mtd_partition *parts;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30   91  	uint8_t i, curr_part = 0;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30   92  	uint32_t *buf;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30   93  	size_t bytes_read;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30   94  	uint32_t offset;
25bad1d3c9f561 drivers/mtd/bcm47xxpart.c Hauke Mehrtens  2013-01-24   95  	uint32_t blocksize = master->erasesize;
89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10   96  	int trx_parts[2]; /* Array with indexes of TRX partitions */
89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10   97  	int trx_num = 0; /* Number of found TRX partitions */
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07   98  	int possible_nvram_sizes[] = { 0x8000, 0xF000, 0x10000, };
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06   99  	int err;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  100  
16bd87b3a352b5 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-12-08  101  	/*
16bd87b3a352b5 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-12-08  102  	 * Some really old flashes (like AT45DB*) had smaller erasesize-s, but
16bd87b3a352b5 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-12-08  103  	 * partitions were aligned to at least 0x1000 anyway.
16bd87b3a352b5 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-12-08  104  	 */
16bd87b3a352b5 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-12-08  105  	if (blocksize < 0x1000)
16bd87b3a352b5 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-12-08  106  		blocksize = 0x1000;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  107  
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  108  	/* Alloc */
6396bb221514d2 drivers/mtd/bcm47xxpart.c Kees Cook       2018-06-12  109  	parts = kcalloc(BCM47XXPART_MAX_PARTS, sizeof(struct mtd_partition),
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  110  			GFP_KERNEL);
99b1d1887fee36 drivers/mtd/bcm47xxpart.c Hauke Mehrtens  2013-10-13  111  	if (!parts)
99b1d1887fee36 drivers/mtd/bcm47xxpart.c Hauke Mehrtens  2013-10-13  112  		return -ENOMEM;
99b1d1887fee36 drivers/mtd/bcm47xxpart.c Hauke Mehrtens  2013-10-13  113  
5ca1088f10d617 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  114  	buf = kzalloc(BCM47XXPART_BYTES_TO_READ, GFP_KERNEL);
99b1d1887fee36 drivers/mtd/bcm47xxpart.c Hauke Mehrtens  2013-10-13  115  	if (!buf) {
99b1d1887fee36 drivers/mtd/bcm47xxpart.c Hauke Mehrtens  2013-10-13  116  		kfree(parts);
99b1d1887fee36 drivers/mtd/bcm47xxpart.c Hauke Mehrtens  2013-10-13  117  		return -ENOMEM;
99b1d1887fee36 drivers/mtd/bcm47xxpart.c Hauke Mehrtens  2013-10-13  118  	}
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  119  
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  120  	/* Parse block by block looking for magics */
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  121  	for (offset = 0; offset <= master->size - blocksize;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  122  	     offset += blocksize) {
2a36a5c30eab9c drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-05  123  		/* Nothing more in higher memory on BCM47XX (MIPS) */
97f2645f358b41 drivers/mtd/bcm47xxpart.c Masahiro Yamada 2016-08-03  124  		if (IS_ENABLED(CONFIG_BCM47XX) && offset >= 0x2000000)
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  125  			break;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  126  
00b79860eb5f72 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-02-26  127  		if (curr_part >= BCM47XXPART_MAX_PARTS) {
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  128  			pr_warn("Reached maximum number of partitions, scanning stopped!\n");
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  129  			break;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  130  		}
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  131  
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  132  		/* Read beginning of the block */
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  133  		err = mtd_read(master, offset, BCM47XXPART_BYTES_TO_READ,
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  134  			       &bytes_read, (uint8_t *)buf);
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  135  		if (err && !mtd_is_bitflip(err)) {
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  136  			pr_err("mtd_read error while parsing (offset: 0x%X): %d\n",
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  137  			       offset, err);
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  138  			continue;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  139  		}
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  140  
4f8aaf72287578 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  141  		/* Magic or small NVRAM at 0x400 */
4f8aaf72287578 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  142  		if ((buf[0x4e0 / 4] == CFE_MAGIC && buf[0x4e4 / 4] == CFE_MAGIC) ||
4f8aaf72287578 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  143  		    (buf[0x400 / 4] == NVRAM_HEADER)) {
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  144  			bcm47xxpart_add_part(&parts[curr_part++], "boot",
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  145  					     offset, MTD_WRITEABLE);
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  146  			continue;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  147  		}
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  148  
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  149  		/*
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  150  		 * board_data starts with board_id which differs across boards,
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  151  		 * but we can use 'MPFR' (hopefully) magic at 0x100
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  152  		 */
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  153  		if (buf[0x100 / 4] == BOARD_DATA_MAGIC) {
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  154  			bcm47xxpart_add_part(&parts[curr_part++], "board_data",
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  155  					     offset, MTD_WRITEABLE);
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  156  			continue;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  157  		}
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  158  
33094c736cd36a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  159  		/* Found on Huawei E970 */
33094c736cd36a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  160  		if (buf[0x000 / 4] == FACTORY_MAGIC) {
33094c736cd36a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  161  			bcm47xxpart_add_part(&parts[curr_part++], "factory",
33094c736cd36a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  162  					     offset, MTD_WRITEABLE);
33094c736cd36a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  163  			continue;
33094c736cd36a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  164  		}
33094c736cd36a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  165  
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  166  		/* POT(TOP) */
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  167  		if (buf[0x000 / 4] == POT_MAGIC1 &&
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  168  		    (buf[0x004 / 4] & 0xFFFF) == POT_MAGIC2) {
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  169  			bcm47xxpart_add_part(&parts[curr_part++], "POT", offset,
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  170  					     MTD_WRITEABLE);
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  171  			continue;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  172  		}
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  173  
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  174  		/* ML */
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  175  		if (buf[0x010 / 4] == ML_MAGIC1 &&
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  176  		    buf[0x014 / 4] == ML_MAGIC2) {
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  177  			bcm47xxpart_add_part(&parts[curr_part++], "ML", offset,
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  178  					     MTD_WRITEABLE);
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  179  			continue;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  180  		}
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  181  
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  182  		/* TRX */
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  183  		if (buf[0x000 / 4] == TRX_MAGIC) {
b522d7b0ebe353 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  184  			struct trx_header *trx;
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  185  			uint32_t last_subpart;
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  186  			uint32_t trx_size;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  187  
89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  188  			if (trx_num >= ARRAY_SIZE(trx_parts))
89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  189  				pr_warn("No enough space to store another TRX found at 0x%X\n",
89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  190  					offset);
89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  191  			else
89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  192  				trx_parts[trx_num++] = curr_part;
396afe553bd607 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-01-06  193  			bcm47xxpart_add_part(&parts[curr_part++], "firmware",
396afe553bd607 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-01-06  194  					     offset, 0);
396afe553bd607 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-01-06  195  
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  196  			/*
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  197  			 * Try to find TRX size. The "length" field isn't fully
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  198  			 * reliable as it could be decreased to make CRC32 cover
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  199  			 * only part of TRX data. It's commonly used as checksum
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  200  			 * can't cover e.g. ever-changing rootfs partition.
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  201  			 * Use offsets as helpers for assuming min TRX size.
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  202  			 */
b522d7b0ebe353 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  203  			trx = (struct trx_header *)buf;
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  204  			last_subpart = max3(trx->offset[0], trx->offset[1],
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  205  					    trx->offset[2]);
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  206  			trx_size = max(trx->length, last_subpart + blocksize);
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  207  
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  208  			/*
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  209  			 * Skip the TRX data. Decrease offset by block size as
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  210  			 * the next loop iteration will increase it.
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  211  			 */
237ea0d4762cc1 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2018-04-12  212  			offset += roundup(trx_size, blocksize) - blocksize;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  213  			continue;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  214  		}
020c6bcfbeabee drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  215  
020c6bcfbeabee drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  216  		/* Squashfs on devices not using TRX */
0b56d2d45e7c27 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-12-16 @217  		if (le32_to_cpu(buf[0x000 / 4]) == SQUASHFS_MAGIC ||
0b56d2d45e7c27 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-12-16  218  		    buf[0x000 / 4] == SHSQ_MAGIC) {
020c6bcfbeabee drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  219  			bcm47xxpart_add_part(&parts[curr_part++], "rootfs",
020c6bcfbeabee drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  220  					     offset, 0);
020c6bcfbeabee drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  221  			continue;
024629fdca1bbb drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-08-18  222  		}
024629fdca1bbb drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-08-18  223  
024629fdca1bbb drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-08-18  224  		/*
024629fdca1bbb drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-08-18  225  		 * New (ARM?) devices may have NVRAM in some middle block. Last
024629fdca1bbb drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-08-18  226  		 * block will be checked later, so skip it.
024629fdca1bbb drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-08-18  227  		 */
024629fdca1bbb drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-08-18  228  		if (offset != master->size - blocksize &&
024629fdca1bbb drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-08-18  229  		    buf[0x000 / 4] == NVRAM_HEADER) {
024629fdca1bbb drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-08-18  230  			bcm47xxpart_add_part(&parts[curr_part++], "nvram",
024629fdca1bbb drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-08-18  231  					     offset, 0);
024629fdca1bbb drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-08-18  232  			continue;
020c6bcfbeabee drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-10-21  233  		}
f0501e81fbaa51 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  234  
f0501e81fbaa51 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  235  		/* Read middle of the block */
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  236  		err = mtd_read(master, offset + 0x8000, 0x4, &bytes_read,
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  237  			       (uint8_t *)buf);
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  238  		if (err && !mtd_is_bitflip(err)) {
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  239  			pr_err("mtd_read error while parsing (offset: 0x%X): %d\n",
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  240  			       offset, err);
f0501e81fbaa51 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  241  			continue;
f0501e81fbaa51 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  242  		}
f0501e81fbaa51 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  243  
f0501e81fbaa51 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  244  		/* Some devices (ex. WNDR3700v3) don't have a standard 'MPFR' */
f0501e81fbaa51 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  245  		if (buf[0x000 / 4] == BOARD_DATA_MAGIC2) {
f0501e81fbaa51 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  246  			bcm47xxpart_add_part(&parts[curr_part++], "board_data",
f0501e81fbaa51 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  247  					     offset, MTD_WRITEABLE);
f0501e81fbaa51 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  248  			continue;
f0501e81fbaa51 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-12-21  249  		}
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  250  	}
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  251  
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  252  	/* Look for NVRAM at the end of the last block. */
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  253  	for (i = 0; i < ARRAY_SIZE(possible_nvram_sizes); i++) {
00b79860eb5f72 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2014-02-26  254  		if (curr_part >= BCM47XXPART_MAX_PARTS) {
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  255  			pr_warn("Reached maximum number of partitions, scanning stopped!\n");
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  256  			break;
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  257  		}
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  258  
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  259  		offset = master->size - possible_nvram_sizes[i];
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  260  		err = mtd_read(master, offset, 0x4, &bytes_read,
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  261  			       (uint8_t *)buf);
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  262  		if (err && !mtd_is_bitflip(err)) {
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  263  			pr_err("mtd_read error while reading (offset 0x%X): %d\n",
36bcc0c9c2bc8f drivers/mtd/bcm47xxpart.c Rafał Miłecki   2015-12-06  264  			       offset, err);
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  265  			continue;
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  266  		}
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  267  
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  268  		/* Standard NVRAM */
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  269  		if (buf[0] == NVRAM_HEADER) {
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  270  			bcm47xxpart_add_part(&parts[curr_part++], "nvram",
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  271  					     master->size - blocksize, 0);
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  272  			break;
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  273  		}
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  274  	}
91d542f4dcc231 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-03-07  275  
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  276  	kfree(buf);
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  277  
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  278  	/*
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  279  	 * Assume that partitions end at the beginning of the one they are
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  280  	 * followed by.
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  281  	 */
648bdbee5d2cc3 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-01-06  282  	for (i = 0; i < curr_part; i++) {
648bdbee5d2cc3 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-01-06  283  		u64 next_part_offset = (i < curr_part - 1) ?
648bdbee5d2cc3 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-01-06  284  				       parts[i + 1].offset : master->size;
648bdbee5d2cc3 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-01-06  285  
648bdbee5d2cc3 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2013-01-06  286  		parts[i].size = next_part_offset - parts[i].offset;
b522d7b0ebe353 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  287  	}
b522d7b0ebe353 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  288  
b522d7b0ebe353 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  289  	/* If there was TRX parse it now */
89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  290  	for (i = 0; i < trx_num; i++) {
89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  291  		struct mtd_partition *trx = &parts[trx_parts[i]];
89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  292  
99352afe8f169c drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-06-21  293  		if (i == bcm47xxpart_bootpartition())
99352afe8f169c drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-06-21  294  			trx->types = trx_types;
99352afe8f169c drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-06-21  295  		else
89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  296  			trx->name = "failsafe";
89a0d9a9f1941a drivers/mtd/bcm47xxpart.c Rafał Miłecki   2017-01-10  297  	}
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  298  
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  299  	*pparts = parts;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  300  	return curr_part;
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  301  };
3cf7f1314ed885 drivers/mtd/bcm47xxpart.c Rafał Miłecki   2012-08-30  302  

:::::: The code at line 217 was first introduced by commit
:::::: 0b56d2d45e7c27581ca90f36b4317373f23e7622 mtd: bcm47xxpart: support SquashFS with an original magic

:::::: TO: Rafał Miłecki <zajec5@gmail.com>
:::::: CC: Brian Norris <computersforpeace@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ibTvN161/egqYuK8--
