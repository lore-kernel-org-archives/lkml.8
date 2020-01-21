Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7D1C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B9E24654
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Z6icbBGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAULdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:33:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57976 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgAULdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:33:25 -0500
Received: from zn.tnic (p200300EC2F0B0400D59E977D8F003815.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:400:d59e:977d:8f00:3815])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 008791EC0CDF;
        Tue, 21 Jan 2020 12:33:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579606404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J6F93+LsImtFtzVA+R6J81QBkEV14BOR4MTybNBm7XQ=;
        b=Z6icbBGVtkuf+ecXMCU+0qwQRFabuAUEH8giGTDkFz/48jyTHrvTXJIcUv7z+waDPP6xka
        ZGwSTTQ4yl24R6CvmRO9xKhQ+UdS6JphHhyBXLGbr2gWSSF1FumIBhPczw9xoq7Lcbj5/5
        1lHnrIpj4mMozjcF6y5hSsjf78AU0Jw=
Date:   Tue, 21 Jan 2020 12:33:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Anthony Steinhauser <asteinhauser@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] Return ENXIO instead of EPERM when speculation control
 is unimplemented
Message-ID: <20200121113317.GH7808@zn.tnic>
References: <20191229164830.62144-1-asteinhauser@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191229164830.62144-1-asteinhauser@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 08:48:30AM -0800, Anthony Steinhauser wrote:
> @@ -602,7 +603,7 @@ spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
>  static void __init
>  spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
>  {
> -	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
> +	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_UNAVAILABLE;
>  	bool smt_possible = IS_ENABLED(CONFIG_SMP);
>  	enum spectre_v2_user_cmd cmd;

So here in the code, right under this line we check IBPB and STIBP and
whether SMT is force_disabled/possible and set smt_possible if not. We
parse cmdline, pick apart selection, etc...

> @@ -616,6 +617,7 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
>  	cmd = spectre_v2_parse_user_cmdline(v2_cmd);
>  	switch (cmd) {
>  	case SPECTRE_V2_USER_CMD_NONE:
> +		mode = SPECTRE_V2_USER_DISABLED;
>  		goto set_mode;
>  	case SPECTRE_V2_USER_CMD_FORCE:
>  		mode = SPECTRE_V2_USER_STRICT;
> @@ -676,7 +678,7 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
>  	 * mode.
>  	 */
>  	if (!smt_possible || !boot_cpu_has(X86_FEATURE_STIBP))
> -		mode = SPECTRE_V2_USER_NONE;
> +		mode = SPECTRE_V2_USER_UNAVAILABLE;

... but here we do that evaluation again. But I think that *if* the
required hw support is not there - either SMT is not possible or STIBP
not present - then there's no real need to parse the cmdline and do all
that.

IOW, the filtering out of the cases where the user can't do any changes
due to not present hw should be concentrated at the function entry and
mode left at SPECTRE_V2_USER_UNAVAILABLE.

IOW 2, unless I'm not missing some of the gazillion use cases with this
;-\ I think that check needs to be moved up and integrated into the
entry checks. I.e., this ontop or a separate patch...:

---
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2e9299816530..ffe5e4fa4611 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -618,8 +618,10 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 		return;
 
 	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
-	    cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+	    cpu_smt_control == CPU_SMT_NOT_SUPPORTED) {
 		smt_possible = false;
+		return;
+	}
 
 	cmd = spectre_v2_parse_user_cmdline(v2_cmd);
 	switch (cmd) {
@@ -679,13 +681,6 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	/* If enhanced IBRS is enabled no STIBP required */
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return;
-
-	/*
-	 * If SMT is not possible or STIBP is not available clear the STIBP
-	 * mode.
-	 */
-	if (!smt_possible || !boot_cpu_has(X86_FEATURE_STIBP))
-		mode = SPECTRE_V2_USER_UNAVAILABLE;
 set_mode:
 	spectre_v2_user = mode;
 	/* Only print the STIBP mode when SMT possible */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
