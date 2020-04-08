Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B6AC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D26720769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586361302;
	bh=srK23C8ykEqzmk67HFRfWIUxEO6G0UBRCN/+5bHhQT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z4ZZapuEyUs2bI2fowwRIL4hiAI0XhfrXx07o1Rj28bNR7gWGFdgA0G4ljDUGwdpB
	 vsIoMqFhGQg2E+Hs1FFs/aiLictj6v6qLQzfNrG/R81h4MrbabeYrKcCo8ArgKNxT/
	 RqjXzLqjcjPFoZp2i61BctvNjJzjU+MPPryvj/q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgDHPzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729171AbgDHPzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:55:01 -0400
Received: from linux-8ccs (p3EE2C7AC.dip0.t-ipconnect.de [62.226.199.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FE4620730;
        Wed,  8 Apr 2020 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586361300;
        bh=srK23C8ykEqzmk67HFRfWIUxEO6G0UBRCN/+5bHhQT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GbbtpXNUkUPJejI4zWCd+Dlni1tb6Lru8e+gKPjvhdBOEUiBejtk61Uss7tjOzEHF
         XnLESMVxnTVmGECD9W3SX0BKSKRaTc4MjkhmkdWq1StIOHK7yXcCKn1Ahf4wrwlNMr
         qq1pKG1kuxbJixzqTRNZf3qtW6aaja+yyQJbCNys=
Date:   Wed, 8 Apr 2020 17:54:53 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        sean.j.christopherson@intel.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kenny@panix.com,
        rasmus.villemoes@prevas.dk, pbonzini@redhat.com,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <20200408155453.GB26619@linux-8ccs>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200408092726.7c2bda01@gandalf.local.home>
 <20200408154419.GP20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200408154419.GP20730@hirez.programming.kicks-ass.net>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Peter Zijlstra [08/04/20 17:44 +0200]:
>On Wed, Apr 08, 2020 at 09:27:26AM -0400, Steven Rostedt wrote:
>> On Tue, 07 Apr 2020 13:02:40 +0200
>> Peter Zijlstra <peterz@infradead.org> wrote:
>
>> > +		if (insn_is_mov_CRn(&insn) || insn_is_mov_DRn(&insn)) {
>> > +			pr_err("Module writes to CRn or DRn, please use the proper accessors: %s\n", mod->name);
>> > +			return -ENOEXEC;
>> > +		}
>> > +
>>
>> Something like this should be done for all modules, not just out of tree
>> modules.
>
>I'm all for it; but people were worried scanning all modules was too
>expensive (I don't really believe it is, module loading just can't be a
>hot-path). Also, in-tree modules are audited a lot more than out of tree
>magic voodoo crap.

The intention of the original patches was to do the text scan to catch
a handful of out-of-tree hypervisor modules - but now that
decode_module() is being generalized to more cases, I don't mind
scanning all modules.

Thanks,

Jessica
