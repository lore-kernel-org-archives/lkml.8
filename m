Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC67C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B9420801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgFLHtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFLHs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:48:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8CDC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:48:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jjeQk-0004do-Kf; Fri, 12 Jun 2020 09:48:50 +0200
Received: from [IPv6:2a03:f580:87bc:d400:b44d:6713:e0e9:e23c] (2a03-f580-87bc-d400-b44d-6713-e0e9-e23c.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:b44d:6713:e0e9:e23c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 90FEB5143FD;
        Fri, 12 Jun 2020 07:48:47 +0000 (UTC)
Subject: Re: drivers/net/can/kvaser_pciefd.c:801:17: sparse: sparse: cast
 removes address space '<asn:2>' of expression
To:     kernel test robot <lkp@intel.com>,
        Henning Colliander <henning.colliander@evidente.se>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>
References: <202006121356.lKucoVPo%lkp@intel.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 mQINBFFVq30BEACtnSvtXHoeHJxG6nRULcvlkW6RuNwHKmrqoksispp43X8+nwqIFYgb8UaX
 zu8T6kZP2wEIpM9RjEL3jdBjZNCsjSS6x1qzpc2+2ivjdiJsqeaagIgvy2JWy7vUa4/PyGfx
 QyUeXOxdj59DvLwAx8I6hOgeHx2X/ntKAMUxwawYfPZpP3gwTNKc27dJWSomOLgp+gbmOmgc
 6U5KwhAxPTEb3CsT5RicsC+uQQFumdl5I6XS+pbeXZndXwnj5t84M+HEj7RN6bUfV2WZO/AB
 Xt5+qFkC/AVUcj/dcHvZwQJlGeZxoi4veCoOT2MYqfR0ax1MmN+LVRvKm29oSyD4Ts/97cbs
 XsZDRxnEG3z/7Winiv0ZanclA7v7CQwrzsbpCv+oj+zokGuKasofzKdpywkjAfSE1zTyF+8K
 nxBAmzwEqeQ3iKqBc3AcCseqSPX53mPqmwvNVS2GqBpnOfY7Mxr1AEmxdEcRYbhG6Xdn+ACq
 Dq0Db3A++3PhMSaOu125uIAIwMXRJIzCXYSqXo8NIeo9tobk0C/9w3fUfMTrBDtSviLHqlp8
 eQEP8+TDSmRP/CwmFHv36jd+XGmBHzW5I7qw0OORRwNFYBeEuiOIgxAfjjbLGHh9SRwEqXAL
 kw+WVTwh0MN1k7I9/CDVlGvc3yIKS0sA+wudYiselXzgLuP5cQARAQABtCZNYXJjIEtsZWlu
 ZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPokCVAQTAQoAPgIbAwIeAQIXgAULCQgHAwUV
 CgkICwUWAgMBABYhBMFAC6CzmJ5vvH1bXCte4hHFiupUBQJcUsSbBQkM366zAAoJECte4hHF
 iupUgkAP/2RdxKPZ3GMqag33jKwKAbn/fRqAFWqUH9TCsRH3h6+/uEPnZdzhkL4a9p/6OeJn
 Z6NXqgsyRAOTZsSFcwlfxLNHVxBWm8pMwrBecdt4lzrjSt/3ws2GqxPsmza1Gs61lEdYvLST
 Ix2vPbB4FAfE0kizKAjRZzlwOyuHOr2ilujDsKTpFtd8lV1nBNNn6HBIBR5ShvJnwyUdzuby
 tOsSt7qJEvF1x3y49bHCy3uy+MmYuoEyG6zo9udUzhVsKe3hHYC2kfB16ZOBjFC3lH2U5An+
 yQYIIPZrSWXUeKjeMaKGvbg6W9Oi4XEtrwpzUGhbewxCZZCIrzAH2hz0dUhacxB201Y/faY6
 BdTS75SPs+zjTYo8yE9Y9eG7x/lB60nQjJiZVNvZ88QDfVuLl/heuIq+fyNajBbqbtBT5CWf
 mOP4Dh4xjm3Vwlz8imWW/drEVJZJrPYqv0HdPbY8jVMpqoe5jDloyVn3prfLdXSbKPexlJaW
 5tnPd4lj8rqOFShRnLFCibpeHWIumqrIqIkiRA9kFW3XMgtU6JkIrQzhJb6Tc6mZg2wuYW0d
 Wo2qvdziMgPkMFiWJpsxM9xPk9BBVwR+uojNq5LzdCsXQ2seG0dhaOTaaIDWVS8U/V8Nqjrl
 6bGG2quo5YzJuXKjtKjZ4R6k762pHJ3tnzI/jnlc1sXz
Message-ID: <e93fe895-a6b8-34ff-f9c8-00ec7138b1c1@pengutronix.de>
Date:   Fri, 12 Jun 2020 09:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <202006121356.lKucoVPo%lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

the k-build robot found this sparse problem, triggered by building a CAN driver
for m68k. Is this a problem in our CAN driver or in the m68k headers?

Marc

On 6/12/20 7:28 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b791d1bdf9212d944d749a5c7ff6febdba241771
> commit: 26ad340e582d3d5958ed8456a1911d79cfb567b4 can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices
> date:   11 months ago
> config: m68k-randconfig-s032-20200612 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-250-g42323db3-dirty
>         git checkout 26ad340e582d3d5958ed8456a1911d79cfb567b4
>         # save the attached .config to linux build tree
>         make W=1 C=1 ARCH=m68k CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>>> drivers/net/can/kvaser_pciefd.c:801:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>    drivers/net/can/kvaser_pciefd.c:805:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>    arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
> 
> vim +801 drivers/net/can/kvaser_pciefd.c
> 
>    764	
>    765	static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
>    766						    struct net_device *netdev)
>    767	{
>    768		struct kvaser_pciefd_can *can = netdev_priv(netdev);
>    769		unsigned long irq_flags;
>    770		struct kvaser_pciefd_tx_packet packet;
>    771		int nwords;
>    772		u8 count;
>    773	
>    774		if (can_dropped_invalid_skb(netdev, skb))
>    775			return NETDEV_TX_OK;
>    776	
>    777		nwords = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
>    778	
>    779		spin_lock_irqsave(&can->echo_lock, irq_flags);
>    780	
>    781		/* Prepare and save echo skb in internal slot */
>    782		can_put_echo_skb(skb, netdev, can->echo_idx);
>    783	
>    784		/* Move echo index to the next slot */
>    785		can->echo_idx = (can->echo_idx + 1) % can->can.echo_skb_max;
>    786	
>    787		/* Write header to fifo */
>    788		iowrite32(packet.header[0],
>    789			  can->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG);
>    790		iowrite32(packet.header[1],
>    791			  can->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG);
>    792	
>    793		if (nwords) {
>    794			u32 data_last = ((u32 *)packet.data)[nwords - 1];
>    795	
>    796			/* Write data to fifo, except last word */
>    797			iowrite32_rep(can->reg_base +
>    798				      KVASER_PCIEFD_KCAN_FIFO_REG, packet.data,
>    799				      nwords - 1);
>    800			/* Write last word to end of fifo */
>  > 801			__raw_writel(data_last, can->reg_base +
>    802				     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
>    803		} else {
>    804			/* Complete write to fifo */
>    805			__raw_writel(0, can->reg_base +
>    806				     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
>    807		}
>    808	
>    809		count = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG);
>    810		/* No room for a new message, stop the queue until at least one
>    811		 * successful transmit
>    812		 */
>    813		if (count >= KVASER_PCIEFD_CAN_TX_MAX_COUNT ||
>    814		    can->can.echo_skb[can->echo_idx])
>    815			netif_stop_queue(netdev);
>    816	
>    817		spin_unlock_irqrestore(&can->echo_lock, irq_flags);
>    818	
>    819		return NETDEV_TX_OK;
>    820	}
>    821	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 


-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
