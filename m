Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4598D207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgE0Laq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:30:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:27398 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387397AbgE0Lap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:30:45 -0400
IronPort-SDR: L3UuCnrof8rQLZf+BCplu6VpGsJt99zhCrSSZrKab6XMdX2N+exsED18qAHKahaU+042d4z0z6
 R893RfkvH5zA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 04:18:27 -0700
IronPort-SDR: YPsrnKijXHb0xtPcpP5BleFBZtt45MKkCZ6US4w0ru+itlea9ZwTkH5b5qYceC8vfTMXvhr7dX
 hGpKZ5aUqujA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="gz'50?scan'50,208,50";a="442484059"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2020 04:18:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jdu4m-000DLy-5i; Wed, 27 May 2020 19:18:24 +0800
Date:   Wed, 27 May 2020 19:17:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: drivers/net/ethernet/intel/igc/igc_ptp.c:397:17: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202005271926.c6kaTjRU%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   444fc5cde64330661bf59944c43844e7d4c2ccd8
commit: 81b055205e8ba2d400c8fa5845ba540a4a880a3a igc: Add support for RX timestamping
date:   5 months ago
config: ia64-randconfig-s032-20200527 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-240-gf0fe1cd9-dirty
        git checkout 81b055205e8ba2d400c8fa5845ba540a4a880a3a
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=ia64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   ./arch/ia64/include/generated/uapi/asm/unistd_64.h:348:39: sparse: sparse: no newline at end of file
>> drivers/net/ethernet/intel/igc/igc_ptp.c:397:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be16 [usertype] @@
>> drivers/net/ethernet/intel/igc/igc_ptp.c:397:17: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/intel/igc/igc_ptp.c:397:17: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/intel/igc/igc_ptp.c:415:6: sparse: sparse: symbol 'igc_ptp_tx_hang' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_ptp.c:445:6: sparse: sparse: symbol 'igc_ptp_tx_work' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_ptp.c:549:6: sparse: sparse: symbol 'igc_ptp_suspend' was not declared. Should it be static?
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]

vim +397 drivers/net/ethernet/intel/igc/igc_ptp.c

   281	
   282	/**
   283	 * igc_ptp_set_timestamp_mode - setup hardware for timestamping
   284	 * @adapter: networking device structure
   285	 * @config: hwtstamp configuration
   286	 *
   287	 * Incoming time stamping has to be configured via the hardware
   288	 * filters. Not all combinations are supported, in particular event
   289	 * type has to be specified. Matching the kind of event packet is
   290	 * not supported, with the exception of "all V2 events regardless of
   291	 * level 2 or 4".
   292	 *
   293	 */
   294	static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
   295					      struct hwtstamp_config *config)
   296	{
   297		u32 tsync_rx_ctl = IGC_TSYNCRXCTL_ENABLED;
   298		struct igc_hw *hw = &adapter->hw;
   299		u32 tsync_rx_cfg = 0;
   300		bool is_l4 = false;
   301		bool is_l2 = false;
   302		u32 regval;
   303	
   304		/* reserved for future extensions */
   305		if (config->flags)
   306			return -EINVAL;
   307	
   308		switch (config->rx_filter) {
   309		case HWTSTAMP_FILTER_NONE:
   310			tsync_rx_ctl = 0;
   311			break;
   312		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
   313			tsync_rx_ctl |= IGC_TSYNCRXCTL_TYPE_L4_V1;
   314			tsync_rx_cfg = IGC_TSYNCRXCFG_PTP_V1_SYNC_MESSAGE;
   315			is_l4 = true;
   316			break;
   317		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
   318			tsync_rx_ctl |= IGC_TSYNCRXCTL_TYPE_L4_V1;
   319			tsync_rx_cfg = IGC_TSYNCRXCFG_PTP_V1_DELAY_REQ_MESSAGE;
   320			is_l4 = true;
   321			break;
   322		case HWTSTAMP_FILTER_PTP_V2_EVENT:
   323		case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
   324		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
   325		case HWTSTAMP_FILTER_PTP_V2_SYNC:
   326		case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
   327		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
   328		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
   329		case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
   330		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
   331			tsync_rx_ctl |= IGC_TSYNCRXCTL_TYPE_EVENT_V2;
   332			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
   333			is_l2 = true;
   334			is_l4 = true;
   335			break;
   336		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
   337		case HWTSTAMP_FILTER_NTP_ALL:
   338		case HWTSTAMP_FILTER_ALL:
   339			tsync_rx_ctl |= IGC_TSYNCRXCTL_TYPE_ALL;
   340			config->rx_filter = HWTSTAMP_FILTER_ALL;
   341			break;
   342			/* fall through */
   343		default:
   344			config->rx_filter = HWTSTAMP_FILTER_NONE;
   345			return -ERANGE;
   346		}
   347	
   348		/* Per-packet timestamping only works if all packets are
   349		 * timestamped, so enable timestamping in all packets as long
   350		 * as one Rx filter was configured.
   351		 */
   352		if (tsync_rx_ctl) {
   353			tsync_rx_ctl = IGC_TSYNCRXCTL_ENABLED;
   354			tsync_rx_ctl |= IGC_TSYNCRXCTL_TYPE_ALL;
   355			config->rx_filter = HWTSTAMP_FILTER_ALL;
   356			is_l2 = true;
   357			is_l4 = true;
   358	
   359			if (hw->mac.type == igc_i225) {
   360				regval = rd32(IGC_RXPBS);
   361				regval |= IGC_RXPBS_CFG_TS_EN;
   362				wr32(IGC_RXPBS, regval);
   363	
   364				/* FIXME: For now, only support retrieving RX
   365				 * timestamps from timer 0
   366				 */
   367				igc_ptp_enable_tstamp_all_rxqueues(adapter, 0);
   368			}
   369		}
   370	
   371		/* enable/disable RX */
   372		regval = rd32(IGC_TSYNCRXCTL);
   373		regval &= ~(IGC_TSYNCRXCTL_ENABLED | IGC_TSYNCRXCTL_TYPE_MASK);
   374		regval |= tsync_rx_ctl;
   375		wr32(IGC_TSYNCRXCTL, regval);
   376	
   377		/* define which PTP packets are time stamped */
   378		wr32(IGC_TSYNCRXCFG, tsync_rx_cfg);
   379	
   380		/* define ethertype filter for timestamped packets */
   381		if (is_l2)
   382			wr32(IGC_ETQF(3),
   383			     (IGC_ETQF_FILTER_ENABLE | /* enable filter */
   384			     IGC_ETQF_1588 | /* enable timestamping */
   385			     ETH_P_1588)); /* 1588 eth protocol type */
   386		else
   387			wr32(IGC_ETQF(3), 0);
   388	
   389		/* L4 Queue Filter[3]: filter by destination port and protocol */
   390		if (is_l4) {
   391			u32 ftqf = (IPPROTO_UDP /* UDP */
   392				    | IGC_FTQF_VF_BP /* VF not compared */
   393				    | IGC_FTQF_1588_TIME_STAMP /* Enable Timestamp */
   394				    | IGC_FTQF_MASK); /* mask all inputs */
   395			ftqf &= ~IGC_FTQF_MASK_PROTO_BP; /* enable protocol check */
   396	
 > 397			wr32(IGC_IMIR(3), htons(PTP_EV_PORT));
   398			wr32(IGC_IMIREXT(3),
   399			     (IGC_IMIREXT_SIZE_BP | IGC_IMIREXT_CTRL_BP));
   400			wr32(IGC_FTQF(3), ftqf);
   401		} else {
   402			wr32(IGC_FTQF(3), IGC_FTQF_MASK);
   403		}
   404		wrfl();
   405	
   406		/* clear TX/RX time stamp registers, just to be sure */
   407		regval = rd32(IGC_TXSTMPL);
   408		regval = rd32(IGC_TXSTMPH);
   409		regval = rd32(IGC_RXSTMPL);
   410		regval = rd32(IGC_RXSTMPH);
   411	
   412		return 0;
   413	}
   414	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
drzIeF1d3DLgVLdh+aFVl3W1s6vc+VXu8io3uv7eG78KPAE/FsT7OEEplz1zPq53sSRoXhkL
27WwF8prnrqbjV07Z4mskzEd1BY2ph5rkXpTE8s8QuER2Eby3IHSv9KlNTjm3c+feP5jiIic
qaXuviHuvdfvC9y/ajqwQa+3ImpjNu6qhnwNpsAWwx09FYwbGr321pAmGCvIzU7bQgzMkAso
jOQ+KYipxmpPiGBdjbIAyxiqj5ygP6o2fWXfw9Pvn9Ceu1OgAJCnWa+tWcV9YxavVqGOKtNR
+5f7EQl+fBo8t3VRs1Rvytq3rBgurxQUNHJn84hYIuZY9tEO3+Pbfz4Vz59i/O7Qdh9mkRTx
bjEUaaNjeEF1y36dLcfUWgGKdhcbfliH9pty0P+7cxx3rcg58gJVq5LxOEb7fM8y/7wvIALr
E7XLq0fqWaVw28bOY6M8k4zN999fYJm/A5v/aaJK+bserMOGiFufKp+E44VyxAs0w9/2GmqH
bUNLlOJnjQOx3pFxWBJkHCO4I9l9S/b49s0tLCzivuNBnxp/Obfl9pxKxMWe+jghD0Ue70V5
lalXWhuz62/IJsqCmhJ1NhLeix3l2UEl2Gzqc6XhllQNpSXObf/Qf+cTmKcmPzRSKqlqKDG3
/F/QHanXJfqR8nHGdibHjdd3gNCeU4WVL/cFGMbePKEENnxjnBLmXj0hdwvKVBZUMVBilx75
ZtQvVc6+nmrx9xcwhL09/YLCGfPvRyljVPbcA8GBMNhHmtSS8QwdkzVRdLu+GWXUwoy5HFNz
VPRtSOPcWRgV8Kc5VVMHcYTR8/ry/vLt5cneQsxL90IYA89u59whtufHNMUHcsHthHATWEpc
NUS5mJPbRl9xObFcN/C5VT3a35VwRQyAdAcufLUYRxC+KoAOUFcFkmoThqdX1fEBXx4+4DfR
Vf5IUegM8gS0L3TOiZMT/Qa8SwtP2fBEjRQwflwfteVHNVBJt321U9Ep49S9Tn21nULh2MBo
twF/Z+TpwC7aH8l+ab9sWFscnf3Hc1lUEmYcuUhP07l7102ymq+aNinJG3WSY5ZdzBbNMOj2
LK/JOyJrsc08/w9Fum0ax9tDxHK9mMvllFLSeB6nhTyiWwavlEeMdRhVtiK1FlBWJnIdTefM
Q7uV6Xw9nS6I3DVr7twa2FVQDbzVinbj6WQ2+5nnbeQJqCKtp86m8j6LbxYr2rJK5Owmolky
NBqc4xf/iMXINHjRZtPKZMvt+fNUslw40Ofx3IfB0PcUcFgaM+e4qWsgxYEBN6cDyAw/5TsW
gKowEhlrbqLb1TWR9SJuaHd5IwBGaxut9yWX1KxrhDifTadLe5X3vs6qjc3tbKr68KhG6oc/
794mAr1N/vihrnx9+373Ctr0O24fYT6TJ9CuJ/cwCh9/4r/DGKzRPLUL8P/IjBrP7tYrw8g6
hoZwmXaKEt719jTJRAw6zevD0907vOPNPx89FaV7FQAQrAc89GyrTp3vYkqvZNzvWfL8/MX2
rlDPvbqLdwwWVX9J4eDowuO9rSbjoRVL46IaqePIqWrZtN7pcjfw2IblYL4Ku+DOLDlInvCO
RcfiEcm4E+D9MZ3pNKpGdblM5l4mVjGRwFipA5f7ydi/QrGz2IgXOasdvQVAL149xFxFL0Pb
o/TumtB9h3M+mS3Wy8k/t4+vD2f4+df4q7ei4ugL6BzCGFpb7APH/r1EHgAPGQQKSW/vXi1e
V7pcIRe6y0gmnF6UE1XTNc8x3+EdgHv3hr0qDpUag2v1IcpYFQVL//318bc/cKSYAz9m3Tvl
bGd0fgJ/M0k/cOo9uinau2bJ2FXrBIsHDKZFXAQheToZlrCy5uGArE5sx8n6s0VSFqO+a8cS
yRQM1HEgWp+i5vSleHqeq6XnBNaly9hX5zIimAKsiiFfFRg4tsiXI+g9gjrWt6Vsn0ebju8v
3Jsd65Q6+AeytTuMT15odzojA8bThn7xEaZY+6Yi9QyKfBRNp2SKTVWwJC6c4MzNkgqm28QI
VOtW6iZvaG0mBr2DnpzErshpdGPMjA7005dz+prLkMy+3AueTPhbj47rFhjs3HNG9jS3WmIH
E3iTM7L+UCqPeaCnxewkjh8Ou3jPUxn0yeyE8LIju5u7ip0tqQ596SUjyWnw4iF1wkf51sc0
BNRspfM9GsciPDum3Oq4Gz73+5OijBvIF4A/VE/omAsizxR3tQL3rGkJebjs2fmjb/hqNtKo
OtgeP4taUg6/lpC+VdhSk070xLY/sjMfLV2GKSIw5Cgl2JbBfXqrx8zsKQCfHLtIEchLC3bu
Re67zZX2Ae6J2mUSjZcLPJMvQ/rJudxALOlisZPlQYJCznNsX6uezaaW367YWbP254yu/YxV
J277yWYnf3GVhwDyCHQkqnvauUPWLC8cuzFLm2UbQAIH3iqs0AFXnq+y3Vu5ifKI2PG9P8go
Ws0gpUP7GkXLxtfKvVwKHB4fzRVKUPKM0uJtsYvrzIrPs2mg0recpfkHIyJnNb7VavARQUaL
aE4vlfAvr7obDrumnpPz9qmxAVPwqXPeQWeWVjtgUzUD/1ZFXoTx/HrBD+ouWqyd4d2d7TUh
XTbn84NvWPmpy6AmbJfsJJKPFKfiYNU5XskcWsvMtWPa6zB8n1YnDcYyg/+uv/xLWuzs85ov
KVs0TWMTYm911ZRrikPD8zZ3crWPUOCBnmZAzUzxqMcSjXEPI2O2k1WW+7e+meSVfY95dTNd
TgP1iIicNQ8Cpg5iUMsshCLSCWFsbEWWR7IMjShL58f5HFuYFuf8C80oUlZt4ceqNbmNnQfj
CmUT4gQtcneAdnRo9B2NQ4QiW2yG3M1O03yPK7uUIiVDIx0R+xY+IdfuoguU2Zreg7QzySRl
BDj1FaNvThOyeGStptwPMjk690iX5SXjtuuZNo+H5xijeXN78hTH0PsveVHKy4cDuOb7Y01P
QbbUhxInEYS27UTO4uuHurDeVrW/yWy0skaoMfrRSxpRxeTm+TZJnKUt4dsmYPsctvR6Cuts
GVoE5Maod93Kqf2yT45apIjORqCmxHjVsnBmIM0Q9YbZg1tRvUNu5astYwz7E45RqTj1/pgn
dMDQ/pIKC1lDnvU2jD7qEGICj1c8QVgicsyDspWzZLSlY6x7P8UgoA8uN4EsoYpuYcUw2Q7E
6JYg6khz7/M6s3ucxTKKZi41FmBkMo+mbTyXmIC1OcozKVGjmftVgOQ6jmazwCeqZMuIShbd
3F5LdLN2C7AVDU9ckojL9Cg9mvIqas7s4tLBMob1YzadzWKP0dR+6YzSHihdxwUVcpRQ6b/B
7tArtqGce37ttV2v6brkXEUqs9SjNpDBZzab+b2I1dF04dG+jHM1i7xPVEu6/8W4iF/5Ilxy
3HxkDRZiYx0U4K4cdG0Rew15EjWXkrtEM2/uYCTPq53eku1Gfura02VJIhKmtvuKTPe2MgC8
3p3fVrsUA7HJao+GUefqv5tuitm/vL1/enu8f5gc5abbV1bleHi4f7hXzmrI6XAh2P3dT4Sy
JI7Mzp5WoHjnx4w1E9y1fnp4e5tsXl/u7n+7e763TnD1SdyzupHbLsT7C2TzYHJABrF1/GH2
VvEC+AcW/B+xpz2crGdoQlCnrWb3o+VuOC0sO+iv5OHrXI2TFTIh9aqTiyF3gqnOO+E3p2A/
/3gPntt0YdH2owoL92nbLTpkpB52muYhSEnoGiUtoa8TP9C+PVokY3UlmoP2/+yd1Z+w2R6f
oXP9fvfNjTQzyYoj9HIS7EULfC4unoOLpvPTtVT8pGF7rCoMOSjqBAd+2RROcF1HgeW4XK3c
c3eXF0VEOTyRNZVxfdhQL/wCK8RqGmDc0oz57IZiJAbgp7qJVgQ7PegSjD8sEFfv8FXH4dQX
1DG7Wboe2zYvWs5oZ5peSPem6zJpFnl3C1ISiwVRPphfbhcrqk2yWJKlhvl4RsYn9hI5P9eu
udazEA4Kd7QoW3So0SJNtkLuTaAOUTZZF2cGOgXFOuahlqyzeVsXx3jv3dNNSJ7T5XRBuYj0
Io3bZa0xbKkJ+NiW0oGQ7YktS0vSGbsX2FwSIjO0eQX8LUuKCTYZK3H5vsqE5dPzIhyE4ota
cWmVqZdS3mzKe+UDQQ7rJp4YXv1S9NXnqeNuO7xJNZmoKd62iFE5ss8jrUwz1wxSjHHclqaD
YZxy9aor3wOa/Gp9S7vMaIn4wsrAsb7iY22gw8cVkZMEI4RRW22a75lm+qv6htXOJF6WAxsV
jfDqBksM3n5CbyhpEYW5HcB31wJYhxIUb07CGutxImTsj50oKrNo2rRFjsiAHpMlt7OlY7Lb
dL9CHZFNxmb2GmKWxUUzBSu59iYqUzyZgb67qXzsc2+Zb25vb9YL3FNxYrt7drRe34a48Wxx
Gy3a8lz1hXAFMlgbVtNx2XblnL6tWzPRoOfcC6e1mAlHNNvwVykh9e1EZddChabWnD4d7vUH
UJJyIxl80aGpP6/H71AYIFnoyh4tcwGDyDuV9CTibDZdB19d8Z3GtQ80DmvKOXTEkh98jlkX
nGbzu78RUXV4pYhH9SdYxjLeRqvbpV+A8pwN7TvidO02btGqqFl1Qb/MIqH6RsLW09Vcj71g
mVjSpItlMx6biuzPPF1LsIUHq+bwRcJhwsSQHvhvw0aflVSn+Q00xt5f1Cz2zcpi+x+mBLph
SC23VSaWo0AZRQxN04oJi0sos+3U0rQ6ilp4Co8+T4wnoC9vw3EZytynLKajEm8X9NqkmSvK
/8OwVr3FfPd6r2LlxS/FBE0sxwvZ+QQixsCTUI+tiKbLuU+E3240giaDeeWpb4Yeo8pD7SAo
dio2npql6d69Hg7PeCDpdO7L5DzzsIxMkipurxVD2wJ2hkevRnYs4+53d5Q2l2AdEfR0SRB5
dpxNDzOCs4VVVHtqm00EqkUHB1DCpta26fe717tvuBcyckava2fP6UTNYsdcNOuoLeuLMyi1
Q7Ei09viSjsziCl5Aoo2tWFQfC2c0912J60DDH0Yq+938KlSQ30Nmw0YGlKTF7v0Voj+XILa
clalFxWqV6TO9JEqjBZ2rAv0VKJddvgpFOoBrIPHM0GUr493T+PgKFNpqjSxc9ylGdHc1n8s
IrwJVH0Vqj+OurblvJAdm7XFHV7Ku8YWGqqIytwOY7UZvGFV6LXx1f6jRDKeg55FzdK2VF61
RwV9sKS41TFHpJ1ehHwRb2qeJwG4A6e6aVB454X1PIqI4JSX50/IB4rqA2oHcey7rDPCwqY6
zo5mBNujF+hrZeZJuJEhFpEaBob9WZIgpZop4zhvqN6lGV221ypOxrMbIW9JxykjYub6zzXb
HVk1mtnHEtR7yQRH5i9iLg8NAYXBNOpgttCGHRO8jfPX2Ww1n06vSIaaznFaHWjX5LGVddH8
Vq7K+SgB0IZuMdwXYLhbmbZpGajbgfl3mlNJi3yb8gaThFsAB/jX2WJlL3beHOmniOsq9Qxo
w8IQL2e7wKKrVHgNq7Nw4wpQVjD9HSiaQfPs40YV1VW9U7J3d/Klt9lrYt/CKUSZCVDE8iR1
rAOkJvijLD+PoSDvEla71p7iYIyR3oGjrRiVrzp7Vod81ZaRSIxKzoZZ1AQpth7pjLc7JMXO
LyEahMXWld6M3jyw92fQ+vLExoPoSQo2DfSxjJNcz7VyYIzRUvkWbOGadOIuS/SI7+PAtZPV
5BuhTw09/5LHan+atFAQRA6R9peeb+dAXwYC3uJqvqT3jkXZQT+77B6FL1Boy6ZgZwLravBj
KAO7RNBDd/GexwfdGMT31jH8lM6hkNWCJRm1iEmE2v3C8A3ubPDZTJhXRE5HJNhi+fFUeOY9
slXW5Fchl8rbEYgrShtBzqlGSFO8x9CaS0x5ZL1YfC3nyzDHjSCDoeFOVI1I04u33dvRCBTY
DpFy3PZ9y+uWqI4SVq6iqHtUOH3IBGbz+HjOiXGLS6GquQD1cyec3S+gqg12ddGIPSnNYwI3
xWbuIZWaMi1idmy6YmV/PL0//nx6+BO+CIuosDqIc16TLHTu07HTOl4upjej10GFsvVqOfPL
PrD+vJIrVMc4xyxt4jJN7GXu6sfY6Q10Hpoibsbe5rgaOOmu2Nj77B0Rym03bm9QIuzaUINm
tptAzkD//vL2fhUEVGcuZqvFyq8rRb6hw0l6fnOFnyW3K/IuV82MZvb+iiG2WTn3CyIiMrxZ
saR96ICUUohm6eeQK0jnwH4p8pVbLXQ2KrxAtZOQq9V6VEVAviEPqAxzfdO4pTvZ8KiGABNO
164K/5fwwFLZxa5L9zDK/3p7f/gx+Q3R9wz6zz9/QLs//TV5+PHbwz16WPxipD6BBYOwQP9y
e0CMc5CrkCE54Yjnr7ApXYvDYzq2I/JMVk751a6MxqMX+WcFZRdsjwPPYKgF6rVQR5deq8fM
hn7xGinz4u4sZu+FqB1E/oSZ9hk01/9xdmXNkeM4+q/4aWMnYmZbR+p6mAelpEyrratE5WG/
ZHjsrC7HuOwK2zXTs79+AVIHDzBdsQ/d5cQHHgIvkAQBgH4TI+h+tEUhRw7hu0Mig/68vbbo
bcA1pC0D1c48YWg/vokJZayC1LKyWYp1EtA+n3Z+zaEq3ReGuJA4vve21l0Y3FtfRSwsOHF9
wrLe0dqPvILNtfbVF/cY/gloo9s8ymruIOHKpsjiaZt15MuJa1l5hh/K8iiObFmpeUhayM9P
+DBdHtGYBa6V5J5DdQDdMavX32boRnYx7XdsKstc+zEfUG/R4+wN1/n0QkaQn5rR1ZpYTB82
CzYO/bk+f6Af0fuP1zdzkRo6qO3rwz+JusJ3uUEcQ6YtjzIlm28Jc88rtORpiuHQ9twoj+ux
bEhrdAQ3mXXBQIIB/Mg9V8Ko5qW9/4+tHHSBkNXyAm9WcU5ZNrgflURQNkLNkRjgL+nMsmhg
05OZgBgFVIZ8xwuLotJSI7nOOs9nDm23MjGxoxs41IHMnAuqjKlZaMZWUeUGFsC3AYl0YIEd
QTHLHQncKxMokNej46bA9WSOk+pQaEpU9l/0t4FCbhYFkWfFA6KpeU3NoFG5AY6zaKnCT9X3
+x8/YPHkRRjzv6hsnXfK9C+udw9a5GEVxhNVOzr3k3E5s3PW6zhkEdW8Ai6aO9eLjNqJJc+W
CnWwTXatqLl2acxKCKee//wBo5KQkrBK02Q+UlW/xVJrOBTVO9JUIheu5/tH4/tHOqawy1bc
/FqlNHRl5sWuI4uJEIPoTJv8F8SjGvQJel/etQ1lZyAsDPIkiNz6sDf7H79HtqUTypUmrKrz
k5VvyFadHcQldhYMQayzDh0LAycOKXLiejr5S32MQ6PehMGXynCo4yRZkdoCIeU5GMJF6a+H
+Eh1Etgb46sKl9rBTCyF4JFPBYSM8sz33KOylJj1UGUNC9BOsiWTvX4fXDxwnCYn92//fho1
vvoelHr5i4BzDEaIFovtUcljClPIvFWsbLJkzD1QJzsLh7pLWOhsq7iGISopV5493/9LPXyD
nITmie4dLFUQDKxWw13PAH6YE1xKyjlie+KYe8G2eLdXWF3fngvtZknhIe1EZY7YCRQpL0l9
xwa41ir5nxW38mM618A50kAUW+oRxS4NxIWzstUwLtyIHNZqf5E0HO6EIt1TJ7UCgz2i/LBT
IuL/B+XCaI551FXKpbpMtyrhChN/xapkga+LkIM+j8SAAXYYdwhb/E5YIZyQOgRZpwOMvlsu
eNniWqbHNrproXsmna2VTclUMSBTFpJpk46onGjKa/3Fwxdel76GL2BE7dLEVc3xJgTUADfS
TuBpFiJbjkzztfaF3IKQdIA3cVRdHKlq1oRYdNMlay4mKmU1+CHpeHliABmu3EAamwqQODTg
BRENROrxnwQFseUN7dwF6rW/ii5UVagGCdls23S3LfAU10tWl7r3ZPBhtl0/BI7vU5Xvh2QV
UMvBNEbln6d9meuk8ZBDbDuEAcD9B+i9lO3H6LIwj1aupAwo9Jii167juTYgsAGhDUgsgLo2
SFDikWNm4Riio+tQuQ7wSaTzRwFRralwhJ418WW3kJwjIBMz/3JSlkWhR4uCdUVBnTjODMOx
IxoqZyHtAhO9UZIPNGYGYeyZ5pmZaxncwEZsbQKbyAXNYEMViFDsbWjHtgtT4EeBzWpH8ExW
0WlOHQPNOQ2g9u2GdCiYWc1tFbixbA0mAZ5DArB6pSTZM6nX5XXo+qTYy3WdFrShy8zQFUcy
6RBT09gE/56tiKrA2t27nkeMEAz1km4LAuCzHTG2BRBZAd22V4Ets7TEA+uF+ymP51IzpsLh
kQOXQ6tPE4eUpDhADC5cl0MnJETFEZeY7TgQxlQNEUoutTB6UQ2p2ZgDPl1aGFLdggMB8a0c
SCJL/Xw3Si5NYHXW+eR6MWRhsCIzLZqN565rwr+K2YS15bZvYYgoRUiCyWkZ6NFn+VJPFhc4
Jsc6Pqf7JN/4YoesY2qw1QnVR+uEaGag+nTNksCzWIErPKTSo3KQIu2yOPLDS10FOVYe8X3N
kIk9dsm0sFwzRzbAELosWuSJokvSBQ7YeRBCQyBxyN7adNz5w8XP2sRBoizhXb0mw6lMSdj1
4BJTCJCpkQRk/0+SnFHc872wvrrXsKP1CfEXsLyuHLLXAOS5zmW5A0948JzLEzk6GFhF9aW+
NbFQvVpgaz8hqs+y6yA8Ho0QGgrukfMbh3zqOG3mGAYWBaR+xuoaJtSLamHmenEe02o2g00t
BYA0Y6oXlE3qOcSEj3TZm5VE9z1asxyyiHrxMcPXdUYtFEPduQ650nLk0jzMGcglEBDaVbzM
QK4vdRe4ZKfdl2kYh/Qbq5lncL2LG4L9EHv0FuUQ+1HkX1ZqkSd2LynvyJG4ufldHPByW8nJ
JTFzBmLoC/ppk04XelTWVRQHZPRDlSdU/H0tEAyxa3IXILDimvITOfEc8Yrp77TJiT5A0EaM
n08t1eCLh+y7aiSceHhdpj4Qm7CiLmBT3uCrk9GUFLbXVXp7qtnirHxiNg7RJgDDfPCoukNf
WmLtTaxjJPTTtt2je5XudCgZZRlL8W/SshfRM6lKyJw8MCrraKPbKcHnWf5qJZEP3USdRl9R
ZEYX65QX+01ffJEa0cgDPclyFzrUmbFhHjxRjMd7M9C0h/S23dGGMDOXMJnmhoxj6GRqQM/s
6MJgDr/sEPnxu1/DtOZw//Hw7fH1j6vu7fzx9P38+vPjavsKff/lVblGmXLp+mIsBEVLfLXK
AOOmkp2x2NgaLXzMJ+xdqng/pNjkTjmxq19s8zfC2s1AtKtClkpaOMYDDDPpsucgsTsnTKiO
lKdQYK5azKJfI5P1rix7vDgwkdFjtIws9gKHmUwNsfHFMJUSN23+8Ugmn5nSqqwj13HxG2iL
p9B3nIKtdYYJHrJW/X5Omf0HdqrJjbjFHRMsNYVRkXpGHaab0L/94/79/Lj0iez+7VGNCN9l
VMsM6usw+IauZaxcKy9a2FplYZ0SDpKnykoeAYNMPaE6EW3g9VTLuqewUIse1iQv2wvlTrBK
nQI4ZyV/WEUnVZlITL0wXWd1SuSFZI1JVDgrLdwzTpFZm2nkpaKy9DjENlXKKMcgcsJtnWan
rG6M1NJXkr1eMOlXZ4st+NefLw88XLDhf3Dq0ptcsz5FCh71yubDXV1mlCEF500HL47MWDQS
C3cp4siaPadKFhZyftwzAUVTDeyRrptQLDST1zC6monq7cxMjumIPzNOniUtqLK74ALEKd0n
7cUmVL6Vw5zGRUD3dzIh9goiHFpC5E4wpX2PoOJMhAs1c1VHwxJRrx7s5WGRZGVG77URhhS0
BXLVASgbnSOBjQZTUtG/p80dDJg2J68AkUO3w0GacL9i9GBBtguT46FDPzISXe7orgLLMdzI
wP2oWOrK4Vg2EBqpceJEem052aM26zOa0IkS2pyR40Pok6e3HJw0Dj1XUFt21iy7bBNAJ7N9
82LEIxOn60aZpltEIZEVGTFtsXIVhUcKqAPH1WvPibZbZM5wcxtDu3p6XrJfn3R9DBxHKzJd
+66NqAaRxvxuWaaESwXagNGjfT84ngaWKXdYiOrWZIIWR7IN4JhLVe/0z+7Sqib9ZONNsusE
yu2NuF12qZlOQJHWgqal2kJNjJGHNYSK+/ahxVPG4ScMCVlDCfaI+gDVXCUAgRnCl9a+SXU1
e9WEpDstvAIA6ND8QlwDSH2oXC/yLy2bVe0H+miYbfsk2v4YB9q6Nho3kkTL0uit9NY51IHr
2BcRhF36XkzAOBFdhql7iRFcmfM0UH3XcIRlsASOxVfWXKzypXyvwzqiseR3aDZFasp79re0
SHZxwcQVNAoQDob3bTWIu8ylUjMLPsvdcf8DDdvRb0kXZjyc4GcTMztVKqxn2zg80uWNayQp
4YUrzYY4Jk+MJZ488JOYLiVt4B9qky6x8PmSqr+unUqIpjsuiKmCSpipiEptp6llCuK5ZAU5
QlZwkzaBH8ijdcH0Z10LUrIq8UnbS4Un9CI3pXKGiST0yU/HpSQia8oRj64Pt8miFFmVJQjs
yWNaF5GYhswPYsrBmcoTRiFdCiplsHJczADVonCVWDOIw/CzkTBqab/CZYmsqnFZ5kyFy6ZM
Skyjbq6uWioexb7lywEEHfNyAaAx0n282+zuCsvQ7fZx7IR2SL2K1kBywyXxHGoqX0N/lCBN
3VwQ5tVdqqqMKshc+pJQ4grqOAopnVriMTRMCau2gRoKYcFASwnc0CfTSWociXk+LX+ho3mk
OCRdj/jSSef7RCCTEnhRIpzJtX+ZqsspmKa3SZjQ0yjIVDQUTHsOMbJkxuYDKU07lJtSWXFH
tu8SAT1mz7+rUnZo02eT50rVxx+GVsoop5YyC/Tyz1nCz1h+339aEGub20950ub2ohtOcVnT
TSzyoX6J009xulnnn5VyrLvLZZTCzJQqos/q+kJi3hT7MRjr0jUyyT0oXSRe/aklldZ4c2MF
Nfd9miA0X7ZSWnRxVfZLZyr70U+ZQpqcfGifX6AnJotzAYy50xdpfZfS0Vuw8G3bd9Vua/W0
iyy71BLJEdBhgKSlRfRV23b4SkT5kNGnsUlCr3cNq8tBcYWHcKm0OmR8XLfHU76nDp7qAl0U
LPcAyxHq9/Pj0/3Vw+vbmfKkIdJlac0DWovk9O6EM4JIqhY2iPtf4M3LbTng9/0Kc5/iUymC
T/2+XL7r0D8CZhl7BvsyL3ggnkXGgrRfVR5F048FBZLme/O8WuMRu6K6bHCJTpst6UmdF7E5
NMLf0/iuFFvKPOLmX4dn/cSno0TmMN+2gMhMtPv58aqus9/wQmNyXCAVw+u+3m08bW1Y6ISk
OL2GCaVjZIo6rao2Uz/w/uXh6fn5/u0/i0OKj58v8O9focYv76/4x5P3AL9+PP316uvb68sH
7GTf/2J2W7Zb5/2eO05hRVVk9nbHAQ3N+X15klq8PLw+8kIfz9NfY/H88fgrd7Pw7fz8A/5B
pxjzm/305+PTq5Tqx9vrw/l9Tvj96U/NP4eowrDn5yzWKg55Gq18z+xyACSxxXvUyFFgAIOA
OjOQGGQzZEGuWeevHIOcMd93YpMa+LJd8kKtfC8lql3tfc9Jy8zzqSVAMO3y1PVXxEeD8qIZ
EBIMfnKBYd95Eas7apsnGLgmsB42J2Caemifs7lltaEBWkEainfKnHX/9Hh+lZnNmSJyY2qX
I/D1EMsmyjMxCE1pADmkdoICvWGO9pJ7bN4qDvdRGNIbsvmjItspmMxhF+Ow7wLN77sEBJS6
POOR4xhz73DwYmdlUpNEdtksUUOK6hq9et8dfWGKLzUfDth7ZTwTrR65EfF52dELtGEpZXx+
uZAd1VgcIA2Spe4UGV8lyMawRLK/MuTFyYlJvolj+SpjFOM1iz1nFlh2//38dj/OkXrspAqo
0srFaZvn+/dvOqOQztN3mDT/df5+fvmY51Z1XujyEPY88nGQDPDt8DIZ/yZyfXiFbGEmxmPO
KVdTymEUeNfEGpn3V3wZ0iuEK2ydHj0hZbGOPb0/nGEJezm/ohctdY3QZRj5Zr+tAy9KjLac
FA7JY8D/Y5USX9OVer0W95s6pioaw65Z/MRlP98/Xr8//e/5atgL8RiKCedHN0qdbIQgY7CA
uap/Yw2NveQSqNzRGPnKx38amsSyCb8CFmkQhbaUHLSkrAfPUT0C6KjlyM1gI28WVSYvDC+U
5Pr0GY7MhkGY6MsliemYeY5sAK1igRrPUsF0d5dKDY8VJA3IJ8AGWzRYxJ2tViyWR5CC4riU
XwCZ3cONbfXbZI5jOQUz2Cy3SDrbZ006VsmjK1xckuYmg+Xms4as47hnIeRikeawSxPHsXR7
VnpuENnKL4fEtd1zSmw9LBmX9nlzm/uO228+7761m7sg2RV1mGswruHLV/IUSk1f8rz2fr7K
9+urzbTHmFap4fX1+R3dRMHqdX5+/XH1cv73shORJ1NbRpxn+3b/49vTA+FuK91Kt+jw41Su
5FNNpFx3p7uj1FT7LWy/+7VBwEGAvgnZ393ZkXHeS0fJOe4MO9glHSX/m4vdI6L8KXNNPYxc
YNhhbdAhwXKEgdhNzUb/lXSmUHDNMOBQ11bt9vbUFxvaMhuTbNboyZm0MFb40JfpCRo/h612
X6OTQVvNOzwVUEUxDLVBOOVod5du0ZCvrVR436f18olaOoq+LeoTu4ZNMYnutdJZds2D0s0b
01FzvHo1dp9SKuFMFdTnUM1NeDSs3HClNwd3ZIlRTmFZTGJKnTe4AsOBka1uQhXra8Vv8phO
JqtV6tPc5okX4bTONZeb05OEq/8We/DstZv23n+BHy9fn/74+XaP19xKBX4pgVp20+72RUr5
++RtqATj5hQYByoFT1q7rNxq3tYR2uWVJeOUGcz1Nt16ZHAeRLOy73fs9KXgdjIS8OWodeN1
m11rVRy9lYOQVXqXNtw5Mxdi/vT+4/n+P1cdaLvPSsNqiFJYX+by4+Y51wVRMi+nmJtX67en
xz/OWm8Xp47lEf44RpM/Jq0WZhZyDsXQpPvSmPhG8vS4wSJkERBFTzvkG9so6l0vJtrRwi0C
1SvMtiDqnD3dw0RlyUsIue3R2SKfQ09fdmV/ozU8usyb/a+Lvdob7O6u/vHz61cY07keTGaz
PmU1BueUmhRo/MZIDjctLU7TxMynaSVVLpuDwW/+pmNfsNS0Ysdy4b9NWVV9kZlA1na3UEZq
AGUNIlpXpTKaMKe2L8ptcyoa0ByoFyzAw2BdVTwTYh3T7Ia7a1WoPJSxmOOZAgxlxUsfymZL
Svjb5JiV8OaLn8BHNV29rva0jwIKiGjTntA1Z9s09DkoZnu7LnpP0zFlOrYN2e+AKYVlBWRm
ybqERV4X9g4blWafQ4wqYmOgwqlWutjJuPNlLevRIzNtJrXgmt3SAtDt2Zf71CCo1mYTccpZ
rhQH5pwtcopWuvSFKzaaXayQejmcaP/4Ebd8owCp+qfDLcxb1vYf6His2G5kSOr1OFNppQii
1Qhu4UizrKBmZOQotY5TspPiEXKiuYHecYoWpobSIrmb275VMvFhjtdyQNKlunFc7zP7ts3b
1tWy2g9xSLp6wykE1kmYw5Vc0v7GGPr0HSgOatC7YMK2CFC3J8auuQbV9TisAovxHLBMfpZs
+GjrZ4PrAnp609aWSqHDUk8b/SON335ttYVjwnRhz0dRSqeqI30TPyoQ5NLHJ+T1/cM/n5/+
+PZx9V9XVZZbw5oDdsqqlLHx0n2pDSKS4/GROo9MS6oFN9zRLpBuXLsgih3RQp4NAWexLNiX
rK1Ph8oSHmvhG5/QEO2n8MRx6NAFcZD0wqR8WejL7n40KCGRLg5U028Fi8io55LMUBvqyTJN
GyfpczRLTqnl1HddS132IL+o6ihsnYeuE5Hl9NkxaxpZ7/2kc0qHBPjwWo69k9fKKy/QrFty
YBinF9Ktc7trlL4inJmXuTk4rkvl/Tz8XLwGDn3RbAd6OgFGm2XJDgsyWxOzXgaMOAb/cX7A
UFOYwLhXR/50pQam5rSs3x31OnPiaUM9nOdwp005nMhIJY5DO1BbK7XcdVHdlI1Ky2Bj0t/q
tBJ+3eqlZe1ua/EcjXCdZmlV0Ws4T85P0+zwhYDjiENjbdumpx+oI0NRs9Nmo1cab+1b6tyJ
g3ciyrSSArbe67KnJyqObyxOsRGE/Izw4TJ8W6iiPqTV0HZ6FfZlcWBtU9IaDK/EbW97I49w
iQ+R9VxL0iYLkd9TJWQwkoZD2VynWme5KRoGOw4lUjXSq0zz0cCJRa4Tmnbf6rXCfbclMrzo
VaBM8fjlekLYTuNqf6E/3tpeliLMLby2+pfUZda3+PZcI7cYYqzQxgmGhy15c+t1awYyiAMg
sP2UI0ojCZYGPB6o2l4SmEQ8yXHPeIJiSKvb5qhRYdDCPK1XZSSDimKV1MRyaWsh84lSKKDI
mVF+BV/SY2e2TVVdD7tpYz5kaamFFNXgmu0a2kiK4+hPUQ8QLuNDkdZGmUNRVGg0V9jnISi1
q6zTbi+HpOUDtS+KBra2shvziWQ0LKvTfvi9vcUCFkSmGkmG0hxSMKMw2pskR69hCNdaLtcY
xsuMUiLT7WsTRq08nDrma3NbWaIdqEo8lk3dqqS7om/VL54oxHx+d5vDSmmd+P6vsidpbhtX
+q+4cppXlZnY8hL7kANFQhIibiZISfaFpdiKo0piuSy53uT9+q8bIEgsDSXfYcZRd2Ml0OgG
elGBY9pZM3ZmVsFjGA0IouqXd5qmbkwX/Z5NHPJDHixKJpFJt7iVrMuj7TMzG0BdvhHjtpiB
SoJ3PCnrrpOGISGesNVDcJOW3M9pYxDAP/OQUyfiZULvWSTamc1MaEPbRgVO0PIQEsm0tI6p
BsLLb7/22weYx3T9y8po1DeRF6WscBUzvggOQMarX4TS9hxpyakmSqaB7IT1XcnosxcLVgV8
EbHkNXloZZnpO5jF7bjLIeOClP2m+HRtSL1oohpId4rl5OuYNhGRhpbK1nKGadbiIc2aF2QF
Czt3VQgSycwM4NCDWpkHJQZxrDAvHge8E8cBESAUFzP8V6DvqmCXXcUq2VWZ1hNKTkOKKI1N
v0E5FXwC+zixgUaYZqcF1btAvmgkiccfQ66amUyTBpU4g7MoGhgFv4KlQb6gYwO33lzXhZjx
cWRH0UBEZmaTzUCwrXlMQPpPaiSNEYftw3fKxLcr0uQimjAMQd9klkiVYbwUtTLpQQof6bX7
+4Wo+yG/n/mk1WM+Sxksb8+vHSOYDl9dko5XOVtq+aOD4C91AWJpoz209cRDm2hcoSyUwy7A
zKMxpixlvk6KdxredMvy8gLl1OmPBI68DqnLlnBf8F7igrYRkXiVVIaaF4m2LwtUjegjf+F3
BMBk7pYOe3lJRF/scWbsvgF4TgDNuMod8Pry1C9uO+0PYzXdt0woNVREXdmZeCTcz1PjTOqS
VvQksneDCs3VOBlZ8UclcAgRY0IJX0MJr+MIvcrCnajT+PLmjIxYqir2g130y+2SSkGqShnh
LJw1fvJ193ry5cf2+ftfZ/+RZ201HZ9093pvmFeGkpZO/hoET8vKXk0UiulHZjpLVzDZoc6i
R7c/cTKwQ7dOyS1bv26fnhzxQxWFXT91fBw6vDoS+ZiDVGZdG8icv8DJc/rWoKpjxXHoJ1eM
xyNdqbyOAmrcTE52L2hAYFqM3uUxPlqaEZ+WEmqIiKrwAFC/eysbYQqnTkP9gJtVwgVocKbi
m1xcWCk9eDbFyPac23qhTkKp3/oHvZalfQa/UwdcFXJUlzZYsV5YlkJYEc27B3983tW4d+80
Ei2RpFKbtoWtRpgY+vrAoAifEbJ1YpV0hY0vYTKkBrO3m2nPEVCik8mU5VYSMUQkaORDISLT
6AgBsAviQlgspOnySHVXlpTwDhQ5q1dOb0DnEzYom1yZSaYWE9sRH3+D8M5hu9HhbiRBBsuc
xnJYJ4RrkYE2p7CzKgEu1XhAS5QaYISFRYcco/9QYBl0JDwvA9EjdU8yW5nqTLgfXnf73dfD
yezXy+b178XJ09sGpCPTRU7Hz/gNqXFxcGflaxZ1NOV2JE5geSyhU4su6qurQEQs9X516fsa
ADNff397wcyi+92Pzcn+ZbN5+GYZe9MUhlKjOtl617/K2Or58XW3fTTZcCRt28h+AoetCrwg
FQWZUddKIg4ypLgTtTSTi0qT3elGjQngFVvCf53LJNm41i5az81qIAGhspxGyJJo9THn0CVR
Bq7RlzyN0aNdKoKUHlHY5lv4u41D20pi84CKK5HSKyCMDj2hz8XH04Cy1C1RyZRDCXw1jfPI
4uHD6Yt7ikAszAGv/GSPEoXTX2mK0DORxi/4uHIlQX9GpF1agrlivU0wXe+/bw6UbaODMRcs
SxOsN/T152WMFjf0MlzSl8FsNYnqNmA/e5uSRmGwwHSQ0Jn9kFGeBZpfknZtlPLeb7mSl+Tj
xVKUPHcuWCKejs3Ug2VshiNLa3REziwKeXDB/03rHAWLzGSwCuS4QE8xwfD24UQdfuX6aXOQ
aYKFz+d/R2oIlLIlqd5PqCNR41XQ3RJEy3pWFc3UeGgEka5qZbRqYwB5DQKTLEwC+xqHbI8V
aPeHDXqgUhd2ytMfxDaHUXQDJgqrSl9+7p/I+spMTJWxwBS1AgTQIrUkVOcv3bTVRH9g4rMy
8nk9PLEDpWWJKf4S240MD5i/hEptXzyfxJi0Hs+2h+1X+IKJfbsZ/fyxewKw2MVUpnQKrcrh
YfkYLOZjldXI6279+LD7GSpH4lX+sFX5YfK62ewf1rDsbnev/DZUye9IJe32n2wVqsDDSeTt
2/oHdC3YdxJvyBIF3vx5/HO1BY30X6fOrkgXxXkRN6YEQJXoJZo/+vQ9d8l0UHO9prqfVGBv
Hf5cxuqWVkSw1RKWgVxj7FyDqGQVmvZEuWm+YxHg6SWihXWXZxL0Ec8INmJVBEyEL5g7iMTf
pMOIWwacn7qsZqs6HngI+/cA0mEwArgihmMnurkwFcsObl/odEBMVnRuRgkb4E6g0AHR3YTY
8LLOL61grh28qq9vPp5HHlxkl5d2XowOoV8mKLENuGRlXxiQdHltvFrBjzYT3AZwMz43AtQz
RM2sQBKIwDT0ZZFT1yaIrpUXil2EVdQLX9cR/fhgFZGRRYKBNxYZc1+i9BIyLcjgh5sqHUFu
EE+EyZu860sbWC9TD9BZH6hXuupWepH4z3Q6ErLUroeXOpe+PylhG81bSwMbF1GFMTFjPjLN
Q7vAK7ws4tq0wlH5X+EHCMdpagcfREzNh2inKmg6SIvi7ctecqOh432S9plxMzOOs3aO4Sth
KY461LBpZ3dtuYra0XUO+pAgrwMsGqzEnBW7J30RZD9xZEZsjcfWD++tCEBpSSsWVeTfgQ0K
oq0DmnVqtXDMgZlWMO20OOKrfSkf54uEZ7SQkUSUnJovMtM5R/7s168yU1ueHF7XD9vnJyog
jqipZy4lhdWW9KthOIVHiniPaj0iZPrWE2SC8kAa2q3peon4NPox2x+6obOUpIsKnCdFaakO
gpP26iLlmdp9AyWAlLyIyW4CY6li5bRg35M0iCEH4RxUyrtii3cbcvHbXv9RypOoZnB84a2m
IKNlAQ7k68gaIxwbo5CqBbjzI7iLEK5iHDoArQXwnz2UFpIkwgwGhZDbpqhpgz3EloVAh6mY
vixBisCxgKgiR2efVsRVQ6uiSLSMKvpiDpHhGEmgMgVntoh9pGafdeXNgob9ZrA9WTxjcELg
mptWPODP0BNXTY6B4IBOnq10hxV1eLAKD7IbC8z20BybgKJe8QndrZynR+ZtMgqvKuwfySnN
eTMFKRQYzNNeQzq7CCvUE74HtAjmZioqFJjxxuUugIe6WB5Xd2VtXQkCGGegviNAhMdKjxo3
PK05fC0+zaO6qch4WxPRu6sNJ4gCkXxJYrznq0kULCK3o0krAXgBI1VlyekmjqA/nP8V4LsS
uK94wHZOUYRyzd9OsrpdWI4dCkS9GMuq4tqSMzGS1kS4DMxCtubSmMD8qD2p+TZagho7tLuC
D213+ICY5YtIxRSvH75ZLogijmD72gtAgmRisdDSVxQzTGY5rSJajtBU4V2sKYrxZzinQCwR
9GaWVLjkadunbkxqfMnfVZF9wGB+eHYRRxcXxc3V1Wlo7ppk4qF0O3TdSnEsxIdJVH8AvTDQ
biaAJtTq4sgNZF4TTEif2XSzSojeb94edydfre70+6KI1YoztgqA5oGw8xKJMnptKh0IlN79
WQH83LRVkqh4xtOkYgYnmrMqN9e5o//UWen9pHipQqyiuratGZspMIUxuclAWsWA9hWzfDbU
H2fzwUpbRJWeHa0H+JPZV82FepZWzy5GTYWMUqirH7hBEj5VoklIWGGSsTtV9cDuKTjE32bh
FgGljE4DJzELFx2HUUdKfZ4cOXGbMQ9NQAyMxvxO6rc6PZ3gGx0qq+mnFnHbRGIW2oqrcNcz
nsNaDHHd7Mgkl2Hcbb66OIq9Cs1I1TVpDl3B8PmHgWZ451uvBehgro5WU9SU2aciw4um2jSC
wBzH1pmiIHjRnqLWAJqL5/ZiU6b3RU9FVJTeX5CVEHSz+I8ory9Gf9Cte1EnZr9sbBBhjka/
NhCjsmrXdOHOeDW++/G/3TuPKBeF+RrSwfElwQPCtjGlDGBoi+BGPbL3qyK0YkFqWxbVnGaX
ucOI8fdi5Py2bD0UxFVQTOSFOR6EiGUgfLEibwPh29HaJg8d0LLfUkgJ4lGgU9YYIB2TM9MR
4RHJUiRyBko5NoDsFTO8weSFsf0kQ3R+4kxYE+mlkm7yqozd3+1UWJphBw2LdDErZwH2zW0l
E38rGZOSoiUWjVSWIOELFjcVI6xZJNWSRfO2XKLxPn3vI6maEv30wngpTYQ64ilJA5Q2pBzw
bdJkJTrI0WtHEf5B/44tsLhIorBAEdynN2Vgk6bmJkwN/rLd766vL2/+PntnojFauhQDL84t
m0sL9/GcNui0icjc9hbJ9eVpsI3rgFmrQ0QbAzlEVIIGm+TqSEeuaDbiEJEG3TbJuf0lDMzF
kdZ/P4tXV8GKbwKYm/NQmRvzJckpMwphLkLtXH/0hgY6G667lnI2t8qejY4sD0CGP4u05Qxi
dQeodOomfhTqORWOwsRf2JOhwZeh+qioxSb+I13fTag+O8QiTULlvLAIvN7OC37dUly1RzZu
Ecx4ClIlGUVI42OW1mb0hgGe16ypCqrOuCqimg5O1JPcVTxNqYqnEVNwr1r0aqTEa43n0Ffr
mbtH5I0dRska/PGO1k01d0yGENXUEzrMTJJSby9NzmMVJd8GtDk+vaf8XgW66uMTGtqw9Syg
DEc2D2+v28Mv32objz6zp/i7rdhtw9CKL3imYfAnDgJiXmOJChTbgA7aVUkMsEYvTpZ4Peju
SDsMWSsg2mSG8ZSUwzlNJeUSeYkK2rd8zKwrTkaJ0pTmW6mC2NpbX2MnKB9vtoxIpWyGmetk
RMocxthIG+nyTkpTsZ2KziOyrlO8GiZQRdCw0CdHpitKciWj3MdjSYrRvtyAjiRaDvfTuw/7
L9vnD2/7zevP3ePmbxUv8R0xOyILdbUnqYusuKNNQXuaqCwj6AVt5thTYejMktPvNj3RXZTR
D0tDn6MJvogHTESN1kCkL5Z5m4rQq+q08rw1OuBwn3+sqDT3tRgUD3SeLcgAp51N3bBHIoOx
Qr9BW909fH/c/ff5/a/1z/X7H7v148v2+f1+/XUD9Wwf32+fD5snZCrvv7x8faf4zHzz+rz5
IQO9bZ7xvXXgN4Zb3sn2eXvYrn9s/6ejVvbD4zWurngOXC63bAQ52v+pTWIbBDoUE+D4NsFg
0U43rtHhvvc2WC4X7V8qMR0hfnXzTQCZWKFf3+PXXy+HncpH04cRHQauiGF4U8u20wKPfDiL
EhLok4p5zMuZuYkdhF8EFTYS6JNW5jPXACMJjQsWp+PBnkShzs/L0qeel6VfA17G+KRwlAMT
9Ovt4H6B7mGMpMZAhGjZ2mpHJptqOjkbXWdN6iHyJqWBfvOl/GtfpUqE/ENdQejxN/WM5TFR
EjvrPUOVb19+bB/+/r75dfIgF+4TBkX65a3XSkReH5MZ0QqLk4Dyr/FVImj+pUfYVAs2urw8
u/F6G70dvm2eD9uHNeb6Yc+yy5gN4b/bw7eTaL/fPWwlKlkf1t4Y4jjzvxUBi2cgDEWj07JI
787OTy+JUUZsyoUTTNDZbeyWL7yqGVQM/GuhmcUYWe8Jnp97v7vj2O+aGYJUw2p/ocbEsmSx
XzatlsToigkVaqFfmUS/VkR7ILotK9voRM8eRpOoG+q00n1FY1A9STNMsxGYoyzyOzOjgCvV
bbcrC6D1llmyfdrsD35jVXw+oiqRiPBgVivJYJ3zAo6RaM5GY6I+haGfXnSD9dlpYvrx6fVM
8nJjJTsMLbkgYNSKzzgsXZbi33C/qixxIgMbiCsqNMGAH9l5gQbEORmPT2+zWXTmjQCAqjYP
fHk2IhoBBK11a3wgCqVG1yCJjAO+QJr5TqszMm5Ah1+WqmtKhNi+fLNMlHuuI0heJFoy3pPG
582YkwWr+OJYn0HOWQajYeqVGGUMVHXKrq6nQPXSueQ2cNRiQzidrVQfPaQJTIec6LPT4Uez
6J6QokSUish0iXdOAb8AYwm1iFhV0tbo/Sry91rN/GMV9M3OD4mED3Op1sqQE8hbL90rn8/1
7wsPdn1B7Yz0nsyv2iNnPqPFtzPduWr9/Lj7eZK//fyyeVX+R44e0K9Rwdu4pKTLpBpPHWdb
E0Mye4WhOKHEUCcmIjzgZ5m0kqG5dHnnYVFEbCkpXiNaku/32KCk3lNQ89EjSZ1AvuOQsjxG
CXCVlB/bL6+Yp/B193bYPhPnKwZSj5hfoYQD+yAR3fHlB3f1aUic2nlHiysSGtWLj8dr6MlI
NDAY78MhXJ+kIBDze/bp7BjJseaDJ/IwOksA9Yn6Q87ds7MlsWUjcZdheGIeyys1jDA11Gog
y2acdjSiGXdkwxvWQFiXmUlFNLm6PL1pY1Zh1uUYjQ2UffLQbDmPxTVaBi4Qi5VRFB91cIUB
O9xNSjwqNlicut7iU7wJK5ky1JT2p9gZbjDQzesBPatAb9jL8CL77dPz+vAG6vvDt83D9+3z
kxn5Qjp0GxealWX46eMFxoQwH/IRz1Z1FZlzE7plKvIkqu7c9mhqVTVsLIyiKGqaWFvQ/cGg
VaySIIeoIp5cteWtkT27g7RjUECBL9vRvNF5hZMOQWMOAhQGXzCWpPYwQffepubmQ2hcVIm5
qzB+IwM1OhtjmgKjN/iVTe+X3mtFRhjLTK8RjXLAMhYdGgPEWbmKZ+oJv2KW2B2DXslrS9yI
z5x9CdtFiuvkWQqt1k1rV3A+cn7at/82BjYsG9/RLw4WCX2WS4KoWipJwSkJ34YudGXxfvsk
iI1HL2BVvd40EBgxlTrtyDR5kpk7jDETPTCthIa6EIpJw134PTJMOP9saeheMXoH6hg8GVCq
ZtuuyYLTPaHtliSYol/dI9j93a6urRXWQaU3VMC3qSPh0RUt83f4KBBceEDXM9hpx2gwvASl
I3bocfyZ6HrgMw9T0k7vubEzDQRMtb+RiTcWUNKSVhRpYWkiJhQfpK4DKGjwCOrM0DbHZrzt
Gli9YMhHKFg7z8qBYxnwcUaCJ8KAR0IUMQcut2DwXSorSFIkPX5MPzEFkiGRLBaH8CQzRKlc
Dk068GPI5Gk9c3CIgCpaJ+y67CDioiSp2rq9uhjz2kFjYzJ4FNJNMCCqmZpJLHlRp8YlFVLl
RR4XMymEt5njwyRbA0k45C4gpmmr83MPfK1sskjMMSqTfH+g2FvZtJU1S8mtcY7kaWfwrMnT
e4x0YDbCq1sU8ShruKzkVvadhGfW70IGh57CCW7GRW9iMcKLBtsNhWVIaVmP4ZASVhbG1Av4
ENZoVD3kg7J33tuPPVocktCX1+3z4btM0/r4c7N/8p+cpdcHBlu0Yz12YLSzIv3VYmUqifFV
UhAM0v4h4WOQ4rbhrP50McyMEhm9Gi6MB2s0Jey6krA0ouTH5C6PMu4FLwUxeFygnMyqCgiY
OYPBWenV9e2Pzd+H7c9O1FJ5bh8U/NWfQ2W81ilvHgzjiDexfSFhYEWZctqVwyBKllE1oU8F
g2pc09ksp8kY/eh4GfBRYbl8KskavAZC/zRimicVTKL0C/p0fXYzMtdpCXwO/Vsz27gadF9Z
bUS+u84YelYLtFisI/PNpShhLYLiBpiU59Zm0kkgY2lskXGRRbXJtV2M7C46EpreXHIcZSF9
odyqgd/FrDOSZJr1DRL5ny4MK+pLtzGTzZe3pyd8yeTP+8PrG+adNqOeYhB7VBDMMG4GsH9F
Vd/q0+m/ZxSV8ir3hmV9mGYsSDsDCQdmDPpYptL+eGFpjo7FblPZ5ro9Qf+PT1Y02qEygych
X4AjFXMJ2KmnVC2Il4cGZe+NZYtl7mihKq8mx5QJpIKjKlbOVcJvsUMcE3dtQnz5DleD3JYM
ZGeToVWLO4MaV8WN3EPhRmAF4ylJuDGT5B0T0Fz4zNl0aWQcgDJhaGcbwPJEMQ23p4vM79si
k885QUumnqqi5dceX05BJ5iGp1AF1JCGCG6/up2NApIhxc8jXP1ySDB210xhWKRuX8QMg0F4
z1NIf1LsXvbvT9Ldw/e3F8UqZuvnJ/PwjXLYusCxCsuj1QKj/3hjXGMpJK6gosHwmMPtQjGp
UfltSuhaDd80YIejkO2sAfmiBjGLmMPlLbBOYKBJMTXZwPFRKds24IuPbzKws7+v1bJxD2oJ
tA9PCdP3pIPFB1G3+zlwXuaMlc4uVxcl+JA78K6/9i/bZ3zchdH8fDts/t3APzaHh3/++ec/
7tmOInkDUr55z9p9fy+6WLcAe3Knh9VSsCy8cEEhQmlGpDAIv3DnxqzupnWYVvIrSz9pWAJo
uxRS3ZZL1U0zr/IgZv4/ZssSbWt0tDC7Lk9h4NcYWRy0E/ja6vrgyA6fK64U2Fff1TH0uD6s
T/D8ecBbMU8ewxs2b+9TQOGJGNLBmquUmoMwiswSVMmojvCCq2pKP0G0tVEC3bSbikE6hNMW
Tu0+OAiwdmr3mB/TErTgJMDAPKGvjHinrIFBTiglsJ6ljM7suuX3DNTLbk2HDx1Yzeq/PVzg
LErIqgbxyiJQDv5w+GMEqYCLM3R5VtRl2ijrR6bD5RCdxIujPL5TGZR6fRrU8UmTK2FRDq9y
sRLaZvLwBFE2tjLviAjjctnGqBJErVuPpKyKcSB7jCbBVKrHCNSvgKvKQJOHD4GO6EiGs46i
5MkkYGGpCPrAvfA/tHulD+6e2Hez366vLqj1jvdg6LWVN1Dw7CqztXdEqogF+GZcJYHI2Z0V
2GJW0h9F1tPtRHWB/Dsy57gfotnZwzCV8nqzPyAPxbMyxpBv66eN6e4+b3LyDlezIdRhiwrO
yM9KwTEnImc1zj1JSqlxUokga5pEPEUxj5wARCop2hO8bZosmjNtsh6mgiXTsZswzQSPpgDa
GkSv5VD3FLG60YryuFiovd6arnsV7G98m0DGqEIQm6/Y6TypLSlWvmPJpxsRCmkmSYLYbveb
UV1oU319kMqzOUxXjdGy5QjevAUNUkllGOTM9nhlnUYRxCvZBXYKpSbZEzRjK3T2OzKD6gKs
S21NeSx0VCIu70xfSfXUCIiajBAl0ZJxTMz7WwB2V3BuVQCWkXTDXW2agA26xK7kxW8YjwFI
JmlBM2FJUeHri4zTemQ+Qw6dEssTyvpHLeZ55swDKGjyQtaGSpsG6fbgzFrpzSM+b84KqUsu
zOmc8BwDsNXD42OoUzpzu3khj19bB9Vw5j90NdgtEekfId953W8LWmIcwXI4Uhblbdu2X5fk
eeDeDnD+4rft2ukTwTN+V3e5/wdHmim6rZQBAA==

--45Z9DzgjV8m4Oswq--
