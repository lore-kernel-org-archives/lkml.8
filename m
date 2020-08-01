Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D860C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 05:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E710E20725
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 05:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgHAFdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 01:33:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:35246 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgHAFdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 01:33:53 -0400
IronPort-SDR: QLTKAGJhTw9wfCipf1t0zOGE3wlqno2Ij0mWQCjED8rmG4QyhglDWi1eqnBOfuWUpUdXDJxfj0
 tDhSCD+WCXQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="216344247"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="216344247"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 22:33:53 -0700
IronPort-SDR: UsGVkwM1v1qXVh0o78jE9Dx2HFhfMo0klUIPlyoBfBH0tgPW26VxTQQDzIQbOywezHsNLKiA/r
 QGxj0I3ucavA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="305259374"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2020 22:33:51 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1k9X-0000KE-4D; Sat, 01 Aug 2020 05:33:51 +0000
Date:   Sat, 1 Aug 2020 13:33:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Varghese <martin.varghese@nokia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/bareudp.c:274:45: warning: Clarify calculation
 precedence for '&' and
Message-ID: <202008011329.WoACRMn4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7dc6fd0f3b8404542718039f5de19fe56e474578
commit: 571912c69f0ed731bd1e071ade9dc7ca4aa52065 net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.
date:   5 months ago
compiler: sparc-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/net/bareudp.c:274:45: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
    df = key->tun_flags & TUNNEL_DONT_FRAGMENT ? htons(IP_DF) : 0;
                                               ^

vim +274 drivers/net/bareudp.c

   240	
   241	static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
   242				    struct bareudp_dev *bareudp,
   243				    const struct ip_tunnel_info *info)
   244	{
   245		bool xnet = !net_eq(bareudp->net, dev_net(bareudp->dev));
   246		bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
   247		struct socket *sock = rcu_dereference(bareudp->sock);
   248		bool udp_sum = !!(info->key.tun_flags & TUNNEL_CSUM);
   249		const struct ip_tunnel_key *key = &info->key;
   250		struct rtable *rt;
   251		__be16 sport, df;
   252		int min_headroom;
   253		__u8 tos, ttl;
   254		__be32 saddr;
   255		int err;
   256	
   257		if (!sock)
   258			return -ESHUTDOWN;
   259	
   260		rt = ip_route_output_tunnel(skb, dev, bareudp->net, &saddr, info,
   261					    IPPROTO_UDP, use_cache);
   262	
   263		if (IS_ERR(rt))
   264			return PTR_ERR(rt);
   265	
   266		skb_tunnel_check_pmtu(skb, &rt->dst,
   267				      BAREUDP_IPV4_HLEN + info->options_len);
   268	
   269		sport = udp_flow_src_port(bareudp->net, skb,
   270					  bareudp->sport_min, USHRT_MAX,
   271					  true);
   272		tos = ip_tunnel_ecn_encap(key->tos, ip_hdr(skb), skb);
   273		ttl = key->ttl;
 > 274		df = key->tun_flags & TUNNEL_DONT_FRAGMENT ? htons(IP_DF) : 0;
   275		skb_scrub_packet(skb, xnet);
   276	
   277		if (!skb_pull(skb, skb_network_offset(skb)))
   278			goto free_dst;
   279	
   280		min_headroom = LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len +
   281			BAREUDP_BASE_HLEN + info->options_len + sizeof(struct iphdr);
   282	
   283		err = skb_cow_head(skb, min_headroom);
   284		if (unlikely(err))
   285			goto free_dst;
   286	
   287		err = udp_tunnel_handle_offloads(skb, udp_sum);
   288		if (err)
   289			goto free_dst;
   290	
   291		skb_set_inner_protocol(skb, bareudp->ethertype);
   292		udp_tunnel_xmit_skb(rt, sock->sk, skb, saddr, info->key.u.ipv4.dst,
   293				    tos, ttl, df, sport, bareudp->port,
   294				    !net_eq(bareudp->net, dev_net(bareudp->dev)),
   295				    !(info->key.tun_flags & TUNNEL_CSUM));
   296		return 0;
   297	
   298	free_dst:
   299		dst_release(&rt->dst);
   300		return err;
   301	}
   302	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
