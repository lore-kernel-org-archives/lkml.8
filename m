Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83465C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 22:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F39206F6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 22:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgHAWTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 18:19:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:25562 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgHAWTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 18:19:03 -0400
IronPort-SDR: Zok2cQw0IxrpJfOn/o2Tj3yDs2W4yBzstLcVYlxY6JqrtN1z6Jk39Frq2vnMAqIsK0wyevd0iB
 LYiV7I372eyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="149766141"
X-IronPort-AV: E=Sophos;i="5.75,424,1589266800"; 
   d="scan'208";a="149766141"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2020 15:18:57 -0700
IronPort-SDR: rauja/wBQiesmbmRGdJWhFcR7VDtT8zjRPNNpoJpShgj4RamFHZT3oCIcntDUiNCQQUCnATDfI
 9BGmpi3jKNaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,424,1589266800"; 
   d="scan'208";a="321805504"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Aug 2020 15:18:55 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1zqA-0001Q4-Nc; Sat, 01 Aug 2020 22:18:54 +0000
Date:   Sun, 2 Aug 2020 06:18:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johnny Chuang <johnny.chuang@emc.com.tw>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Subject: drivers/input/touchscreen/elants_i2c.c:859:45: warning: Clarify
 calculation precedence for '&' and
Message-ID: <202008020615.7WF7Tnj9%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d52daa8620c65960e1ef882adc1f92061326bd7a
commit: f27ad8932725f8dd0cd1a46763de4a40377b1ae6 Input: elants_i2c - support palm detection
date:   4 months ago
compiler: xtensa-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/input/touchscreen/elants_i2c.c:859:45: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
    tool_type = buf[FW_POS_TOOL_TYPE] & BIT(0) ?
                                               ^

vim +859 drivers/input/touchscreen/elants_i2c.c

   838	
   839	/*
   840	 * Event reporting.
   841	 */
   842	
   843	static void elants_i2c_mt_event(struct elants_data *ts, u8 *buf)
   844	{
   845		struct input_dev *input = ts->input;
   846		unsigned int n_fingers;
   847		unsigned int tool_type;
   848		u16 finger_state;
   849		int i;
   850	
   851		n_fingers = buf[FW_POS_STATE + 1] & 0x0f;
   852		finger_state = ((buf[FW_POS_STATE + 1] & 0x30) << 4) |
   853				buf[FW_POS_STATE];
   854	
   855		dev_dbg(&ts->client->dev,
   856			"n_fingers: %u, state: %04x\n",  n_fingers, finger_state);
   857	
   858		/* Note: all fingers have the same tool type */
 > 859		tool_type = buf[FW_POS_TOOL_TYPE] & BIT(0) ?
   860				MT_TOOL_FINGER : MT_TOOL_PALM;
   861	
   862		for (i = 0; i < MAX_CONTACT_NUM && n_fingers; i++) {
   863			if (finger_state & 1) {
   864				unsigned int x, y, p, w;
   865				u8 *pos;
   866	
   867				pos = &buf[FW_POS_XY + i * 3];
   868				x = (((u16)pos[0] & 0xf0) << 4) | pos[1];
   869				y = (((u16)pos[0] & 0x0f) << 8) | pos[2];
   870				p = buf[FW_POS_PRESSURE + i];
   871				w = buf[FW_POS_WIDTH + i];
   872	
   873				dev_dbg(&ts->client->dev, "i=%d x=%d y=%d p=%d w=%d\n",
   874					i, x, y, p, w);
   875	
   876				input_mt_slot(input, i);
   877				input_mt_report_slot_state(input, tool_type, true);
   878				input_event(input, EV_ABS, ABS_MT_POSITION_X, x);
   879				input_event(input, EV_ABS, ABS_MT_POSITION_Y, y);
   880				input_event(input, EV_ABS, ABS_MT_PRESSURE, p);
   881				input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, w);
   882	
   883				n_fingers--;
   884			}
   885	
   886			finger_state >>= 1;
   887		}
   888	
   889		input_mt_sync_frame(input);
   890		input_sync(input);
   891	}
   892	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
