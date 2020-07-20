Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE3AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AED422482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgGTPaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:30:02 -0400
Received: from 8bytes.org ([81.169.241.247]:58142 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgGTPaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:30:01 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4CFC6344; Mon, 20 Jul 2020 17:29:59 +0200 (CEST)
Date:   Mon, 20 Jul 2020 17:29:55 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Joerg Roedel <jroedel@suse.de>, x86@kernel.org, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 70/75] x86/head/64: Don't call verify_cpu() on
 starting APs
Message-ID: <20200720152955.GA620@8bytes.org>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-71-joro@8bytes.org>
 <202007141837.2B93BBD78@keescook>
 <20200715092638.GJ16200@suse.de>
 <202007150815.A81E879@keescook>
 <20200715154856.GA24822@suse.de>
 <202007151244.315DCBAE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007151244.315DCBAE@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 12:49:23PM -0700, Kees Cook wrote:
> Aaah. I see. Thanks for the details there. So ... can you add a bunch
> more comments about why/when the new entry path is being used? I really
> don't want to accidentally discover some unrelated refactoring down
> the road (in months, years, unrelated to SEV, etc) starts to also skip
> verify_cpu() on Intel systems. There had been a lot of BIOSes that set
> this MSR to disable NX, and I don't want to repeat that pain: Linux must
> never start an Intel CPU with that MSR set. :P

Understood :)

I added a comment above the label explaining why it is only used for
SEV-ES guests and pointing out the importance of running verify_cpu() on
all other systems, especially if they are Intel based.

Regards,

	Joerg
