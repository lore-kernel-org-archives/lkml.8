Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6435C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 06:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15BF2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 06:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgBSGqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 01:46:49 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:53117
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgBSGqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 01:46:49 -0500
X-IronPort-AV: E=Sophos;i="5.70,459,1574118000"; 
   d="scan'208";a="339671665"
Received: from abo-105-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.105])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 07:46:46 +0100
Date:   Wed, 19 Feb 2020 07:46:33 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Andrew Lunn <andrew@lunn.ch>
cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Subject: drivers/net/dsa/mv88e6xxx/chip.c:3801:48-49: phylink_validate: first
 occurrence line 3850, second occurrence line 3852 (fwd)
Message-ID: <alpine.DEB.2.21.2002190744550.2792@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-753273642-1582094807=:2792"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-753273642-1582094807=:2792
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

The phylink_validate field occurs twice, near the end of the structure.
This seems to occur in two structures of which only the first is shown.

julia

---------- Forwarded message ----------
Date: Wed, 19 Feb 2020 07:37:20 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: drivers/net/dsa/mv88e6xxx/chip.c:3801:48-49: phylink_validate: first
    occurrence line 3850, second occurrence line 3852


tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b1da3acc781ce445445d959b41064d209a27bc2d
commit: 4262c38dc42e092987f41cb1695240ac7dab86a9 net: dsa: mv88e6xxx: Add SERDES stats counters to all 6390 family members
date:   4 weeks ago
:::::: branch date: 18 hours ago
:::::: commit date: 4 weeks ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> drivers/net/dsa/mv88e6xxx/chip.c:3801:48-49: phylink_validate: first occurrence line 3850, second occurrence line 3852
   drivers/net/dsa/mv88e6xxx/chip.c:3855:49-50: phylink_validate: first occurrence line 3904, second occurrence line 3906
   drivers/net/dsa/mv88e6xxx/chip.c:3909:48-49: phylink_validate: first occurrence line 3957, second occurrence line 3960
   drivers/net/dsa/mv88e6xxx/chip.c:4057:48-49: phylink_validate: first occurrence line 4106, second occurrence line 4110

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4262c38dc42e092987f41cb1695240ac7dab86a9
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout 4262c38dc42e092987f41cb1695240ac7dab86a9
vim +3801 drivers/net/dsa/mv88e6xxx/chip.c

b3469dd8adade11 Vivien Didelot   2016-09-29  3800
1a3b39ecfe32bf9 Andrew Lunn      2016-11-21 @3801  static const struct mv88e6xxx_ops mv88e6190_ops = {
4b325d8c84a8dda Andrew Lunn      2016-11-21  3802  	/* MV88E6XXX_FAMILY_6390 */
ea89098ef9a574b Andrew Lunn      2019-01-09  3803  	.setup_errata = mv88e6390_setup_errata,
cd8da8bb0ec199d Vivien Didelot   2017-06-19  3804  	.irl_init_all = mv88e6390_g2_irl_init_all,
98fc3c6fa5cfda7 Vivien Didelot   2017-01-12  3805  	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
98fc3c6fa5cfda7 Vivien Didelot   2017-01-12  3806  	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
1a3b39ecfe32bf9 Andrew Lunn      2016-11-21  3807  	.set_switch_mac = mv88e6xxx_g2_set_switch_mac,
1a3b39ecfe32bf9 Andrew Lunn      2016-11-21  3808  	.phy_read = mv88e6xxx_g2_smi_phy_read,
1a3b39ecfe32bf9 Andrew Lunn      2016-11-21  3809  	.phy_write = mv88e6xxx_g2_smi_phy_write,
1a3b39ecfe32bf9 Andrew Lunn      2016-11-21  3810  	.port_set_link = mv88e6xxx_port_set_link,
1a3b39ecfe32bf9 Andrew Lunn      2016-11-21  3811  	.port_set_duplex = mv88e6xxx_port_set_duplex,
1a3b39ecfe32bf9 Andrew Lunn      2016-11-21  3812  	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
1a3b39ecfe32bf9 Andrew Lunn      2016-11-21  3813  	.port_set_speed = mv88e6390_port_set_speed,
7cbbee050c959f4 Andrew Lunn      2019-03-08  3814  	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
ef0a731882a2bf1 Andrew Lunn      2016-12-03  3815  	.port_tag_remap = mv88e6390_port_tag_remap,
f3a2cd326e448f5 Vivien Didelot   2019-09-07  3816  	.port_set_policy = mv88e6352_port_set_policy,
56995cbc3540797 Andrew Lunn      2016-12-03  3817  	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
601aeed371a36e6 Vivien Didelot   2017-03-11  3818  	.port_set_egress_floods = mv88e6352_port_set_egress_floods,
56995cbc3540797 Andrew Lunn      2016-12-03  3819  	.port_set_ether_type = mv88e6351_port_set_ether_type,
0898432cc296cc2 Vivien Didelot   2017-06-08  3820  	.port_pause_limit = mv88e6390_port_pause_limit,
c8c94891527a9e6 Vivien Didelot   2017-03-11  3821  	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
9dbfb4e1ca45c06 Vivien Didelot   2017-03-11  3822  	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
6c422e34b1b6533 Russell King     2018-08-09  3823  	.port_link_state = mv88e6352_port_link_state,
2d2e1dd29962ce0 Andrew Lunn      2018-08-09  3824  	.port_get_cmode = mv88e6352_port_get_cmode,
fdc71eea8c0aefa Andrew Lunn      2018-11-11  3825  	.port_set_cmode = mv88e6390_port_set_cmode,
121b8fe2fdc931a Hubert Feurstein 2019-07-31  3826  	.port_setup_message_port = mv88e6xxx_setup_message_port,
795234739105381 Andrew Lunn      2016-11-21  3827  	.stats_snapshot = mv88e6390_g1_stats_snapshot,
de2273876e3fb5a Andrew Lunn      2016-11-21  3828  	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
dfafe449bbc91df Andrew Lunn      2016-11-21  3829  	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
dfafe449bbc91df Andrew Lunn      2016-11-21  3830  	.stats_get_strings = mv88e6320_stats_get_strings,
e0d8b61556b672e Andrew Lunn      2016-11-21  3831  	.stats_get_stats = mv88e6390_stats_get_stats,
fa8d11796080987 Vivien Didelot   2017-06-08  3832  	.set_cpu_port = mv88e6390_g1_set_cpu_port,
fa8d11796080987 Vivien Didelot   2017-06-08  3833  	.set_egress_port = mv88e6390_g1_set_egress_port,
61303736638aa92 Andrew Lunn      2017-02-09  3834  	.watchdog_ops = &mv88e6390_watchdog_ops,
6e55f69846f0b11 Andrew Lunn      2016-12-03  3835  	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
9e907d739cc3caf Vivien Didelot   2017-07-17  3836  	.pot_clear = mv88e6xxx_g2_pot_clear,
17e708baf7f2419 Vivien Didelot   2016-12-05  3837  	.reset = mv88e6352_g1_reset,
9e5baf9b363673a Vivien Didelot   2018-05-09  3838  	.rmu_disable = mv88e6390_g1_rmu_disable,
23e8b470c7788da Andrew Lunn      2019-10-25  3839  	.atu_get_hash = mv88e6165_g1_atu_get_hash,
23e8b470c7788da Andrew Lunn      2019-10-25  3840  	.atu_set_hash = mv88e6165_g1_atu_set_hash,
931d18223998c53 Vivien Didelot   2017-05-01  3841  	.vtu_getnext = mv88e6390_g1_vtu_getnext,
931d18223998c53 Vivien Didelot   2017-05-01  3842  	.vtu_loadpurge = mv88e6390_g1_vtu_loadpurge,
6335e9f2446b441 Andrew Lunn      2017-05-26  3843  	.serdes_power = mv88e6390_serdes_power,
17deaf5cb37a365 Marek Behún      2019-08-26  3844  	.serdes_get_lane = mv88e6390_serdes_get_lane,
4241ef52372ebee Vivien Didelot   2019-08-31  3845  	.serdes_irq_mapping = mv88e6390_serdes_irq_mapping,
61a46b4147b2767 Vivien Didelot   2019-08-31  3846  	.serdes_irq_enable = mv88e6390_serdes_irq_enable,
907b9b9fcaef7fb Vivien Didelot   2019-08-31  3847  	.serdes_irq_status = mv88e6390_serdes_irq_status,
4262c38dc42e092 Andrew Lunn      2020-01-18  3848  	.serdes_get_strings = mv88e6390_serdes_get_strings,
4262c38dc42e092 Andrew Lunn      2020-01-18  3849  	.serdes_get_stats = mv88e6390_serdes_get_stats,
4262c38dc42e092 Andrew Lunn      2020-01-18 @3850  	.phylink_validate = mv88e6390_phylink_validate,
a73ccd610690505 Brandon Streiff  2018-02-14  3851  	.gpio_ops = &mv88e6352_gpio_ops,
6c422e34b1b6533 Russell King     2018-08-09 @3852  	.phylink_validate = mv88e6390_phylink_validate,
1a3b39ecfe32bf9 Andrew Lunn      2016-11-21  3853  };
1a3b39ecfe32bf9 Andrew Lunn      2016-11-21  3854

:::::: The code at line 3801 was first introduced by commit
:::::: 1a3b39ecfe32bf9a13df44b4fadf91d4e4d3d5ff net: dsa: mv88e6xxx: Add the mv88e6390 family

:::::: TO: Andrew Lunn <andrew@lunn.ch>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--8323329-753273642-1582094807=:2792--
