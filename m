Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 10:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006F3208B6
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 10:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgF0KWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 06:22:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgF0KWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 06:22:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52891ACA7;
        Sat, 27 Jun 2020 10:22:50 +0000 (UTC)
Date:   Sat, 27 Jun 2020 12:22:40 +0200
From:   Borislav Petkov <bp@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Petteri Aimonen <jpa@git.mail.kapsi.fi>, kbuild-all@lists.01.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bp:tip-x86-fpu 2/2] test_fpu.c:undefined reference to
 `__sanitizer_cov_trace_cmpd'
Message-ID: <20200627102240.GC18956@zn.tnic>
References: <202006271139.H8IXpYlR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202006271139.H8IXpYlR%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 11:15:42AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tip-x86-fpu
> head:   dca364a883e0ac1f61b4d4e482edf66e63ffcdd2
> commit: dca364a883e0ac1f61b4d4e482edf66e63ffcdd2 [2/2] selftests/fpu: Add an FPU selftest
> config: x86_64-allyesconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ld: lib/test_fpu.o: in function `test_fpu_get':
> >> test_fpu.c:(.text+0x16e): undefined reference to `__sanitizer_cov_trace_cmpd'
> >> ld: test_fpu.c:(.text+0x1a7): undefined reference to `__sanitizer_cov_trace_cmpd'
>    ld: test_fpu.c:(.text+0x1e0): undefined reference to `__sanitizer_cov_trace_cmpd'
> 
> ---

I'm getting sick'n'tired of having to deal with compilers lately:

---
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e4add3e89c47..5842885ab184 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2309,7 +2309,7 @@ config TEST_HMM
 
 config TEST_FPU
 	tristate "Test floating point operations in kernel space"
-	depends on X86
+	depends on X86 && !KCOV_INSTRUMENT_ALL
 	help
 	  Enable this option to add /sys/kernel/debug/selftest_helpers/test_fpu
 	  which will trigger a sequence of floating point operations. This is used
---

Thx for the report, folded in.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
