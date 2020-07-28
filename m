Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CF0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD06C2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgG1FVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:21:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:64440 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgG1FVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 01:21:21 -0400
IronPort-SDR: y/58n59NRcHbU3ZmnkRGzPcUGiHilmOtItpswC2KWVYowonNTRfTw8oLCuoYbLdpaWf4PS2wsB
 +kw4LDuexvmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="150321950"
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="gz'50?scan'50,208,50";a="150321950"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 21:47:18 -0700
IronPort-SDR: k276931IclaTlY429JfON/yQTSQq8DPyhs3a6VF3P9ZhpqEoc/hMNXxTZJqyuNkWSfhJ/mArI/
 cWGuuZuW+mwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="gz'50?scan'50,208,50";a="290040690"
Received: from lkp-server01.sh.intel.com (HELO 99889102fa3d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2020 21:47:14 -0700
Received: from kbuild by 99889102fa3d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0HWE-0000Ao-1j; Tue, 28 Jul 2020 04:47:14 +0000
Date:   Tue, 28 Jul 2020 12:47:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:1388:5:
 warning: 'strncpy' output may be truncated copying 32 bytes from a string of
 length 32
Message-ID: <202007281247.3Pfw7f7K%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92ed301919932f777713b9172e525674157e983d
commit: df41017eafd267c08acbfff99d34e4f96bbfbc92 ia64: remove support for machvecs
date:   12 months ago
config: ia64-randconfig-r003-20200728 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout df41017eafd267c08acbfff99d34e4f96bbfbc92
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c: In function 'ieee80211_softmac_init':
   drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:2598:8: warning: cast between incompatible function types from 'void (*)(struct ieee80211_device *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
    2598 |        (void(*)(unsigned long)) ieee80211_sta_ps,
         |        ^
   drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c: In function 'ieee80211_softmac_new_net':
>> drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:1388:5: warning: 'strncpy' output may be truncated copying 32 bytes from a string of length 32 [-Wstringop-truncation]
    1388 |     strncpy(tmp_ssid, ieee->current_network.ssid, IW_ESSID_MAX_SIZE);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:1393:4: warning: 'strncpy' output may be truncated copying 32 bytes from a string of length 32 [-Wstringop-truncation]
    1393 |    strncpy(ieee->current_network.ssid, tmp_ssid, IW_ESSID_MAX_SIZE);
         |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'ieee80211_softmac_new_net',
       inlined from 'ieee80211_softmac_check_all_nets' at drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:1455:4:
>> drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:1388:5: warning: 'strncpy' output may be truncated copying 32 bytes from a string of length 32 [-Wstringop-truncation]
    1388 |     strncpy(tmp_ssid, ieee->current_network.ssid, IW_ESSID_MAX_SIZE);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:1393:4: warning: 'strncpy' output may be truncated copying 32 bytes from a string of length 32 [-Wstringop-truncation]
    1393 |    strncpy(ieee->current_network.ssid, tmp_ssid, IW_ESSID_MAX_SIZE);
         |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/strncpy +1388 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c

8fc8598e61f6f3 Jerry Chuang         2009-11-03  1341  
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1342  inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee80211_network *net)
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1343  {
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1344  	u8 tmp_ssid[IW_ESSID_MAX_SIZE + 1];
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1345  	int tmp_ssid_len = 0;
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1346  
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1347  	short apset, ssidset, ssidbroad, apmatch, ssidmatch;
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1348  
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1349  	/* we are interested in new new only if we are not associated
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1350  	 * and we are not associating / authenticating
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1351  	 */
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1352  	if (ieee->state != IEEE80211_NOLINK)
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1353  		return;
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1354  
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1355  	if ((ieee->iw_mode == IW_MODE_INFRA) && !(net->capability & WLAN_CAPABILITY_BSS))
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1356  		return;
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1357  
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1358  	if ((ieee->iw_mode == IW_MODE_ADHOC) && !(net->capability & WLAN_CAPABILITY_IBSS))
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1359  		return;
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1360  
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1361  	if (ieee->iw_mode == IW_MODE_INFRA || ieee->iw_mode == IW_MODE_ADHOC) {
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1362  		/* if the user specified the AP MAC, we need also the essid
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1363  		 * This could be obtained by beacons or, if the network does not
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1364  		 * broadcast it, it can be put manually.
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1365  		 */
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1366  		apset = ieee->wap_set;//(memcmp(ieee->current_network.bssid, zero,ETH_ALEN)!=0 );
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1367  		ssidset = ieee->ssid_set;//ieee->current_network.ssid[0] != '\0';
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1368  		ssidbroad =  !(net->ssid_len == 0 || net->ssid[0] == '\0');
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1369  		apmatch = (memcmp(ieee->current_network.bssid, net->bssid, ETH_ALEN) == 0);
de6610e27dd2e4 John Whitmore        2018-07-07  1370  		ssidmatch = (ieee->current_network.ssid_len == net->ssid_len) &&
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1371  			(!strncmp(ieee->current_network.ssid, net->ssid, net->ssid_len));
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1372  
591968b2f40491 John Whitmore        2018-07-10  1373  		/* if the user set the AP check if match.
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1374  		 * if the network does not broadcast essid we check the user supplyed ANY essid
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1375  		 * if the network does broadcast and the user does not set essid it is OK
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1376  		 * if the network does broadcast and the user did set essid chech if essid match
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1377  		 */
591968b2f40491 John Whitmore        2018-07-10  1378  		if ((apset && apmatch &&
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1379  		     ((ssidset && ssidbroad && ssidmatch) || (ssidbroad && !ssidset) || (!ssidbroad && ssidset))) ||
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1380  		    /* if the ap is not set, check that the user set the bssid
935d59ff255896 Masanari Iida        2012-08-10  1381  		     * and the network does broadcast and that those two bssid matches
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1382  		     */
deb379066d376d John Whitmore        2018-07-10  1383  		    (!apset && ssidset && ssidbroad && ssidmatch)) {
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1384  			/* if the essid is hidden replace it with the
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1385  			 * essid provided by the user.
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1386  			 */
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1387  			if (!ssidbroad) {
8fc8598e61f6f3 Jerry Chuang         2009-11-03 @1388  				strncpy(tmp_ssid, ieee->current_network.ssid, IW_ESSID_MAX_SIZE);
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1389  				tmp_ssid_len = ieee->current_network.ssid_len;
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1390  			}
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1391  			memcpy(&ieee->current_network, net, sizeof(struct ieee80211_network));
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1392  
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1393  			strncpy(ieee->current_network.ssid, tmp_ssid, IW_ESSID_MAX_SIZE);
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1394  			ieee->current_network.ssid_len = tmp_ssid_len;
4031e6ca35993f John Whitmore        2018-07-04  1395  			printk(KERN_INFO"Linking with %s,channel:%d, qos:%d, myHT:%d, networkHT:%d\n",
4031e6ca35993f John Whitmore        2018-07-04  1396  			       ieee->current_network.ssid,
4031e6ca35993f John Whitmore        2018-07-04  1397  			       ieee->current_network.channel,
4031e6ca35993f John Whitmore        2018-07-04  1398  			       ieee->current_network.qos_data.supported,
4031e6ca35993f John Whitmore        2018-07-04  1399  			       ieee->pHTInfo->bEnableHT,
4031e6ca35993f John Whitmore        2018-07-04  1400  			       ieee->current_network.bssht.bdSupportHT);
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1401  
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1402  			//ieee->pHTInfo->IOTAction = 0;
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1403  			HTResetIOTSetting(ieee->pHTInfo);
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1404  			if (ieee->iw_mode == IW_MODE_INFRA) {
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1405  				/* Join the network for the first time */
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1406  				ieee->AsocRetryCount = 0;
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1407  				//for HT by amy 080514
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1408  				if ((ieee->current_network.qos_data.supported == 1) &&
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1409  				    // (ieee->pHTInfo->bEnableHT && ieee->current_network.bssht.bdSupportHT))
eb2cbcc37763b6 John Whitmore        2018-07-10  1410  				    ieee->current_network.bssht.bdSupportHT) {
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1411  /*WB, 2008.09.09:bCurrentHTSupport and bEnableHT two flags are going to put together to check whether we are in HT now, so needn't to check bEnableHT flags here. That's is to say we will set to HT support whenever joined AP has the ability to support HT. And whether we are in HT or not, please check bCurrentHTSupport&&bEnableHT now please.*/
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1412  					//	ieee->pHTInfo->bCurrentHTSupport = true;
e4c8f0638ae9ea John Whitmore        2018-07-10  1413  					HTResetSelfAndSavePeerSetting(ieee, &ieee->current_network);
eb2cbcc37763b6 John Whitmore        2018-07-10  1414  				} else {
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1415  					ieee->pHTInfo->bCurrentHTSupport = false;
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1416  				}
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1417  
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1418  				ieee->state = IEEE80211_ASSOCIATING;
1761a85c3bed33 Bhaktipriya Shridhar 2016-02-20  1419  				schedule_work(&ieee->associate_procedure_wq);
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1420  			} else {
58af58007e7bf6 Jesper Juhl          2011-08-13  1421  				if (ieee80211_is_54g(&ieee->current_network) &&
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1422  				    (ieee->modulation & IEEE80211_OFDM_MODULATION)) {
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1423  					ieee->rate = 108;
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1424  					ieee->SetWirelessMode(ieee->dev, IEEE_G);
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1425  					printk(KERN_INFO"Using G rates\n");
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1426  				} else {
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1427  					ieee->rate = 22;
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1428  					ieee->SetWirelessMode(ieee->dev, IEEE_B);
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1429  					printk(KERN_INFO"Using B rates\n");
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1430  				}
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1431  				memset(ieee->dot11HTOperationalRateSet, 0, 16);
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1432  				//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1433  				ieee->state = IEEE80211_LINKED;
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1434  			}
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1435  		}
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1436  	}
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1437  }
8fc8598e61f6f3 Jerry Chuang         2009-11-03  1438  

:::::: The code at line 1388 was first introduced by commit
:::::: 8fc8598e61f6f384f3eaf1d9b09500c12af47b37 Staging: Added Realtek rtl8192u driver to staging

:::::: TO: Jerry Chuang <jerry-chuang@realtek.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICB6jH18AAy5jb25maWcAlDxbc9u20u/9FZz0pX1I60viJOcbP4AgKKIiCRoAZdkvHNVm
Uk1tK0eSm/bff7vgDSBBpWcmMzF3F7fFYm9Y6McffgzI63H3vDluHzZPT/8EX+qXer851o/B
5+1T/X9BJIJc6IBFXP8CxOn25fXvX7ebq3fB+18ufzl7u3+4DJb1/qV+Cuju5fP2yyu03u5e
fvjxB/j3IwCfv0JH+/8E2OjtE7Z/++XhIfhpQenPwSfsBAipyGO+qCituKoAc/1PB4KPasWk
4iK//nR2eXbW06YkX/SoM6uLhKiKqKxaCC2GjlrELZF5lZG7kFVlznOuOUn5PYsGQi5vqlsh
lwAxS1gYljwFh/r4+nWYK7atWL6qiFxUKc+4vr686AcTWcFTVmmmNPQDfGjgCSMRkwYcbA/B
y+6I3XatUkFJ2q3ozZsOHJY8jSpFUm0BIxaTMtVVIpTOScau3/z0snupf+4J1J1a8cLiZAvA
/6lO7VkVQvF1ld2UrGT2tHoCKoVSVcYyIe8qojWhiWf6pWIpD4cBSQlSM3wmZMWAWTRpEDgN
kqYj8gFqeA97ERxefz/8czjWzwPvFyxnklOzVSlbEHpnCYyFK6QImR+lEnE7xRQsj3huZMDf
jCa8cEUlEhnhuQtTPPMRVQlnEjlw52JjojQTfEADr/IoBUGYTiJTvJ1dvzv2/CIWlotYubtY
vzwGu88jZvZsxx2hIHpLJUpJWRURTabjap6xajVszyA8krGs0FUucr/wdAQrkZa5JvLOIzot
zTBs14gKaDMB4/loJYQW5a96c/gzOG6f62ADKz0cN8dDsHl42L2+HLcvXwax0ZwuK2hQEWr6
hZ22V7LiUo/QVU40XzHPjEMVoXhRBgcD6K05jjHV6tIeRRO1VJpo5WeW4t69+xfL7HUPrIAr
kRKbTZKWgZoepI7NgLbnCJ8VWxdM+rSUaoi75UAPYxCusHJA2CEsOk1RM2YidzE5Y6Df2IKG
KW/1Zbtsd9r9mVk2f1inaNkvSFAb3Chcdf086FhUqDGcfx7r64szG46cy8jawp9fDJziuV6C
Fo7ZqI/zS0fDlTksNATdr2gCyzInq9sF9fBH/fgK5jD4XG+Or/v6YMDtYj3Yfk8XUpSFpQ4K
smDN4WBygIKGpovRZ7WE/ywzaHpqJjdAY8Jl5WIG5R+rKgR9dMsj7VP7cGjmWjbwgkd+YW/x
MsrIKXwMInbP5CmSpFwwnYae2cGeKqZtzoGE4JRazIQzEVtxyiZgoG6P+Xhso3J950Sgtmlp
Gp3aN0WLrQoCOsI35YTRZSFA3ioJjoKQ1mwaoSKlFqZju0/QzbBTEYMzTYlmkW+rWEos2xOm
S1yucWWk7QHhN8mgt8YkWG6HjKrFvW0CARAC4MKBpPcZcQDr+xFejL7fOY6aABWfgVdWxUKC
TZbwX0ZysysD90dkCv7w7ULn7TjfjdUrc/D9FjmYLuMWWowp4uGjUYTWqQK3i4PoWOdOgfRl
oPUqj31stqVFeGW4nZKHpDudjTtgybBx2NAkS0eyUUVZqygtXRASBXwqbYcrLjVbjz7hZFgr
L4RNr4BXJI0tQTEzsAFsxXJtA1TiaB/CrY3noirlyAaTaMVhoi0vfKcD+guJlNzm/xJp7zI1
hVSj3YCdPcFo3FXjVjtrykIWRa5mK+j52Tu7A6PH20CoqPefd/vnzctDHbC/6hcw0wQ0PEVD
Xe8dlf8vW1g+StbwuNP9M4oVwg+iq1AufSciJaEjoGkZ+uUyFXMIEsI+SDBBbRgyT4bKG616
JUGGReYnTMo4BotpjBrsDIRBoPX8h1mzzGhTjPx4zGnn5Vjupoh5CmLl9aPcYK4/OYvGZKfA
21RdXzbbWex3D/XhsNsHx3++Nk6XZbY7ISZXlu66ehfaIc89+MQVWLdLSz3elOCFtn5OJ9KZ
5SqB90CXoH7BE1dlUQhb9bRmrmEUKrxqRSTHqU8ddhBxHkowBLBHjtY3XgpYPrTMEIsah1cy
S19Hma0DYuujsT4CYl3YVzBhlbFS9kk0QZzRrvaecE1yXma+00yXPE/ZnUMNLLWW+G7ps+sj
oo/L8EQX51dLvySP6K78YyX31fnZmRPH31cX78+8XQLq8mwWBf2ceUe4Ph9SG2ZW6TlsIfC7
9TI/jCatFrwqV3OMScAbCwloWEe0DIregUuaWwIDxhNkDf1eFFchwV++Pv/Qb3lmGfvciIu6
fnf26aqfutBFWhpHyxIDNK8sN4eqTRu0dN+jkfDXauLwqMzxvEBuUQZDBc6joffwwXSvWMog
Amu7zwQchdEEIq7gU/MF0LSzGVHEEEnNIsGJk4rNop3eW105DjlLkuIEYQeKuWUYnxVCHIkZ
pbWeSHpGCTCCAiO80XUr5aAUYzFEQm3LikkJHt9vwCfAuf0yNxodSRjJ0iqPb+3ZLNma0Yld
jLf752+bfR1E++1fnQXspI/LDJwvIwJ+DoAGAnsbOb4uqCjuc3AB3jhcjjYDISKY9KMJB32c
i9z0GYOlCYkJzoZUihALEMduUpOVQLvgJ/b3sX45bH9/qoeVcTTUnzcP9c8Qr379utsfBxOB
g4GeVvZACAuF0KkwCUEUEil8LgkSUlKoEs2TIXZ085BhbA3c/zJDsyRdf9lvgs8d2aPZIttH
mSHo0NPN7TCn7GdjYHffINgFt2fzpX4Gr8eQEFrwYPcVk8iOoBQ+89GcwcZMYrbF9l5HX0iZ
8UWi20QkYKsioi5952EU4hZ2BdM0TFlmeHBTkdYEfgvmc1SavgoqK91qBbcpo75MnU1BxjML
iQZLezec3wZaag3+jwuMST5qHDVJCBvUpqggcqJmnZM59gReWzZwYB5dUI5OpN87NBQo9wQO
5SwPMaPwPG5UQlAM+pLpRETzfUsWlRRsR0JkZDSMyNM7L3mRcQwmJVuALzk3k+bvWJnpdBL+
XQEeBslU4VGNnT+62T/8sT3WD3g63j7WX2EA7G84B51nL4lKKurkBIw8i8bvtcBLk/22YyLJ
9Bhm2k4oG+gcuTlKxkNNhLDEqvM8wWWoeIS3Hwn4ldHoDGoTJ2tZgl0GTWzc3RMkfTgwpjF9
N81nicx0czQAmLajWbGmieWBtFdCpg9YqQYTCMchd7wj04UnM/x9CuTHiAockM5tYBSjFysG
EBGoeIUhaMXS2KRqRq3ZGnyeMU9NxGECcSeBy2IzDRPxe2Ue05J2KKmmogn+xNvfN4f6Mfiz
CVO/7neft09NSn0wmUAGdl/mLPVHXCe66eMvcAzxekQoTSlmmybx2nfOh5WLzDCNYcusyXyo
DBMBZyNu2yxrQK03jJbWF600NGWO+PHetU17pN1ze6nnj9bb5krSlqyayxR1lNyvdFs0Rv8S
NLeXRkuewRxBzKJqiRkSL1WI4uG7pyHu7RBR+fnwhReqKbpYqoDdREYMqW/2d/3wetygS4I3
y4HJdxwtzRaCd5pplH3LwUljV9W1RIpKXjgGuUVk4G/PZETQHGSFV0Tn5mYmntXPu/0/QTYo
+YlSPhlldOFDRnLw9B0n1g4OGrQ/PdLHGFMidxB3VNBkEetCCyui6rtbNT73JHRpdBXLjBS0
vdg9tAu1L5n6vlPQRoU2DZtQsVe2mJOiLjn4Y3LUQ8ORRqNbqc3kDty7KAJ/apxjgZjUpFSu
zzuI0cVagG/kHPCl8nmQ3T26YUQGYoujOAEuTRnJTShuzTJz0vnwOXsN0OPsoASBmHRR132g
fV8Ikdq+zn1Y+nTQ/WUs0mjw+O6NanOY1WazYEXFKL3aERvX1p8RibpEHFr45SiP1kmXSf6s
jL20xmUSLaC53LS8grKoQpbTJCNyaUcq8wer31r7egY+IExdoGLrdEpeH7/t9n+CJZmeSZC1
JdMDm5pvOHNkMQBBYa0d9bUG1ZLZDDMwbORXpqlffa5jmZlksheLK1kyb6DerHjYjKK5baBE
zexWgRlzvBqJKinA8vkcaSAqcrtqwXxXUUKL0WAIxqi0mBsMCSSRfrzZoYKfQsL2wWHIyrVn
mg1Fpcs8Z6MblBzUglhy5ud203Cl+Sw2FuUp3DCsfwDclook8zimZjjWTA1V38xuD8u1gUZK
XZCmRQd2uy+jYl5ADYUkt9+hQCzsC7jcwh8h4ejw56KXNs9yehpahrZn22nYDn/95uH19+3D
G7f3LHo/cmt6qVtduWK6umplHcsX4hlRBaLmelDB8aki4g8UcfVXp7b26uTeXnk2151Dxour
eSxP/RffBjkSaBuluJ6wBGDVlfRtjEHn6G0YW67vCjZp3YjhiXWgGiowpkPTMnNMDKHZmnm8
YourKr393niGDEwG9SsKrM8DGtrblBEK/AUTE4Etygq/DQNSiJedy4se1Iu542JKHoFZ7Ikm
ARPd7Wu0SeBDHuv9pB5yMshgzez5t0j4C1zppakgmtNdI9L5+r0pbSr86mBKKZT/iOUxnubc
eAlzBFgoA/1EbDVHcUKchqmsfVRdYdQppju2S7FZG7qaRr+8+M+JvbSXgHUejQV6N7vKQor1
3UmSCNykU3hk5azhbdCnmkuGCf55EmACUEFQdep4IwnM4cRunOJay9a/rv53xvpVqMPYWZKW
sbP4gTOzJC1z5xT51TzreracWrVZdsToS308xZrenFI02TAkxE5hmZq0l5WT/F5HlkIrporM
3u2I0llHUNEZJ1HO1HqB9fDpcghbncSzziDemnEhEZmSmSpTRIby4uqjX77TC+1zwZQuhmhg
AbI9fDXqfvxdQbQOq8+FGIdWLX4FM6wavvrtTpOTRKdLkZHqR5Cnheny49nF+c0wmwFWLVbS
8eMtVLaSvlU3IjR01opU41QN5jBNqfNx4e4USX0ZovXFe6sRKax68CIRo/jmKhW3BfGl3Dlj
DNfw3iquGGBVnrZ/mOIsMPS5dnMrFm2jRvwJM0IboplwpKtoNCf05rV+rSHW/LWt03RKi1vq
ioY3dgzfgRPtrz/o8fFM3qojAPGenyNWfgnfsMZruznRULouTgdWsa8MYsBagtgBNbtJfV3p
cMZ96Bk2H9QhHpyAk3hNcPEnZruQLJpON1Kt6ziCw/8s85BLOaXNbgzfJ3C1DFvEdLWJWPqK
FTr8TXzjbYYpxRPN4puGZDpxSpZsCvWPkiTxKRnjbLrUtqJj0pWnLKwx7k+bw2H7efswdYpB
7yt3AABg8h5iyZFoI0JTnkdsPSsbSGMU2tzZRoL41uUNwsrLC3u8FmSqUP2Z5ZYA5enEUFKt
Ct86ED7jeHSTBCV5ouOmwni6Dqxh9YyHvXmzRB1BRjRN8LLE6ZEZsLs/Day9wRvePlko6hQP
DfA8vNPMN4Dh/kieWkzGtD9YtmiwOGZmad2MSM4jH18InWtpDgyPnfMcUZ+CjHKFFdsC33BZ
jgPoboJ55ZU97gDt/vQVc9lU9n2gBY+I9sJz6gVnmEt0/Barq9mShDHRTAem9Ma7SaJg+Urd
ck39uZZVY6V9Y3eB6Dj7lRUz6TrjHiv/OImaz8k205sNVoEivYTjoTAkHVG1NDdSW3YCvyqV
WdbHQHSZj0U8p95CK2m/+JCxeU5k5wrXhZM8aN8aYIczNtGioClRikfu8ZT49kXdVW7dd3iT
umSoQ9onj24mPjjWh+PofthMZ6kXLHfZ2oYrk5YjhJ3ct7aRZJJE/jXaxS9Y9yWJpeURENLM
0fAAWtxOTRX4pVH91/bBLluzmqwmA63WDcjpWaXU6+AiDoTI7YGSlFYh15i3tEsMEEf0p3N3
Hb+R/L7i8NelC1dl/o5bNx+N2nNp6AwILDrR+NxizKEWS/1JdkNBP3zw1bYijpsqttwuqzcl
edPdKhhZ4jAsjkar+o1g8axL3QIr7sZSNqpb0MzMWKZguIxy4g7XwLl3ci21M1w375lhliui
MGE96TFdT4FKxOO3iRa4otNsFcpYqcAmdUV+I2H9iM98gGA8a1ylaefnjYoQe+FyZqHanqbL
m8AzGpIp1PBqAi0biRwye9M1uZM3lqh9rzWTHJyeYctuzdSlxaAGZeEPxwC5pD5RinlYybak
pAXdcsnSJr87glRNDW8Hha9RRZcBuU8ZDUgVdxMibuuQeIHxrFWS0QTK56ZMFAsTprTIQJYK
fAqAj6BAwFyj0pFRJnX/4KISeel9utZRS3ZTwmrNmyG8m2SLKPSMjdVOTe1QQ4L3ov7hu1uk
4uSw04v2fvoyIr5Kzp7g1u87pjwcsbSDQJd3hYZ2xSyOOg7wCKmX3Ifs/KvOy2lSFOeO59PC
KkmxZEFp6Y0ObbKu9vzNm/Yl6u65Dr5t9/VTfTi0Nb2HYF//9xVgwSbA34AIHnYvx/3uKdg8
fdntt8c/rIfDfd8ZU8l0tlXKIuUBT/bH7kd1VQeO7XPbAl1eepC5aEqPPChwxkOh2BxjqyzN
2NSr7dEQ3szWdvREiT7Rg6Dh93vgoVKzUyzUie7BDz5RiGuREZ38K8LkNvO8avUQwtbj5Tz9
/uoMKVVkfhOQ4OQydZSqfzOrRkx8z+N8O5tgOS2+fcH3P0N94C0HmK24kaTp2bwRu/5oZbzj
Jfe+JkTP99MoAP5UmPKkaXbo0/xDYkq4VROHX1M2GeiJqzaDH1n6AcmKBBWQbw2xZYPgA6Kw
Bcdcqx1CAzifcQwRl7i4NmDY7IN4Wz/hK8fn59eXNiUU/AQtfg4ejdE+uBdCFH9XY3YUVOzn
Mw+vDD5/f3k5y4KBgl9Qry/xL2fce92KwMFk423msf/6wncj3qIipatR+RmEcbBp6ThhBpuP
kfIAjAlPRZOMaC6ZZuIZcyfhuKFNLasDGn+0P2qiXODkZ13Ql8e9GVXjdc/GsA2SeBaOYGJf
SLSA7rWSA68YldQewBAr76sRQx/Zv41jIIXORpDw1l1cpkYsQCdnqUbDzh5kwx9dhm4fTbWc
0wEXvuyCYZUczaAgThSPoJSEdpbA4vTcBpgnC56rKouEnmiukmL6sgFjodaBwJ+0eOxlrjnU
m8caXzsDVW2RHYJD/3pq8OK/R+vs2Rof/67HHF3j4wTvyTONCN7X+dOL2BoL0yudlDm+1SqY
XwlNCBkl2YQtUX3Yfnm5xQdTyCFTvqCmaz5J1j8/8bO4Zz97efy6g/DJeUYFs2R5ZB7uevWc
07Dv6vBte3z4w7+htnTftlk0zajzUOZkF0MPlMjIzly4cXnzbYrzK8rdOAEahuU0MC7o24fN
/jH4fb99/GJHxXd4ZTh0bT4r4SSfG5jkVPhziQ3eW6XVooRKeGilbYvo6sPFJ+eZ5ceLs08X
3sOOS8LHKFhPa9fTSVLwyL53agGVVvzDxfkUbiq/sBpKlPr68myMbp/gynWl18aKOoztO8kI
UC74zCnqyWZU3zBYmU0vdTosFgn7kmUdPsPpVRTzZq1Fk5uv20cuAtUI10QoLd68/7Ae9rsf
EXzO9dq3YGxx9fHEZLApaJUL30Lk2uAuvSdsZs7De7DtQ2uiAzF9B1k2j3YSlhbeexxgjs4K
5wVsC6ky98e0QLDyiLSPwQcFIZsB+oe55ufnJgerf/b5tAP1vB84Ht9O3qn2IFNYHuFvJw1I
CLsl6UezfmpmaIWV1O2C7Zl6Cfpnvb4kTd+geyJzbdWjj1fUO/8kN65V/4bEngNW0986WO/x
+H/OnmTHcRzZX8nTw8xhMJK8yYc+0BRts1KUlKJky3kRqrsS0wXU0qgFr+fvH4OULJIKWoV3
qEI6IriISzAYGwdVVc0vgTkbNFm1G5Nk4KC7GcqGw901ETG3MUNqkt/dV7ws6RARMa5VdnKi
OsxvkH9nMCVGWQrlAXiNZyAhHL40VGjn0gM2Is9qovUqOLoTCsgjK6jRAjB08wQ2iF6Th5/f
sZvDi5rtnh14glZoF7LOk1JJ4xTPQnIqbKUe/OrV+uPEMplqoIB8YRhC8vqIY9pDNyGmu22D
ey+XmL3eD3Su1MWG1G4ekRFgtTGA+oDic0STLk13+y12YA0UcZJaPjtO4IGOOhi0OFrbc4/k
qL59/fH1j6+f7MQqkviFh4huc4G8CIYJTg7cBHB9/P6HtSzG7cAKWdZSXXvlKr9EiSV2kGyT
bNR1vyobFKi3yOQ81Qpxcxd5dVYso3Qc2yBNSq6mJVO3DExgaPhReEpgDdp1nXWicyr3q0Su
o9gJim6EqlsGPIjUfspL2YIultWIqnyU59VGzTF7mt49VImLcOG0TJkAhsSVdWUNBqkyuU+j
hORWyj0u82QfRSvrOzQkiSzuNExHozCbDYI4nOPdzrL+jHDd4j5yjvCzoNvVBpOqMhlvU+fE
ButYdW4x3YesiTOHtugcSuFqbh+9zI7MDu4FCUwJVpYAUl0qUnBr6GgybEkTLskU+xbWbWic
TQ1XU55Ym2wADplQrY8bEIJ023S3Qbo7EOxXtNvO6uNZ06f7c8Xsfg84xuIoWtsivtfj+2cd
dnE0ruyJvWpoUOE1YdWRJluT8fPOLJq3v99/f+Jfvv/49vOzTpb1/U91bn94+vHt/Zfv0PrT
p49f3p4+qI3/8S/4004B2rv5Mv4flWEsxOUJ5joJAlaVjzMK+Tc+PQlOn/7n6dvbJ51jeZpe
jwQOpWzMxGEU9pQfEfClrFzo0AMFH057r+bz1+8/vDomJIWrEtJukP7rX/ccH/IHmAysaL5/
0FKKf1rKpnuHsynHyNRd9HB+NGj3g5MV1xc3AZb6fbf7Qn6bsr6nx5l0vIyerWw4eouSnJae
kfa+dTX48xzsWVXP5EAK0hM8jatzFjnaN65tc8OQSz4QzRkAICHE2F7DWIG7zNtKJ77W/DYq
7xP7TZ3WHiYvTydjgDGTzRh7ilf79dM/lID8dlX//jnvlRLfGVg37ZEYYX15DiiH7xQFw3jp
hC7lzWY1D/tkKUQH07A9mXzm+1XWgexRjou0+a2EmyieA6PNHOh4nQwwShwXwBFain3099/B
TowEvJw3whWXxqtMInW+YnU2YrggODcNDQZJBjd7K2xD0fRUxiefcL8yVmBiDmBgWsFkSey8
kAr+ShoE4luMAKTOTcVaaxSoTcqyLWYdsvHqZNupIwY7EYFUo5NN4lcxwh/lvbHJanrxUzlg
ZFaPLTQRB3X2kWyI7kAxwRMUyM5lzV+d3EATcG5A0j3Cog/0lKlNohYUc+saofoDIGdLbsdr
OxRNpxhwo7hvvEXxpjuR250zujEVQpZKoh0ZFFi2rMP6wzzFmLZ9NQ2+tDVSQramnFwC2e+B
5Own5raRxqQ31/V+VFLFx99/wqk1KHuIlcfE6euo9/3FIvdDrDmD+4QXJ39RYqpaHStaegKs
1p+u6GaHR8lMBOked9NUImrA6bq5VecSTZ9k9YhkpGqYY6cZQCAs1cAaFio4MVeSZE28ikPh
5GOhnNCaq0acpJQy50pCCXicTkUb5uYXJVSxtoB3kBH7Grn0EYK8upUyJTKMU7lU1onYUD/T
OI6hcGBGVdlV8mi2CwFPaeAfJLK+Ox2CQaUPzCp3bH/BLmL2F7206rrMHQc+8tLgqbjscjVF
Vz2BcSy90y3Hh0Ah4iAiFGiWx6HpX1qHrZJE3e/UkL44pCmaF9QqfKhLknkb+rDG9/GBChh6
3MHtUHT4YNDQum74qfR12VZlOD8wmfTgThsquLDS1QdTkjmb/VBgJ5RVBgp4ecKN4JV3LCNq
QQYjyqcaLrx1Bnk05xXwPggeA2KTXJZJDqcAC7Vo6gCN6V9fBcIvc/7Scs8xeob0+ogMwpnl
0vVRGUB9g++XOxpfJnc0vl4n9GLPIGeSyzn50oyqJcgL1z+4A+MsvjCzRRacuQdYobN4eEGr
SKnBNWNqKE/wwHklC2aQfeBxfUy0OXPUXgeWLPadvbov2FioI6nVWXzDcTVj4Nfh7Kwjw9nF
Ueb9UQSOFEBWL70IrdETJ4XqSbAssLVwsxq7uLyP7TveyBYRjY7i8i5OF9i4SRJrlz6hJhmr
yJlLDuKGc+ifebc5Z0nvMyWLQN31jyyMrqJ18OQ/B7LNKTjEGeNcCpDBg0MhVwuf6djGzlW8
dKidW3JlHF1yPE02XYejQJnuMAG8ITYEDDh0USA5ySmQIfx0CHB03oWKBEUmjQlVtw71TCFC
ZXwj2bgVRBzhvIWf8LX0TiysYEHqC3PfUhCX7XrVdcEVKC7BXS4uRSicT1yqKiCvdiTepsHm
5PMJHw35fMMrLCkI902X9GSBYwj16aQoHXYr8k7tPpzLKdxmplqysfL6EH0MRXyO/eG0drfA
s0zTDTgz40l1nuVrmq67QISKV3M5nBGT4ECKnZrqXygpmcC3s7jVjkoGfsdRYMaOjOTFQnMF
aYbGppPYgPD7iExXKaoRs+tkkLbB5dIyCazhS3da2DPqz7osSjc1a3FcEBRc1VWhfdcg86O6
+kKegxl/nteQrvYRcriRLsTZEauuJd4ks8Amv2Z9y1z4qouSPB0hTLuYZgx9U8oqWD5z91vO
fYi9QkLoBWFwSANoPJlch1SiE8SjFd8YuHkc+cKN9CUvT9yRDV9yojgkLsm/5MEL10se2Biq
sY4VfbAcmpjN7mELJg7h3G+Me0RIyKjF4tTWmfPN9TZaL+yzmoGqxJGG03i1D6SbAVRT4puw
TuPtfqkxNdPEmWt5Dp4iNbmEcl+M9UGkco0yOUmEEt4dvaqEI99vDSnJ2AteZZmT+qj+OUxE
HvHZUnBwgKJLuhMljbqhqpLuk2gVL5VyR5HLfcDhXqHi/cIikEJShEtJQfcx3eMnNqs4DTn5
Q337OA5oIwC5XuL/sqSK+zvReTa20UecMwSNUBvnF6bXjfk+k6q6CRbK96uWUMDHmELQdhE4
4Xi70IlbUVbSja/LrrTv8mW1SMPObeMwYgNZKOWW4H1GLrwAN4oQu7FogsJjA97oSoCCJH8y
kERwoMFxOepkavX74p5U6mdfn0Our4CFCErKGyynq1Xtlb8WbgIkA+mvm9CivhOslq5Sc7/3
wReFdA/Ge6DJczWfi4ug4zVuUQBEgkZmHrPMkgczdrSvdPrn6DRoietH/BxQQikapqBzNxz0
XW+yzxtn5IvzlKMGOj6QBkIhIzpXn++VP/DmQJxYRICeKtvJUYNE2ZG68UorjgPhmVx48DE8
fxKFtbux0f0hn6fRWpVueQ+db+ap5UlEZxnkdof3SABr12O84Dh/AvjgJoCYyUDZ75UcMYOG
HtCWCdAIjQcNdZTtabTq/KomLRUVW7g14k0p7K4z2GmMFTDdIUCTW2I2FKOmPNAE5ZRkxK1s
0BG6QGBEQzUWsIJ7RDIMxcRHFbihKcRqoo3qYusUqWu78+s68o6FpoLTKm+lOxHGt7C7kpsL
zyUH81gUx9RtN+8aFzBc7nGguqV5CCbLoj91uT/z5lYa6Pn9YomVMogmNHr3q6X7gYWORSe5
P4BFp+p6R5QsEFpmL1Zlk+hnpNJAkUGMdIcCZMH7N00+i2rre5CGxVFn6V3BUKhWL6dehRfe
MCmZW3pg0ie1h5P6ZJxYRkaQcyv3U1XZDrNVBW9Rg6u7QwFsN/ce/AHwg2SQgBZVhQbpVUOO
cl+9rRAlnrUOMMztp3Zcd3upXdmbxhob6XyrzM+O+AjYu18/eg/SFJD3rXHr1C826L+2o1MB
eMn96/vHD286A8XgWqSrfHv78PYBXojQmDF7Dfnw/i9ItTlzjFJEJjRzcLn5bCMoaZwwGIA9
kysuTQKyYiciW6+WusnT2HaZnYCJXzsoctIO06wAVv0zTk9OGeg+8Pp4Fyo3Uez7eJcStyva
AJdRbd5GMT2zU+7ZiMLN1DOijNZ4pHjQKaAQB45Wkon9NsKNWSOJrPe7gFxmkeCW2zuB4gU7
UGQjXdCXkk1wOoDklG+TCBnQAhh7Gs0RcDwcsMYElbt09airNeQI1yGM+GzI9iC17kS/FvKA
xMWRXMnym639BqoGF8kucdRUAD2w/JnjOlVdqBaKz6DPBwCaVepkStI0dZt6pkm8j1wY9PiV
tHUrscGiXZqs4ihwsRupnkkuODI5L+psuV7t/EojRh3Vm7iL/SZh6Ex21OCX8+oc7ozkrAY3
gvnmveTbh8uTntW9P0K3/AuNY0whcM3tnE33nDZXO+EH0Ew+P8Loekb5MBOpl9DEIUe/0qUQ
ru5bAzC5tdlt6Saa+ejalY3C4kKbM7sz4RCDj1157GKjpWqU1KprEts5rAaAOoEKbt5SmSw1
AyrsawgUCTq7SiBWSEvg0799V0p+nUcMKNh6v8UcIxVmtV9vRnf2j//7CX4+/Rv+0kWyt99/
/uc/kK+t9B9jGVsK9cDKC3P3hPuVBqx6rvxoiUUDwEtDo6DZRXifKy7Y3I8VlJUWDvTLWtrj
dAjifvSpuuDMwdJB+FkS71HfoS/0F1UtuRPiD6EGjhu6hqAPmfo0Feq2NCJtp/cBRh2WqU51
wbB9UG3WII8J2wUVYN5mBBBulQKMO4FVzaWwU0Lbw4JYKNW6Z3VDsN6NKHXx5gUME1bujgw6
2s4pnbxmAqacWSqPAdDLzM3YPML9VBgzAjxbm7jm6XNgWFjGicOAhWKLUdxavVQAL/hMg7wk
TgByv05B/o6S3ty/PSBCOS4Hj7b16bx+/J3M1pEBO+EGBoS/86O/eBUYWIWLN9jVxh7Fmvj3
m7pJOpT5OsXuho57KSWXp5EP2FmhtAbgDb6C6hwH0iu5Tyjzyu4TyWZUmUe1S1ZkDjr4daUp
m9fFPCp1mpM5FW0dKs2f/+sB3FCbEeisnBHonRxjI7OVMXwJBj80tGQdd9PfAn3Xdfi6qZtr
mqIYZ5IDruE2DRosaBM03N6+cbKJXYkFIJprBJqKE/QeoRCprXK95l6mQf17xo6u+jo/xVDB
q4+L3/h6ywjuc2RTaV0iK4pQthWtUK7JjeJVDQRKGNlEmHQ6pWS7Sm7Fk7iXHC3DWt+rnwyE
dTbTm14/CtI9XcdMeYdvX99/+B2e+UUCzU2aMJ6so0jMM00NZ/xihfepscVs1V/NyK3DOMup
+2uIOZpO5gEWdhEDAi3ZYgIAII+11wRomFwIPPjgxNNyJZPKG2ZhUV/UOYHtGmASTDwWVSq6
iqKQDfhIalAWobhMUoplgFc9t+0SOdibSGendYO3K7TOArebJBtQWmGS4/TyxKT0mRaaACcM
zI1ucErsmZvUK2MXyb0XCay0XmOjMnMMjPAbws0wsUr4xBqgRgq3uhhsHpeug6te958B9/Tn
+28frKfhLWHYlD0fqR87aaBab+ic4SMmIOVoNLmIY82bV79CWTGWHUk3rxAks4KVAVctTXLd
bgMmZ4NXw/4O9YMYWqgc45GBSXJPvMa//PXzRzCmkxdVa+kk9U9z/n92YccjvL2qk8p6GMjY
bdLiOGDz1uuzIJWPEaSpeTdgdB/b72/fPgEjwpIID4VKeDd43swIh6x3bed/yR0rac1Y0Xe/
xVGyfkxz+223TV2Sd+XNND2tcg1nl1DSwxHvie7WjIQS4pmSz+x2KCEjle1nN8B6kuEcxyKo
NpuA+OARYR4sE0nzfMC78NLE0QbXTzo0u0WaJN4u0GRDDv56m24eU+bPqr+PSVi1XwW8ou40
YGZdptALny0011CyXce4e5tNlK7jhekyu2bh+0W6SvAwCIdmtUCjzqPdaoPH4U1EATFpIqjq
OMHV3Heagl2bAHe808ADDiAqLjRXCU7TkMfbNHNlnh05eGFBqqmFKmVTXsmV4NZki0rnjqaB
sIOJri0Wl6fqmK5rYcGIpG/Klp69t3wRymu+jlYLG6xrFvsFRtA+EHQxTXjzrGfhAUfUzPYB
XnFaeDUVS6FlCPRTd841ykCMjp4yStAHYi0aXsG1+DNawalBBVKL4kyKKzhmfEZwzwf1A8VM
1jO/VZNySYmj6taISYvDV8Nkm/PJMuROQMi4VUGWdNex1KZI00qk2wi7qdlkJNulu731ETOc
m2/ExYcQOk2Q6JoFdN+sdqH+k1ZxXN5Rjjmq2ISHNomjeIU3pZFJ4PvAnF4WrOe0SDfRJkB0
S2kjTnEchfBNIyuj0/qMf8pAMkv3GyRdh3JF2KQZ2UebBO9UdiuIWiKhDp2JqOQZj4C26Rhz
hWYHdyI5GVOILX4X6+BahemwbKoxWirQ5KksM760oM88Y6wKVcFzrhbEUh1cP4iAjqzcyttu
G+PIU1u8MhzFnptjEie7ADa3TXgupsQRmoP01zSKAp0xBGbzomOhTv04TlHVhkNG5cZxeHOQ
QsbxOtgCy49EwsvUeDCmQ6t/LE2M6LZt3jcyMDvq7tXxwICJ510c2C5K4DAJK/EpyNR1qNl0
0RbH10Sq+3td3ypunnnDv4+f0BR/No3+u4aEenhL+u8rL0Jt/BK/vGaNdnELsnVtJi5FVUre
BFaz6GSf14b/41/bJZhlz11X8WqXBvi2NrFrDoOff/qQJcU73oTxKxHGcfcx2FnTTVsfAi7B
Hqne8wufCnSZoLBu4+hBp2oNeUCQ+Ur+WW9YwWolX4wVhbtdNiUWHeTTvYNHyGi4QeBPYWTC
w8jXG4QsuUEs83lQMgJdb0K59H16vf1/iZIReZtxHJRa/83VvRVTpTmEkurjMMB/FDqJom6U
FIIU60fIwPkxIHvOA7NRC0UTONF4zkgWwslHJ4hs4iSQ8cMlE8fA1cshA2/lhTGWbb0OHEWy
S7eb4FHUVHK7iVC/MpvslTXbJAkwpVcdRxY4BMqzGKTNQGn+Ij3nrOGKxCXmDF8LvvbWigY5
bFtDpDh4kKOdAXOE+GtTw5NsyC3o09vPEA2QxIesHJ+qAYZdagzKtqYPkM3dC3JU7PJ/l0+g
snTypzpv3yJZZz0K/bPnabROfKD6309HaxAVqb1LsYumvJKW9GCgOT8A1GvDycdmQEO6HqQK
BQLd9KxATTHqMldfSypZ+Qi9d7ASRnNlw9txHdxH4EQEm2dPGYxI2MxMORMRXbMxU/35/tv7
P8BPdZYO1zjaTmYKTNXdFrzbp33V3CwTxeDAEwKah3h+SzZbd27VaWhS2xcZqdGgxfK19KJ7
+5PEo6J0tujh+XKMlWi0dF5GKVoIeWlsb3mdJp+0TQk5wu0glYtgwvn9bAAmWePbt4/vP81N
H8NHMlLnN2r7PAyINNk4G9UCqyaqGvKTMFC76dSngS0wFjCJktG6juAthGlybCIFkmXO0E66
LkA2gnWkxjFU4vCi7lsCDwysMWytVgoX7BEJ6xpWZCzDe6oTi7upmN1hVUJTM+DRwaolbpW2
aQ5UJOlqQ1AnVKe5a7CZJknRJCM2kdpt1ZnbgaY2Nq9kYIwFz0LtQpjSzBBSfP3yL8AqiF7J
2tN9nnbUVDNzvbTh4zJ6NISGsArYThwitTsJxoYGIqqGYBfH3WwU1HUU6aGCYv1ziWDl5c79
ykNMKzietQCPoaF+bGOHHccLCxjcfu+kmPVER2urC8V8T0pKi67yD1GNiLdc7gJK+YFI7Tx1
Xc7I4+kbgrceTp45Vd815AQjFR6PgbB14zFmONCImFdJfI5gEx1Im9UQ1BLHGyV0P6AMDTYk
FmidKL4BAddqgmPUEf640jvF/AtrOqsP5Au1wMzXxh6yrpJZAQWbVuT0AvuAhYRIeYW2PqGC
XdfPSdAA2Co1W22NWGEZ/8YRubBDOw6JX9YgF7dpecV4kIIuF1UrfPZJ8DKo/T1jVmX3ZPe/
gzZ17sWCDigwYx/sKB3FycB1tWhsHcEdNrwoaAlIGh4MxQpZu00S0odMmFeCg/Eky1FBSaOf
qewPwpp4oh0rNFwTOMji/zi7subGcST9V/y4EzG9zft46AeKpGRWESSLpCTaLwq1rZ5yrI8K
HzNV++sXCYAkACbojn2oQ/klcR8JII+GGWzq6JSj+HjTTyie70YY63Ll5m0in+iuj1R6r7Ka
ICQW14hKziRX9LpnnGngY+pNE4eIx4h+bRrMMwczhsQKJhwJIgjpv2LkfLipauV1KmkacBq2
DCLGleCu7hB5fp4VN1XK3uxRIwXQJSVJdfIs1fpjpnsGLwtp63iY7FI0U8BjJfCXoaRT/Rv1
IRF+nwhJsGswOnJ36XWefuW9rtxRpfRPgx8P6MjSD1ICGYqyvFEMwkcKU8SWV4Pl2YmrkTgp
os8jh9CBoCVAoaJ8m+8UX+xAZY+2RbVVjEsKrtjaGFwUMpjKutpKIKFkP4xqPeTj8f3hx+Pl
Jy06lDb9/vBDibInfZa0G342pamXZV6hDo5E+nzte1pSed4auexTz2V39UqGADVpEvserqKg
8vxc5aGtu4qTckibUntiH/3yrzWSXBcRZAqOiWo/dkQZR6w1y129KXq1MYBIazMeHyGz6TAP
gRy0kBBNekVTpvTvELcBDb+n9mBZ2L6L2u+MaODqxaTEwdWKSbLQDzRG7mtYH6jgN4A02CrJ
Gow7OVRTLyJrkQw9fWMPTQA1RTF4On/F7v3we06GM4dTdDxiXlFYjxWd78e+WjJKDNQbNEGN
A1zqBfhQ4MdGgTXt0jU4i7i5uDRgeaWkkEfH26+398vT1Z8fc5ju/3qig+Hx19Xl6c/LPZgj
/y64fqNnuTs6dP+hJsk3Ya2Dh0HWJmZLUUrEI6u6QrUp6fqNPnVTWCV1JS0Jz3KI/c4iyKkX
phrIrxeUpPMtvusybOdYvf7BSjEKsluMNHoULBvt4V/Cv9x6YbQYA2yjNy2HfaDfIjNqGDjY
Qy7bDZgyldoqXK6VB36aTDr4KoIcA4HcFoXWexDemq5CqqjOxzTpDbpEDAbJZ4sqw0xoqM2d
fRUUp8Y5FloRbqpveyrRtSr7dMGBUk9bNRFQpE76osz1VhaOU1CRhMKTWxyZVjbxoNHadDbv
y3/Sff6Zyv4U+J0vv2dh4I9O2ayowcBhLz8CMHpZaQsfEnhNIp9KuEA3VKStN3W/3d/enuqu
2KrJ9gkohh2IRi2qG9WYhi9IdAPjaq1CQqjfv/NtT9RVWmrUegr9sxMPVS2LecZtTB00e60s
LOaCNliAJKJM6c00hnY3GAnMLLDJfsKiBYtVarIovCtNqjSrOqCcCDzCSqM3O8pk+XyKquGz
mIq/5F8n0hGmugdymHRCkINO0x+KyMjfaTo5DvAUaomRHx8gqJUU6psmALKjXMCmQQLn9g39
+OXufzBZkYIn24+iU1rWqpognz/P5z8fL1fcM88VqJRXeX+sW+ZahcnuXZ+Qpqh2V+8v9LPL
FR2BdIrdP4DRK513LOO3/zZnCbc1aPctiy0lUVRwaEf6AvYPxYhREFiAOyqFX9OZSagk59uO
zHESAQm1j4r2m+pkm4849a6Afd/ddHKgVkZjygJsFefi++Xp5fXX1dP5xw+60bONbjE3eVlI
1vRaWrTkYazRpHvT+a0JgOyYNJjVBQPVu365oPIGpSZYoLoMDCKbKOjkeLyc2jDdYa3AbGXW
C9sVNbbiM2zcEbTUD0Pk+xpN7A4q8XZYVAVk3K1hyK300CTEMerl5w86FzShnSe/YirAWwZ0
wQ2uSGYGx9gk7PzkLusl6DBkzWk36Tby0Ud63txNkTqRrInJyZ0XC+/b0tKqNQQf4tts2UBK
87CYRcmi9Jss9kObHLFTMB/SozamNtLpvmz65EtS3Z76vtRqUzZu7Ln6eKWNTkU8a1EwDhhM
M8Sg9ns/wpRXRJuCYkQU6G36jQxRoM0PoV0ub8dIi06R3NdbWhzx1Gw3fTQs5mo5bLYLGp3z
11rx6EqtsUEcTRaGwtarApcuHHK8Ra+1Weo6untPKb48VmFQUVqtsCINTckhn6kVpVvQXnru
P9rjcm3/9p8HIQKRMz2SyRkebSEcMDOSepC/H5Gsc+i0MSGREpJMSm/AzjLyt/ZROkDMgNiT
poojxZer1T2e/62ZvNpCYgNLSdSJysjQEdnL00SGasla3ioQKYWWATCtzyDOt9YiMw+qGqam
otxHKZDz2ceR5RvK5tomwDUCVLROTWCEN04oexFQAUMBolxWY1MRO0SGgeju8YumPsLV10F2
yMFI9CCrXuJKZHZ98LU2mXtrjF2PqxTKfHWal3XPfyCdJLOyiyNOqbdbubNlLghHiL9Uylxg
EdTXVY5W/tSKQ7Yhi1ts95QZutQJZcmHY92+acqbZctyutEpSQPuLYFRWUOFuJZk6WmT9HT2
41ZLLJA8+xqFxadrlixwvAA3pCDVWIE0GMdvk7SPYs9XNvQRgwEcYCYJMoPs+EyhI5kxuiID
jEi3QV9GROkpOifG3e9z4iLnzTfou2GZtQBU7UAdvM6+Ye0wwll/2tP+pL1yqlBPRVM9NcuT
sR6UrngHlPhROhgghJZnLasjEMfwjaOeKcb8qfRIR4GLracjS9E1kDD2NU05iq21j2fxRwPK
Jgpl0w6ZHkVL+rQXLorA+h6dDVOavRv42FWfVA8mEUr3CAoSu8sCsbrHSA3o2PBsfzAAMZIJ
AI5vSCp0ffQLP1LDSEwzg2xcL1xtDy6/oh7gxzGzS/a7HN6FnNizsRkwGomutGrb02UEKTy7
qKJCXJNhYwrWWtTV/Xafl6JcYj2WnmmJ+sxLf1LhUUmfE8Ul1TXiLqE6v9NzIfZ0M0Wzz0LP
xi5dFYZIVfIZEWJbBktflQd7HVI5AnMGuD2ywoO2rcQRO7K2+Az04WAbAM+28CIBtJ4d5Qgc
Q6qhKbvQR4Auhft8tBzsgWWtGP3Q2Msksw5Oj0iCVGAPPulLvt7rbgg0psL/CuGCsSy2oU1l
WDyulMwTOVtMxphZfDf0u2XdhCXRSbNHmr7r6QFk38PGtpL6rvTtSNWCmwDH6giW8o7KD1iY
SAlHxsN1cR3YLjIeCnre02b/BPWy466R+iX1kPSpRNXaDt7bZVHlCfrWPnGwZRIZlAyIkWLD
g7vtI2MOAMfGk/Icx0ELCJCH+31QeAxeJFSetfkKkkRgBUjxGGLHWPEYFESfJMt2Uuzb4LOp
xnhczEmHwuGhbccgw1WQwhOH6xm4doh1NEkb13KQju5Tbnmj8+fV1rE3JJ1G9bKbSIBJXDMc
usjwIdiiSanIFKHUCKNG2EAmzBwRKWS0tpFRGM04xmcgiXGdxQlGaxz7jos0MQM8dKfg0FrB
mzQK3QBpCAA8Bx3EVZ/yC5iCHlExzb6JMe3pREHqAkCIdSAF6HELWdAAiC2k9kIlcAnUaXpq
IvU0JGFYjbeRH0tDuyGKXuXEJ8ioOOKE6+tWsSGndLtFo5dMPK3rO/jWT6HICtZEtqJtOt+z
kBladGUQ0V0SHygOPTYFn+0J6DziAChE7ctEcyssMbmRvTYQxVKMLSHJ4Fihj7YHX6hWpyaw
eB4mA8KJJ4iQKjVDThd/dOrSo4ZHD6W4IpDE5LtBuLaE79MsVizqZUDzkT1Ct2WARx6dyn0k
p22CLrKygTpbiVeS6a5728cSoQCqYSLh7s9llSg5RcbjQiNqkjVJbof4OM2pnOdZuCsjicex
0UO8xBEcHWyOgI98LyQrSIwsThzbuDGyB3TptR8Mw+whdNmqwOGsbceMw0WPSV3fd6G/LlB0
hASok+154UptJ8oi01Gvsy17fVmjPGHk4E+KEw9t9Wh1/BRV4liozAUI6nFUYnAdXC4JkTWl
vyapj09w0tBz5/r0Bpb1MchY1kREyoAu0kDHqnEokiAKEqzEh9527PURcOghwMBKcY6RG4bu
bpkvAJGd4UBsBBwTgAgDjI6uNxyBJc2gSSExlnQX6NFtmYNBhevrSlx0El5jkXlVlvwarvYx
tcrliAdl7MXltmBiElQiqeAJAp3SSV+AR6xuieUkb3d5Bdau4pnhlOVlcnMi3R+WdKsu2I9t
wXxOQawuVOQYGbN8m+zL/rSrDxA9qDkdi07R4cMYt0nRcitI/Gof+QQMj8FNpCGSNPaJeAcq
yzpNNHFz8Z25VAjjaj2BAaKxsb8+SWiulCmllToI7iw/bNv8m3lU5ASkK0Whf4RYSDs5stQY
JkowINmBlssyL3DmNhInV6Lvl0dQmHp9UuyO5/FfVL3rWQPCMz3wrfPNluRYViwd5rb47uUJ
yUQUXTznScWfb3ghdFu30hjA0MnNMRXJmC8rVX/5eX6jxX57f/14Ar03c/H6AqJ9Ir1bLGk1
SRpXKY0EeFg9FA5/paZZm4S+g9X087pw+/Pz09vH87/WOtvEIs0MOqXqlVLKb4facPz2cX6k
/bEyEJiqcg8r8B+SioXxu7lUt4MTB+FKsY5Jn15nteQWfqRoxrYTuaqPyU0tO9udIG4Wd9rU
9RjiKEO4wA0m02CERKwFPCr0cdfh5/e77/cv/7pqXi/vD0+Xl4/3q90LreTzi7o7TZ83bS7S
hkVq8X4wJWhyW9vV2x5pFXFVPAFPCuAbgMA1JBU4CDBfKy0xNrwGGZirniU9OL9CeldEvVsW
7rYoWlBckJB5pWWqJs2EIekmdDRlyckFs0UsiaSP7ZbAkQ9NReHrEhIPa5lRhsTPPDSjNMmo
4JCvfb7tadtYtoW2Xeemjmd/UsrsuJY+d8SLlg5WrrVPxzC9WMnayu8DO1ovWbevhmKdZbQu
XSmGeP7FG4jK7hB+/dT26ScZ7dP4s/6mxzpnvSxwjas0p6Q/wDUFkdFckMGBGTBT6CKwRxh5
kFnBOtexaLewka0XPd+1yVrJ2RqtpTyG+dxs1hPnfGvNIiLQYOtMsSvSuoTYyIs2K5sUYlcg
SNKXSRciwBijE2qyILa3iUIXpsnowGnabHUJKQsS0iO4yGj+LvWhj9HlrAhcy8q7jdrXRZ/W
eiqMNgUOb5ZOgMaKcYVIQ35UhvLY3FETB9EK1LHMX4WWG2mFJLuG7vxK65EG6mppxEPgDYGl
fk3Ab6xj68NrT0q0iUdF1d/+PL9d7uc9Lz2/3iu7Jnh/Slc6iebHbctGTVBTimOBus2cnnQo
BqeGddcVG8VJQrdRfkBpIDyWzDoPixnHtgjwQ8giRWgmArQvEiRrIGtMPOe0MHBPuDYQBECX
D3wkJGO5lDA9MkDoIVYv8JZOzmuNWGHEsdIkSU8pqQzosknGUECzefNfH893YDqyjG49jsFt
NoqE87q1zYSHrl1jcuYPPEnnhobbHG6sA8r7DnYLzL5OeicKLT28FiBUfqCDTvOEAQitpR9b
6O0ag0e1d/27ZGgca9BdGstNwA249O9Guy7Eplzho3JT3hoUOaElQDh0UU3HEfUdtQ2EZMoN
5pW8uGhqLAqXQ9dh7MJZgLasicVoiqkeULg7BroLJbKnJdYMqQ1SBUpUX7cYMHll/aWSHXou
7DTtiOsejAG7IsUvMwGmGSys2Ocd81SgVtSAdLITUygCM3VISa2HoqPQ15xomUggU/2UX0pm
oq/mMCqJ6p0LT0ueH2I37AIe7SoWVL3jOFU2ipipsavXi9EjzzQyuLZhiBQ3ilG1qQmN8Y9i
7MaZoX2gPE4w2niEUsmKiYJEBzFRrfWoaqkoDAuaQVFogtV1lqVGosUoFyKHXte29y1Uw5OB
3NRlsfTCgoM7VGdw4YXBgCybHfFV5wET0RwyhLF8vYnooMOe+XkKsrOjZDP4lr5oJxvXnonz
OZCT6x6zdhObDNhFtynRanLTpXWlV6UvTglxXX8A/7F4pwGbbpDEaUyzdZlgSQxxEaGbk5Kg
ETJBh9O2fKWzuV6njWuzrHhzZeVY2DTNVFXRdCw1rY6Le12YvowMbhkmhthQWInBWdkxKQtd
6mSTjvHAiYkTI5bsTYH6KEdgedbayIdYfqGLjPySuL67WNJwx20yg2Y0xtYU1RaSCQ+Tkd2S
iG3QaeeFpYO7kGfVIL72bKeBtraSH4lYRnVatKB51mK8UKprL2SfBYtvfcYSx5gyB5uv/dGL
VCV3TiauQwcr80lkXn4YF+PBJptg2UpWBONV1hTEQvZVY5J450MvovsxEY2WIzPHthjo4fhQ
l32yy/FEwHHWPuFO1/amus/s8CjD3mT+7gdUethp8xvjEbIIngCIH7iq+swG5igR+hwv8WS+
G0d4NkmVaG7bMSZ+DljPhO0k8s3FiMwi/9MS1AVrBXFsQ+MwDHuBlsZAUvmuLyvYz5gqL8z0
oitj10I/AXUnJ7QTvDywoYX4MUtjwhYVmSUKnQHLHxC8MtPGuUT61PWj2AQFYYBBIN/68k6n
QAubYR3114cJ05LyYkPqURCYEwfp9tO0Y9mMSINUJVq94BGmr6YzyRoHGgaKhlhzirOV5nhd
wZWgFSoUxXh9qAgumzqriIMnRxFZSVVFZIF+RppNkXR4q2G2URjbdn+b44pmEtMhiqzAMNkZ
GP2NBGJTAkfM9mzG2QVy25BrrAUY2JEMGMx4o7r7nmGzrfzMw216sMS7ckcFEXxZ5Zvypq51
ly06y6HNt5s9biyh8zbHzzY2IUicDgR1hykx0iOLFSR4yUCn0Q5QR1kKExfikZYBzHEDtGW4
WO64ZiwcjMViYv6nxRJSP47ZLjpnJ3Ecw3RDwBmaREaBpOLsOfMCpar7Yqt43AZqU0g3k63+
XQsOfxSny2XRop0KjofSOoN4wPJdf3uq8glCx03BZgDGIjMEI4N0bd+evhxSlN7V1Y0EyHl1
SXVTf1Yg0OZp1otEqKD3dZMZchnIJ58X3JYO+5YepMlqAVlbgzdZVNKG16jxXeUP2Unm0+X+
4Xx19/J6wXwe8e/ShIAn6bVnGc5IhcKypue9w9/ghVewHnxw/x3mNslYaIkFn1q/bHo7kt/o
WRXyVIL0+uXgCg1JVkyFU962IMpVX+ZkD0WWw4iRhFNOOnilo9OS7DBd4E95c4gfOUhRwZqf
VDu0+yBNCILs0D9anoBsjxUdFlO3sh5dvgawqkLAobkduDLNy1/vPJL15a+H58v91ev5/uGF
uQNZRMzgYSzpieZGedVi0SnTr62yV0y+SK4zUlzRphz9ySkPWix81r7s8ghaG6k7MLRJUdHZ
l9VHYFLfa6FW8ApkHhysF4W/pik8udaR02tAnuqdx596k1rFIFHVGSzn7hLS7avdqfMbLLGu
L07QHjgGO6mEakOFP2iPODZMeDJ0kcATYEhriEJA547eSIve7PgKQccI3cR/7+C+R+rTsWVu
mjbvuim2vVZNKlE42n4y05HJw+h03NdNhyEZYX7M+2KHpkeYtqPpw26nTprz893D4+P59dfs
dfT945n++0/aBs9vL/CfB+eO/vrx8M+rv15fnt8vz/dv/9BnWbffZO2BOczt8jJPe324wVrP
3kwmZ1n5893LPcvp/jL+T+TJnMm9MH+F3y+PP+g/4O50Vn/8gOk6f/Xj9YXO2enDp4ef2pQT
o+mwuLBT8SwJPXexlFFyHHkWNjoh3rRvHpeMwbEW06trXM9CEkw710WV10fYd2Xj0Jlauk6y
KHZ5cB0rKVLH3Syz2meJ7Xr4yxrnoMJUaLCpmhlc3E5c7AuNE3akwW52xOwE8WTTb0+UaRwZ
bdZNPTsPsnGlSQKf2Q0x1sPD/eVFZtbyp3tQaKMHCo5v+siO9WajRD9AiMGC+LWzlJiionPL
KDiEQRAii1GShLbhnlrmwK+6xzHc+Lb3KQd6tTDhoWUtR/nRiWQzv5Eax5aLDH2g45HWZwbb
XIhDM7jcSlrqSZi7Z2VqL/uUtRD69iBmw+D4fLJKCV+ejeMptB1TT6HGbdLIChcTm5MXMxTI
rvyII5FjpHGTr1Fkm6vYX3cRN1TjzXN+uryexcqJRQjgX9WHODD4+hcDt4+Jrd4UslRKmrCu
f759PL99l/KS2vrhia7G/76AKvO0aKsrT5PRgrj2YsHiALvfmVf533mqdy80WbrEw1U4mios
DaHvXHfj13R3v2I7mc4P2z5YNvKO4lvhw9vdhe6Cz5cXcMGu7jh624eutehK4juK0bbY8kTw
Rskv4v9jz+O1aQq9XLPet46pO3O/r9jRig+Jj7f3l6eH/71c9QfePAt5mfGD2+imlAQWGaMb
os3impnQyInXQNkh6DLd0DaicSQbeytgnvhKZOglaPiS9I41GAoEWGCoCcNcI+YEitWghtqo
TZjM9K23LduQ9ZA6lhOZMDVetIp5RowMJf3Q74yFZnhoPokKttTzusgytQtMu8A35cH7//8o
u7LmuHEk/Vcq5mGj+6FjimQd1G70A4tkFWHxEkFWlfzCUMtltWJkSyvJMeN/v5nghSNBeV8s
V35JHIkrASQyHdKWQmLbh8ulY2lqgbkzmPdB5uRNpsQW65FU1Bxg8bHcQ8ti8P2KbyCdj6RZ
N8FVF2KcTIcz11mTxjUSE6uvHM/Svyu/c7JPt7e3dKq9Le+bzIkcEKhFhTRYd1Bd7RJ5iLhC
TEnyXPV2WUTH3WI/bD2G5aZ+fn56Q8fSsAxdnp5fFt8v/542KPIEaUtI8Bxe717+frx/M8O7
BAflwA9+tmxF+qxDKCnbz2elqY6HAD18U+de2bllZXP0tF1hVCmebiLcl5awpzrPhIERTMIX
Fey79ujVT0mvvc54H81ET3q/wwhW4/M2sh2RD+NkttCe0bi/tbJGpWWfjmBdZ2rRDnHW8gQP
ePoC/pTRY6b+5mESj77scS3ttbrFs7FJlL7qYuiAwrtR8+5CI6TOZqWLRQQVOZdivbnyaU3b
4NMdv0hLvq2YnY5TZYrKNrzbk8hyqasA9IpcL3FHFRfvZU0flSJbkEValJThLeHit25HHT6X
w076d/jx/evjw4/XO7Q/0B4V/sIHat550RzjgLZOEo0NfcHSbY7Qg9W2g+6K518HJeIdAk2U
6rIJOH3Iilh2CA6uxds24iGrqoa3N3FGxZZBjpuzkeGuCBPqQFNUpQvdBq2gVqgMchFuU0g5
enx7ebr7uShBHX1SeoWGyCnsKhYdYlUaItUJURLHJ5+vX+/uL4vd6+OXh4s2arpTbXaG/5y3
fh/yRCuFmYQ2PjJqC4NIXOfBkR1VGfRE6vklwgnjDP7RAsspLBgHIyKdE/fS2FeFPjt2EYxV
udXR/mwMMcel1JK+F6lpcsb1z7XIQTJzcETDG7M7tEXF4rwWU3N707DqWhsFGIKgj5fXN+7+
FbaCi79+fP0Kk0ykH2Tvd22YReiDTJbtfkdOXGRS3Yvgu/t/PT0+/P2++K9FGkZ6AOoxO8Da
MA047+9opsIjMgYTGKno41nERVG/UhxGDhz9O1VCpBOPaUU3YfQt94Sb/uSlbzP/auW0p5R0
BDjxBVHp+/LmQYO2iufVAZIsqc2cJ7NfM8nO7IiCQBAbbxlYoSu6nmnpr9fUCFZYFHMaqajY
L6vA0np0FCcp3ePaXW7TkpLdLto4yy0p1So8h3lOQb2JnTyLfdCNhzTw6uFP6bW2oS1K1wlF
k0fG6pqwyBwbieZQFFSr0VlxXcX5oaaM+4ENo9uP4m66ZKREhpgiwxHIy+UeQ5tiGQhnGfhF
sKpjPd6FDIdhUxcN+dagw6vmrFdFENs9bUUhGMqStGIdMVap9Qq47A5MUJoqVp0NCCHG6TWj
HCx1YF2U7X6vJrRjh12ct6rXcARA26wsrrM7mMGvW0teoNbzQK9FWDSHQKNlQRik6a3GKHZP
Gq10Hcc1CtldPFlLCR3mUOQV4zZxx7A7MOsep4FNini3o0Zs6qjUiBbI5+v4Vu+l2Y5Vetfd
y4sBUpIirWM5gqr4jaX9qXxYFIc0bpMgy2JNuId643saDUojOrRGvY1VQhOi/hPq9TwFaU1G
u0HwyOITL3Lzq8NtZd9hIQPDJ+KWVJUw5Uj4FOwqrXPUJ5YnQa7XNOcMppJCo6fh4DNeJsaR
TsiLY6HXBIUyO2FkAUgtKxprhwPVrq7ULUxHvhVPB60JV3HXl23JMrzOLva1kXCBgYZj+0CG
7W/N5ua4vGZ6onldMfqRNKJFBf3UkhgsjKjgpoXc/yVi172V5Mo4B4Hm1FlRB9dBepsbs3CJ
D65DSkcRKIxwbAf0daS0e1mxLDirtCoG1kjrhlURhoEhbpj17JXvDQXUdPAOcKKIG0FTBuIJ
N0Y5tgqd13FAKXU9FqcYtDvWKgulKVN9aakyo70PVRznAbeE/xQpZbAZ/VTcYnJWppodbdMk
zCq8i92pfpHACLZVq05gd1rr4elkKiHJBnWItuTUrajA3f3nuCpUkZyCsNBm5xNjWaFPTWcG
XVUlYWK9jMdyDDRNR5C/uo1Ai9Bnrs67V5s0O6PbdUgINUcTU/HLpmCkpeKghlKSJjseSnsT
tj+mBlcy+rVmz66d3ilZ7J6BWr4+vz/fPz9Rqhqmcb2jBjMiYr6V6/RBujrbpMv2J2tqtSeb
PBHnl46srH8m+bBC3/6kIEXM9hbgUZyKQyrjuwFW8pHkUCQhg21xXYM+EOegQkkWnaoVmETs
3UMqNNhKQJkC3iZhpCBTf2y6t/7ad3kOM3UYt3l8GkwTxwfsyh0jiv75BQ/KNFOzwQFbGVec
ccVyT8C3eYCPrIX1HHXMJORQH9pTAhNx2qWgQbtUbIx4LUaSAoMawNFl3QHjJ6CjhM52Uq4i
Gvg0MB/nUecA709XLWFm0XMQOwmB7wKL0RyGvg6n0NcRPQ7Czfa8XGLTWPM5Y0dIyMUP4biH
1ZoJaoVuoUAsbW2IXuB1jW0rjqLnEu8cUujUPU8JKhTE9KWsoOZhiWjKc+M6y6Q0a4JxVpzN
uQeUSiDkbdxZ6e2hk0DKszzFvISbScLKZ43jGXnLAzT1HYf6bgSgAtQSOvHI+oywo/SDzWZ9
taVSHTzGwP8TPlMszFd449ANQIHOOXXBM6AiyFKGupMyzJSM/5w8lwwOv8KnuzciNq8Yf6HW
DUBhyxUFQAy0SOOqs/FUIIdl+78XQmJ1UWE8gi+XF7wPWzx/X/CQs8VfP94Xu/QaZ7CWR4tv
dz+HO7e7p7fnxV+XxffL5cvly/8sMKarnFJyeXpZfH1+XXxD6+rH71+fhy+xduzb3cPj9wfK
RkXMHFHok49fAGTS+0iFepztiMCQKGe+/UdNFOo0w1hZFKlu6Ec7AhStHJFm1GKuPoWe3mWQ
1japGinY5NBdyJgchyA6kHHRRo4I32xWRTqe/ZdPd+/QNt8Wh6cfg1O5wb5VbwuRAkZbnMkg
CUptsAnyGEDNhG4UNbInu4SMXEMC3V3t3ZeHy/s/ox93T3/AInGBbvblsni9/O+Px9dLt6h2
LIN6gNfD0F0vIlDxF6KSLi60rITdF+l5cOSShUmkEc62p2u+wzVZ6gpWZVjXOY9xU7S3Le7o
X5RFcaDKcaD2K4+6YA5YY/F+ozBZvBcNi8dWPtKWiIaqNAHoe4gS3cDQdWXBYi3ewDu2A6lB
iCa3qM8N51vSe4+Yv6ATqMeJE3XmtkFi0u2lJChgVYh+Ji3JB9W1B8v1fPLdySaZfJh4K4dE
hA6YxEFNovgaBQ944zTWY9XLqZegClDXADJPb/6e+WRGcVbGB0vy+zpiGOR5PoMjrPqVJQVW
BjfzX7OKLhb0upmKDzDs2ueT3/uO6xmT2ASuSVdJcv8KqszStqw82ard0JfpEgtOxGWQY5jI
X2T9kC3l9olu4MEAmS0PbZNIz5aFddvY5ZbhkdMHKRR8u1UDLemos27LoLK8kdGY/dWSbILs
3Ji7oB7Lg2OmRn2QwDJ1PTIYgsRT1Gzjr+lhcxMGzZlGYBLEbSsJ8jIs/fOaxoI9PUUhAKKK
IuEMl6oNZ3FVBSdWwXRhuXCQuW+zXUF7Spa46g87U3i7i6tPsDDOi/EMM6yuWQxz4MnaQEWp
H8oTPFnO8phuffw+LGypn/EUChTI+fRPjCe7Tlki5cgb+j243BtqlyxeU0Zbf7/cenS/7vRd
ae+hHlCQm484YxtjxALRta1eQdTU6gVhV4Ijj+3qUMWKtbXSaXwoavX+QpDN3d2wKoW325D0
EdcxCXsTY5sc2e4wxAYZFy28I9OORvDqMgJNBU9FVJEzDn+OB01pS7V9O6iAeRgf2a4SHl1U
Nas4BRVIRiOr9n6iORKMMyw2nnt2rptKG/GM45X4/qRSb4FPP374LOp61noXHo7AX3ftnLXj
sISzEP/jrZfGvmfAVpsl5XZHSIPl1y2IThhsc2NZDpOg4NcxdeMqhF/r4x+vDLSrPpHOGe+n
VVoTB4c07pJQD5LgHyCTymb598+3x/u7p0V69xM2UuSAKRMlqvOwNRowoi55UXY5h7FsIdW7
CoNfsC6myGFgkJ5Kx2REGPujFjarDpJjgfCMnu/1ZsfSUbGlwkp2QpXXpdgr+DZnRDoL9Ns0
5vo6pHLYdkc9F9a4FdYSLoH2pxVt3mTtrtnv8XGsKzXs5fXx5e/LK9R0Oo1U23U4ItPPEdpD
ZdKGIyiNqhw+mR9NsKci5TlQXlAgLTuaKSDN02YYnpeaybHgxOIZ8/ouCvUdozzesmi99jaN
6tcSEVguXZd03jOivrYkHYprbUTGB8UyXWq8zl28NvN2Lp6P3c2QBERNlt2OR39yXybbWJ2O
dqBTlAVXLuDFbNHGuGioxH2b6ydz+zY2SeRxXfffPddFOdD7Ndu+eR/4gjD7mKnYxbYdyciT
y04MFSQWCJ1yjPE8mh2P7YdXI2+Vw1L5MVsc/0KNygQm1V/Ic9+mMAZ+Ide9NsPYuIzbMJqt
OdqGkcQ09IzJA+FtGYfaz7YOS2WVGqnkWV2H7nESkV98duQm5PL9Ffxqw/CgUTCCDJGf8Kio
GseP82f98+XyR9j52nh5uvzn8vrP6CL9WvB/P77f/23eB3ZpZw2sZcwTZV73G0Rp5P5/U9eL
FTy9X16/371fFhkeHhKnRV0x8OFFWuPZPXnf+XGKymxepHHLT6yWffN26mwk7ttUKh4Qt9qi
3Zyo5TqTvciid4K2CeTNKuCDNtXdQgonBp0fA/t9m/TxcCwukXiUyNdbIwl0VHGexDEEl+Jy
ZOSwHZROHCJiEVnPIYm03mdU7nv8K292pIKVVaH60ABIBL5ISNcxgOIOu9LkyPYwvUUqcYhe
r2dbwdYwUW6jRBIZyEhdgPtSmgJl6DgWfTaEBCSmihy3cQYe7raOJoWj8BSj9BXRtif9NyVd
oO7SJt6zOI10GQLW+c+2tipwJMzbXvnh0SU3dT3TtWeWRT3KFnVP8A+jzEZEPRuYM7S6Nzwx
mr5BGW5gUFre6gELmpeiueFcjx14NE1a4QlvEnJmFr2h4AnbBeptMQK7MHN9b60Ss/raEIfo
3ec4J48xsjjDYHbXsmOgjqK51r98e379yd8f7/9FTYfjR00ujolgU91k5vm7nMrHM8uQphhT
mTpbDNgnYdSXt57lEdbIWK3JqM4TPrWlIkEdp3dEaMuBdhGTGIWVhHilIJd7orZ2U0bBtKtw
C57j4URywo1tfohNy3F8YEA0h0hheCZAFFfg4vHDUiuxILoUURp7AxGjnOuV6/wl2utVhsHV
mnRUJ2DVlWiXEXq3Xum5A3FtlLNcr6dgribmOhTRI4gbM2l/LUcEHYiaj+2pimu6P44MG/LE
X8Dmy5LuqxOt5Qpw9G8306Mi2FPRL3G7lus8Z9pKVYcBevrTRFCn4frKka1SurQM//wDWfXr
PHav9X8MMRY1vRh0KUn+8bWRIGwL/np6/P6v35zfhQ5WHXaL/inOj+/4zJKw51v8NtlSSo6L
OsnhsVNmtjMGOaBefHUlTM/QKMZH+ADTKmLhnX3qv2PF6tfHhwdlcpSNsPRZZ7DNEg6mjW40
oLAb4klBHT0rbEkMuuIuVq14FY7xCY29aw2sYUk9klRYgrBmR1bfWuqk+hZToMEqTpy2C9E9
vrzjnf7b4r2T39QB8sv710dUyRf34kHq4jcU8/vd68Pl/XdjJh0FWgU5xwd3v1BT4RvwY74y
yBl94a6wwc6VftmtJYbvg3Kjz42ytbqi71RytmMpiJ7kYPBvDopITlnRYEy1lEl2gkgYFj+J
lISgztzSxOEx3z9e3++X/5gyRhaOR6IJ6UqzNrYfSMqPsHAPIwgIi8fhIao0hpARdOT9GKlR
yVMguCew5CpwdDpIfYdWUQ2LxcN5W6mrY7fr+jnZ1GJJjTPigdl89qcgS9mvaw8Eu936c8w9
ComLz1dmUsHuTKbUR3CVJ4EBirjj0Z6kJYbtSpfThOjhxyi2zZZeuQaWbimeKQTG47uS9X4J
EHFeaECN5SJBhodrg6ni69CjHZT3HIynjrv0zaw7wHXN9umRjfnNGehrk1yGe1/RcRQAvdPQ
iGdFrIAa12WU1cqpLf5Oxs4VbUHhoePTjzw3nku/7BgHU+8PeEbgQ/gZQ0ocFNyrZWAC+8xz
PKLXVDBM5KAVEn3tOyR96RLNE2fe0iX7WHUEZF4mFXrpJn1hD9VaZ9SI5REMWCXp0X+UdQZC
u36Y/FtgGj2kAj/6o/pw5oq453pEZ4Ze4zoztb8KXaOQo4HiBzk6rk8MEqCvHaJ5kL72LLPb
xsco9xlL6ZVR4tyu5oZ7xN2V7D1vpA/6vt439oxsvfra2dbB7GS38muq+kj31mb1kb6+Ivh5
tnFXRMvtblb+kihyVa5D1RfRgGB7zs8C6LadjHM3MpSgi1KdhXKdb6xrfTgN4+Mu3OtsyXov
uEZffP7+B2q0sz0x4NmVuyFmkD5mLtEXhzioRDuhz11q9gpN3i6cL1XjY7VyzvT2dCz1GPd4
RqbTS3Izi9qnzTPGImPAX6pw9Xl1ZXEYOkqBUoTHkouIzp5PqEn7Gv6nOEwbG7hIrpaOp/iS
H0dbVlI17ONQzBb00+fVdjUnhbQMPfd8ptLvIq7NL3jo+HhuFhBBgsnCiwAVc5/W243rUu1z
xlafa1j01kysf3XkOFfnYenAjTfvnFGqo8fIT3q5h/tZUiARBqM0fLx3vmyyAGM1GM+o+G0e
ChsCuY78JOjUNVyXjuzlQUt54Aya82DeI7+qjFarLRlzg2UYfThkTDdP6o0SO0cvZLUF0h8N
4tTA8XWFmQO6BUN3Kru0LdS3njJC23VKHPbzSqOE6sfStZV8ttfgLQeTPC0goeznFVbdKBfI
AEXoA6yDqAbCeyX5JhQJPK7CQt79iCxCJs1cEgB7bNUKDZmrhpNmJIBle1gb5Q/Qc1NL+AiX
YFkAvaOnLM4bg6ic9k+0yRWRkimAO3ToTZ7w9wwsL5taLy1mn6lHAv07xPvX57fnr++L5OfL
5fWP4+Lhx+XtXXnvOUQg+4B1HHB1cGC5tE0vK8YzV7VGCgv0ajHxdL/1Df5I7c57YBS2nH3G
CBN/usuVP8MG+zaZcyl19I45YzycacKei/EhJDE3SlWG6VZ2PCmR3RVN3pBkT9FWJsAn3U/K
+IYqlO/4BDnzqFIFWZmCGFiBQb2hshaGMnS9zTy+8QSuZww9z1disEhk12zoIJR1zZEKmnlm
ShroS5/MVXwhD4GJ7ls0QOlL+tnZxLBZUYWsXV/VhyWAjLgm4yvbh7THdZmDjnMncbiUpj3g
GazhQW0IcJ+uHbOOAU69rHDc1id6LKKMVUXr0Kclw5AS9/7u8pqMN9LxhJsz6saFUa6sDHEq
1slBdOO4O4OcA1JjFPq12QN7zMxCABmR9wA4m8iQDGBpsMNAzMQYgcEXmJ8ANQoIIQM9k0++
J3JDkIW/khvPKCxfu9TkwMbZzOxvvrteWx75jWKGf05BHSZRcTB7B6IB5uEsPaLzTPBaPp0j
YMecJ2V4Q8xjE7xRtWyDwV2Sd5ImnztbSs9xZ2HlDtGElRjLI5yi/DfdQaFZA4Fuz+R1osrk
O6SMBHblEIvWhPkEhvtu5ih2JDpGCmPAvBmMKmePbaxptlrwcmo1m+/J0rKm2QEQC9svJcVc
l5rFJ9ibWVXgVx2HUtWolU5RFccJ3lsS/RQdQwghLsnRcADdJymjmVqBynumqsPCsptz5lbI
GxG33NVcY/fwp8oQqM5yjcFiG7RpmpGYcLghVmMikxGdy6ZniqidtcICEzU3RDxAUUDknwnH
4HOZZzEKyp4zrCibtRxPRKYTkwfSN0uavl1SnWBcs2a7dy6WDapTdgi1VlV1tCYmBL4hFOBM
MaiekoYdCyyQ1DIYskBaxYxGEbqfYmqnDCICyEWfbbcY5d2K4qyysuCdGENqUc2xhhiVxy7h
myZAJ2qYS0llICzXLfWN6iuf0CFy8dWGWoOAHjVmN+nI+0B9aaOAnB0y+p67Zztm1/6SPNed
NAxTd0O1gyS2nBpZ193flFHGWcQ6MLejobsIpfiJFrZ0U4q/Kppa2QNXNezLrtxGPaNLtWrI
kA/r5o6evyp/67j0g98Kdn9+TGPHerNZW0I4IaSo7d1NNSsWb++9mw415ktwf395urw+f7uM
Ae0Gh+Aq0nF/v3t6fhDu+R8fHt/vntAaA5Izvp3jk1Ma4P9j7VmWG7eV3ecrVFmdU5WciHpr
kQVEUhIjPmCCkuXZsBRbGatmbPlKdiXO1180wAcaaNo5t+5mPOpuAE08u4F+/H76+eF0Oeqs
6KjO6stYUEyHWBmsQG5KeMzEZ01U6XZeDveS7Pn+2Pl1TbNTb9zHjEynownJw+f1VgG8gTH5
R6PF+/Pr4/F6suKEd9Do+C/H1z/Pl2/qo9//Pl5+6kVPL8cH1bBPfsV4XgVSrur/hzVUs+ZV
ziJZ8nj5+t5TMwTmVuSbDYTT2dgQCyuAnT+nuyptCnK8nr+Djdinc+4zyiYMGbEY6sC6h29v
L1DoCmFIri/H4/0jyslDU1g3ZjpNhnlDqNI/xXG4klp1sLMu9drUjLvgo2yI1ftLBdQ5FHdt
tszr+b68x0mjrJX+/HA5nx7wMtUgw/qoCMtVkEh5ntr/l1EegrN4G1mjRtwWxR1c1pVFBrlQ
4R5c/DoZuXhfSpQVemjEGFuJcslXbJGR9m3bNBJ3QnD8mHgbxT7khlYeEpSlcIZPQfhd+pZV
FsZ2+RsppBqHbrSzDZlI2gh5I6b6davthzy8W2zdV5HV4frt+EollbAw7VCFcaD8JVWW1aaB
jTwx+/TF2DqX514Tlsy8KFWYTJTFwnQ2qFON6gVtA8W64C445saNfw3keVZkFhiSD4MbTWOr
aNUlO5SryLUrbDGZhHHM0mzffAc5Jpnko9xn3pRKBre+FTxK40zZ2LcVsyheZNSqiLIk2cp/
d8aVkYZZCWpXsMmd7nsK2eOHr0dl7WhEa7JqLPmqUDFm3rswskMZehEjCZokMh9w3xRgebKb
ig+a1ARtYhozkPonX2jzqd4JOpzyqjiSqiYKr/LOO+jq0Hg6vx4hfyjxzB9ChFPlOvRuHh5O
CV3Ty9P1K1EJTwQKfqMA6v2MemlVyOo1yTj6cOXGqybEnId91jX4yfzev8T79fX41Muee/7j
6eXfcArdn/6QvR5YG/6TFH8kWJzJ91p95vgs3XWo1xVBvJH/Y2KbU0+Vmma1lzz7Ubo0VrHG
JCamPXcIzjTLcKI+WBw3veJXLsFtI5WLMKxmv8hjEiHSLOMOhg+YLmKKIm7rhpBXzD3FQ+Q6
dSwu58PD/fmpq6uhWGWPSUqJZHkt1u35L8vL8Xi9P8hldHO+RDdOI7X89gmpNrD+T7LvqsDB
ad1hz0d//UUPCeD2+/ImWZkJ6jUw5aE55EQ1PzT5iovjt85ZWmwgwQl1wwIoObNy5i9NX0YJ
5RBM9TZnxgEEYOFzbcvcvoVSravmb94O3+WI2ENq7j3wtF0K49ZDQ8UiskBx7PvmHq2AIkhm
o7HCdW9vcuegX/B1FQmZXqnCBVDa3KMU/NZPIXqKnPldJRnPzUVBdoS5JquYBu0IyD72ITyC
VIqGJHSMTDha+JQSSww888jq/D4Fns7pVuYfNzL3OorR1swGwegzAlplNwioeDsmuqPf5p/0
23xGdtB83u+or4PTHCL++eQJpwv7LLcbSiBumCG/yGN3A0EJpaCLDFtgIlWB5KnqM/DTNUxF
9mMQ+9VmXAtX+9P303PHPqWjS5Q7f2sufqIEZuhLQXuJ/7NTuG6cQya/3TIPb2pWq5+91VkS
Pp9NTitUucp2VfDBMkuDMGEpCuFlkvEwBzkXggzRtlYmLcRYEmxHHeUmHfg8SXXLzO+EqmFC
RLvQ/h7HIZRBBjDlSVxWqojqhie3a8pwF6Zm3jcTXNeRZj7/hITzxIg5Eu4Lv/XLCv96lYp7
HY3XYVYTlyzwS4hNZtdSLgWbj8wYJxUcOzhVwEp4TYvhaG484FZYqQgPh+OxU0p7KcyHFEJ5
NthwXqRjb+zypI8AeQwq+xgHnRez+XSIrmUrjEjG4w6Xw4qijj/0CY1P2eAaomWS5VSgpMjs
ywjMpFQkH0MbaWClv6BIlfNtloI3c47xm2W0VFQYXPlaga6p20JY/d+lIMtgtupWBSzJhsS4
5AAiUYeQpz8e8HXJOmG2fUNbL65gHw9HxiSqAFgfV8DpwAFgqkXCvBm6iJCavpxYOpIotVkw
FO4nYEMPGc0ECcuDPnWgaczcISbTyhu2pIqT0gx9pPq8ukLQ2MrYDlHIQ6sqyvaR6MCBr4SF
3+xFgLhUgM5bns3e/23j9T3KpD3xhwMcwoJJIWjsAJqrUQM8mXRFM2BSfCQd5BNwZvZKO7J2
Be8sYYZqUDmlcUbnvT8ZdLw6iGIzG3odApLELVhHItX/wxNDM4ung7lnzurpxEwGq3+X0VKe
YWCYC7evKBKwJJjPqdscreexhI2DARwGxiLxEx1zBIMDNoeVsuIYGqdW8WQvyjiH4wWBlwKi
kQ7GGLreT/GCilI2kFoV6wj2HKWgjfg2vsYm+2mAG9DudzZMGbdbwMIfjKaIFwWaUVdnCqPO
KePebO8NJ3R8AYmbT0ijusTnw9HATvkN4RySYjKeTsFqG7GZsu0UObhA8gX8JepQ3MEA+Npf
29aNtAV/uc/oXmwP1citV8F3DAdOazESQfUXiMyQSCwrrZLataZzuJVjTcdgK3v+MlhKBbPE
QWlMjNVeoVjszzy6PYUWcnujN4DiNh71h305niRHEj0BdL1EjMcPeVIqI5POL61E972D/29f
GlWC8F6ok4gbZ0AeCp/FKNGOW6K6T3v5LiV8+6mzhep7i8fjk4qnqL0lzD2riBlENatONHza
hhPS2cD3xcy084rYDR5TnohpH0fmhOqjHBLMihUnrZUEF+Z5tPsym6NkwM43UEeu/grhnDME
Db1lEXXFkMopXRGB4Nenh9r/BB7w/PPTk8pf7QoKWhSrFjiNbiWsNvsQWb/53Ylo2NTntL6R
Fbwu1/DUKooO0pI+cIU0rurf6p1Yz3E53Q96ktKH47g/QS+v46EprcnfoxE6LMfj+QDiQpi3
WQpqJlqUgMkMF5vMJ7bQEojRaEDfhSSTwXBIiwnyJBh7lH+TPAhG0wESRaptjJFbjTI+H4+n
KM7ph93WWEg8vD09vVdXAeYoOrgfdFrm4/+8HZ/v35uX+L8hKEkQiF94HNd38P738/03/Sxy
eD1ffglO19fL6fc3O/v6h3TajfbxcD3+HEuy40MvPp9fev+S7fy790fDx9Xgw6z7vy3ZZov+
8AvRhPz6fjlf788vx+rxGd3hLpKV1yHGLvdMDLx+v0OqNtatOiWHVCyLhG+HfVMJrgD2zKzW
la4IhH1KUipWw0Fl72hNHvcT9cZ0PHx/fTR2+xp6ee3lOnzg8+kVHwTLcIT8iuE+oO+hGGca
guIkknUaSJMNzcTb0+nh9PpOjQlLBkOPEkmCdYElz3UAr+yUqIyy9yVRAEFgzIKFGAwo4W5d
bAeoCRHJM4xiBhADNBrON+nlK9fNK8QHejoerm+X49NRntxvso+seRjJeWircLUCl+wnlsS9
g5k0qWZSl75elLFIJoHYOxt4BbcNXj7gVYcPUvmrr4704HMphMXC3H9/k/1vKd4slltsnzKF
ZTwQcxRIT0HmE6z3r72pra0ZqI64EL7ckb0Z6R2TDAfIiyCR/A3R78lk7NnrtLEX0InH84x2
rF3xAeNyhrB+n05M3RywIh7M+x7lgo9JBobhvIJ4ZhAI8z4iRnaiBsbmtqL4TTBvYBp55jzv
jweGcNdIQU6S+7jIx32qe+Od3CVG2GRV7h0j22wZo9C9RsbB9pyqnEuGB31AGjxGnmdGloPf
I+t43gyHHj1PwBJmF4lBhxrhi+HIoyLJK8wURVirO6uQgzQmMwEojBk7BABT8y5MAkbjIUqz
M/ZmA+OOaeen8QhZ5muIGcZxFyZSv5maNPHEuk77IntZ9qWHv7vaEfCK18+ih6/Px1d9MUJu
35vZfEr3Itv053NSqa7u9BK2MkRjA4jFUAmRe0u/Y5IDfVhkSQgJaYd0vOQk8YfjAelPX22R
qlX6Yq5mqEE7I79O/PFsNOzYnGuqPBmikxXD7c2Z7Hc9Im0wYkuDTLZIeUKE1el0//307Awm
oZukvtR2m04l9x19e1zmWaGyj+OThWhHcVCHo+v9DKaPzw9SBn4+mvMJvmOdq/hztXbUqbSp
KLX5lhefUmpJPead9Tq0iNI+FAo4DOIs459VBdHBKCWP7gYkyL6cX+V5fCJu28cDvAEF4GFK
X/fyUd90wAKA3mbarY7HIN6R20EHKySb8jOwjBMnfO45PisdNevSWr24HK8gjZCbzYL3J/2E
epldJBw9BOjfrj5bn+cLZmahDrgUX7p2GJXnhdYKON3vPPY881Zd/XYu1XkstzVK2EzEeGLe
tejfTnkJHdLOutXO5TBej/l41DdOozUf9Ceo6i+cSVmJNiR3xqeVFZ/BktkcNvNYQchqpM9/
nZ5AhIZQUA+nq7ZOd/YlJf2MsS90HAUsh2TMYbkj3x4Wdta0fAnG8R1PiiJfkoljxH4+xk5n
QEkJb7t4PIz7joz9yTf+/1qW6x32+PQCunvHEjKDooQJp7ou3s/7E8/UChUEd2eR8D75rKYQ
xgNxITdBU25TvwcoYwbFcnN7jiMHyp9y4lPuZYCJAsM6FwA6Jn4R+hjMo3TFs3SFoUWWxRZd
mC8tGojjiRO27ZJQBdOvHvflz97icnr4eqQyTAOxz+aevx/RMxEICinLjshJJpFLtmlu4VRb
58PlwTUi2CURUEs9aWxy1mVzALRga2EE2bhN0I8m1KUB8mMupp5naJwKqrdYc9gAvI4WO8ru
F3AqUPPQLgGmchARp6NQ/RJj2qMAXMVIntEyKeA7TIcUqkqLU/At/qZagLDbKm6pR+kKA3bj
9VBB7Jn7x9OLm5YC0jhGyCyv5kLKN34pC8rpSttB1XT5DX1rVRPkX5jXTVWI0QwEUDI6Tl3F
eqb5MSwN8hvwh+DrCOLDRkGIUppHyR4oRBHaYlktI9odYpTlkKvW8j5o+IH8Y/IHJKqKQxzU
TeFYsZ7OO0uyvfBQIFQFXYS5lHcdaBW51GliLYKOgJIKDa+cH6BjlhYR3dcKzX1vtndY1AHc
KKAOzluyHMdYVQQ8EgXz16RbiqbQppYZDjZvoDj5kqYJqqy0FlNqrSTcG0/dKkXmg3tNd43Y
uUgDC5Wrwkfx6xTiy116g7wlE7Ap0kMUDSeWv7+JnEgduN4XIVOaePv9quzo2nVZRXqqkqzV
K3t9BzyOoir6ULsZaMQEDJ14JAVKMv1aRTWPcPAieNDfZClTme/srG5QRjPc4byjCeBzca0a
LicwfPwCan2yaxWQ6iNVydooKQqI+J6Vg1maqBx7uCMaFBTH7fpyE+YuO2pG6YR9NjMGKqJm
HNDkTGXxg2oRI/r1OkyHVj4zhasNPbkfhRhVmeqpAVM+VdY4azNQ4uvgUQwevj2pNEBxZ4Y0
+FEHPlqP+lNyDqmDBpyK1ndUN6i0MtX2h6emXCU84uEQN1XIqryBGWlDQaNylURgNI78DvBK
aAqAraYcTuSE5FMzMWdoFynW2zSAd/XYzbVuOgHWB2Ea5Jmd8arTQTBg1N1mHb3b/OkG6dZg
dURFlOF6i8/8rOB2fdUOXYbgveO0VmMz0+1Mo8DyRtdo6nFSygmXdDpQtShulqqZdu+rZ7Qq
haRj1QrsJqqVzi/Tkwx86XBKyvo072JHl94tJ3La1z1jmFJWfjZOaYs/ke4gAcaKky5KbBfK
xVP3bXtbpu1Q9CfXoSBve6+Xw71SLG2pSuBsm/Kn9u6Dt+Wow5aloYGY8pSoChQq55/BlwSJ
bJv7oTK7zOKQxJm5EGopR1nmFmsXggOzNNAqV5oNXqkqjNeiCi4K2mOjIZC7G3Vv1TBRRGS9
Tp7N9knMHY+6Vjj0zdrgd5ms8g8EApukZOYuBil1cibHS0qLjuVHU7Si8nfUWmioQIyoOTRx
izwKVqHT5jIPwy9hi7VNhDjcjfrZVopG1AxXVefhKjLlGQUMlrELKZdJSENL5O2EMDbnCNm0
jfsL0GxJuzg2BHRoF9STCbf6UqoA9YqV/6Ucvkxwc+kAQYFkF+5bA2QzDZ/jWgF5/Viwms4H
aKIB2LYSN1BVaDTqztzhiMttlRuHgYiyPf6lnAuwGb6Io0Sn2jMAel+vvP6M9ZXL/6ehb7oY
67BFyEPFuJ/2U9pNHN93O1T1LSy+DNDWJCcIJ6AEAHxxweDKrQhLyIfJcjoVDeAyEcmB8A0X
yHAPFybm3UENKRfg3Cx71cBBZN0SwDrcifGYmAaQpegOUdCzVZRh6ud3XQnYlyLNimiJpOxA
g8gNUWGs65Ela+qoz+ptVjDkXQcA8ORXQqsaX7ACpmRbyM1Z0d+yPEWRXjTYCmSqgYXcidq5
crNMinLn2QBDdlWl/MJ0T90W2VKMSnN0NAyB4NRFAF8fw+3b7U5q0OzOymuqJ9Dh/tHMnbIU
vtRIDa2xAkDUigKJaTUClJhslTPahb6m6sr/XOOzxW9yaZVxhD3FK/a0Jng9vj2ce3/INdAu
gWaMMh91gQJs1NGDYaCrmn2sgBwyQksNNCrM6OwKJWW5OMhDQ7nfhHm6xI6M5s8i4c5PauFp
xJ4VhdHkeruSM3JhVlCBFI+m33SyDEo/l0KLAdV/9PRovXmW0U5qYEvk0kp0prGaIVquSsR9
J4owoW565MK5zfKNSWWI2tYEhd+7gfUbJRXREOggqi1AorhvABG3jNNyrCIvPRKZZ1kBFJ0l
qwnZiYe1ph1I5K5E9kxFBNNEymSSyPpQyjhNrh/wQAjzKDP81mEbtX9CT6CO9K2seFIrzs3w
Gfp3uRLGlJAAESpYuckX2C5DkweRUFEcolQSbvMQ9mzIjUt3XF3IFT7riRnyNZ243Y9w6mv4
rTcbMm4nYCEk9m3LmRs7W1HdhmxT8tty3RXeXFFtuS+r68ar9dnFSL3t4yIKSr8ftHjQVLic
I3cdMQsV4T/g76Pp6mcB68plzVRZEjXn9EilsbmkY1FH4P71x9P1PJuN5z97RnovIJAMhGpr
HQ0po11EMh1Oce0tZoo8mhFuNqbMRiySwQfF6YcIi+hT5mfmZaaF8bpbn1BT3CIZdvTKbDLq
xIw7MSgymoWjk3MgovmQelTEJOOurpib+SMwZjTv4ng6wrVFIoOpVs46GvEGne1LlIebUfkZ
6Po9Gjyw+69G0J5LJgX1gm3ix3SLE8xyDZ7S4HnH1wy7+Cbt6BCBs/g2WTQraWueBk0rqoBO
mA93W4wS/Wu8H0rt0sdfqOFSTN+apiENJs9YEbGUKHOXR3FM1bZiYYyz3DQYKblvPuAvkgyC
q73DRpRuo8Lur+aLow8/utjmG8glbpXeFks6WVgQ0xL3No38rsT1SH/UjinH+7cLWEA4mVTg
bDKF3jtIRnuzDSE6WqUitHfjYS6k5A4e9pJQ6ksr6gBZtLU2JStVMAycs7BtuAzWUgsNc2XJ
hkorCSAq7iCJiFDvTkUe+R1ad0VLGgFqFBK74apzzfIgTCVzW5VyhN8p2cNnSE1wiD5ASc00
jiFY2Uc0sFsJbk5mkIciX1EkcmzXYcxNdZdEQ9bQ9a8//nL9/fT8y9v1eHk6Pxx/fjx+fzle
fqxL1kk02o5kxkqJRfLrj+By8nD+8/mn98PT4afv58PDy+n5p+vhj6PswdPDT5CB8ytMoR/1
jNocL8/H773Hw+XhqMyK2pn1Q5srvHd6PoF5++nvQ+XkUrUZSSUMPsjflGmW4qBlgIIXVRgD
Iy1sx0WqJob7wE7aJr4PyVKN7v6ixoPLXkWNmAiTO6sv2PzL+8vruXd/vhx750tPj0X76ZpY
ft6KcTNZigkeuPCQBSTQJV3EGz/ia3Pq2Bi3EMjPJNAlzc2bkRZGEjbSo8N6Jyesi/sN5y71
xrwNrGuQyhJBKvdmtiLqreBuAXzbhKkb1Qmi3gmHarX0BrNkGzuIdBvTQLd5rv46YPWHmAvb
Yi23WQeuovJVl7f87ffvp/ufvx3fe/dqkn69HF4e3525maP0KxoWuNMj9N3mQp8kzAMV+Fk/
O769PoLF6f3h9fjQC58VKxCH98/T62OPXa/n+5NCBYfXg8Ob7ydubxMwfy2PLzbo8yy+84b9
MbF4VhHkmUSaHUZ1aGQG0WDckRelmixZvoXUMp/SyMZIj19NIsKbaEf06prJ/W9X7zsL5TYI
+//V7bUFCsupYcuFCyvcGe8XwqEL/YVDF+e3DixbLoj+5ZKdj7pkX5B3CNWKD+9UNDdi2AIp
exVbJDDpR8rD9bGrYxLmTuI1BdxDH9rA3f9WdizLcduwX/Hk1M60GdvZusnBB0rirhjrFUra
Xe9Fk6Qbx5Pa8fgxk/59AVAPUgTV9JQYwFIkSIJ4kUDK6T7u8enZ/4KO35z7vySw/5F9L4jn
YwPy5uw0UeswYzasDA+u/zxZedOaJwydgnUmM/yX6ZfOk7NzLk/Swjs5QCMYto7jERoRb86X
tkJqP/w2AbE1BuxWPBrBb3xgzsDQtx85VXF6mbrRZ+/8ydtV+LlBC7h9+OoEx0ax4Z8WAOvc
SO+AKNqIvZo6bDkVdULHK79FA5y3F2Xlbq1CnrJ+pQl8NlexBTQGCrQOBoek//u64TLqLbQ/
VYmsmeGv6d8FUZCKA6MW1SKrxflp8EhgOl1LyTlsR6yu8EUyf9FwTG7kAu+aXblWzDbt4RNb
zSL6fveAuf6O7jyybJ0Jp85GvyYOJdOpt2xt4/En/goCWOpLrUPdjOm0+uP9X9/vToqXu0/H
x+G6+nCVfb6Oa9XFlWYf9BvGo6PNrJyijell8rxlg5s5fxkS7mBDhAd8r5pGaonJXbaNZ6mE
nai4vTqgFlzRM8K613TDXR9JdeFLoRFJtoEvvASjl2LfuvEF3hlux3RE1Nd5LtHeJhsdgwNT
oxayaqOsp6nbyCXb/3H6roulbtRaxRi/NsFrx7VwFddvMQa7RTy2EgxwI+mfQ8HUqSkHi0ov
tuJ4EdQG7e9KmuD1VmrTnVl82qxevJX9hTTUp5MvYMQ93d7cm8sRn78eP38D89BKc6LAWNeA
Gtd7OLQTPPbx9eWrVzOs3DeYJDMxyfu9R0FlMy9Xp+8uLA9HWSRCXzOdmfhgmosyeky9Hn05
rM38M4zoLx99evwI1vXj95fn2/ujk7eAqeSK3fqRgiMWi+BYwx1yfgvZdG2j7HBEXOrErvsK
6yWXYD3lkVNHx7iQROa3ibW4FKZv+qgZGAtH99crrfWu45SifnFe7ePUxOq0XNvbLAYLBUSI
A6KantZ2i7sFXQ660rSd24CrKcKf04PrjiAiDOxDGV3zOplFMDu6CCP0TszfOXUoYML4dp3a
dDONJLbc2KCx+ApxbPn5fQ1YiyIpc2vMTA8OqAmBXMucnUPQ4ZycunCgN4HoZp4LxZQxH75i
qeF05OFsK3huTuR3Dtiin7hwQLDNBQPp9m+52EyPpCxhOyrcw5W4WDFtiUBBhAndpLC3lmiw
DAeXIt2jo/i915m+TEAPnAbfbQ6qYhERIM5ZTHbIBYvYHwL0ZQC+8iUC4wSmBKKtyEzWj3UO
4rv2IHW2WBBBC8c3XKNosROiDYiqgzsiB+GJPZ4C36av6UnMLpMFJpm6OERgLjqe9XMxhTiR
JLpruotVpGyW55jKFGdCY75sSsrO7MfYFaqxjrTrUoPu1jIkiB1a6NDWXNve7J0qm8wx/6lP
lQqmCdWbzHDdEU1Vm4v6Cqufk8OYkz9VC4ajzcvkgy39szJy/7LF58DQzM3RibND1wjrd3jX
Coxpq928wpJl1kdV7vxdqoQSPcGOtFZEG9fnaFq65bQFPtpsHz+Id6X8eJN3dtKOn4vei81m
0M5Hd/agrRD04fH2/vmbuQh7d3y68QNClAd3RbmNjoJmwJimEKjgSInXWIQlgxM9Gx2/fwYp
PrRKNperkZu9Rue1sJp6gSWBhq4kMhPXrGzCQpn46H84SzrIhtHquv37+Pvz7V2v5jwR6WcD
f7SYZkW4yBuct2gap5JdpmsNpjUlFzqVznGuK5AheEkin10BE4mpslKHooCgjST4u6jMOD+B
yUJxb16k0Co+TKwK2E+BrJMS01ax1roqMlXwyptpG3RO1LYwmyzHKsLWGp5haORdWWTXtgym
/pWYn29SeeQgbCYd9GenY1xJYqMoBVBbN9Ms4BgoMpN2efrjzM5xnehMZavg0E3u13ww9Mj2
P04ULDl+erm5MdvQ0ophsYNSjw80simypjkk82TiDDWsvn5c7IzS58pdwdtUZEqVqi6LmViy
4V2BvpUCX/YKURykLv2OmrRPPg+pX0WZ4PUMg97yy79nOL0fTqHAMBfNssLT0g53CxiOCUNe
nnmBwmnWRhEWm5NRFHG5xXvomM0XzxdAnSo9Pe+PjZzge3svD2bZph/vbyx5iyZEi6ZGAyyy
dY26XDc+0hGF+JZxbhNWMDucOhYmxqTyFraAzVT8WJfitbsGDl6W87sPY83wQFo7P2x7PeLX
QTyUZcVJLgc/9tJB4hlVts0ErkHyJvM0bQN06xERzMt1NpQmKi2LxJfjs4WH37+SspqJR2MP
YyxmXEEnvzw93N5jfObpt5O7l+fjjyP85/j8+fXr17/aQsE0jJph28i9DIt0qyqZuxnM7/w9
qHc1n+Nr0KDn4pFZZzCeeZt9nr/xWfUaiW3z4P0BWJ0Npmm6StVuZzrEKzL/g0XTWQmTQxvP
HiEdLCAJ4TxERy5MorEZF+buysikBQr0jYTlSZ/C7s7Jxmc73VBQUoc5H2vocdEokY3vV+i4
dc6Mnt7h8fhtIKZHMrqx/pqFsH/C9ABJUCySIjDup/MzGz9w2wLJD3ZW7PAwitPpOR9AYJhT
XpMgDijxKYiprDWpLnK4YmsZPT0zO6k1vZD13qgY9qgL2SRyy5PydxdIFRjbYmnQgVDE103J
3WGjHKJ1Wxhth9jl5A0BdtBI1zNmmp+agySne0ag86GXayIxyNjd6xoo0fWF02qKjBatzYTs
Kmn41U+eUXL71bA0wiRB7FWly0jWvSLgLazpfBo2Ku39MJ2O0JZewJMRXGYlPh0QpHIM8zAZ
7BNcZkG8kYIXK9bV5DIolXtM7l7goDHhTJoW+wRUT1XHleOoNs5rQDTs05GEJhvIeheHgGDl
525gfABTAdBwV9t2fuXbxu7JpRHG472jdVbuwhQaXXpUL3KBn6GoCWFVwlcpN8wg43lhuV8t
7IVtTir0AnMwzIIZe2GSqOJcuQaFbva0JOXcqb26VqBhwNR0EUiWNBea1zSokbXSOZxxC9wz
950WBuFZy+4ipMxCikzczX4J2nUsgMcL809+h6WNQP5/tbCZ4CMB9R0w83ONLIqiS0SD3id6
fDAkt2ssDM9qUW1UC+fcIABaOCJTmwIEKlt7mIhGCktKE5OpTet5fhAkG9BEWpj9s4vccYUR
0tw5xCC2TgLWUZ9ltk2rgODDdnpFwgQl/ots9saQn//YR3Vs3Qps2hqFWVLGLQ4cNZV/AbIB
WrNy/AEA

--LQksG6bCIzRHxTLp--
