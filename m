Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEB7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E1E20675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgC3O0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:26:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:5350 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbgC3O0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:26:49 -0400
IronPort-SDR: pIwhlMxOFcOkJiIjBqvs8iBEsT+b28YAH9fOJVqJts3uOo/MyESZ4+xErYIm/8wFY12oFK1q9g
 RiCN20+wuIQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 07:26:48 -0700
IronPort-SDR: JUIupGuoPUqfVrfkZhq8vYZWzlbWTiZaIArhKr1LpSB5A3ivl6KThUNC17TPkaXGHFPtr3BTKL
 iLxxQpfrarJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; 
   d="scan'208";a="421941906"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2020 07:26:48 -0700
Date:   Mon, 30 Mar 2020 07:26:48 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v7 1/2] x86/split_lock: Rework the initialization flow of
 split lock detection
Message-ID: <20200330142648.GA24988@linux.intel.com>
References: <20200325030924.132881-1-xiaoyao.li@intel.com>
 <20200325030924.132881-2-xiaoyao.li@intel.com>
 <20200328163201.GI8104@linux.intel.com>
 <9db4acdc-add6-f63c-fb5c-654cb429b578@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9db4acdc-add6-f63c-fb5c-654cb429b578@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 09:26:25PM +0800, Xiaoyao Li wrote:
> On 3/29/2020 12:32 AM, Sean Christopherson wrote:
> >On Wed, Mar 25, 2020 at 11:09:23AM +0800, Xiaoyao Li wrote:
> >>  static void split_lock_init(void)
> >>  {
> >>-	if (sld_state == sld_off)
> >>-		return;
> >>-
> >>-	if (__sld_msr_set(true))
> >>-		return;
> >>-
> >>-	/*
> >>-	 * If this is anything other than the boot-cpu, you've done
> >>-	 * funny things and you get to keep whatever pieces.
> >>-	 */
> >>-	pr_warn("MSR fail -- disabled\n");
> >>-	sld_state = sld_off;
> >>+	split_lock_verify_msr(sld_state != sld_off);
> >
> >I think it'd be worth a WARN_ON() if this fails with sld_state != off.  If
> >the WRMSR fails, then presumably SLD is off when it's expected to be on.
> >The implied WARN on the unsafe WRMSR in sld_update_msr() won't fire unless
> >a task generates an #AC on a non-buggy core and then gets migrated to the
> >buggy core.  Even if the WARNs are redundant, if something is wrong it'd be
> >a lot easier for a user to triage/debug if there is a WARN in boot as
> >opposed to a runtime WARN that requires a misbehaving application and
> >scheduler behavior.
> >
> 
> IIUC, you're recommending something like below?
> 
>         WARN_ON(!split_lock_verify_msr(sld_state != sld_off) &&
> 		sld_state != sld_off);

Ya.
