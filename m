Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1CDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F10206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="NY41Kgrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGGIq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGGIq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:46:57 -0400
X-Greylist: delayed 1842 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jul 2020 01:46:56 PDT
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D322FC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=EA/3cNstrWMDO33kM+6w6yj9HV+JpNqfCcL3vex3MqA=; b=NY41KgrkrgsH2VNw4Wic5NBxK9
        c433IFDrijCmG1B8UIlMAmnn6z5XT/rSqRN/mWZetxCKQPZpPI+GQPmNaRVCa+aRIIJHMa+jiETQX
        mr1BcuChG5I87In8K454cVqCgL5qxPMDnrBZ3c39F9zoBAVEPLXk+MNzFS94+07pP8anA941E6ou0
        QN7Hp8M0IFTRmOegfKWxLNg4oipRcjKN4iNMfw1OWj7lM8sH5Yzi5BQGJDef+4CF95vsX3PM+u0D1
        PJ+d1A8Famx0l00G7jd+937pJ+Yvnn7SUhs86TVTWNrpJAl8WlLkxV+ix9QdoGFrWcIvwcqHpm0VX
        0AbvaWrA==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1jsilv-00036X-9u; Tue, 07 Jul 2020 10:16:11 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
        (envelope-from <aurelien@aurel32.net>)
        id 1jsils-007vhX-RV; Tue, 07 Jul 2020 10:16:08 +0200
Date:   Tue, 7 Jul 2020 10:16:08 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Andreas Schwab <schwab@suse.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: use 16KB kernel stack on 64-bit
Message-ID: <20200707081608.GA1889963@aurel32.net>
Mail-Followup-To: Andreas Schwab <schwab@suse.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mvmeepoddt1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmeepoddt1.fsf@suse.de>
User-Agent: Mutt/1.14.0 (2020-05-02)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-06 14:32, Andreas Schwab wrote:
> With the current 8KB stack size there are frequent overflows in a 64-bit
> configuration.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  arch/riscv/include/asm/thread_info.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 1dd12a0cbb2b..464a2bbc97ea 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -12,7 +12,11 @@
>  #include <linux/const.h>
>  
>  /* thread information allocation */
> +#ifdef CONFIG_64BIT
> +#define THREAD_SIZE_ORDER	(2)
> +#else
>  #define THREAD_SIZE_ORDER	(1)
> +#endif
>  #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
>  
>  #ifndef __ASSEMBLY__
> -- 
> 2.26.2


Following the discussion on the mailing list, I have been trying this
patch on my system for a few days, and it indeed seems more stable. I
just wonder if you should Cc stable@ so that it is backported in older
kernel versions.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
