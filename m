Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8D3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9854207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbgGASdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:33:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:15563 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732542AbgGASdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:33:45 -0400
IronPort-SDR: HjC/b+JsuzI7UIzKJMBcKeiNDFB7x9rzvMYSBZ/SBma8mTV//VVjIvXY6PxkwVaDVIe2Xi0qvJ
 p5tLXvZoe3Qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="126296205"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="gz'50?scan'50,208,50";a="126296205"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:33:34 -0700
IronPort-SDR: sW1AWNVPXIGuPeQYkQ+9pVi6re/VCmWB46hqeyGClgQFrYN/FwfLIa1TYpJs0UKBQNle1G3fsF
 UDwVWomONeXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="gz'50?scan'50,208,50";a="281690689"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Jul 2020 11:33:32 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jqhY3-0003ER-KC; Wed, 01 Jul 2020 18:33:31 +0000
Date:   Thu, 2 Jul 2020 02:33:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Po Liu <Po.Liu@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/freescale/enetc/enetc_qos.c:491:30: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202007020212.eRt7lED2%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7c30b859a947535f2213277e827d7ac7dcff9c84
commit: 888ae5a3952badf11fdcd210f5da9994462ec2fc net: enetc: add tc flower psfp offload driver
date:   9 weeks ago
config: powerpc64-randconfig-s032-20200701 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        git checkout 888ae5a3952badf11fdcd210f5da9994462ec2fc
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/freescale/enetc/enetc_qos.c:134:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 @@     got unsigned int [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:134:21: sparse:     expected restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:134:21: sparse:     got unsigned int [usertype]
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:135:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 @@     got unsigned int [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:135:21: sparse:     expected restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:135:21: sparse:     got unsigned int [usertype]
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:427:20: sparse: sparse: symbol 'enetc_act_fwd' was not declared. Should it be static?
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:488:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 @@     got unsigned int [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:488:21: sparse:     expected restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:488:21: sparse:     got unsigned int [usertype]
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:489:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 @@     got unsigned int [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:489:21: sparse:     expected restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:489:21: sparse:     got unsigned int [usertype]
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:491:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] vid_vidm_tg @@     got restricted __le16 [usertype] @@
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:491:30: sparse:     expected unsigned short [usertype] vid_vidm_tg
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:491:30: sparse:     got restricted __le16 [usertype]
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:497:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] iports @@     got int @@
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:497:25: sparse:     expected restricted __le32 [usertype] iports
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:497:25: sparse:     got int
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:522:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] iports @@     got int @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:522:25: sparse:     expected restricted __le32 [usertype] iports
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:522:25: sparse:     got int
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:532:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 @@     got unsigned int [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:532:21: sparse:     expected restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:532:21: sparse:     got unsigned int [usertype]
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:533:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 @@     got unsigned int [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:533:21: sparse:     expected restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:533:21: sparse:     got unsigned int [usertype]
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:542:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] vid_vidm_tg @@     got restricted __le16 [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:542:38: sparse:     expected unsigned short [usertype] vid_vidm_tg
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:542:38: sparse:     got restricted __le16 [usertype]
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:548:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] vid_vidm_tg @@     got restricted __le16 [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:548:38: sparse:     expected unsigned short [usertype] vid_vidm_tg
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:548:38: sparse:     got restricted __le16 [usertype]
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:586:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] input_ports @@     got int @@
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:586:33: sparse:     expected restricted __le32 [usertype] input_ports
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:586:33: sparse:     got int
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:636:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 @@     got unsigned int [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:636:21: sparse:     expected restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:636:21: sparse:     got unsigned int [usertype]
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:637:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 @@     got unsigned int [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:637:21: sparse:     expected restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:637:21: sparse:     got unsigned int [usertype]
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:646:31: sparse: sparse: cast to restricted __le32
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:646:31: sparse: sparse: cast to restricted __le32
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:646:31: sparse: sparse: cast to restricted __le32
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:646:31: sparse: sparse: cast to restricted __le32
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:646:31: sparse: sparse: cast to restricted __le32
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:646:31: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:650:31: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:650:31: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:650:31: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:650:31: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:650:31: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:650:31: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:657:23: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:657:23: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:657:23: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:657:23: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:657:23: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:657:23: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:658:19: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:658:19: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:658:19: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:658:19: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:658:19: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:658:19: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:665:23: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:665:23: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:665:23: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:665:23: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:665:23: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:665:23: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:666:19: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:666:19: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:666:19: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:666:19: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:666:19: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:666:19: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:773:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 @@     got unsigned int [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:773:21: sparse:     expected restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:773:21: sparse:     got unsigned int [usertype]
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:774:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 @@     got unsigned int [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:774:21: sparse:     expected restricted __le32
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:774:21: sparse:     got unsigned int [usertype]
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:780:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ct @@     got restricted __le32 [usertype] @@
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:780:23: sparse:     expected unsigned int [usertype] ct
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:780:23: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:781:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cte @@     got restricted __le32 [usertype] @@
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:781:24: sparse:     expected unsigned int [usertype] cte
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:781:24: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:803:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] interval @@     got restricted __le32 [usertype] @@
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:803:30: sparse:     expected unsigned int [usertype] interval
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:803:30: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:815:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] btl @@     got restricted __le32 [usertype] @@
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:815:32: sparse:     expected unsigned int [usertype] btl
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:815:32: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:816:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bth @@     got restricted __le32 [usertype] @@
>> drivers/net/ethernet/freescale/enetc/enetc_qos.c:816:32: sparse:     expected unsigned int [usertype] bth
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:816:32: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:822:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bth @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:822:32: sparse:     expected unsigned int [usertype] bth
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:822:32: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:823:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] btl @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:823:32: sparse:     expected unsigned int [usertype] btl
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:823:32: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/freescale/enetc/enetc_qos.c:966:20: sparse: sparse: symbol 'enetc_check_flow_actions' was not declared. Should it be static?

vim +491 drivers/net/ethernet/freescale/enetc/enetc_qos.c

   426	
 > 427	struct actions_fwd enetc_act_fwd[] = {
   428		{
   429			BIT(FLOW_ACTION_GATE),
   430			BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS),
   431			FILTER_ACTION_TYPE_PSFP
   432		},
   433		/* example for ACL actions */
   434		{
   435			BIT(FLOW_ACTION_DROP),
   436			0,
   437			FILTER_ACTION_TYPE_ACL
   438		}
   439	};
   440	
   441	static struct enetc_psfp epsfp = {
   442		.psfp_sfi_bitmap = NULL,
   443	};
   444	
   445	static LIST_HEAD(enetc_block_cb_list);
   446	
   447	static inline int enetc_get_port(struct enetc_ndev_priv *priv)
   448	{
   449		return priv->si->pdev->devfn & 0x7;
   450	}
   451	
   452	/* Stream Identity Entry Set Descriptor */
   453	static int enetc_streamid_hw_set(struct enetc_ndev_priv *priv,
   454					 struct enetc_streamid *sid,
   455					 u8 enable)
   456	{
   457		struct enetc_cbd cbd = {.cmd = 0};
   458		struct streamid_data *si_data;
   459		struct streamid_conf *si_conf;
   460		u16 data_size;
   461		dma_addr_t dma;
   462		int err;
   463	
   464		if (sid->index >= priv->psfp_cap.max_streamid)
   465			return -EINVAL;
   466	
   467		if (sid->filtertype != STREAMID_TYPE_NULL &&
   468		    sid->filtertype != STREAMID_TYPE_SMAC)
   469			return -EOPNOTSUPP;
   470	
   471		/* Disable operation before enable */
   472		cbd.index = cpu_to_le16((u16)sid->index);
   473		cbd.cls = BDCR_CMD_STREAM_IDENTIFY;
   474		cbd.status_flags = 0;
   475	
   476		data_size = sizeof(struct streamid_data);
   477		si_data = kzalloc(data_size, __GFP_DMA | GFP_KERNEL);
   478		cbd.length = cpu_to_le16(data_size);
   479	
   480		dma = dma_map_single(&priv->si->pdev->dev, si_data,
   481				     data_size, DMA_FROM_DEVICE);
   482		if (dma_mapping_error(&priv->si->pdev->dev, dma)) {
   483			netdev_err(priv->si->ndev, "DMA mapping failed!\n");
   484			kfree(si_data);
   485			return -ENOMEM;
   486		}
   487	
 > 488		cbd.addr[0] = lower_32_bits(dma);
   489		cbd.addr[1] = upper_32_bits(dma);
   490		memset(si_data->dmac, 0xff, ETH_ALEN);
 > 491		si_data->vid_vidm_tg =
   492			cpu_to_le16(ENETC_CBDR_SID_VID_MASK
   493				    + ((0x3 << 14) | ENETC_CBDR_SID_VIDM));
   494	
   495		si_conf = &cbd.sid_set;
   496		/* Only one port supported for one entry, set itself */
 > 497		si_conf->iports = 1 << enetc_get_port(priv);
   498		si_conf->id_type = 1;
   499		si_conf->oui[2] = 0x0;
   500		si_conf->oui[1] = 0x80;
   501		si_conf->oui[0] = 0xC2;
   502	
   503		err = enetc_send_cmd(priv->si, &cbd);
   504		if (err)
   505			return -EINVAL;
   506	
   507		if (!enable) {
   508			kfree(si_data);
   509			return 0;
   510		}
   511	
   512		/* Enable the entry overwrite again incase space flushed by hardware */
   513		memset(&cbd, 0, sizeof(cbd));
   514	
   515		cbd.index = cpu_to_le16((u16)sid->index);
   516		cbd.cmd = 0;
   517		cbd.cls = BDCR_CMD_STREAM_IDENTIFY;
   518		cbd.status_flags = 0;
   519	
   520		si_conf->en = 0x80;
   521		si_conf->stream_handle = cpu_to_le32(sid->handle);
   522		si_conf->iports = 1 << enetc_get_port(priv);
   523		si_conf->id_type = sid->filtertype;
   524		si_conf->oui[2] = 0x0;
   525		si_conf->oui[1] = 0x80;
   526		si_conf->oui[0] = 0xC2;
   527	
   528		memset(si_data, 0, data_size);
   529	
   530		cbd.length = cpu_to_le16(data_size);
   531	
   532		cbd.addr[0] = lower_32_bits(dma);
 > 533		cbd.addr[1] = upper_32_bits(dma);
   534	
   535		/* VIDM default to be 1.
   536		 * VID Match. If set (b1) then the VID must match, otherwise
   537		 * any VID is considered a match. VIDM setting is only used
   538		 * when TG is set to b01.
   539		 */
   540		if (si_conf->id_type == STREAMID_TYPE_NULL) {
   541			ether_addr_copy(si_data->dmac, sid->dst_mac);
   542			si_data->vid_vidm_tg =
   543			cpu_to_le16((sid->vid & ENETC_CBDR_SID_VID_MASK) +
   544				    ((((u16)(sid->tagged) & 0x3) << 14)
   545				     | ENETC_CBDR_SID_VIDM));
   546		} else if (si_conf->id_type == STREAMID_TYPE_SMAC) {
   547			ether_addr_copy(si_data->smac, sid->src_mac);
   548			si_data->vid_vidm_tg =
   549			cpu_to_le16((sid->vid & ENETC_CBDR_SID_VID_MASK) +
   550				    ((((u16)(sid->tagged) & 0x3) << 14)
   551				     | ENETC_CBDR_SID_VIDM));
   552		}
   553	
   554		err = enetc_send_cmd(priv->si, &cbd);
   555		kfree(si_data);
   556	
   557		return err;
   558	}
   559	
   560	/* Stream Filter Instance Set Descriptor */
   561	static int enetc_streamfilter_hw_set(struct enetc_ndev_priv *priv,
   562					     struct enetc_psfp_filter *sfi,
   563					     u8 enable)
   564	{
   565		struct enetc_cbd cbd = {.cmd = 0};
   566		struct sfi_conf *sfi_config;
   567	
   568		cbd.index = cpu_to_le16(sfi->index);
   569		cbd.cls = BDCR_CMD_STREAM_FILTER;
   570		cbd.status_flags = 0x80;
   571		cbd.length = cpu_to_le16(1);
   572	
   573		sfi_config = &cbd.sfi_conf;
   574		if (!enable)
   575			goto exit;
   576	
   577		sfi_config->en = 0x80;
   578	
   579		if (sfi->handle >= 0) {
   580			sfi_config->stream_handle =
   581				cpu_to_le32(sfi->handle);
   582			sfi_config->sthm |= 0x80;
   583		}
   584	
   585		sfi_config->sg_inst_table_index = cpu_to_le16(sfi->gate_id);
 > 586		sfi_config->input_ports = 1 << enetc_get_port(priv);
   587	
   588		/* The priority value which may be matched against the
   589		 * frame’s priority value to determine a match for this entry.
   590		 */
   591		if (sfi->prio >= 0)
   592			sfi_config->multi |= (sfi->prio & 0x7) | 0x8;
   593	
   594		/* Filter Type. Identifies the contents of the MSDU/FM_INST_INDEX
   595		 * field as being either an MSDU value or an index into the Flow
   596		 * Meter Instance table.
   597		 * TODO: no limit max sdu
   598		 */
   599	
   600		if (sfi->meter_id >= 0) {
   601			sfi_config->fm_inst_table_index = cpu_to_le16(sfi->meter_id);
   602			sfi_config->multi |= 0x80;
   603		}
   604	
   605	exit:
   606		return enetc_send_cmd(priv->si, &cbd);
   607	}
   608	
   609	static int enetc_streamcounter_hw_get(struct enetc_ndev_priv *priv,
   610					      u32 index,
   611					      struct psfp_streamfilter_counters *cnt)
   612	{
   613		struct enetc_cbd cbd = { .cmd = 2 };
   614		struct sfi_counter_data *data_buf;
   615		dma_addr_t dma;
   616		u16 data_size;
   617		int err;
   618	
   619		cbd.index = cpu_to_le16((u16)index);
   620		cbd.cmd = 2;
   621		cbd.cls = BDCR_CMD_STREAM_FILTER;
   622		cbd.status_flags = 0;
   623	
   624		data_size = sizeof(struct sfi_counter_data);
   625		data_buf = kzalloc(data_size, __GFP_DMA | GFP_KERNEL);
   626		if (!data_buf)
   627			return -ENOMEM;
   628	
   629		dma = dma_map_single(&priv->si->pdev->dev, data_buf,
   630				     data_size, DMA_FROM_DEVICE);
   631		if (dma_mapping_error(&priv->si->pdev->dev, dma)) {
   632			netdev_err(priv->si->ndev, "DMA mapping failed!\n");
   633			err = -ENOMEM;
   634			goto exit;
   635		}
   636		cbd.addr[0] = lower_32_bits(dma);
   637		cbd.addr[1] = upper_32_bits(dma);
   638	
   639		cbd.length = cpu_to_le16(data_size);
   640	
   641		err = enetc_send_cmd(priv->si, &cbd);
   642		if (err)
   643			goto exit;
   644	
   645		cnt->matching_frames_count =
 > 646				((u64)le32_to_cpu(data_buf->matchh) << 32)
   647				+ data_buf->matchl;
   648	
   649		cnt->not_passing_sdu_count =
   650				((u64)le32_to_cpu(data_buf->msdu_droph) << 32)
   651				+ data_buf->msdu_dropl;
   652	
   653		cnt->passing_sdu_count = cnt->matching_frames_count
   654					- cnt->not_passing_sdu_count;
   655	
   656		cnt->not_passing_frames_count =
   657			((u64)le32_to_cpu(data_buf->stream_gate_droph) << 32)
   658			+ le32_to_cpu(data_buf->stream_gate_dropl);
   659	
   660		cnt->passing_frames_count = cnt->matching_frames_count
   661					- cnt->not_passing_sdu_count
   662					- cnt->not_passing_frames_count;
   663	
   664		cnt->red_frames_count =
   665			((u64)le32_to_cpu(data_buf->flow_meter_droph) << 32)
 > 666			+ le32_to_cpu(data_buf->flow_meter_dropl);
   667	
   668	exit:
   669		kfree(data_buf);
   670		return err;
   671	}
   672	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--1yeeQ81UyVL57Vl7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--1yeeQ81UyVL57Vl7--
