Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE538C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6685820578
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgC0G4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:56:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:62682 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgC0G4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:56:03 -0400
IronPort-SDR: klV06LFNo6u8qsd8nckRsFb7GawjIY6/ydq18svQPgwrVf2iCSby7qYC3niR19q8F5LK5rKL2r
 qAXXGvWiHXfw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 23:56:02 -0700
IronPort-SDR: M+UVpNbAmLFe0tsPrTXVMRFo5w7TYWg7t3u69fY+AxDcHKzmCkoMuW/Cqhg+tak0TmanKL3UAZ
 1XtqCqaoQW4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="gz'50?scan'50,208,50";a="240889085"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2020 23:55:59 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jHiuM-000771-IS; Fri, 27 Mar 2020 14:55:58 +0800
Date:   Fri, 27 Mar 2020 14:55:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     kbuild-all@lists.01.org, Jiri Pirko <jiri@resnulli.us>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] ethtool: add timestamping related string
 sets
Message-ID: <202003271437.5LMEAGMc%lkp@intel.com>
References: <105373960c4afeeea7b51459b9763b0452d6e660.1585267388.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <105373960c4afeeea7b51459b9763b0452d6e660.1585267388.git.mkubecek@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michal,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]
[also build test WARNING on next-20200326]
[cannot apply to net/master linus/master v5.6-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Michal-Kubecek/ethtool-netlink-interface-part-4/20200327-122420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 5bb7357f45315138f623d08a615d23dd6ac26cf3
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/core/dev_ioctl.c: In function 'net_hwtstamp_validate':
>> net/core/dev_ioctl.c:186:2: warning: enumeration value '__HWTSTAMP_TX_CNT' not handled in switch [-Wswitch]
     186 |  switch (tx_type) {
         |  ^~~~~~
>> net/core/dev_ioctl.c:195:2: warning: enumeration value '__HWTSTAMP_FILTER_CNT' not handled in switch [-Wswitch]
     195 |  switch (rx_filter) {
         |  ^~~~~~

vim +/__HWTSTAMP_TX_CNT +186 net/core/dev_ioctl.c

96b45cbd956ce8 Cong Wang        2013-02-15  168  
96b45cbd956ce8 Cong Wang        2013-02-15  169  static int net_hwtstamp_validate(struct ifreq *ifr)
96b45cbd956ce8 Cong Wang        2013-02-15  170  {
96b45cbd956ce8 Cong Wang        2013-02-15  171  	struct hwtstamp_config cfg;
96b45cbd956ce8 Cong Wang        2013-02-15  172  	enum hwtstamp_tx_types tx_type;
96b45cbd956ce8 Cong Wang        2013-02-15  173  	enum hwtstamp_rx_filters rx_filter;
96b45cbd956ce8 Cong Wang        2013-02-15  174  	int tx_type_valid = 0;
96b45cbd956ce8 Cong Wang        2013-02-15  175  	int rx_filter_valid = 0;
96b45cbd956ce8 Cong Wang        2013-02-15  176  
96b45cbd956ce8 Cong Wang        2013-02-15  177  	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
96b45cbd956ce8 Cong Wang        2013-02-15  178  		return -EFAULT;
96b45cbd956ce8 Cong Wang        2013-02-15  179  
96b45cbd956ce8 Cong Wang        2013-02-15  180  	if (cfg.flags) /* reserved for future extensions */
96b45cbd956ce8 Cong Wang        2013-02-15  181  		return -EINVAL;
96b45cbd956ce8 Cong Wang        2013-02-15  182  
96b45cbd956ce8 Cong Wang        2013-02-15  183  	tx_type = cfg.tx_type;
96b45cbd956ce8 Cong Wang        2013-02-15  184  	rx_filter = cfg.rx_filter;
96b45cbd956ce8 Cong Wang        2013-02-15  185  
96b45cbd956ce8 Cong Wang        2013-02-15 @186  	switch (tx_type) {
96b45cbd956ce8 Cong Wang        2013-02-15  187  	case HWTSTAMP_TX_OFF:
96b45cbd956ce8 Cong Wang        2013-02-15  188  	case HWTSTAMP_TX_ON:
96b45cbd956ce8 Cong Wang        2013-02-15  189  	case HWTSTAMP_TX_ONESTEP_SYNC:
b6fd7b96366769 Richard Cochran  2019-12-25  190  	case HWTSTAMP_TX_ONESTEP_P2P:
96b45cbd956ce8 Cong Wang        2013-02-15  191  		tx_type_valid = 1;
96b45cbd956ce8 Cong Wang        2013-02-15  192  		break;
96b45cbd956ce8 Cong Wang        2013-02-15  193  	}
96b45cbd956ce8 Cong Wang        2013-02-15  194  
96b45cbd956ce8 Cong Wang        2013-02-15 @195  	switch (rx_filter) {
96b45cbd956ce8 Cong Wang        2013-02-15  196  	case HWTSTAMP_FILTER_NONE:
96b45cbd956ce8 Cong Wang        2013-02-15  197  	case HWTSTAMP_FILTER_ALL:
96b45cbd956ce8 Cong Wang        2013-02-15  198  	case HWTSTAMP_FILTER_SOME:
96b45cbd956ce8 Cong Wang        2013-02-15  199  	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
96b45cbd956ce8 Cong Wang        2013-02-15  200  	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
96b45cbd956ce8 Cong Wang        2013-02-15  201  	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
96b45cbd956ce8 Cong Wang        2013-02-15  202  	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
96b45cbd956ce8 Cong Wang        2013-02-15  203  	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
96b45cbd956ce8 Cong Wang        2013-02-15  204  	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
96b45cbd956ce8 Cong Wang        2013-02-15  205  	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
96b45cbd956ce8 Cong Wang        2013-02-15  206  	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
96b45cbd956ce8 Cong Wang        2013-02-15  207  	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
96b45cbd956ce8 Cong Wang        2013-02-15  208  	case HWTSTAMP_FILTER_PTP_V2_EVENT:
96b45cbd956ce8 Cong Wang        2013-02-15  209  	case HWTSTAMP_FILTER_PTP_V2_SYNC:
96b45cbd956ce8 Cong Wang        2013-02-15  210  	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
b8210a9e4bea63 Miroslav Lichvar 2017-05-19  211  	case HWTSTAMP_FILTER_NTP_ALL:
e3412575488ac2 Miroslav Lichvar 2017-05-19  212  		rx_filter_valid = 1;
b8210a9e4bea63 Miroslav Lichvar 2017-05-19  213  		break;
96b45cbd956ce8 Cong Wang        2013-02-15  214  	}
96b45cbd956ce8 Cong Wang        2013-02-15  215  
96b45cbd956ce8 Cong Wang        2013-02-15  216  	if (!tx_type_valid || !rx_filter_valid)
96b45cbd956ce8 Cong Wang        2013-02-15  217  		return -ERANGE;
96b45cbd956ce8 Cong Wang        2013-02-15  218  
96b45cbd956ce8 Cong Wang        2013-02-15  219  	return 0;
96b45cbd956ce8 Cong Wang        2013-02-15  220  }
96b45cbd956ce8 Cong Wang        2013-02-15  221  

:::::: The code at line 186 was first introduced by commit
:::::: 96b45cbd956ce83908378d87d009b05645353f22 net: move ioctl functions into a separated file

:::::: TO: Cong Wang <xiyou.wangcong@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--bg08WKrSYDhXBjb5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--bg08WKrSYDhXBjb5--
