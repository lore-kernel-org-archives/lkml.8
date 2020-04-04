Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0B9C4332B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 16:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70FD206D4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 16:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgDDQHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 12:07:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:16443 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgDDQHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 12:07:18 -0400
IronPort-SDR: 8fksCJ8UzkTv2A0tHlmruJnrxTM+cnTIcU59geqnqMTQPkLX0rrzEnKG2igob6FlRxKCv4XqnI
 toH7DYGdW/hA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2020 09:07:18 -0700
IronPort-SDR: RDUjI/AWXs+vqYRceXyu3tD+Vj42RLCvdbXtx5gM8WJysEA8L/R++VxcxN3mbl+Yz+acGAncdm
 5cNzwuGOPM/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,344,1580803200"; 
   d="scan'208";a="397049186"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Apr 2020 09:07:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKlKF-0008h4-9Y; Sun, 05 Apr 2020 00:07:15 +0800
Date:   Sun, 5 Apr 2020 00:07:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     vladimir.stankovic@displaylink.com
Cc:     kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: Re: [PATCH v4 7/8] usb: mausb_host: MA-USB PAL events processing
Message-ID: <202004050038.meqL6HAk%lkp@intel.com>
References: <20200327152614.26833-8-vladimir.stankovic@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327152614.26833-8-vladimir.stankovic@displaylink.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on balbi-usb/next peter.chen-usb/ci-for-usb-next linus/master linux/master v5.6 next-20200403]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/vladimir-stankovic-displaylink-com/Add-MA-USB-Host-driver/20200328-042436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/usb/mausb_host/utils.c:209:1-18: ERROR: nested lock+irqsave that reuses flags from line 201.
--
>> drivers/usb/mausb_host/hpal_events.c:86:46-49: ERROR: reference preceded by free on line 85

vim +209 drivers/usb/mausb_host/utils.c

   182	
   183	static ssize_t mausb_file_write(struct file *filp, const char __user *buffer,
   184					size_t size, loff_t *offset)
   185	{
   186		ssize_t num_of_bytes_to_write =
   187					sizeof(struct mausb_events_notification);
   188		struct mausb_events_notification notification;
   189		unsigned long flags;
   190		struct mausb_device *dev;
   191	
   192		if (size != (size_t)num_of_bytes_to_write) {
   193			mausb_pr_alert("Different expected bytes to write (%ld) from actual size (%ld)",
   194				       num_of_bytes_to_write, size);
   195			return MAUSB_DRIVER_WRITE_ERROR;
   196		}
   197	
   198		if (copy_from_user(&notification, buffer, size))
   199			return MAUSB_DRIVER_WRITE_ERROR;
   200	
 > 201		spin_lock_irqsave(&mss.lock, flags);
   202		dev = mausb_get_dev_from_addr_unsafe(notification.madev_addr);
   203	
   204		if (!dev) {
   205			spin_unlock_irqrestore(&mss.lock, flags);
   206			return 0;
   207		}
   208	
 > 209		spin_lock_irqsave(&dev->num_of_user_events_lock, flags);
   210		dev->num_of_user_events += notification.num_of_events;
   211		dev->num_of_completed_events += notification.num_of_completed_events;
   212		spin_unlock_irqrestore(&dev->num_of_user_events_lock, flags);
   213	
   214		queue_work(dev->workq, &dev->work);
   215		spin_unlock_irqrestore(&mss.lock, flags);
   216	
   217		return num_of_bytes_to_write;
   218	}
   219	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
