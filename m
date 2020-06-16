Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D32EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232B7206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgFPBvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:51:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:18586 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgFPBvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:51:32 -0400
IronPort-SDR: Iog+5KIJ7x7HcREwl57FJ6AWPpylwiXjMeEm8xrRrCdC1MrSI31ReS+GBQTVqbKY+7Jb+hHj7O
 lazIXsh81a0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 18:51:31 -0700
IronPort-SDR: MhTL47sbS+pRc/kLZQKHQ0AQ/M0ggkjhNBL+Z0Cal3rc4x4rO0tukFSHpVcJA3lhdBbyc3DpB6
 i/ucjTf5/PWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,517,1583222400"; 
   d="scan'208";a="276757754"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2020 18:51:31 -0700
Date:   Mon, 15 Jun 2020 18:51:31 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3] x86/split_lock: Sanitize userspace and guest error
 output
Message-ID: <20200616015131.GA26491@linux.intel.com>
References: <20200615113900.35697-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615113900.35697-1-prarit@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 07:39:00AM -0400, Prarit Bhargava wrote:
> There are two problems with kernel messages in fatal mode that were found
> during testing of guests and userspace programs.
> 
> The first is that no kernel message is output when the split lock detector
> is triggered with a userspace program.  As a result the userspace process
> dies from receiving SIGBUS with no indication to the user of what caused
> the process to die.
> 
> The second problem is that only the first triggering guest causes a kernel
> message to be output because the message is output with pr_warn_once().
> This also results in a loss of information to the user.
> 
> While fixing these I noticed that the same message was being output
> three times so I'm cleaning that up too.
> 
> Fix fatal mode output, and use consistent messages for fatal and
> warn modes for both userspace and guests.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

This needs a Co-developed-by for me, and your SOB should come last, e.g.

  Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com> 
  Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
  Signed-off-by: Prarit Bhargava <prarit@redhat.com>

See "12) When to use Acked-by:, Cc:, and Co-developed-by:" in
Documentation/process/submitting-patches.rst for more details.
