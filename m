Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AB3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576DD20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFLFxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:53:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:1622 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgFLFxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 01:53:19 -0400
IronPort-SDR: fTHl4lcPIr6iwlWU30iNns2gmRrrgvVkJxoXDeay8zw0UFCaHbmaF0Ji46jl68RSZlS2W0CkaQ
 vw7vNq5tqTww==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 22:29:17 -0700
IronPort-SDR: F4OSde5mHGjDwKPBcl0MVhsx+q/Uq16TVp1FFJQoNQhH0/guSrwCGFztaHApb3DA8ehCtmpA9P
 j+fTAIB3sTNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; 
   d="gz'50?scan'50,208,50";a="259800585"
Received: from lkp-server01.sh.intel.com (HELO b6eec31c25be) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jun 2020 22:29:15 -0700
Received: from kbuild by b6eec31c25be with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jjcFe-0000XP-Ed; Fri, 12 Jun 2020 05:29:14 +0000
Date:   Fri, 12 Jun 2020 13:28:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Henning Colliander <henning.colliander@evidente.se>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>
Subject: drivers/net/can/kvaser_pciefd.c:801:17: sparse: sparse: cast removes
 address space '<asn:2>' of expression
Message-ID: <202006121356.lKucoVPo%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b791d1bdf9212d944d749a5c7ff6febdba241771
commit: 26ad340e582d3d5958ed8456a1911d79cfb567b4 can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices
date:   11 months ago
config: m68k-randconfig-s032-20200612 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-250-g42323db3-dirty
        git checkout 26ad340e582d3d5958ed8456a1911d79cfb567b4
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=m68k CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/can/kvaser_pciefd.c:801:17: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/net/can/kvaser_pciefd.c:805:17: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32

vim +801 drivers/net/can/kvaser_pciefd.c

   764	
   765	static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
   766						    struct net_device *netdev)
   767	{
   768		struct kvaser_pciefd_can *can = netdev_priv(netdev);
   769		unsigned long irq_flags;
   770		struct kvaser_pciefd_tx_packet packet;
   771		int nwords;
   772		u8 count;
   773	
   774		if (can_dropped_invalid_skb(netdev, skb))
   775			return NETDEV_TX_OK;
   776	
   777		nwords = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
   778	
   779		spin_lock_irqsave(&can->echo_lock, irq_flags);
   780	
   781		/* Prepare and save echo skb in internal slot */
   782		can_put_echo_skb(skb, netdev, can->echo_idx);
   783	
   784		/* Move echo index to the next slot */
   785		can->echo_idx = (can->echo_idx + 1) % can->can.echo_skb_max;
   786	
   787		/* Write header to fifo */
   788		iowrite32(packet.header[0],
   789			  can->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG);
   790		iowrite32(packet.header[1],
   791			  can->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG);
   792	
   793		if (nwords) {
   794			u32 data_last = ((u32 *)packet.data)[nwords - 1];
   795	
   796			/* Write data to fifo, except last word */
   797			iowrite32_rep(can->reg_base +
   798				      KVASER_PCIEFD_KCAN_FIFO_REG, packet.data,
   799				      nwords - 1);
   800			/* Write last word to end of fifo */
 > 801			__raw_writel(data_last, can->reg_base +
   802				     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
   803		} else {
   804			/* Complete write to fifo */
   805			__raw_writel(0, can->reg_base +
   806				     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
   807		}
   808	
   809		count = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG);
   810		/* No room for a new message, stop the queue until at least one
   811		 * successful transmit
   812		 */
   813		if (count >= KVASER_PCIEFD_CAN_TX_MAX_COUNT ||
   814		    can->can.echo_skb[can->echo_idx])
   815			netif_stop_queue(netdev);
   816	
   817		spin_unlock_irqrestore(&can->echo_lock, irq_flags);
   818	
   819		return NETDEV_TX_OK;
   820	}
   821	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tKW2IUtsqtDRztdT--
