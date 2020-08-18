Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF11C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5987920709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597728697;
	bh=LKJAZtd9P564VUG8gtnO3BFeuzDLPZMgDh7ubxEcUzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HzoShegB8naE8tVCx9KFLrcyM2/MhFzZt3mdy1Pvs3erzwiAW5GHL4M2Ac23o49vS
	 BOcwPB9LWG5Bnhh9BZ22e4Nl/LzQiA/AX7GLMxz3CQb3Fm29ahB8zP80+3oR2zc2SA
	 s6Sn2+8jModDVOZ4YHOqMGHCAhUUsYLi87Q05Ivo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHRFbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRFbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:31:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4A8C061389;
        Mon, 17 Aug 2020 22:31:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id jp10so20587920ejb.0;
        Mon, 17 Aug 2020 22:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ChmhumhWJU1XQvt57mk+v+sw0rrMe14Xi0/RZhUp6hU=;
        b=X97+snzQcS/KUjTBcIjGcFrtPtkarbXeWX31ymjYaEYuUW4LUcTV4fXOzFTBIzsxr7
         L/huM9JBOXzVKuTLCMHGsJjXS0B8chr0aMZdeleegPK+osn4krecxiHD5dWZL92wE/dm
         0shGB0dpsDSBf7wQAutaIpq6Ep5m4YVn7UrnklRNzqLEgW217ardQoSt2iEiupHXvJjH
         a0c/rKl29mB27HFtQqu7Y+QYDSa7s3KuWUveI2cSWjzOmk5OPdQRBPKrt9E9BxoMJ1Ut
         lPET24VzydtKUAwOvenAMFdJODBdVDEonO4Ji6kT1rMNd1EEnGNHfulwkBfwm5xB7i2y
         qvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ChmhumhWJU1XQvt57mk+v+sw0rrMe14Xi0/RZhUp6hU=;
        b=QTvjrwA72oKdxkqnyefji8tJK5P5y9gea9AOT45yXkagiMnjungZBVuwnAqxgxNLQS
         QsMNdvDvme32QxEmyMvldX+m8OukgjLTWZBUkzjJ/H24JL++822HgofxTN/IRW/DqrTn
         8e1QC3cyCpB0zjjESp6i2hadGgDW8vPYt1E6RH8z5EUPsSEAXrl5wkKUt4jPLVoehdqU
         xMc4uSHMBkJjjOq74TvvZiwOD7bH16sl7h6X60VyQ6crD+EgsdxiPL62/zGYspwfnMBb
         uG20J52k5XSIf1MZe5Bixq17yeiM1vPftelo4TIxLmSvI7QpfS51Fj7wWEnVHCDCho1P
         x5AQ==
X-Gm-Message-State: AOAM532aOsZ8riubQ6rbbW3Hxi7J/C0EZyQeu+nSghzATn2H6fID/YH8
        o9g62evh5mgkB4Z0ujtCTnRVBf5qnxI=
X-Google-Smtp-Source: ABdhPJx3JLYhoUan01ju2xlfkyp1/L54Wo8wK2Lc4WK0ROMclsqaffqRP6SXyzUAYFWA35FPm9t2+A==
X-Received: by 2002:a17:906:1d56:: with SMTP id o22mr10980122ejh.530.1597728692911;
        Mon, 17 Aug 2020 22:31:32 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a26sm15470368eju.83.2020.08.17.22.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 22:31:32 -0700 (PDT)
Date:   Tue, 18 Aug 2020 07:31:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>
Subject: [PATCH] x86/cpu: Fix typos and improve the comments in sync_core()
Message-ID: <20200818053130.GA3161093@gmail.com>
References: <20200807032833.17484-1-ricardo.neri-calderon@linux.intel.com>
 <159767927411.3192.1923111080573965673.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159767927411.3192.1923111080573965673.tip-bot2@tip-bot2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Ricardo Neri <tip-bot2@linutronix.de> wrote:

> --- a/arch/x86/include/asm/sync_core.h
> +++ b/arch/x86/include/asm/sync_core.h
> @@ -5,6 +5,7 @@
>  #include <linux/preempt.h>
>  #include <asm/processor.h>
>  #include <asm/cpufeature.h>
> +#include <asm/special_insns.h>
>  
>  #ifdef CONFIG_X86_32
>  static inline void iret_to_self(void)
> @@ -54,14 +55,23 @@ static inline void iret_to_self(void)
>  static inline void sync_core(void)
>  {
>  	/*
> +	 * The SERIALIZE instruction is the most straightforward way to
> +	 * do this but it not universally available.
> +	 */
> +	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
> +		serialize();
> +		return;
> +	}
> +
> +	/*
> +	 * For all other processors, there are quite a few ways to do this.
> +	 * IRET-to-self is nice because it works on every CPU, at any CPL
> +	 * (so it's compatible with paravirtualization), and it never exits
> +	 * to a hypervisor. The only down sides are that it's a bit slow
> +	 * (it seems to be a bit more than 2x slower than the fastest
> +	 * options) and that it unmasks NMIs.  The "push %cs" is needed
> +	 * because, in paravirtual environments, __KERNEL_CS may not be a
> +	 * valid CS value when we do IRET directly.

So there's two typos in the new comments, there are at least two 
misapplied commas, it departs from existing style, and there's a typo 
in the existing comments as well.

Also, before this patch the 'compiler barrier' comment was valid for 
the whole function (there was no branching), but after this patch it 
reads of it was only valid for the legacy IRET-to-self branch.

Which together broke my detector and triggered a bit of compulsive 
bike-shed painting. ;-) See the resulting patch below.

Thanks,

	Ingo

================>
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 18 Aug 2020 07:24:05 +0200
Subject: [PATCH] x86/cpu: Fix typos and improve the comments in sync_core()

- Fix typos.

- Move the compiler barrier comment to the top, because it's valid for the
  whole function, not just the legacy branch.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/sync_core.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index 4631c0f969d4..0fd4a9dfb29c 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -47,16 +47,19 @@ static inline void iret_to_self(void)
  *
  *  b) Text was modified on a different CPU, may subsequently be
  *     executed on this CPU, and you want to make sure the new version
- *     gets executed.  This generally means you're calling this in a IPI.
+ *     gets executed.  This generally means you're calling this in an IPI.
  *
  * If you're calling this for a different reason, you're probably doing
  * it wrong.
+ *
+ * Like all of Linux's memory ordering operations, this is a
+ * compiler barrier as well.
  */
 static inline void sync_core(void)
 {
 	/*
 	 * The SERIALIZE instruction is the most straightforward way to
-	 * do this but it not universally available.
+	 * do this, but it is not universally available.
 	 */
 	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
 		serialize();
@@ -67,10 +70,10 @@ static inline void sync_core(void)
 	 * For all other processors, there are quite a few ways to do this.
 	 * IRET-to-self is nice because it works on every CPU, at any CPL
 	 * (so it's compatible with paravirtualization), and it never exits
-	 * to a hypervisor. The only down sides are that it's a bit slow
+	 * to a hypervisor.  The only downsides are that it's a bit slow
 	 * (it seems to be a bit more than 2x slower than the fastest
-	 * options) and that it unmasks NMIs.  The "push %cs" is needed
-	 * because, in paravirtual environments, __KERNEL_CS may not be a
+	 * options) and that it unmasks NMIs.  The "push %cs" is needed,
+	 * because in paravirtual environments __KERNEL_CS may not be a
 	 * valid CS value when we do IRET directly.
 	 *
 	 * In case NMI unmasking or performance ever becomes a problem,
@@ -81,9 +84,6 @@ static inline void sync_core(void)
 	 * CPUID is the conventional way, but it's nasty: it doesn't
 	 * exist on some 486-like CPUs, and it usually exits to a
 	 * hypervisor.
-	 *
-	 * Like all of Linux's memory ordering operations, this is a
-	 * compiler barrier as well.
 	 */
 	iret_to_self();
 }
