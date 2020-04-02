Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4963CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1773B2074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585821093;
	bh=H/Tb0rCKSnj/WD1eFxXduZP+zX3vYOPOdbSTaK9kuQI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bKI6npwGJbeLnS322eGr3oULKZwWMIBPzEQB7siY73uwn7BknOwwUQNyfTicciIXH
	 zH2Or3QCWOQK0uYDkHxICeJLX87NGnWA5t74WRCRQQMK9jkd/YzGTEa0a69xJqRg2B
	 FSi+eSHqv2P5kPQwBtefkUwSKjlGStDE5IUtPWcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbgDBJvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:51:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36422 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387726AbgDBJvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:51:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id d202so2921949wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kf/imtJJqyKKJyxPBOWh8dG0fjVra/5NYi0kTur39HM=;
        b=VCdO2HtZrniws3amVSmgXsnjuBF/KI9QxWQ+VKmb+UjZ5V+Lh8YqGNXRNQgXrFu368
         WGZ6A4VypTILtdeAsTJqTM56Jel1acVJoPGh+bakcRCcIy+5q5GnCSHVu1aKYNO2YpEO
         WyFc1AYZbb7TzVTksL1Drbzln/HLlZo0dmgSnoEZ7RcZ/xBk7vFZ0hFWCacZq3yJNv5N
         ezaMkBWolq898W5UWLB96xTfO2ukTYMUvbqWU7xhUUL4P11qoEbFFaOmAHiRImPH1qrP
         mHC9LVhqGxI7Y/mtvOVphImHUadFL50J0CbNk1WubhniF4rG/STYgqPKX6FqFgpNSRLl
         SUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=kf/imtJJqyKKJyxPBOWh8dG0fjVra/5NYi0kTur39HM=;
        b=cvZ/xsMwl5ksjxfQ7fxSl3GuuoOCzZg2CfAl7UL1LY837fs+loDoD+TmMMfb0/ZaZO
         JmmfUDMVmApIerc8Z899PVDe320ouUnlcuktrZoDftG6A3mNeRPhkyIQTOirhqKP7UBH
         HE6ozIjr+IXNwYVWfIIT3Yo1Olk4BEdKSWCf6MBDcufElOa1xavlUEd6RRCQI1vIEuaf
         Gu24C3s6MZpI97mPx/yOvdD2/ATdLmkW2Ix/P6xSstb0qGAh3Qgzw3hkcwHN9HW2bysX
         7INQB2PfhJEenGPmemzxLiqMUovOUBbBLT026aVhcxknhrbCUiEgYQjobOofx7FgOtzq
         Bl3w==
X-Gm-Message-State: AGi0PubjCOmVxT3P7fMfN7Ev0Hl+yGcqnByZbR6lq3qOH1J/FB3Oadhg
        7wFw7yn51Ve62aHVYd8+lSnggbtr
X-Google-Smtp-Source: APiQypLxDS1wjtB+Zz5CPe5Dy67ZiA6L+QbehGh3gei3w6RjFHXFKPQZB/yn17GzHQRkzGgGj79RVQ==
X-Received: by 2002:a1c:9907:: with SMTP id b7mr2767101wme.17.1585821088393;
        Thu, 02 Apr 2020 02:51:28 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u13sm6949379wru.88.2020.04.02.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 02:51:27 -0700 (PDT)
Date:   Thu, 2 Apr 2020 11:51:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fix
Message-ID: <20200402095125.GA21592@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-04-02

   # HEAD: 1651e700664b4597ddf4f8adfe435252a0d11277 x86: Fix bitops.h warning with a moved cast

A single fix addressing Sparse warnings. <asm/bitops.h> is changed non-trivially
to avoid the warnings, but generated code is not supposed to be affected.

Hopefully I got the Git tagging and the scripting around it right. :-)

The only slightly annoying part for the scripting was to extract the 
contents of the signed tag into the draft email, which I did with this 
rather inelegant hack:

 git tag -l --format='%(contents)' $TAG | gawk '/-----BEGIN PGP SIGNATURE-----/{exit;}//{print $0;}' | head -n -1

... but I couldn't find a better way.

I suspect Git is trying to gently tell me that I should be using
'git request-pull' instead of rolling my own, I guess? ;-)

 Thanks,

	Ingo

------------------>
Jesse Brandeburg (1):
      x86: Fix bitops.h warning with a moved cast


 arch/x86/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 062cdecb2f24..53f246e9df5a 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "orb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)CONST_MASK(nr))
+			: "iq" (CONST_MASK(nr) & 0xff)
 			: "memory");
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
@@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "andb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)~CONST_MASK(nr)));
+			: "iq" (CONST_MASK(nr) ^ 0xff));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
