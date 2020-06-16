Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09304C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB81720FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgFPMZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:25:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:7700 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFPMZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:25:12 -0400
IronPort-SDR: +W2YBVb6ABaB5AD70t65jubEUjv7D3hWOg6HXX7F7PJEwZvjAeae9B56QibNNKwwdRuFXnotI1
 WN+exJfBjhYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 05:25:11 -0700
IronPort-SDR: 1bnQa6Z+nx5XOwk5MnWgETija5ju7Fp+hma9kfl2w+TDxXx95LW9d6xXMsLUpbhdFU57t3uwr/
 QXMrUFRb4DOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="476444896"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2020 05:25:10 -0700
Date:   Tue, 16 Jun 2020 20:24:52 +0800
From:   Rong Chen <rong.a.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ltp@lists.linux.it
Subject: Re: [LKP] Re: [x86/entry] 2bbc68f837: ltp.ptrace08.fail
Message-ID: <20200616122451.GQ5653@shao2-debian>
References: <20200616075533.GL5653@shao2-debian>
 <87y2onbdtb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2onbdtb.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:44:00AM +0200, Thomas Gleixner wrote:
> kernel test robot <rong.a.chen@intel.com> writes:
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: 2bbc68f8373c0631ebf137f376fbea00e8086be7 ("x86/entry: Convert Debug exception to IDTENTRY_DB")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Is the head of linux.git exposing the same problem or is this an
> intermittent failure, which only affects bisectability?
> 

Hi Thomas,

The problem still exists in v5.8-rc1:

9f58fdde95c9509a  2bbc68f8373c0631ebf137f376                    v5.8-rc1  testcase/testparams/testbox
----------------  --------------------------  --------------------------  ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |    
           :12          92%          11:12         100%          13:13    ltp/1HDD-xfs-syscalls_part4/vm-snb
           :12          92%          11:12         100%          13:13    TOTAL ltp.ptrace08.fail

Best Regards,
Rong Chen
