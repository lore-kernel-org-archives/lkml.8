Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D813AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8CA204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHFQac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:30:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:46052 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgHFQ3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:29:19 -0400
IronPort-SDR: W0cFft5Ni0C8MMk6y4LNpX9rzLMKdISgzFPBUAn+s9yfzC8S94G6NYU9CxN/wGolO0+UFRywcY
 XE+Z7Ky6by3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="153988030"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="gz'50?scan'50,208,50";a="153988030"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 09:26:42 -0700
IronPort-SDR: c96el9MwXOoWNyLWg1pq+aWdkMqdrKcO45PJa1J/Gto8BVQMn9t/ISD2VqX83kuGpNz3hrgLOc
 33K0Zgtbci3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="gz'50?scan'50,208,50";a="289323363"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2020 09:26:40 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3ij1-0001Tl-GA; Thu, 06 Aug 2020 16:26:39 +0000
Date:   Fri, 7 Aug 2020 00:25:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/xilinx/ll_temac_main.c:1410:64: sparse: sparse:
 Using plain integer as NULL pointer
Message-ID: <202008070052.yH1Em3c1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   47ec5303d73ea344e84f46660fff693c57641386
commit: bd69058f50d5ffa659423bcfa6fe6280ce9c760a net: ll_temac: Use devm_platform_ioremap_resource_byname()
date:   7 days ago
config: sparc64-randconfig-s032-20200806 (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-117-g8c7aee71-dirty
        git checkout bd69058f50d5ffa659423bcfa6fe6280ce9c760a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sparc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/xilinx/ll_temac_main.c:356:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] next @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:356:37: sparse:     expected unsigned int [usertype] next
   drivers/net/ethernet/xilinx/ll_temac_main.c:356:37: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:361:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] next @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:361:37: sparse:     expected unsigned int [usertype] next
   drivers/net/ethernet/xilinx/ll_temac_main.c:361:37: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:376:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] phys @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:376:37: sparse:     expected unsigned int [usertype] phys
   drivers/net/ethernet/xilinx/ll_temac_main.c:376:37: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:377:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:377:36: sparse:     expected unsigned int [usertype] len
   drivers/net/ethernet/xilinx/ll_temac_main.c:377:36: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:378:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] app0 @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:378:37: sparse:     expected unsigned int [usertype] app0
   drivers/net/ethernet/xilinx/ll_temac_main.c:378:37: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:774:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:777:17: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:777:17: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:789:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:796:24: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:863:29: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/xilinx/ll_temac_main.c:863:29: sparse:    left side has type unsigned int
   drivers/net/ethernet/xilinx/ll_temac_main.c:863:29: sparse:    right side has type restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:864:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] app1 @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:864:29: sparse:     expected unsigned int [usertype] app1
   drivers/net/ethernet/xilinx/ll_temac_main.c:864:29: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:869:21: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/xilinx/ll_temac_main.c:869:21: sparse:    left side has type unsigned int
   drivers/net/ethernet/xilinx/ll_temac_main.c:869:21: sparse:    right side has type restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:872:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:872:20: sparse:     expected unsigned int [usertype] len
   drivers/net/ethernet/xilinx/ll_temac_main.c:872:20: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:878:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] phys @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:878:21: sparse:     expected unsigned int [usertype] phys
   drivers/net/ethernet/xilinx/ll_temac_main.c:878:21: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:896:33: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:904:25: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:911:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] phys @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:911:29: sparse:     expected unsigned int [usertype] phys
   drivers/net/ethernet/xilinx/ll_temac_main.c:911:29: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:912:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:912:28: sparse:     expected unsigned int [usertype] len
   drivers/net/ethernet/xilinx/ll_temac_main.c:912:28: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:916:21: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/xilinx/ll_temac_main.c:916:21: sparse:    left side has type unsigned int
   drivers/net/ethernet/xilinx/ll_temac_main.c:916:21: sparse:    right side has type restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:961:39: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:975:17: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:981:26: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:996:37: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/xilinx/ll_temac_main.c:996:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:996:35: sparse:     expected restricted __wsum [usertype] csum
   drivers/net/ethernet/xilinx/ll_temac_main.c:996:35: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:1062:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] phys @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:1062:26: sparse:     expected unsigned int [usertype] phys
   drivers/net/ethernet/xilinx/ll_temac_main.c:1062:26: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:1063:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:1063:25: sparse:     expected unsigned int [usertype] len
   drivers/net/ethernet/xilinx/ll_temac_main.c:1063:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/xilinx/ll_temac_main.c:1064:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] app0 @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/xilinx/ll_temac_main.c:1064:26: sparse:     expected unsigned int [usertype] app0
   drivers/net/ethernet/xilinx/ll_temac_main.c:1064:26: sparse:     got restricted __be32 [usertype]
>> drivers/net/ethernet/xilinx/ll_temac_main.c:1410:64: sparse: sparse: Using plain integer as NULL pointer

vim +1410 drivers/net/ethernet/xilinx/ll_temac_main.c

  1383	
  1384		/* setup temac private info structure */
  1385		lp = netdev_priv(ndev);
  1386		lp->ndev = ndev;
  1387		lp->dev = &pdev->dev;
  1388		lp->options = XTE_OPTION_DEFAULTS;
  1389		lp->rx_bd_num = RX_BD_NUM_DEFAULT;
  1390		lp->tx_bd_num = TX_BD_NUM_DEFAULT;
  1391		spin_lock_init(&lp->rx_lock);
  1392		INIT_DELAYED_WORK(&lp->restart_work, ll_temac_restart_work_func);
  1393	
  1394		/* Setup mutex for synchronization of indirect register access */
  1395		if (pdata) {
  1396			if (!pdata->indirect_lock) {
  1397				dev_err(&pdev->dev,
  1398					"indirect_lock missing in platform_data\n");
  1399				return -EINVAL;
  1400			}
  1401			lp->indirect_lock = pdata->indirect_lock;
  1402		} else {
  1403			lp->indirect_lock = devm_kmalloc(&pdev->dev,
  1404							 sizeof(*lp->indirect_lock),
  1405							 GFP_KERNEL);
  1406			spin_lock_init(lp->indirect_lock);
  1407		}
  1408	
  1409		/* map device registers */
> 1410		lp->regs = devm_platform_ioremap_resource_byname(pdev, 0);
  1411		if (IS_ERR(lp->regs)) {
  1412			dev_err(&pdev->dev, "could not map TEMAC registers\n");
  1413			return -ENOMEM;
  1414		}
  1415	
  1416		/* Select register access functions with the specified
  1417		 * endianness mode.  Default for OF devices is big-endian.
  1418		 */
  1419		little_endian = false;
  1420		if (temac_np) {
  1421			if (of_get_property(temac_np, "little-endian", NULL))
  1422				little_endian = true;
  1423		} else if (pdata) {
  1424			little_endian = pdata->reg_little_endian;
  1425		}
  1426		if (little_endian) {
  1427			lp->temac_ior = _temac_ior_le;
  1428			lp->temac_iow = _temac_iow_le;
  1429		} else {
  1430			lp->temac_ior = _temac_ior_be;
  1431			lp->temac_iow = _temac_iow_be;
  1432		}
  1433	
  1434		/* Setup checksum offload, but default to off if not specified */
  1435		lp->temac_features = 0;
  1436		if (temac_np) {
  1437			p = (__be32 *)of_get_property(temac_np, "xlnx,txcsum", NULL);
  1438			if (p && be32_to_cpu(*p))
  1439				lp->temac_features |= TEMAC_FEATURE_TX_CSUM;
  1440			p = (__be32 *)of_get_property(temac_np, "xlnx,rxcsum", NULL);
  1441			if (p && be32_to_cpu(*p))
  1442				lp->temac_features |= TEMAC_FEATURE_RX_CSUM;
  1443		} else if (pdata) {
  1444			if (pdata->txcsum)
  1445				lp->temac_features |= TEMAC_FEATURE_TX_CSUM;
  1446			if (pdata->rxcsum)
  1447				lp->temac_features |= TEMAC_FEATURE_RX_CSUM;
  1448		}
  1449		if (lp->temac_features & TEMAC_FEATURE_TX_CSUM)
  1450			/* Can checksum TCP/UDP over IPv4. */
  1451			ndev->features |= NETIF_F_IP_CSUM;
  1452	
  1453		/* Defaults for IRQ delay/coalescing setup.  These are
  1454		 * configuration values, so does not belong in device-tree.
  1455		 */
  1456		lp->coalesce_delay_tx = 0x10;
  1457		lp->coalesce_count_tx = 0x22;
  1458		lp->coalesce_delay_rx = 0xff;
  1459		lp->coalesce_count_rx = 0x07;
  1460	
  1461		/* Setup LocalLink DMA */
  1462		if (temac_np) {
  1463			/* Find the DMA node, map the DMA registers, and
  1464			 * decode the DMA IRQs.
  1465			 */
  1466			dma_np = of_parse_phandle(temac_np, "llink-connected", 0);
  1467			if (!dma_np) {
  1468				dev_err(&pdev->dev, "could not find DMA node\n");
  1469				return -ENODEV;
  1470			}
  1471	
  1472			/* Setup the DMA register accesses, could be DCR or
  1473			 * memory mapped.
  1474			 */
  1475			if (temac_dcr_setup(lp, pdev, dma_np)) {
  1476				/* no DCR in the device tree, try non-DCR */
  1477				lp->sdma_regs = devm_of_iomap(&pdev->dev, dma_np, 0,
  1478							      NULL);
  1479				if (IS_ERR(lp->sdma_regs)) {
  1480					dev_err(&pdev->dev,
  1481						"unable to map DMA registers\n");
  1482					of_node_put(dma_np);
  1483					return PTR_ERR(lp->sdma_regs);
  1484				}
  1485				if (of_get_property(dma_np, "little-endian", NULL)) {
  1486					lp->dma_in = temac_dma_in32_le;
  1487					lp->dma_out = temac_dma_out32_le;
  1488				} else {
  1489					lp->dma_in = temac_dma_in32_be;
  1490					lp->dma_out = temac_dma_out32_be;
  1491				}
  1492				dev_dbg(&pdev->dev, "MEM base: %p\n", lp->sdma_regs);
  1493			}
  1494	
  1495			/* Get DMA RX and TX interrupts */
  1496			lp->rx_irq = irq_of_parse_and_map(dma_np, 0);
  1497			lp->tx_irq = irq_of_parse_and_map(dma_np, 1);
  1498	
  1499			/* Finished with the DMA node; drop the reference */
  1500			of_node_put(dma_np);
  1501		} else if (pdata) {
  1502			/* 2nd memory resource specifies DMA registers */
  1503			res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
  1504			lp->sdma_regs = devm_ioremap(&pdev->dev, res->start,
  1505							     resource_size(res));
  1506			if (!lp->sdma_regs) {
  1507				dev_err(&pdev->dev,
  1508					"could not map DMA registers\n");
  1509				return -ENOMEM;
  1510			}
  1511			if (pdata->dma_little_endian) {
  1512				lp->dma_in = temac_dma_in32_le;
  1513				lp->dma_out = temac_dma_out32_le;
  1514			} else {
  1515				lp->dma_in = temac_dma_in32_be;
  1516				lp->dma_out = temac_dma_out32_be;
  1517			}
  1518	
  1519			/* Get DMA RX and TX interrupts */
  1520			lp->rx_irq = platform_get_irq(pdev, 0);
  1521			lp->tx_irq = platform_get_irq(pdev, 1);
  1522	
  1523			/* IRQ delay/coalescing setup */
  1524			if (pdata->tx_irq_timeout || pdata->tx_irq_count) {
  1525				lp->coalesce_delay_tx = pdata->tx_irq_timeout;
  1526				lp->coalesce_count_tx = pdata->tx_irq_count;
  1527			}
  1528			if (pdata->rx_irq_timeout || pdata->rx_irq_count) {
  1529				lp->coalesce_delay_rx = pdata->rx_irq_timeout;
  1530				lp->coalesce_count_rx = pdata->rx_irq_count;
  1531			}
  1532		}
  1533	
  1534		/* Error handle returned DMA RX and TX interrupts */
  1535		if (lp->rx_irq < 0) {
  1536			if (lp->rx_irq != -EPROBE_DEFER)
  1537				dev_err(&pdev->dev, "could not get DMA RX irq\n");
  1538			return lp->rx_irq;
  1539		}
  1540		if (lp->tx_irq < 0) {
  1541			if (lp->tx_irq != -EPROBE_DEFER)
  1542				dev_err(&pdev->dev, "could not get DMA TX irq\n");
  1543			return lp->tx_irq;
  1544		}
  1545	
  1546		if (temac_np) {
  1547			/* Retrieve the MAC address */
  1548			addr = of_get_mac_address(temac_np);
  1549			if (IS_ERR(addr)) {
  1550				dev_err(&pdev->dev, "could not find MAC address\n");
  1551				return -ENODEV;
  1552			}
  1553			temac_init_mac_address(ndev, addr);
  1554		} else if (pdata) {
  1555			temac_init_mac_address(ndev, pdata->mac_addr);
  1556		}
  1557	
  1558		rc = temac_mdio_setup(lp, pdev);
  1559		if (rc)
  1560			dev_warn(&pdev->dev, "error registering MDIO bus\n");
  1561	
  1562		if (temac_np) {
  1563			lp->phy_node = of_parse_phandle(temac_np, "phy-handle", 0);
  1564			if (lp->phy_node)
  1565				dev_dbg(lp->dev, "using PHY node %pOF\n", temac_np);
  1566		} else if (pdata) {
  1567			snprintf(lp->phy_name, sizeof(lp->phy_name),
  1568				 PHY_ID_FMT, lp->mii_bus->id, pdata->phy_addr);
  1569			lp->phy_interface = pdata->phy_interface;
  1570		}
  1571	
  1572		/* Add the device attributes */
  1573		rc = sysfs_create_group(&lp->dev->kobj, &temac_attr_group);
  1574		if (rc) {
  1575			dev_err(lp->dev, "Error creating sysfs files\n");
  1576			goto err_sysfs_create;
  1577		}
  1578	
  1579		rc = register_netdev(lp->ndev);
  1580		if (rc) {
  1581			dev_err(lp->dev, "register_netdev() error (%i)\n", rc);
  1582			goto err_register_ndev;
  1583		}
  1584	
  1585		return 0;
  1586	
  1587	err_register_ndev:
  1588		sysfs_remove_group(&lp->dev->kobj, &temac_attr_group);
  1589	err_sysfs_create:
  1590		if (lp->phy_node)
  1591			of_node_put(lp->phy_node);
  1592		temac_mdio_teardown(lp);
  1593		return rc;
  1594	}
  1595	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--M9NhX3UHpAaciwkO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AA==

--M9NhX3UHpAaciwkO--
