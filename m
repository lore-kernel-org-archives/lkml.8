Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C614C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A302223C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TFHquLUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgDQPIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:08:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33090 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgDQPIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:08:14 -0400
Received: from zn.tnic (p200300EC2F0DA8006521B90827ED3880.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:a800:6521:b908:27ed:3880])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B14561EC0CEA;
        Fri, 17 Apr 2020 17:08:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587136092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2zxRtAJv0oK4YmMaMhg1+TfTVEX2L2HVb0TUn9eAlBg=;
        b=TFHquLUXOy13gJaCTXHadFj1fP60HW9igsdtiJQzpswguPpzNGf2/fuK3me+2SQL237Qow
        0qYYFY40eneXariYSHfRxe7wVi1eRP4+KyZuu8qF6wV5HWLumxK/eS+BkeVMEwgdsd7GVf
        Ab4qDVSUw3Rhijne9OjaU+jLgmDQ9Lc=
Date:   Fri, 17 Apr 2020 17:08:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: microcode: fix return value for microcode late
 loading
Message-ID: <20200417150808.GE7322@zn.tnic>
References: <1586858135-29337-1-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1586858135-29337-1-git-send-email-mihai.carabas@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:55:35PM +0300, Mihai Carabas wrote:
> The return value from stop_machine might not be consistent.
> 
> stop_machine_cpuslocked returns:
> - zero if all functions have returned 0
> - a non-zero value if at least one of the functions returned
> a non-zero value
> 
> There is no way to know if it is negative or positive. So make
> __reload_late return 0 on success, or negative otherwise.
> 
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>  arch/x86/kernel/cpu/microcode/core.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 7019d4b..336003e 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -545,8 +545,7 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
>  /*
>   * Returns:
>   * < 0 - on error
> - *   0 - no update done
> - *   1 - microcode was updated
> + *   0 - success (no update done or microcode was updated)
>   */
>  static int __reload_late(void *info)
>  {
> @@ -573,11 +572,9 @@ static int __reload_late(void *info)
>  	else
>  		goto wait_for_siblings;
>  
> -	if (err > UCODE_NFOUND) {
> +	if (err >= UCODE_NFOUND) {

It is not an error if no microcode was found.

>  		pr_warn("Error reloading microcode on CPU %d\n", cpu);
			^^^^^^^^^^

>  		ret = -1;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
