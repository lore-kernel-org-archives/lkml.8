Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F29BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466F62063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLanvurQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgDGMUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:20:03 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35720 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgDGMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:20:02 -0400
Received: by mail-pj1-f68.google.com with SMTP id g9so705753pjp.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=R4hvZR8SPgpRXTOdJt4oRMxXYe8DMEbopd6JEn/rddg=;
        b=NLanvurQ+ZPjNlsHq1Eqo37ceC0rWKMgTTjMn9f1vBeiiXkP24I5O/82bQeGy/l7Eo
         yMKva0N79AFo5oGBvW4HgRB/ROUCognwcHld7nmzH67RzRIUte3JNDxBarqioqw3mtyl
         A70iziS5ofFmI47r0S0PMZI1gDHHUfyABy8iqGsnOzX39utmk6JYQIbsp5ByzXlc2xzY
         KdhYzd0opCH2t8PAZm0H1t9hlGlh5eU4UOL8bylNF7Z4KVwjRZUk3wYQtiuID5WREagO
         vsMhbg0gLx/nAFBg/VY0BgOm2Sod4FFDEGTDJJSZnChEmBw2jxQJeSNv89zs9in8sSn2
         rPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=R4hvZR8SPgpRXTOdJt4oRMxXYe8DMEbopd6JEn/rddg=;
        b=rgECe1jkchbY5aJh+UWLMvmhheTWauenAlnDZo1eeoVfyigy6GW0WaTBpl+V6n7Bse
         dlK6bGqy8ofDAseW+jIujzeH02KgrnNGarutaSfsyabuR40r8Grr9rsjMLVq3Ph8UTXL
         V8Zv+o6BqcGu27FJQ+4vc0hshmj7KBDfuaTRwTVbR+CWfB1BFtbtnW/BQicLUQz/Q+zo
         HLeHV2EWZtkLfSNvo+nrf10hX+4oW0zpxxx+uJaNDINkdb9BOra7uW+shZ/y8nKEZFOY
         Xnmarleq2B6ioyl7HyeC+3sjYZZXYdmi9QPk1Bc1T6TIAbg0NzzKY3fCqjtodfZDV0LA
         fHwQ==
X-Gm-Message-State: AGi0PuZPO3K4jzef7gYgIW0mXVJT6NHeGLVNHc2M8cyhA1tOE5kBOM6J
        QL+okp1z5C8hmC3DU5VIUCo=
X-Google-Smtp-Source: APiQypJQMPX3R8hhbCk3y5ITo4/ipXEOgqTDUwx9oTXuJ3PEI8hMJEPkPisA9p4FuU+QC8Ynj93LrQ==
X-Received: by 2002:a17:90a:c392:: with SMTP id h18mr2488966pjt.89.1586262001848;
        Tue, 07 Apr 2020 05:20:01 -0700 (PDT)
Received: from localhost (g54.222-224-167.ppp.wakwak.ne.jp. [222.224.167.54])
        by smtp.gmail.com with ESMTPSA id r70sm13926024pfr.116.2020.04.07.05.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 05:20:01 -0700 (PDT)
Date:   Tue, 7 Apr 2020 21:19:58 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Subject: Re: [GIT PULL] OpenRISC updates for v5.6
Message-ID: <20200407121958.GQ7926@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Er, Sorry, this should be for 5.7.

I was a bit confused because of other things going on.  Let me know if you are
ok with this or need a new tag.  It should apply just fine for 5.7.

-Stafford

On Tue, Apr 07, 2020 at 09:16:15PM +0900, Stafford Horne wrote:
> Hi Linus,
> 
> Please consider pulling...
> 
> The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:
> 
>   Linux 5.5 (2020-01-26 16:23:03 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/openrisc/linux.git tags/for-linus
> 
> for you to fetch changes up to 9737e2c5f0bc768b58416ec070bd96c91c52a153:
> 
>   openrisc: Remove obsolete show_trace_task function (2020-03-18 22:10:44 +0900)
> 
> ----------------------------------------------------------------
> OpenRISC updates for 5.6
> 
> A few cleanups all over the place, things of note:
>  - Enable the clone3 syscall
>  - Remove CONFIG_CROSS_COMPILE from Krzysztof Kozlowski
>  - Update to use mmgrab from Julia Lawall
> 
> ----------------------------------------------------------------
> Julia Lawall (1):
>       openrisc: use mmgrab
> 
> Krzysztof Kozlowski (1):
>       openrisc: configs: Cleanup CONFIG_CROSS_COMPILE
> 
> Stafford Horne (4):
>       openrisc: Convert copy_thread to copy_thread_tls
>       openrisc: Enable the clone3 syscall
>       openrisc: Cleanup copy_thread_tls docs and comments
>       openrisc: Remove obsolete show_trace_task function
> 
>  Documentation/openrisc/openrisc_port.rst   |  4 ++--
>  arch/openrisc/Kconfig                      |  1 +
>  arch/openrisc/configs/or1ksim_defconfig    |  1 -
>  arch/openrisc/configs/simple_smp_defconfig |  1 -
>  arch/openrisc/include/uapi/asm/unistd.h    |  1 +
>  arch/openrisc/kernel/process.c             | 18 ++++++------------
>  arch/openrisc/kernel/smp.c                 |  3 ++-
>  arch/openrisc/kernel/traps.c               |  7 -------
>  8 files changed, 12 insertions(+), 24 deletions(-)
