Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724E7C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D2620739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbgDMQzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:55:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:53967 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732186AbgDMQza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:55:30 -0400
IronPort-SDR: C11Z5nDMp16fmFrdOzg8IsGBcCEW7wZvQIPMXufjKasN8pVJqUA3R+iGE5W/4VreEez6e0ktuc
 9QYDy4iR9wnQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 09:55:29 -0700
IronPort-SDR: tq8cPtPZvYxM9IxmAqBNXs+YnioHBOEmPz8zEpXMk1eestl6/SfErsM5V4o4YRUnXuU6QERM7u
 VUvshEcY3DVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="243579583"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2020 09:55:08 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jO2MV-0009Di-LC; Tue, 14 Apr 2020 00:55:07 +0800
Date:   Tue, 14 Apr 2020 00:54:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Era Mayflower <mayflowerera@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/macsec.c:905:22: warning: Variable 'recovered_pn.lower'
 is assigned a value that is never used. [unreadVariable]
Message-ID: <202004140049.vN42FESb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f3d9f354286745c751374f5f1fcafee6b3f3136
commit: a21ecf0e033807b976967286e6c392f48ee2049f macsec: Support XPN frame handling - IEEE 802.1AEbw
date:   4 weeks ago

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

   drivers/net/macsec.c:3550:7: warning: Local variable 'ret' shadows outer variable [shadowVariable]
     int ret;
         ^
   drivers/net/macsec.c:3525:6: note: Shadowed declaration
    int ret;
        ^
   drivers/net/macsec.c:3550:7: note: Shadow variable
     int ret;
         ^
   drivers/net/macsec.c:3298:56: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
                                                          ^
   drivers/net/macsec.c:3302:34: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
           dev->flags & IFF_PROMISC ? 1 : -1);
                                    ^
   drivers/net/macsec.c:571:30: warning: 'tmp' is of type 'void *'. When using void pointers in calculations, the behaviour is undefined. [arithOperationsOnVoidPointer]
    *iv = (unsigned char *)(tmp + iv_offset);
                                ^
   drivers/net/macsec.c:572:35: warning: 'tmp' is of type 'void *'. When using void pointers in calculations, the behaviour is undefined. [arithOperationsOnVoidPointer]
    *sg = (struct scatterlist *)(tmp + sg_offset);
                                     ^
>> drivers/net/macsec.c:905:22: warning: Variable 'recovered_pn.lower' is assigned a value that is never used. [unreadVariable]
     recovered_pn.lower = hdr_pn;
                        ^
>> drivers/net/macsec.c:908:22: warning: Variable 'recovered_pn.upper' is assigned a value that is never used. [unreadVariable]
      recovered_pn.upper++;
                        ^
   drivers/net/macsec.c:2195:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
    int ret = 0;
            ^
   drivers/net/macsec.c:2278:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
    int ret = 0;
            ^

vim +905 drivers/net/macsec.c

   867	
   868	static struct sk_buff *macsec_decrypt(struct sk_buff *skb,
   869					      struct net_device *dev,
   870					      struct macsec_rx_sa *rx_sa,
   871					      sci_t sci,
   872					      struct macsec_secy *secy)
   873	{
   874		int ret;
   875		struct scatterlist *sg;
   876		struct sk_buff *trailer;
   877		unsigned char *iv;
   878		struct aead_request *req;
   879		struct macsec_eth_header *hdr;
   880		u32 hdr_pn;
   881		u16 icv_len = secy->icv_len;
   882	
   883		macsec_skb_cb(skb)->valid = false;
   884		skb = skb_share_check(skb, GFP_ATOMIC);
   885		if (!skb)
   886			return ERR_PTR(-ENOMEM);
   887	
   888		ret = skb_cow_data(skb, 0, &trailer);
   889		if (unlikely(ret < 0)) {
   890			kfree_skb(skb);
   891			return ERR_PTR(ret);
   892		}
   893		req = macsec_alloc_req(rx_sa->key.tfm, &iv, &sg, ret);
   894		if (!req) {
   895			kfree_skb(skb);
   896			return ERR_PTR(-ENOMEM);
   897		}
   898	
   899		hdr = (struct macsec_eth_header *)skb->data;
   900		hdr_pn = ntohl(hdr->packet_number);
   901	
   902		if (secy->xpn) {
   903			pn_t recovered_pn = rx_sa->next_pn_halves;
   904	
 > 905			recovered_pn.lower = hdr_pn;
   906			if (hdr_pn < rx_sa->next_pn_halves.lower &&
   907			    !pn_same_half(hdr_pn, rx_sa->next_pn_halves.lower))
 > 908				recovered_pn.upper++;
   909	
   910			macsec_fill_iv_xpn(iv, rx_sa->ssci, recovered_pn.full64,
   911					   rx_sa->key.salt);
   912		} else {
   913			macsec_fill_iv(iv, sci, hdr_pn);
   914		}
   915	
   916		sg_init_table(sg, ret);
   917		ret = skb_to_sgvec(skb, sg, 0, skb->len);
   918		if (unlikely(ret < 0)) {
   919			aead_request_free(req);
   920			kfree_skb(skb);
   921			return ERR_PTR(ret);
   922		}
   923	
   924		if (hdr->tci_an & MACSEC_TCI_E) {
   925			/* confidentiality: ethernet + macsec header
   926			 * authenticated, encrypted payload
   927			 */
   928			int len = skb->len - macsec_hdr_len(macsec_skb_cb(skb)->has_sci);
   929	
   930			aead_request_set_crypt(req, sg, sg, len, iv);
   931			aead_request_set_ad(req, macsec_hdr_len(macsec_skb_cb(skb)->has_sci));
   932			skb = skb_unshare(skb, GFP_ATOMIC);
   933			if (!skb) {
   934				aead_request_free(req);
   935				return ERR_PTR(-ENOMEM);
   936			}
   937		} else {
   938			/* integrity only: all headers + data authenticated */
   939			aead_request_set_crypt(req, sg, sg, icv_len, iv);
   940			aead_request_set_ad(req, skb->len - icv_len);
   941		}
   942	
   943		macsec_skb_cb(skb)->req = req;
   944		skb->dev = dev;
   945		aead_request_set_callback(req, 0, macsec_decrypt_done, skb);
   946	
   947		dev_hold(dev);
   948		ret = crypto_aead_decrypt(req);
   949		if (ret == -EINPROGRESS) {
   950			return ERR_PTR(ret);
   951		} else if (ret != 0) {
   952			/* decryption/authentication failed
   953			 * 10.6 if validateFrames is disabled, deliver anyway
   954			 */
   955			if (ret != -EBADMSG) {
   956				kfree_skb(skb);
   957				skb = ERR_PTR(ret);
   958			}
   959		} else {
   960			macsec_skb_cb(skb)->valid = true;
   961		}
   962		dev_put(dev);
   963	
   964		aead_request_free(req);
   965	
   966		return skb;
   967	}
   968	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
