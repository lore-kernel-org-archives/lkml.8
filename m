Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C80C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2FF22516
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgFUNKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 09:10:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:37941 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730016AbgFUNKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:10:43 -0400
IronPort-SDR: YZdf24RlSqYhkyhNWFXuI7mOlhXLwPagYxeXha2C0u+ghC/DMVcJN358C4sZ9d4NQ/bySKv2dH
 zwQNLNiHFNdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9658"; a="142592553"
X-IronPort-AV: E=Sophos;i="5.75,263,1589266800"; 
   d="gz'50?scan'50,208,50";a="142592553"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2020 05:51:39 -0700
IronPort-SDR: vKvzNrU80W48oTQkiWU51IpI39jTjcb8DIxGQK4hpjJIHRaGFovGSCb6Zxi91v8qs7qM8M0rOE
 SkZRgn4BAX6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,263,1589266800"; 
   d="gz'50?scan'50,208,50";a="353186984"
Received: from lkp-server02.sh.intel.com (HELO 3aa54c81372e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2020 05:51:37 -0700
Received: from kbuild by 3aa54c81372e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jmzRg-0002gE-Eg; Sun, 21 Jun 2020 12:51:36 +0000
Date:   Sun, 21 Jun 2020 20:51:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1225:18:
 sparse: sparse: incorrect type in assignment (different base types)
Message-ID: <202006212002.m7TENLZq%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   64677779e8962c20b580b471790fe42367750599
commit: 4647e021193d638d3c87d1f1b9a5f7f7a48f36a3 net: stmmac: selftests: Add selftest for L3/L4 Filters
date:   10 months ago
config: riscv-randconfig-s031-20200621 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-rc2-13-gc59158c8-dirty
        git checkout 4647e021193d638d3c87d1f1b9a5f7f7a48f36a3
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=riscv CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:991:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] mask @@     got int @@
   drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:991:27: sparse:     expected restricted __be32 [usertype] mask
   drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:991:27: sparse:     got int
>> drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1225:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [addressable] [usertype] src @@     got unsigned int [usertype] src_mask @@
   drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1225:18: sparse:     expected restricted __be32 [addressable] [usertype] src
   drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1225:18: sparse:     got unsigned int [usertype] src_mask
>> drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1226:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [addressable] [usertype] dst @@     got unsigned int [usertype] dst_mask @@
   drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1226:18: sparse:     expected restricted __be32 [addressable] [usertype] dst
   drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1226:18: sparse:     got unsigned int [usertype] dst_mask
>> drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1352:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [addressable] [usertype] src @@     got unsigned int [usertype] src_mask @@
   drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1352:24: sparse:     expected restricted __be16 [addressable] [usertype] src
   drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1352:24: sparse:     got unsigned int [usertype] src_mask
>> drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1353:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [addressable] [usertype] dst @@     got unsigned int [usertype] dst_mask @@
   drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1353:24: sparse:     expected restricted __be16 [addressable] [usertype] dst
   drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1353:24: sparse:     got unsigned int [usertype] dst_mask

vim +1225 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c

  1170	
  1171	#ifdef CONFIG_NET_CLS_ACT
  1172	static int __stmmac_test_l3filt(struct stmmac_priv *priv, u32 dst, u32 src,
  1173					u32 dst_mask, u32 src_mask)
  1174	{
  1175		struct flow_dissector_key_ipv4_addrs key, mask;
  1176		unsigned long dummy_cookie = 0xdeadbeef;
  1177		struct stmmac_packet_attrs attr = { };
  1178		struct flow_dissector *dissector;
  1179		struct flow_cls_offload *cls;
  1180		struct flow_rule *rule;
  1181		int ret;
  1182	
  1183		if (!tc_can_offload(priv->dev))
  1184			return -EOPNOTSUPP;
  1185		if (!priv->dma_cap.l3l4fnum)
  1186			return -EOPNOTSUPP;
  1187		if (priv->rss.enable) {
  1188			struct stmmac_rss rss = { .enable = false, };
  1189	
  1190			stmmac_rss_configure(priv, priv->hw, &rss,
  1191					     priv->plat->rx_queues_to_use);
  1192		}
  1193	
  1194		dissector = kzalloc(sizeof(*dissector), GFP_KERNEL);
  1195		if (!dissector) {
  1196			ret = -ENOMEM;
  1197			goto cleanup_rss;
  1198		}
  1199	
  1200		dissector->used_keys |= (1 << FLOW_DISSECTOR_KEY_IPV4_ADDRS);
  1201		dissector->offset[FLOW_DISSECTOR_KEY_IPV4_ADDRS] = 0;
  1202	
  1203		cls = kzalloc(sizeof(*cls), GFP_KERNEL);
  1204		if (!cls) {
  1205			ret = -ENOMEM;
  1206			goto cleanup_dissector;
  1207		}
  1208	
  1209		cls->common.chain_index = 0;
  1210		cls->command = FLOW_CLS_REPLACE;
  1211		cls->cookie = dummy_cookie;
  1212	
  1213		rule = kzalloc(struct_size(rule, action.entries, 1), GFP_KERNEL);
  1214		if (!rule) {
  1215			ret = -ENOMEM;
  1216			goto cleanup_cls;
  1217		}
  1218	
  1219		rule->match.dissector = dissector;
  1220		rule->match.key = (void *)&key;
  1221		rule->match.mask = (void *)&mask;
  1222	
  1223		key.src = htonl(src);
  1224		key.dst = htonl(dst);
> 1225		mask.src = src_mask;
> 1226		mask.dst = dst_mask;
  1227	
  1228		cls->rule = rule;
  1229	
  1230		rule->action.entries[0].id = FLOW_ACTION_DROP;
  1231		rule->action.num_entries = 1;
  1232	
  1233		attr.dst = priv->dev->dev_addr;
  1234		attr.ip_dst = dst;
  1235		attr.ip_src = src;
  1236	
  1237		/* Shall receive packet */
  1238		ret = __stmmac_test_loopback(priv, &attr);
  1239		if (ret)
  1240			goto cleanup_rule;
  1241	
  1242		ret = stmmac_tc_setup_cls(priv, priv, cls);
  1243		if (ret)
  1244			goto cleanup_rule;
  1245	
  1246		/* Shall NOT receive packet */
  1247		ret = __stmmac_test_loopback(priv, &attr);
  1248		ret = ret ? 0 : -EINVAL;
  1249	
  1250		cls->command = FLOW_CLS_DESTROY;
  1251		stmmac_tc_setup_cls(priv, priv, cls);
  1252	cleanup_rule:
  1253		kfree(rule);
  1254	cleanup_cls:
  1255		kfree(cls);
  1256	cleanup_dissector:
  1257		kfree(dissector);
  1258	cleanup_rss:
  1259		if (priv->rss.enable) {
  1260			stmmac_rss_configure(priv, priv->hw, &priv->rss,
  1261					     priv->plat->rx_queues_to_use);
  1262		}
  1263	
  1264		return ret;
  1265	}
  1266	#else
  1267	static int __stmmac_test_l3filt(struct stmmac_priv *priv, u32 dst, u32 src,
  1268					u32 dst_mask, u32 src_mask)
  1269	{
  1270		return -EOPNOTSUPP;
  1271	}
  1272	#endif
  1273	
  1274	static int stmmac_test_l3filt_da(struct stmmac_priv *priv)
  1275	{
  1276		u32 addr = 0x10203040;
  1277	
  1278		return __stmmac_test_l3filt(priv, addr, 0, ~0, 0);
  1279	}
  1280	
  1281	static int stmmac_test_l3filt_sa(struct stmmac_priv *priv)
  1282	{
  1283		u32 addr = 0x10203040;
  1284	
  1285		return __stmmac_test_l3filt(priv, 0, addr, 0, ~0);
  1286	}
  1287	
  1288	#ifdef CONFIG_NET_CLS_ACT
  1289	static int __stmmac_test_l4filt(struct stmmac_priv *priv, u32 dst, u32 src,
  1290					u32 dst_mask, u32 src_mask, bool udp)
  1291	{
  1292		struct {
  1293			struct flow_dissector_key_basic bkey;
  1294			struct flow_dissector_key_ports key;
  1295		} __aligned(BITS_PER_LONG / 8) keys;
  1296		struct {
  1297			struct flow_dissector_key_basic bmask;
  1298			struct flow_dissector_key_ports mask;
  1299		} __aligned(BITS_PER_LONG / 8) masks;
  1300		unsigned long dummy_cookie = 0xdeadbeef;
  1301		struct stmmac_packet_attrs attr = { };
  1302		struct flow_dissector *dissector;
  1303		struct flow_cls_offload *cls;
  1304		struct flow_rule *rule;
  1305		int ret;
  1306	
  1307		if (!tc_can_offload(priv->dev))
  1308			return -EOPNOTSUPP;
  1309		if (!priv->dma_cap.l3l4fnum)
  1310			return -EOPNOTSUPP;
  1311		if (priv->rss.enable) {
  1312			struct stmmac_rss rss = { .enable = false, };
  1313	
  1314			stmmac_rss_configure(priv, priv->hw, &rss,
  1315					     priv->plat->rx_queues_to_use);
  1316		}
  1317	
  1318		dissector = kzalloc(sizeof(*dissector), GFP_KERNEL);
  1319		if (!dissector) {
  1320			ret = -ENOMEM;
  1321			goto cleanup_rss;
  1322		}
  1323	
  1324		dissector->used_keys |= (1 << FLOW_DISSECTOR_KEY_BASIC);
  1325		dissector->used_keys |= (1 << FLOW_DISSECTOR_KEY_PORTS);
  1326		dissector->offset[FLOW_DISSECTOR_KEY_BASIC] = 0;
  1327		dissector->offset[FLOW_DISSECTOR_KEY_PORTS] = offsetof(typeof(keys), key);
  1328	
  1329		cls = kzalloc(sizeof(*cls), GFP_KERNEL);
  1330		if (!cls) {
  1331			ret = -ENOMEM;
  1332			goto cleanup_dissector;
  1333		}
  1334	
  1335		cls->common.chain_index = 0;
  1336		cls->command = FLOW_CLS_REPLACE;
  1337		cls->cookie = dummy_cookie;
  1338	
  1339		rule = kzalloc(struct_size(rule, action.entries, 1), GFP_KERNEL);
  1340		if (!rule) {
  1341			ret = -ENOMEM;
  1342			goto cleanup_cls;
  1343		}
  1344	
  1345		rule->match.dissector = dissector;
  1346		rule->match.key = (void *)&keys;
  1347		rule->match.mask = (void *)&masks;
  1348	
  1349		keys.bkey.ip_proto = udp ? IPPROTO_UDP : IPPROTO_TCP;
  1350		keys.key.src = htons(src);
  1351		keys.key.dst = htons(dst);
> 1352		masks.mask.src = src_mask;
> 1353		masks.mask.dst = dst_mask;
  1354	
  1355		cls->rule = rule;
  1356	
  1357		rule->action.entries[0].id = FLOW_ACTION_DROP;
  1358		rule->action.num_entries = 1;
  1359	
  1360		attr.dst = priv->dev->dev_addr;
  1361		attr.tcp = !udp;
  1362		attr.sport = src;
  1363		attr.dport = dst;
  1364		attr.ip_dst = 0;
  1365	
  1366		/* Shall receive packet */
  1367		ret = __stmmac_test_loopback(priv, &attr);
  1368		if (ret)
  1369			goto cleanup_rule;
  1370	
  1371		ret = stmmac_tc_setup_cls(priv, priv, cls);
  1372		if (ret)
  1373			goto cleanup_rule;
  1374	
  1375		/* Shall NOT receive packet */
  1376		ret = __stmmac_test_loopback(priv, &attr);
  1377		ret = ret ? 0 : -EINVAL;
  1378	
  1379		cls->command = FLOW_CLS_DESTROY;
  1380		stmmac_tc_setup_cls(priv, priv, cls);
  1381	cleanup_rule:
  1382		kfree(rule);
  1383	cleanup_cls:
  1384		kfree(cls);
  1385	cleanup_dissector:
  1386		kfree(dissector);
  1387	cleanup_rss:
  1388		if (priv->rss.enable) {
  1389			stmmac_rss_configure(priv, priv->hw, &priv->rss,
  1390					     priv->plat->rx_queues_to_use);
  1391		}
  1392	
  1393		return ret;
  1394	}
  1395	#else
  1396	static int __stmmac_test_l4filt(struct stmmac_priv *priv, u32 dst, u32 src,
  1397					u32 dst_mask, u32 src_mask, bool udp)
  1398	{
  1399		return -EOPNOTSUPP;
  1400	}
  1401	#endif
  1402	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--jI8keyz6grp/JLjh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--jI8keyz6grp/JLjh--
