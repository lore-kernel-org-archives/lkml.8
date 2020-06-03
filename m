Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A96C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C2B2068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgFCHZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:25:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:26390 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgFCHZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:25:06 -0400
IronPort-SDR: nkx1eByMNaAlcvMMV64V4GqvueuHomsdKe+RO2GDUIZNo4a8Y5zoB0Xz94d/EEmpsUfc9vi6in
 G5VlInMZjbZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 00:25:06 -0700
IronPort-SDR: J6E6tqn8ZfzzwkdltOBoLoLv+Z2KT3pbtxe8fgeneSmxipHcbjCy0gXQTvcXXwPTOy/Ec50CoA
 kpz3n9x/DasA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="304506658"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga008.jf.intel.com with ESMTP; 03 Jun 2020 00:25:04 -0700
Date:   Wed, 3 Jun 2020 15:24:13 +0800
From:   Philip Li <philip.li@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org,
        lkp@lists.01.org, kernel test robot <lkp@intel.com>
Subject: [0-Day CI notification] kbuild test robot will be combined with
 kernel test robot
Message-ID: <20200603072413.GA29050@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, this is Philip who maintains the 0-Day CI test service. Thanks for
subscribing to the service. It has been a long time we use both kbuild test
robot and kernel test robot to send out report. From now on, we want to
combine two mails to kernel test robot, which is a single voice for the
whole service. Sorry for any inconvenience caused by this change, which may
impact your mail setting.

Meanwhile, we have mail address lkp@intel.com for you to reach us. Kindly
drop us mail at kernel test robot <lkp@intel.com> or submit issue at
https://github.com/intel/lkp-tests for any question and support you need.

Thanks
