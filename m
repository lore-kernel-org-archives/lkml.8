Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748C5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 12:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C462076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 12:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgEXMSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 08:18:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:15943 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgEXMSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 08:18:11 -0400
IronPort-SDR: L+sO4ZQ1aeXooyGptjZCwzemL6x8C2+RZWB8HRGx5B5zUMrXCptmvncSqiCrcvj444fr8eDdeG
 KI8kZhNoarpg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 05:18:03 -0700
IronPort-SDR: J/IKAzfvEh2ru8EBtYPgl6QwjApFj5WPh6+tW4Gi6KT86tZv2oPqFH90rDyBJ/40IxYpPk+i2o
 zpSPmC7UW/ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,429,1583222400"; 
   d="gz'50?scan'50,208,50";a="309785827"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 May 2020 05:18:01 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jcpZo-000DCx-Pd; Sun, 24 May 2020 20:18:00 +0800
Date:   Sun, 24 May 2020 20:16:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1680: undefined
 reference to `devm_ioremap_resource'
Message-ID: <202005242032.Kn1Imbky%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Brendan,

It's probably a bug fix that unveils the link errors.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   caffb99b6929f41a69edbb5aef3a359bf45f3315
commit: 0e31e3573f0cd94d7b821117db854187ffc85765 lkdtm/bugs: fix build error in lkdtm_UNSET_SMEP
date:   4 months ago
config: um-randconfig-s001-20200524 (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-193-gb8fad4bc-dirty
        git checkout 0e31e3573f0cd94d7b821117db854187ffc85765
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=um CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

/usr/bin/ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.o: in function `axienet_probe':
>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1680: undefined reference to `devm_ioremap_resource'
collect2: error: ld returned 1 exit status

vim +1680 drivers/net/ethernet/xilinx/xilinx_axienet_main.c

8a3b7a252dca9f Daniel Borkmann     2012-01-19  1633  
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1634  /**
2be586205ca2b8 Srikanth Thokala    2015-05-05  1635   * axienet_probe - Axi Ethernet probe function.
95219aa538e11d Srikanth Thokala    2015-05-05  1636   * @pdev:	Pointer to platform device structure.
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1637   *
b0d081c524b46c Michal Simek        2015-05-05  1638   * Return: 0, on success
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1639   *	    Non-zero error value on failure.
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1640   *
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1641   * This is the probe routine for Axi Ethernet driver. This is called before
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1642   * any other driver routines are invoked. It allocates and sets up the Ethernet
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1643   * device. Parses through device tree and populates fields of
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1644   * axienet_local. It registers the Ethernet device.
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1645   */
2be586205ca2b8 Srikanth Thokala    2015-05-05  1646  static int axienet_probe(struct platform_device *pdev)
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1647  {
8495659bf93c8e Srikanth Thokala    2015-05-05  1648  	int ret;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1649  	struct device_node *np;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1650  	struct axienet_local *lp;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1651  	struct net_device *ndev;
da90e38003e2f0 Tobias Klauser      2016-12-07  1652  	const void *mac_addr;
28ef9ebdb64c6f Robert Hancock      2019-06-06  1653  	struct resource *ethres;
8495659bf93c8e Srikanth Thokala    2015-05-05  1654  	u32 value;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1655  
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1656  	ndev = alloc_etherdev(sizeof(*lp));
41de8d4cff21a2 Joe Perches         2012-01-29  1657  	if (!ndev)
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1658  		return -ENOMEM;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1659  
95219aa538e11d Srikanth Thokala    2015-05-05  1660  	platform_set_drvdata(pdev, ndev);
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1661  
95219aa538e11d Srikanth Thokala    2015-05-05  1662  	SET_NETDEV_DEV(ndev, &pdev->dev);
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1663  	ndev->flags &= ~IFF_MULTICAST;  /* clear multicast */
28e24c62ab3062 Eric Dumazet        2013-12-02  1664  	ndev->features = NETIF_F_SG;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1665  	ndev->netdev_ops = &axienet_netdev_ops;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1666  	ndev->ethtool_ops = &axienet_ethtool_ops;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1667  
d894be57ca92c8 Jarod Wilson        2016-10-20  1668  	/* MTU range: 64 - 9000 */
d894be57ca92c8 Jarod Wilson        2016-10-20  1669  	ndev->min_mtu = 64;
d894be57ca92c8 Jarod Wilson        2016-10-20  1670  	ndev->max_mtu = XAE_JUMBO_MTU;
d894be57ca92c8 Jarod Wilson        2016-10-20  1671  
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1672  	lp = netdev_priv(ndev);
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1673  	lp->ndev = ndev;
95219aa538e11d Srikanth Thokala    2015-05-05  1674  	lp->dev = &pdev->dev;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1675  	lp->options = XAE_OPTION_DEFAULTS;
8b09ca823ffb4e Robert Hancock      2019-06-06  1676  	lp->rx_bd_num = RX_BD_NUM_DEFAULT;
8b09ca823ffb4e Robert Hancock      2019-06-06  1677  	lp->tx_bd_num = TX_BD_NUM_DEFAULT;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1678  	/* Map device registers */
46aa27df885321 Srikanth Thokala    2015-05-05  1679  	ethres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
46aa27df885321 Srikanth Thokala    2015-05-05 @1680  	lp->regs = devm_ioremap_resource(&pdev->dev, ethres);
fcc028c106e575 Krzysztof Kozlowski 2015-07-09  1681  	if (IS_ERR(lp->regs)) {
95219aa538e11d Srikanth Thokala    2015-05-05  1682  		dev_err(&pdev->dev, "could not map Axi Ethernet regs.\n");
fcc028c106e575 Krzysztof Kozlowski 2015-07-09  1683  		ret = PTR_ERR(lp->regs);
46aa27df885321 Srikanth Thokala    2015-05-05  1684  		goto free_netdev;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1685  	}
7fa0043d5c74c6 Robert Hancock      2019-06-11  1686  	lp->regs_start = ethres->start;
46aa27df885321 Srikanth Thokala    2015-05-05  1687  
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1688  	/* Setup checksum offload, but default to off if not specified */
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1689  	lp->features = 0;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1690  
8495659bf93c8e Srikanth Thokala    2015-05-05  1691  	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,txcsum", &value);
8495659bf93c8e Srikanth Thokala    2015-05-05  1692  	if (!ret) {
8495659bf93c8e Srikanth Thokala    2015-05-05  1693  		switch (value) {
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1694  		case 1:
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1695  			lp->csum_offload_on_tx_path =
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1696  				XAE_FEATURE_PARTIAL_TX_CSUM;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1697  			lp->features |= XAE_FEATURE_PARTIAL_TX_CSUM;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1698  			/* Can checksum TCP/UDP over IPv4. */
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1699  			ndev->features |= NETIF_F_IP_CSUM;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1700  			break;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1701  		case 2:
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1702  			lp->csum_offload_on_tx_path =
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1703  				XAE_FEATURE_FULL_TX_CSUM;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1704  			lp->features |= XAE_FEATURE_FULL_TX_CSUM;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1705  			/* Can checksum TCP/UDP over IPv4. */
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1706  			ndev->features |= NETIF_F_IP_CSUM;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1707  			break;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1708  		default:
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1709  			lp->csum_offload_on_tx_path = XAE_NO_CSUM_OFFLOAD;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1710  		}
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1711  	}
8495659bf93c8e Srikanth Thokala    2015-05-05  1712  	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,rxcsum", &value);
8495659bf93c8e Srikanth Thokala    2015-05-05  1713  	if (!ret) {
8495659bf93c8e Srikanth Thokala    2015-05-05  1714  		switch (value) {
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1715  		case 1:
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1716  			lp->csum_offload_on_rx_path =
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1717  				XAE_FEATURE_PARTIAL_RX_CSUM;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1718  			lp->features |= XAE_FEATURE_PARTIAL_RX_CSUM;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1719  			break;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1720  		case 2:
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1721  			lp->csum_offload_on_rx_path =
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1722  				XAE_FEATURE_FULL_RX_CSUM;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1723  			lp->features |= XAE_FEATURE_FULL_RX_CSUM;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1724  			break;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1725  		default:
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1726  			lp->csum_offload_on_rx_path = XAE_NO_CSUM_OFFLOAD;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1727  		}
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1728  	}
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1729  	/* For supporting jumbo frames, the Axi Ethernet hardware must have
f080a8c35d8932 Srikanth Thokala    2015-05-05  1730  	 * a larger Rx/Tx Memory. Typically, the size must be large so that
f080a8c35d8932 Srikanth Thokala    2015-05-05  1731  	 * we can enable jumbo option and start supporting jumbo frames.
f080a8c35d8932 Srikanth Thokala    2015-05-05  1732  	 * Here we check for memory allocated for Rx/Tx in the hardware from
f080a8c35d8932 Srikanth Thokala    2015-05-05  1733  	 * the device-tree and accordingly set flags.
f080a8c35d8932 Srikanth Thokala    2015-05-05  1734  	 */
8495659bf93c8e Srikanth Thokala    2015-05-05  1735  	of_property_read_u32(pdev->dev.of_node, "xlnx,rxmem", &lp->rxmem);
ee06b1728b9564 Alvaro G. M         2017-07-17  1736  
ee06b1728b9564 Alvaro G. M         2017-07-17  1737  	/* Start with the proprietary, and broken phy_type */
ee06b1728b9564 Alvaro G. M         2017-07-17  1738  	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,phy-type", &value);
ee06b1728b9564 Alvaro G. M         2017-07-17  1739  	if (!ret) {
ee06b1728b9564 Alvaro G. M         2017-07-17  1740  		netdev_warn(ndev, "Please upgrade your device tree binary blob to use phy-mode");
ee06b1728b9564 Alvaro G. M         2017-07-17  1741  		switch (value) {
ee06b1728b9564 Alvaro G. M         2017-07-17  1742  		case XAE_PHY_TYPE_MII:
ee06b1728b9564 Alvaro G. M         2017-07-17  1743  			lp->phy_mode = PHY_INTERFACE_MODE_MII;
ee06b1728b9564 Alvaro G. M         2017-07-17  1744  			break;
ee06b1728b9564 Alvaro G. M         2017-07-17  1745  		case XAE_PHY_TYPE_GMII:
ee06b1728b9564 Alvaro G. M         2017-07-17  1746  			lp->phy_mode = PHY_INTERFACE_MODE_GMII;
ee06b1728b9564 Alvaro G. M         2017-07-17  1747  			break;
ee06b1728b9564 Alvaro G. M         2017-07-17  1748  		case XAE_PHY_TYPE_RGMII_2_0:
ee06b1728b9564 Alvaro G. M         2017-07-17  1749  			lp->phy_mode = PHY_INTERFACE_MODE_RGMII_ID;
ee06b1728b9564 Alvaro G. M         2017-07-17  1750  			break;
ee06b1728b9564 Alvaro G. M         2017-07-17  1751  		case XAE_PHY_TYPE_SGMII:
ee06b1728b9564 Alvaro G. M         2017-07-17  1752  			lp->phy_mode = PHY_INTERFACE_MODE_SGMII;
ee06b1728b9564 Alvaro G. M         2017-07-17  1753  			break;
ee06b1728b9564 Alvaro G. M         2017-07-17  1754  		case XAE_PHY_TYPE_1000BASE_X:
ee06b1728b9564 Alvaro G. M         2017-07-17  1755  			lp->phy_mode = PHY_INTERFACE_MODE_1000BASEX;
ee06b1728b9564 Alvaro G. M         2017-07-17  1756  			break;
ee06b1728b9564 Alvaro G. M         2017-07-17  1757  		default:
ee06b1728b9564 Alvaro G. M         2017-07-17  1758  			ret = -EINVAL;
ee06b1728b9564 Alvaro G. M         2017-07-17  1759  			goto free_netdev;
ee06b1728b9564 Alvaro G. M         2017-07-17  1760  		}
ee06b1728b9564 Alvaro G. M         2017-07-17  1761  	} else {
0c65b2b90d13c1 Andrew Lunn         2019-11-04  1762  		ret = of_get_phy_mode(pdev->dev.of_node, &lp->phy_mode);
0c65b2b90d13c1 Andrew Lunn         2019-11-04  1763  		if (ret)
ee06b1728b9564 Alvaro G. M         2017-07-17  1764  			goto free_netdev;
ee06b1728b9564 Alvaro G. M         2017-07-17  1765  	}
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1766  
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1767  	/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
95219aa538e11d Srikanth Thokala    2015-05-05  1768  	np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
28ef9ebdb64c6f Robert Hancock      2019-06-06  1769  	if (np) {
28ef9ebdb64c6f Robert Hancock      2019-06-06  1770  		struct resource dmares;
28ef9ebdb64c6f Robert Hancock      2019-06-06  1771  
46aa27df885321 Srikanth Thokala    2015-05-05  1772  		ret = of_address_to_resource(np, 0, &dmares);
46aa27df885321 Srikanth Thokala    2015-05-05  1773  		if (ret) {
28ef9ebdb64c6f Robert Hancock      2019-06-06  1774  			dev_err(&pdev->dev,
28ef9ebdb64c6f Robert Hancock      2019-06-06  1775  				"unable to get DMA resource\n");
fa3a419d2f674b Wen Yang            2019-03-22  1776  			of_node_put(np);
46aa27df885321 Srikanth Thokala    2015-05-05  1777  			goto free_netdev;
46aa27df885321 Srikanth Thokala    2015-05-05  1778  		}
28ef9ebdb64c6f Robert Hancock      2019-06-06  1779  		lp->dma_regs = devm_ioremap_resource(&pdev->dev,
28ef9ebdb64c6f Robert Hancock      2019-06-06  1780  						     &dmares);
28ef9ebdb64c6f Robert Hancock      2019-06-06  1781  		lp->rx_irq = irq_of_parse_and_map(np, 1);
28ef9ebdb64c6f Robert Hancock      2019-06-06  1782  		lp->tx_irq = irq_of_parse_and_map(np, 0);
28ef9ebdb64c6f Robert Hancock      2019-06-06  1783  		of_node_put(np);
28ef9ebdb64c6f Robert Hancock      2019-06-06  1784  		lp->eth_irq = platform_get_irq(pdev, 0);
28ef9ebdb64c6f Robert Hancock      2019-06-06  1785  	} else {
28ef9ebdb64c6f Robert Hancock      2019-06-06  1786  		/* Check for these resources directly on the Ethernet node. */
28ef9ebdb64c6f Robert Hancock      2019-06-06  1787  		struct resource *res = platform_get_resource(pdev,
28ef9ebdb64c6f Robert Hancock      2019-06-06  1788  							     IORESOURCE_MEM, 1);
28ef9ebdb64c6f Robert Hancock      2019-06-06  1789  		lp->dma_regs = devm_ioremap_resource(&pdev->dev, res);
28ef9ebdb64c6f Robert Hancock      2019-06-06  1790  		lp->rx_irq = platform_get_irq(pdev, 1);
28ef9ebdb64c6f Robert Hancock      2019-06-06  1791  		lp->tx_irq = platform_get_irq(pdev, 0);
28ef9ebdb64c6f Robert Hancock      2019-06-06  1792  		lp->eth_irq = platform_get_irq(pdev, 2);
28ef9ebdb64c6f Robert Hancock      2019-06-06  1793  	}
fcc028c106e575 Krzysztof Kozlowski 2015-07-09  1794  	if (IS_ERR(lp->dma_regs)) {
46aa27df885321 Srikanth Thokala    2015-05-05  1795  		dev_err(&pdev->dev, "could not map DMA regs\n");
fcc028c106e575 Krzysztof Kozlowski 2015-07-09  1796  		ret = PTR_ERR(lp->dma_regs);
46aa27df885321 Srikanth Thokala    2015-05-05  1797  		goto free_netdev;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1798  	}
cb59c87dbc8be2 Michal Simek        2013-01-10  1799  	if ((lp->rx_irq <= 0) || (lp->tx_irq <= 0)) {
95219aa538e11d Srikanth Thokala    2015-05-05  1800  		dev_err(&pdev->dev, "could not determine irqs\n");
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1801  		ret = -ENOMEM;
46aa27df885321 Srikanth Thokala    2015-05-05  1802  		goto free_netdev;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1803  	}
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1804  
522856cefaf09d Robert Hancock      2019-06-06  1805  	/* Check for Ethernet core IRQ (optional) */
522856cefaf09d Robert Hancock      2019-06-06  1806  	if (lp->eth_irq <= 0)
522856cefaf09d Robert Hancock      2019-06-06  1807  		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");
522856cefaf09d Robert Hancock      2019-06-06  1808  
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1809  	/* Retrieve the MAC address */
da90e38003e2f0 Tobias Klauser      2016-12-07  1810  	mac_addr = of_get_mac_address(pdev->dev.of_node);
a51645f70f6384 Petr Štetiar        2019-05-06  1811  	if (IS_ERR(mac_addr)) {
d05a9ed5c3a773 Robert Hancock      2019-06-06  1812  		dev_warn(&pdev->dev, "could not find MAC address property: %ld\n",
d05a9ed5c3a773 Robert Hancock      2019-06-06  1813  			 PTR_ERR(mac_addr));
d05a9ed5c3a773 Robert Hancock      2019-06-06  1814  		mac_addr = NULL;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1815  	}
da90e38003e2f0 Tobias Klauser      2016-12-07  1816  	axienet_set_mac_address(ndev, mac_addr);
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1817  
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1818  	lp->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1819  	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1820  
95219aa538e11d Srikanth Thokala    2015-05-05  1821  	lp->phy_node = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
46aa27df885321 Srikanth Thokala    2015-05-05  1822  	if (lp->phy_node) {
09a0354cadec26 Robert Hancock      2019-06-06  1823  		lp->clk = devm_clk_get(&pdev->dev, NULL);
09a0354cadec26 Robert Hancock      2019-06-06  1824  		if (IS_ERR(lp->clk)) {
09a0354cadec26 Robert Hancock      2019-06-06  1825  			dev_warn(&pdev->dev, "Failed to get clock: %ld\n",
09a0354cadec26 Robert Hancock      2019-06-06  1826  				 PTR_ERR(lp->clk));
09a0354cadec26 Robert Hancock      2019-06-06  1827  			lp->clk = NULL;
09a0354cadec26 Robert Hancock      2019-06-06  1828  		} else {
09a0354cadec26 Robert Hancock      2019-06-06  1829  			ret = clk_prepare_enable(lp->clk);
09a0354cadec26 Robert Hancock      2019-06-06  1830  			if (ret) {
09a0354cadec26 Robert Hancock      2019-06-06  1831  				dev_err(&pdev->dev, "Unable to enable clock: %d\n",
09a0354cadec26 Robert Hancock      2019-06-06  1832  					ret);
09a0354cadec26 Robert Hancock      2019-06-06  1833  				goto free_netdev;
09a0354cadec26 Robert Hancock      2019-06-06  1834  			}
09a0354cadec26 Robert Hancock      2019-06-06  1835  		}
09a0354cadec26 Robert Hancock      2019-06-06  1836  
09a0354cadec26 Robert Hancock      2019-06-06  1837  		ret = axienet_mdio_setup(lp);
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1838  		if (ret)
09a0354cadec26 Robert Hancock      2019-06-06  1839  			dev_warn(&pdev->dev,
09a0354cadec26 Robert Hancock      2019-06-06  1840  				 "error registering MDIO bus: %d\n", ret);
46aa27df885321 Srikanth Thokala    2015-05-05  1841  	}
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1842  
f5203a3d9b25fa Robert Hancock      2019-06-06  1843  	lp->phylink_config.dev = &ndev->dev;
f5203a3d9b25fa Robert Hancock      2019-06-06  1844  	lp->phylink_config.type = PHYLINK_NETDEV;
f5203a3d9b25fa Robert Hancock      2019-06-06  1845  
f5203a3d9b25fa Robert Hancock      2019-06-06  1846  	lp->phylink = phylink_create(&lp->phylink_config, pdev->dev.fwnode,
f5203a3d9b25fa Robert Hancock      2019-06-06  1847  				     lp->phy_mode,
f5203a3d9b25fa Robert Hancock      2019-06-06  1848  				     &axienet_phylink_ops);
f5203a3d9b25fa Robert Hancock      2019-06-06  1849  	if (IS_ERR(lp->phylink)) {
f5203a3d9b25fa Robert Hancock      2019-06-06  1850  		ret = PTR_ERR(lp->phylink);
f5203a3d9b25fa Robert Hancock      2019-06-06  1851  		dev_err(&pdev->dev, "phylink_create error (%i)\n", ret);
f5203a3d9b25fa Robert Hancock      2019-06-06  1852  		goto free_netdev;
f5203a3d9b25fa Robert Hancock      2019-06-06  1853  	}
f5203a3d9b25fa Robert Hancock      2019-06-06  1854  
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1855  	ret = register_netdev(lp->ndev);
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1856  	if (ret) {
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1857  		dev_err(lp->dev, "register_netdev() error (%i)\n", ret);
46aa27df885321 Srikanth Thokala    2015-05-05  1858  		goto free_netdev;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1859  	}
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1860  
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1861  	return 0;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1862  
46aa27df885321 Srikanth Thokala    2015-05-05  1863  free_netdev:
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1864  	free_netdev(ndev);
46aa27df885321 Srikanth Thokala    2015-05-05  1865  
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1866  	return ret;
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1867  }
8a3b7a252dca9f Daniel Borkmann     2012-01-19  1868  

:::::: The code at line 1680 was first introduced by commit
:::::: 46aa27df88532146974628602b6f5cc587422388 net: axienet: Use devm_* calls

:::::: TO: Srikanth Thokala <srikanth.thokala@xilinx.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--OXfL5xGRrasGEqWY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--OXfL5xGRrasGEqWY--
