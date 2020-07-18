Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B24C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A681E20775
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGRR61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:58:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:3488 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgGRR61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:58:27 -0400
IronPort-SDR: vl+VRnOnxbBD7i9uOc/xUKNG3HdDJkTR5ZavowiFVuu//TMChjfaL79LR7YJjqMbBGplmTmJ4J
 PubqT9zHRNAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="234615165"
X-IronPort-AV: E=Sophos;i="5.75,368,1589266800"; 
   d="scan'208";a="234615165"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 10:58:26 -0700
IronPort-SDR: noNeAW6WZyC/PdsOfTPfAaMBnEkpJPAcQ24OcQAkfjArxFlJesDf5IfzdT5b1bNdBBQO7lgOyb
 vC2UZJHoXrjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,368,1589266800"; 
   d="scan'208";a="271069266"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2020 10:58:26 -0700
Message-ID: <c2bfe1aa390777b10d810d2b76a35b97fbd32a1c.camel@intel.com>
Subject: Random shadow stack pointer corruption
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Sat, 18 Jul 2020 10:57:27 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My shadow stack tests start to have random shadow stack pointer corruption after
v5.7 (excluding).  The symptom looks like some locking issue or the kernel is
confused about which CPU a task is on.  In later tip/master, this can be
triggered by creating two tasks and each does continuous
pthread_create()/pthread_join().  If the kernel has max_cpus=1, the issue goes
away.  I also checked XSAVES/XRSTORS, but this does not seem to be an issue
coming from there.

The tests I run take a long time to complete, and some commit points in bisect
do not show failures right away.  However, the issue can be more easily
triggered after the point of:

d77290507ab2 x86/entry/32: Convert IRET exception to IDTENTRY_SW

Can anyone help me find places to look at?

Thanks,
Yu-cheng

