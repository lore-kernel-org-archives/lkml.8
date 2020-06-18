Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A597DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735FC208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgFRSYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:24:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:27333 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgFRSYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:24:24 -0400
IronPort-SDR: gX3GxLXcdAV96PpVjpg1K0eyArS/yqVyTKihzy0QF5NxAwRESSRPte0+fLbwLK0CW8nf9UdfKP
 kolg7yc+fFfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="122446295"
X-IronPort-AV: E=Sophos;i="5.75,252,1589266800"; 
   d="scan'208";a="122446295"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 11:24:23 -0700
IronPort-SDR: QWjFFZYrpMn49XBxW79LNyP/ysuOitYYgt9ptp+2tGCYQhTM3Z5jOA8X3HSEGlm9DcJztl0PWw
 E6FQAoxnVTXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,252,1589266800"; 
   d="scan'208";a="299788705"
Received: from lkp-server02.sh.intel.com (HELO 5ce11009e457) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jun 2020 11:24:17 -0700
Received: from kbuild by 5ce11009e457 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jlzD0-0000Mc-A4; Thu, 18 Jun 2020 18:24:18 +0000
Date:   Fri, 19 Jun 2020 02:23:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     kbuild-all@lists.01.org, Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] printk: _printk_rb_static_dict can be static
Message-ID: <20200618182323.GA72993@4e49555bcca1>
References: <20200618144919.9806-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618144919.9806-4-john.ogness@linutronix.de>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 printk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7642ef634956f..d812ada06735f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -434,7 +434,7 @@ static u32 log_buf_len = __LOG_BUF_LEN;
  */
 #define PRB_AVGBITS 5	/* 32 character average length */
 
-_DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
+static _DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
 		  PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);
 
 static struct printk_ringbuffer printk_rb_dynamic;
