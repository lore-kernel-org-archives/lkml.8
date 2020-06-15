Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496BEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2722F20757
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RldVNBO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgFOI3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:29:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37942 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgFOI3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:29:06 -0400
Received: from zn.tnic (p200300ec2f063c00b14e1d4a79d0a94f.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:3c00:b14e:1d4a:79d0:a94f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 526601EC009F;
        Mon, 15 Jun 2020 10:29:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592209745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+ZDc66FjhtuDAnAnOt/8l34dAmv5S5LeOFfXTCUFWFI=;
        b=RldVNBO8VRbu+oPtPwxU5wt7Gy1Qcrl4QtlSmPdnavoZ/JYnQKFTroG3Zb1fUII65HtQ9A
        CoZyNrSmHxg4Xmb/x5FJe5if0/x6AnE0QOv+1FEv2a6cIk0AyNVUKAb/O6lJ+Fmz+Ddp9b
        2sOz1nCQ+2q+66cAQJlg83Qz3R8sTMw=
Date:   Mon, 15 Jun 2020 10:28:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Mark Gross <mgross@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>
Subject: Re: [PATCH] x86/speculation/srbds: do not try to turn mitigation off
 when not supported
Message-ID: <20200615082858.GC14668@zn.tnic>
References: <20200609174313.2600320-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200609174313.2600320-1-cascardo@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 02:43:13PM -0300, Thadeu Lima de Souza Cascardo wrote:
> When SRBDS is mitigated by TSX OFF, update_srbds_msr will still read and

Are you talking about this case in srbds_select_mitigation():

        if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM))
                srbds_mitigation = SRBDS_MITIGATION_TSX_OFF;

?

and you have a system which:

         * Check to see if this is one of the MDS_NO systems supporting
         * TSX that are only exposed to SRBDS when TSX is enabled.

i.e., no SRBDS microcode for it and the fix is to disable TSX?

If so, I think the right fix should be to do:

	if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
		return;

in update_srbds_msr() with a comment above it explaining why that check
is being done.

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
