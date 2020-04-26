Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5C8C55186
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D5920706
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587863139;
	bh=TW9WOI1NaKEA7K+nsipDf0IuvMnVChZsi71PeMPMFD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yn5+Cj5aTYSeifR8c51Qc7O4w9vHvEXC8//mpyLIqGO17DUWkffLmXocMh+G6ODcy
	 4MSZTv5F+SpF7skzMbidNWTDBF0pD+hGGlK9xi0RKhIPqch/HQURRdStCqvNAAZyhO
	 FzwZKkFethpIqqcKIETsgxM11vcZv8g4L5YPSRxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDZBFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 21:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgDZBFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 21:05:38 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BEDC206DD;
        Sun, 26 Apr 2020 01:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587863138;
        bh=TW9WOI1NaKEA7K+nsipDf0IuvMnVChZsi71PeMPMFD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xyssavs7qBvNOpyHvBtiegJkq8Wqg9HwnL8VSZPm/f8KpEORw/jy4AReSAPnbTyaS
         c0Cw8kBn/g+AbZeu0VCV07nAEV8i657DrVx4QfURgeCFg0zIN8wLlvc0ertQQb0mih
         zxkGvbWu7NndBLJ4agHVO4dFK7txamla8RvIHWDs=
Date:   Sat, 25 Apr 2020 18:05:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] riscv: support DEBUG_WX
Message-Id: <20200425180537.063e976b232f8771e22f7ee1@linux-foundation.org>
In-Reply-To: <282e266311bced080bc6f7c255b92f87c1eb65d6.1587455584.git.zong.li@sifive.com>
References: <cover.1587455584.git.zong.li@sifive.com>
        <282e266311bced080bc6f7c255b92f87c1eb65d6.1587455584.git.zong.li@sifive.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 16:17:13 +0800 Zong Li <zong.li@sifive.com> wrote:

> Support DEBUG_WX to check whether there are mapping with write and
> execute permission at the same time.
> 
> --- a/arch/riscv/include/asm/ptdump.h
> +++ b/arch/riscv/include/asm/ptdump.h
> @@ -8,4 +8,10 @@
>  
>  void ptdump_check_wx(void);
>  
> +#ifdef CONFIG_DEBUG_WX
> +#define debug_checkwx() ptdump_check_wx()
> +#else
> +#define debug_checkwx() do { } while (0)
> +#endif
> +
>  #endif /* _ASM_RISCV_PTDUMP_H */

It's preferred to implement things in regular C, unless they MUST be
implemented in the preprocessor.  So...

--- a/arch/riscv/include/asm/ptdump.h~riscv-support-debug_wx-fix
+++ a/arch/riscv/include/asm/ptdump.h
@@ -9,9 +9,14 @@
 void ptdump_check_wx(void);
 
 #ifdef CONFIG_DEBUG_WX
-#define debug_checkwx() ptdump_check_wx()
+static inline void debug_checkwx(void)
+{
+	ptdump_check_wx();
+}
 #else
-#define debug_checkwx() do { } while (0)
+static inline void debug_checkwx(void)
+{
+}
 #endif
 
 #endif /* _ASM_RISCV_PTDUMP_H */
_

