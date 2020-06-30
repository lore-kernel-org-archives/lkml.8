Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FC7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A4820722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LnNtZBDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbgF3NzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbgF3NzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:55:09 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC72CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:55:08 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so9660160edz.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I7tKMiZC0Ae0Byi3HySspgtzJ9C4efs0lX4S31oOk74=;
        b=LnNtZBDEHqiNVz5Xx/8x6JH8qathg4jJF7p7rxDKy0Nxla7zJK9ErDjNRHtduC5Nci
         FeoTMPriZiLSIdgls1IBRTJLzfzxJR+IdKD092uwx+7xDfhErqV36s5SbRPy6s9Q1Ti5
         +GwZQhnxKC9pfBrfAy/a0jF+Ce0SL7z8uyb2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I7tKMiZC0Ae0Byi3HySspgtzJ9C4efs0lX4S31oOk74=;
        b=KDtSeDR6bWHV2ZKDl2Aeey7fnli9MtDrzFkTm4nED+vsmtUtzEfR/XF2HCzfmQKqf2
         27GtxsBe5ulDJKWTbiun3RLXRa33mVhsPMmCOq9ckPM2VjsBdtANa/LzSsFrwlIuParx
         IirYj6rEYXer0k9TTcyM+j5ztG6aaeP4lB78m3uz2AOVdr9MDf30hoj3dS3S8fLtisYj
         fu2MSPSyjE73YvpfZdEtTc7P0OCXDtwluEyckLlepuzdXqyzxRP7AZeoZZI8E/jQ1fu0
         LmXEhOxOfLKVv+fyBRmBVU3eRGmAoWHwBcJlpEEon8L7phDWrgsq85IFKrVlQOoMjybh
         qP+Q==
X-Gm-Message-State: AOAM531KMOrAfbHuFtiwdE3960Lo4vm36r+bT+niulF+wag6Ojno8ZFH
        DSD/3Ya9hYhZhO12f5/xc1xc6g==
X-Google-Smtp-Source: ABdhPJw7VJekK2zKCiY0ROhQ5WTgHLU7aDPKFRvAJJ9GplrBmPB6ivjtV0YQz0Lh2E/n22M8WKXnFQ==
X-Received: by 2002:a50:c88d:: with SMTP id d13mr23515533edh.104.1593525307622;
        Tue, 30 Jun 2020 06:55:07 -0700 (PDT)
Received: from [172.16.11.153] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id dn15sm2261654ejc.26.2020.06.30.06.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 06:55:07 -0700 (PDT)
Subject: Re: [sched] c3a340f7e7: invalid_opcode:#[##]
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, keescook@chromium.org, hjl.tools@gmail.com
References: <20200629003127.GB5535@shao2-debian>
 <20200630124628.GV4817@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <5b7286c9-ef4f-c1d0-fae3-ebb198aa0742@rasmusvillemoes.dk>
Date:   Tue, 30 Jun 2020 15:55:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630124628.GV4817@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2020 14.46, Peter Zijlstra wrote:
> On Mon, Jun 29, 2020 at 08:31:27AM +0800, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-4.9):
>>
>> commit: c3a340f7e7eadac7662ab104ceb16432e5a4c6b2 ("sched: Have sched_class_highest define by vmlinux.lds.h")
> 
>> [    1.840970] kernel BUG at kernel/sched/core.c:6652!
> 
> W T H
> 
> $ readelf -Wa defconfig-build/vmlinux | grep sched_class
> 62931: c1e62d20     0 NOTYPE  GLOBAL DEFAULT    2 __begin_sched_classes
> 65736: c1e62f40    96 OBJECT  GLOBAL DEFAULT    2 stop_sched_class
> 71813: c1e62dc0    96 OBJECT  GLOBAL DEFAULT    2 fair_sched_class
> 78689: c1e62d40    96 OBJECT  GLOBAL DEFAULT    2 idle_sched_class
> 78953: c1e62fa0     0 NOTYPE  GLOBAL DEFAULT    2 __end_sched_classes
> 79090: c1e62e40    96 OBJECT  GLOBAL DEFAULT    2 rt_sched_class
> 79431: c1e62ec0    96 OBJECT  GLOBAL DEFAULT    2 dl_sched_class
> 
> $ printf "%d\n" $((0xc1e62dc0 - 0xc1e62d40))
> 128
> 
> So even though the object is 96 bytes in size, has an explicit 32 byte
> alignment, the array ends up with a stride of 128 bytes !?!?!
> 
> Consistently so with GCC-4.9. Any other GCC I tried does the sane thing.

Does that include gcc 4.8, or is it only "anything newer than 4.9"?

>
> Full patch included below.
> 
> Anybody any clue wth 4.9 is doing crazy things like this?

Perhaps
https://gcc.gnu.org/onlinedocs/gcc-4.9.4/gcc/Variable-Attributes.html#Variable-Attributes:

  When used on a struct, or struct member, the aligned attribute can
only increase the alignment; in order to decrease it, the packed
attribute must be specified as well. When used as part of a typedef, the
aligned attribute can both increase and decrease alignment, and
specifying the packed attribute generates a warning.

is part of the explanation. But this is seriously weird. I don't know
which .config you or the buildbot used, but I took an i386_defconfig
with SMP=n to get a small enough struct sched_class (and disable
retpoline stuff), added

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81640fe0eae8..53c0d3ba62ba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -71,6 +71,13 @@ unsigned int sysctl_sched_rt_period = 1000000;

 __read_mostly int scheduler_running;

+void foo(void)
+{
+       extern void bar(int);
+       bar(sizeof(struct sched_class));
+       bar(_Alignof(struct sched_class));
+}
+
 /*
  * part of the period that we allow rt tasks to run in us.
  * default: 0.95s

and apparently _Alignof is only 16:

 00002c90 <foo>:
    2c90:       55                      push   %ebp
    2c91:       b8 60 00 00 00          mov    $0x60,%eax
    2c96:       89 e5                   mov    %esp,%ebp
    2c98:       e8 fc ff ff ff          call   2c99 <foo+0x9>
                        2c99: R_386_PC32        bar
    2c9d:       b8 10 00 00 00          mov    $0x10,%eax
    2ca2:       e8 fc ff ff ff          call   2ca3 <foo+0x13>
                        2ca3: R_386_PC32        bar

Neverthess, readelf -S --wide kernel/sched/fair.o:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg
Lk Inf Al

  [35] __fair_sched_class PROGBITS        00000000 002980 000060 00   A
0   0 64

so the section it was put in has an alignment of 64. The generated
assembly is indeed

        .globl  fair_sched_class
        .section        __fair_sched_class,"a",@progbits
        .align 64

/me goes brew coffee
