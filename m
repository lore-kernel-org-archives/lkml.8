Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771BCC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB582072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="CtTyW0QW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgCMS2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:28:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51062 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgCMS2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:28:14 -0400
Received: from zn.tnic (p200300EC2F0E1E007CE2C412F47CBB57.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:1e00:7ce2:c412:f47c:bb57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A39751EC0CFA;
        Fri, 13 Mar 2020 19:28:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584124091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=af9vjc4SquL5k1ASGpNOj3EgxDCubcDdq9ji+QbhQt8=;
        b=CtTyW0QWLBk9PH5U05eB/gbz26N5Km1JMuXqil5w11lS+K/n2AUvagxumMPHyeRE7UU54k
        +P31fVn6rZ3fG/GD7YqR12zjfVFXPdcICphsaNYMnMOFqAma+VMHvIZPWh/NVnhR2QbnHs
        EgrK8qc6K3cKHG1Gagyk5uKFb1JvcSM=
Date:   Fri, 13 Mar 2020 19:28:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] x86/purgatory: Disable various profiling and
 sanitizing options
Message-ID: <20200313182815.GF8142@zn.tnic>
References: <20200312114951.56009-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312114951.56009-1-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 12:49:50PM +0100, Hans de Goede wrote:
> Since the purgatory is a special stand-alone binary, we need to disable

Pls use passive voice in your commit message: no "we" or "I", etc, and
describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

> various profiling and sanitizing options. Having these options enabled
> typically will cause dependency on various special symbols exported by
> special libs / stubs used by these frameworks. Since the purgatory is
> special we do not link against these stubs causing missing symbols in
> the purgatory if we do not disable these options.
> 
> This commit syncs the set of disabled profiling and sanitizing options

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

Those two review comments apply to patch 2's commit message too, pls fix
them there too.

> with that from drivers/firmware/efi/libstub/Makefile, adding
> -DDISABLE_BRANCH_PROFILING to the CFLAGS and setting:
> 
> GCOV_PROFILE                    := n
> UBSAN_SANITIZE                  := n
> 
> This fixes broken references to ftrace_likely_update when
> CONFIG_TRACE_BRANCH_PROFILING is enabled and to __gcov_init and
> __gcov_exit when CONFIG_GCOV_KERNEL is enabled.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v5:
> -Not only add -DDISABLE_BRANCH_PROFILING to the CFLAGS but also set:
>  GCOV_PROFILE                    := n
>  UBSAN_SANITIZE                  := n
> 
> Changes in v4:
> -This is a new patch in v4 of this series
> ---
>  arch/x86/purgatory/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

$ test-apply.sh -g /tmp/01-x86-purgatory-disable_various_profiling_and_sanitizing_options.patch
checking file arch/x86/purgatory/Makefile
Hunk #1 FAILED at 17.
Hunk #2 succeeded at 27 (offset 2 lines).
1 out of 2 hunks FAILED

This happens because tip/master already has KCSAN merged in and it adds

KCSAN_SANITIZE  := n

there.

Please redo the patches against current tip/master.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
