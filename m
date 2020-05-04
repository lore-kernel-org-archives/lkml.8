Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D5BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FED2078C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="e3zXikzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgEDWKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 18:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726419AbgEDWKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 18:10:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BBBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 15:10:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so11351pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 15:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=RsWtuuae95Pfo1FKcbtwlDSeo9CU2YN0fL7RBypW428=;
        b=e3zXikzx6u7QRuqbHEJY7DGGU05jX7XdVzNnwCyXIoJTW97K7vY4Vh4UN74Ypos1e/
         4u2qb7RmMw2JeIx93QTvYBDH97tOGsJqATkQ6+eRPGcEmd7Sa4AI7CgPpZsRCtnnJzjQ
         3QcQigFfBnJd+3+J/IXH8RUqbawhljSSy1rl5VK8IRtmKC0nivwezbmyDFbLkty1wjpi
         Xo8WD8fjXUpL6vplIk44HWlYhSgWlAoV3TaCde6I/6gYYbRc8k2Sj+Poz8q5dLjyP2gk
         tHOd8/av0lstAqIOQ50Z7T13aEGT9pj8LpFLwn+zHwaILjswIsIdaHOfcafvx7Co1GKs
         KTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=RsWtuuae95Pfo1FKcbtwlDSeo9CU2YN0fL7RBypW428=;
        b=lLjuRAipHhN/hLDZ6ctjyv6ru9Lp8TqEJi9awyC9gaHZuFSSS7tXIsjeQN0ejNxa0w
         NbB1806b3bh4RSlZPRTSg/XHNkL4Nst5oaFnU7RBlQOiLVbaOkrDHSJZVWqGliKHBtJU
         wTlQqxmjIULqJ90/TpumhXF55LHZT2p1fp3lBQl0N6vsfEtAaxuUKHljzYV4InJxzYR3
         MRZISq/bxjiKJPsEoLc09Sgxas/apZ9ZR4GhHWSe2cY8htooEirYPCURVMst3ki2zLjo
         BSZSMjdOS94ZTy+ZKHLIoB+zWXgPmY6ODPUfOPHZ641dRkee8e4tNqoeT3oeCeeP3DdT
         F3RA==
X-Gm-Message-State: AGi0PuamiFC5JI8O8NYo3y53QwbiLpsIOJX+xO3QxL5pdYvIdQd4kD4s
        cQ3lqsk4ULtZbUEyldVZRPn7ag==
X-Google-Smtp-Source: APiQypLTMw94c16mgPZMBgqGaTJsmCgPcg3wtFztESmdv/J6FTXIe0JAYR0JCBbyJ2KhmA2Woo4GZw==
X-Received: by 2002:a63:5b4e:: with SMTP id l14mr354484pgm.146.1588630209329;
        Mon, 04 May 2020 15:10:09 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a2sm75364pfg.106.2020.05.04.15.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 15:10:08 -0700 (PDT)
Date:   Mon, 04 May 2020 15:10:08 -0700 (PDT)
X-Google-Original-Date: Mon, 04 May 2020 15:04:45 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: force __cpu_up_ variables to put in data section
In-Reply-To: <CAOnJCUKCryLuZn0Pd71z3Oa1AEN1xUfz=SW_5PBV-2pDU+Nw=g@mail.gmail.com>
CC:     schwab@linux-m68k.org, anup@brainfault.org, zong.li@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        greentime.hu@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-8854b2d0-fe7b-4af9-aa24-c10e631a8574@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 May 2020 10:37:40 PDT (-0700), atishp@atishpatra.org wrote:
> On Mon, May 4, 2020 at 12:50 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>>
>> On Mai 04 2020, Anup Patel wrote:
>>
>> > Slightly improved text:
>> >
>> > This issue happens on random booting of multiple harts, which means
>> > it will manifest for BBL and OpenSBI v0.6 (or older version). In OpenSBI
>> > v0.7 (or higher version), we have HSM extension so all the secondary harts
>> > are brought-up by Linux kernel in an orderly fashion. This means we don't
>> > this change for OpenSBI v0.7 (or higher version).
>>
>>   +need
>>
>> Andreas.
>>
>> --
>> Andreas Schwab, schwab@linux-m68k.org
>> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
>> "And now for something completely different."
>
> With Andreas & Anup's nitpick addressed,
>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>

Thanks!  It should be on fixes, with the new commit text.
