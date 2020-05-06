Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C972C47247
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562862073B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="aS17fUgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgEFADU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 20:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgEFADT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:03:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5EAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 17:03:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so9312pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 17:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=HQ1Cigpl9A0g2ziQxfxPjRmKwSRMahcOzSHZQwuGlC0=;
        b=aS17fUgF3ZC88stcvJfNxTaoB+HmJk4Ad7IBO2Jbxa7DBT0xHZEzNR+EpuVvT3jKxK
         3fNensYy9VMPP35dxWjkIE/G2AWSvUAtAUsfaCik58Kco16YYkIrxNAod0sW9c1NWlMQ
         kk/wKARGgNRrs/6+2L/Z8zvcdz8+1FVqbBSLfa96M3eHXdnC5bEp/V7dtDLUNdZzB4cR
         PBueW4BvuQgv1sdcX0JxRpzCTiYT1/iUHyB6GwkHI460ETnHumVG+jRbClGLPgWzoBTF
         IO71jMIzDcIgS/qnohBGUlCZC0XTb7LG1Lys3TPvPrd07M9QSQqQcdtB6rk98Q6zybf6
         gL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HQ1Cigpl9A0g2ziQxfxPjRmKwSRMahcOzSHZQwuGlC0=;
        b=c8zbubFfyxxi54JBJPLmrLJ2rEPfuqgB1uHsBolaNL6kU6B6FOdtcxMWppJpgohN6W
         a/jK/JVghhLAghH6cQTyPG8wwwswGrSMtsXHzfxcMgVM8MszJ1MChLIylWu9Eoxpra+O
         SEZBXWHB5p1eBA4yCoA269Ts7F2XrQWB3PCPc4rm4hhed3OeDVuPoMY/SQ4OvPvu+k+q
         1vdZe35rqgT3Mm5Uuw545DDFx5gCQsm74gy/vH+NoUFLRUGIh/JqxxgblgzEKCl6Rclp
         DqLI7B0LUukr6OviOH243zlrD4TB+JwHYXc4FkIcu70t5ESRmm0SeYI4j0kSfIbzHEwb
         0HCQ==
X-Gm-Message-State: AGi0Pua1yu49Onvu1sgbu3EUmGyIu3c8I8szf/bkeI4FBkY02gap8ft8
        6BztyEufI621IEYsEWWqkDQAvA==
X-Google-Smtp-Source: APiQypKgpYaqDCemgOAG6HlmVBw70Z+EdVZDEw8elHZMNfKM8/xCEHqZc+sWdHTnljPuqGXuPzSDCA==
X-Received: by 2002:a17:90a:32ea:: with SMTP id l97mr6115115pjb.50.1588723398999;
        Tue, 05 May 2020 17:03:18 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r4sm220213pgi.6.2020.05.05.17.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:03:18 -0700 (PDT)
Date:   Tue, 05 May 2020 17:03:18 -0700 (PDT)
X-Google-Original-Date: Tue, 05 May 2020 17:03:16 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Remove unused code from STRICT_KERNEL_RWX
In-Reply-To: <CAOnJCUJtnVjYwfaHbiUdO4SqPk8rY0q0uYckNJpQpc7jK0Pz7g@mail.gmail.com>
CC:     Atish Patra <Atish.Patra@wdc.com>, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>, linux-kernel@vger.kernel.org,
        zong.li@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-3b48ef6b-d427-40af-b8f7-1bdccc117927@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 May 2020 17:00:05 PDT (-0700), atishp@atishpatra.org wrote:
> On Tue, May 5, 2020 at 4:55 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Sun, 03 May 2020 21:03:19 PDT (-0700), Atish Patra wrote:
>> > This patch removes the unused functions set_kernel_text_rw/ro.
>> > Currently, it is not being invoked from anywhere and no other architecture
>> > (except arm) uses this code. Even in ARM, these functions are not invoked
>> > from anywhere currently.
>> >
>> > Fixes: d27c3c90817e ("riscv: add STRICT_KERNEL_RWX support")
>> >
>> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> > ---
>> >  arch/riscv/mm/init.c | 16 ----------------
>> >  1 file changed, 16 deletions(-)
>> >
>> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> > index b55be44ff9bd..ba60a581e9b6 100644
>> > --- a/arch/riscv/mm/init.c
>> > +++ b/arch/riscv/mm/init.c
>> > @@ -501,22 +501,6 @@ static inline void setup_vm_final(void)
>> >  #endif /* CONFIG_MMU */
>> >
>> >  #ifdef CONFIG_STRICT_KERNEL_RWX
>> > -void set_kernel_text_rw(void)
>> > -{
>> > -     unsigned long text_start = (unsigned long)_text;
>> > -     unsigned long text_end = (unsigned long)_etext;
>> > -
>> > -     set_memory_rw(text_start, (text_end - text_start) >> PAGE_SHIFT);
>> > -}
>> > -
>> > -void set_kernel_text_ro(void)
>> > -{
>> > -     unsigned long text_start = (unsigned long)_text;
>> > -     unsigned long text_end = (unsigned long)_etext;
>> > -
>> > -     set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
>> > -}
>> > -
>> >  void mark_rodata_ro(void)
>> >  {
>> >       unsigned long text_start = (unsigned long)_text;
>>
>> Thanks, this is on fixes.  Are you going to remove the ARM code as well?
>>
>
> Yeah and also I realized that I forgot to remove the declarations from
> the header file.
> My bad. I will send out a v2. Please drop this one and take v2.

I just fixed it up

commit 73cb8e2a5863ccc5215660f5123db621bd57dff7
gpg: Signature made Tue 05 May 2020 05:02:17 PM PDT
gpg:                using RSA key 2B3C3747446843B24A943A7A2E1319F35FBB1889
gpg:                issuer "palmer@dabbelt.com"
gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
gpg:                 aka "Palmer Dabbelt <palmerdabbelt@google.com>" [ultimate]
Author: Atish Patra <atish.patra@wdc.com>
Date:   Sun May 3 21:03:19 2020 -0700

    RISC-V: Remove unused code from STRICT_KERNEL_RWX
    
    This patch removes the unused functions set_kernel_text_rw/ro.
    Currently, it is not being invoked from anywhere and no other architecture
    (except arm) uses this code. Even in ARM, these functions are not invoked
    from anywhere currently.
    
    Fixes: d27c3c90817e ("riscv: add STRICT_KERNEL_RWX support")
    Signed-off-by: Atish Patra <atish.patra@wdc.com>
    Reviewed-by: Zong Li <zong.li@sifive.com>
    Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index c38df4771c09..4c5bae7ca01c 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -22,14 +22,6 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
-#ifdef CONFIG_STRICT_KERNEL_RWX
-void set_kernel_text_ro(void);
-void set_kernel_text_rw(void);
-#else
-static inline void set_kernel_text_ro(void) { }
-static inline void set_kernel_text_rw(void) { }
-#endif
-
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5b813532db59..27a334106708 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -502,22 +502,6 @@ static inline void setup_vm_final(void)
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-void set_kernel_text_rw(void)
-{
-	unsigned long text_start = (unsigned long)_text;
-	unsigned long text_end = (unsigned long)_etext;
-
-	set_memory_rw(text_start, (text_end - text_start) >> PAGE_SHIFT);
-}
-
-void set_kernel_text_ro(void)
-{
-	unsigned long text_start = (unsigned long)_text;
-	unsigned long text_end = (unsigned long)_etext;
-
-	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
-}
-
 void mark_rodata_ro(void)
 {
 	unsigned long text_start = (unsigned long)_text;

