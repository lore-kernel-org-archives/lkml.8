Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA5BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE9D20707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgFOK1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:27:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34781 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgFOK1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:27:47 -0400
Received: from 200-158-207-52.dsl.telesp.net.br ([200.158.207.52] helo=mussarela)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1jkmLA-0003OU-NJ; Mon, 15 Jun 2020 10:27:45 +0000
Date:   Mon, 15 Jun 2020 07:27:38 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Mark Gross <mgross@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>
Subject: Re: [PATCH] x86/speculation/srbds: do not try to turn mitigation off
 when not supported
Message-ID: <20200615102738.GZ4342@mussarela>
References: <20200609174313.2600320-1-cascardo@canonical.com>
 <20200615082858.GC14668@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615082858.GC14668@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:28:58AM +0200, Borislav Petkov wrote:
> On Tue, Jun 09, 2020 at 02:43:13PM -0300, Thadeu Lima de Souza Cascardo wrote:
> > When SRBDS is mitigated by TSX OFF, update_srbds_msr will still read and
> 
> Are you talking about this case in srbds_select_mitigation():
> 
>         if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM))
>                 srbds_mitigation = SRBDS_MITIGATION_TSX_OFF;
> 
> ?
> 

That's the case that it hits, correct.

> and you have a system which:
> 
>          * Check to see if this is one of the MDS_NO systems supporting
>          * TSX that are only exposed to SRBDS when TSX is enabled.
> 
> i.e., no SRBDS microcode for it and the fix is to disable TSX?

It was booted without the microcode update. There was microcode available, but
systems may be booted without it, thus causing warnings due to the MSR
read/write.

> 
> If so, I think the right fix should be to do:
> 
> 	if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
> 		return;
> 
> in update_srbds_msr() with a comment above it explaining why that check
> is being done.

That's exactly the fix in the patch I sent, right? Do you want me to resend
with a comment, then?

Thanks.
Cascardo.

> 
> Hmmm.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
