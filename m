Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A34C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6789020835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgFLPdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFLPdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:33:23 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC75920801;
        Fri, 12 Jun 2020 15:33:19 +0000 (UTC)
Subject: Re: drivers/net/can/kvaser_pciefd.c:801:17: sparse: sparse: cast
 removes address space '<asn:2>' of expression
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>,
        Henning Colliander <henning.colliander@evidente.se>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>
References: <202006121356.lKucoVPo%lkp@intel.com>
 <e93fe895-a6b8-34ff-f9c8-00ec7138b1c1@pengutronix.de>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <9b599221-3c15-909c-168a-766c554827d9@linux-m68k.org>
Date:   Sat, 13 Jun 2020 01:33:16 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e93fe895-a6b8-34ff-f9c8-00ec7138b1c1@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 12/6/20 5:48 pm, Marc Kleine-Budde wrote:
> the k-build robot found this sparse problem, triggered by building a CAN driver
> for m68k. Is this a problem in our CAN driver or in the m68k headers?

I suspect a problem with the m68k (specifically non-mmu) headers.


> On 6/12/20 7:28 AM, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   b791d1bdf9212d944d749a5c7ff6febdba241771
>> commit: 26ad340e582d3d5958ed8456a1911d79cfb567b4 can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices
>> date:   11 months ago
>> config: m68k-randconfig-s032-20200612 (attached as .config)
>> compiler: m68k-linux-gcc (GCC) 9.3.0
>> reproduce:
>>          # apt-get install sparse
>>          # sparse version: v0.6.1-250-g42323db3-dirty
>>          git checkout 26ad340e582d3d5958ed8456a1911d79cfb567b4
>>          # save the attached .config to linux build tree
>>          make W=1 C=1 ARCH=m68k CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>>> drivers/net/can/kvaser_pciefd.c:801:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     drivers/net/can/kvaser_pciefd.c:805:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression

I think this one is due to not forcing the volatile cast in __raw_write().
So this change will fix that:

diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
index 0498192e1d98..1bc739f1f1ad 100644
--- a/arch/m68k/include/asm/io_no.h
+++ b/arch/m68k/include/asm/io_no.h
@@ -14,15 +14,15 @@
   * that behavior here first before we include asm-generic/io.h.
   */
  #define __raw_readb(addr) \
-    ({ unsigned char __v = (*(volatile unsigned char *) (addr)); __v; })
+    ({ u8 __v = (*(__force volatile u8 *) (addr)); __v; })
  #define __raw_readw(addr) \
-    ({ unsigned short __v = (*(volatile unsigned short *) (addr)); __v; })
+    ({ u16 __v = (*(__force volatile u16 *) (addr)); __v; })
  #define __raw_readl(addr) \
-    ({ unsigned int __v = (*(volatile unsigned int *) (addr)); __v; })
+    ({ u32 __v = (*(__force volatile u32 *) (addr)); __v; })
  
-#define __raw_writeb(b, addr) (void)((*(volatile unsigned char *) (addr)) = (b))
-#define __raw_writew(b, addr) (void)((*(volatile unsigned short *) (addr)) = (b))
-#define __raw_writel(b, addr) (void)((*(volatile unsigned int *) (addr)) = (b))
+#define __raw_writeb(b, addr) (void)((*(__force volatile u8 *) (addr)) = (b))
+#define __raw_writew(b, addr) (void)((*(__force volatile u16 *) (addr)) = (b))
+#define __raw_writel(b, addr) (void)((*(__force volatile u32 *) (addr)) = (b))
  
  #if defined(CONFIG_COLDFIRE)
  /*


>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32

This one I am not sure about yet.
Still investigating.

Regards
Greg


>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>>     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>
>> vim +801 drivers/net/can/kvaser_pciefd.c
>>
>>     764	
>>     765	static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
>>     766						    struct net_device *netdev)
>>     767	{
>>     768		struct kvaser_pciefd_can *can = netdev_priv(netdev);
>>     769		unsigned long irq_flags;
>>     770		struct kvaser_pciefd_tx_packet packet;
>>     771		int nwords;
>>     772		u8 count;
>>     773	
>>     774		if (can_dropped_invalid_skb(netdev, skb))
>>     775			return NETDEV_TX_OK;
>>     776	
>>     777		nwords = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
>>     778	
>>     779		spin_lock_irqsave(&can->echo_lock, irq_flags);
>>     780	
>>     781		/* Prepare and save echo skb in internal slot */
>>     782		can_put_echo_skb(skb, netdev, can->echo_idx);
>>     783	
>>     784		/* Move echo index to the next slot */
>>     785		can->echo_idx = (can->echo_idx + 1) % can->can.echo_skb_max;
>>     786	
>>     787		/* Write header to fifo */
>>     788		iowrite32(packet.header[0],
>>     789			  can->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG);
>>     790		iowrite32(packet.header[1],
>>     791			  can->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG);
>>     792	
>>     793		if (nwords) {
>>     794			u32 data_last = ((u32 *)packet.data)[nwords - 1];
>>     795	
>>     796			/* Write data to fifo, except last word */
>>     797			iowrite32_rep(can->reg_base +
>>     798				      KVASER_PCIEFD_KCAN_FIFO_REG, packet.data,
>>     799				      nwords - 1);
>>     800			/* Write last word to end of fifo */
>>   > 801			__raw_writel(data_last, can->reg_base +
>>     802				     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
>>     803		} else {
>>     804			/* Complete write to fifo */
>>     805			__raw_writel(0, can->reg_base +
>>     806				     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
>>     807		}
>>     808	
>>     809		count = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG);
>>     810		/* No room for a new message, stop the queue until at least one
>>     811		 * successful transmit
>>     812		 */
>>     813		if (count >= KVASER_PCIEFD_CAN_TX_MAX_COUNT ||
>>     814		    can->can.echo_skb[can->echo_idx])
>>     815			netif_stop_queue(netdev);
>>     816	
>>     817		spin_unlock_irqrestore(&can->echo_lock, irq_flags);
>>     818	
>>     819		return NETDEV_TX_OK;
>>     820	}
>>     821	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> 
> 
