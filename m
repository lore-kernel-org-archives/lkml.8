Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62956C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D282086A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgEZNdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:33:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:57902 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgEZNdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:33:05 -0400
IronPort-SDR: 2n4cEgzIrKD/tRQdzkPQyXUsonBWUj0HbfBOpfXNFMzBZKGQAotUOP/Le4A7x8bZHTy7mnOEgY
 OBKwcDP3CNYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 06:33:04 -0700
IronPort-SDR: zaMEbV0489KP+M6dd6VhdAyfyz8b7DBMVGuds/ebfJytRH1kWPI/zXLSawIKTODnr5y+SDuU6V
 8iBtSShzgBow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="310256423"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 26 May 2020 06:33:04 -0700
Date:   Tue, 26 May 2020 06:33:18 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Andreas Rammhold <andi@notmuch.email>
Cc:     Brendan Shanks <bshanks@codeweavers.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT
 instruction
Message-ID: <20200526133318.GA3796@ranerica-svr.sc.intel.com>
References: <20200519143815.cpsd2xfx2kl3khsq@wrt>
 <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
 <20200519194320.GA25138@ranerica-svr.sc.intel.com>
 <20200523021739.bbq5m6ze63ctouh6@wrt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523021739.bbq5m6ze63ctouh6@wrt>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 04:17:39AM +0200, Andreas Rammhold wrote:
> On 12:43 19.05.20, Ricardo Neri wrote:
> > I have a patch for this already that I wrote for testing purposes:
> > https://github.com/ricardon/tip/commit/1692889cb3f8accb523d44b682458e234b93be50
> > Perhaps it can be used as a starting point? Not sure what the spoofing
> > value should be, though. Perhaps 0?
> 
> I tried the above patch (in modified/rebased version; hope that didn't
> kill it [0]). The results are negative, as without the patch.

Ah. My patch above is based on a rather old kernel. There is a check in
fixup_umip_exception() for SLDT and STR. I think this causes the
exception you see. Perhaps you can try by removing such check:

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
@@ -383,10 +389,6 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	umip_pr_warn(regs, "%s instruction cannot be used by applications.\n",
 			umip_insns[umip_inst]);

-	/* Do not emulate (spoof) SLDT or STR. */
-	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT)
-		return false;
-
	umip_pr_warn(regs, "For now, expensive software emulation returns the result.\n");

	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,

You would still need my old patch.

Thanks and BR,
Ricardo
