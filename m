Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1068C33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9726E2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/riBuR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgAKAUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 19:20:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33929 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgAKAUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 19:20:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so1759048pgf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 16:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=c3X7AVrd0eaweLYAuO8RL12YZV2EtbyuB8unmVAV0Nc=;
        b=o/riBuR2mH3VghdAJD08lJGw+G6Nmt2YFqawukfV3FgIyraZCC33g4w6UUkTg4B9YA
         bPaQ7HIdl9EVvkaFzug0pY/FlWJECuXnToQMWAXeRVE0al9hqWVAVcLgt0QhvWPJSBsQ
         bB5dxtI06QKGwTmE7+MmdzSWdr5sWOBaOx8ylflwJxzwunQWhFk0yZMqgjvLjx3Ta6Qw
         IY0NzO2fCoYN5CkwLwDpJMeX7S6jXG0r+Ka/MngphRFWsDvtkDRIbForX/TrNPi0+IDh
         9ZHCf9TkSZkGR/2ZIQQ0xtQVlRTLSLv2/gi03mwbtBLmcgcOWB86bKQt7FFpTbEBt+yn
         J0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=c3X7AVrd0eaweLYAuO8RL12YZV2EtbyuB8unmVAV0Nc=;
        b=d1+5jV6+ve9xVKRuWvnC4/REfbnBOzKri5KYXFOZtsbv90PiqF+duXFWUrUhCrd+VB
         +6uS3dvi2O4/3fxm6a+Lv+XpoFnu902MEvi9FmnfsYxHmvdVrwnQpoczDhX4+AFs7U0B
         HLEjVSiaLGBEx56BKpr7uW8jdnMHets6MrTJ/yHxfPbZwKz94dsK0idUoNd+oKvvfArc
         cYi9bOADHQGPsvxlVRMXSmo9wRUyRjE7XUJqfaDXo1Q9GwlcCT6NzvVoj6+lqDU7Pfei
         w6lZ/t2Q/98I7hKxxmYBNj6ldg90qxZPLmnFSbgjmXywlqdOMlLxcKLyTA7PCZ4KyTSW
         SHcg==
X-Gm-Message-State: APjAAAVAFWATJyZ5S/ShjPH2OcNs4RG7Vc9OplN+qgLTbocEStLTSPpi
        WN55mZ0IwcAQgG8TRbMWBdbzWw==
X-Google-Smtp-Source: APXvYqz94HjiloVFGVWbZus+RYXmvPQjwFd3nN3tcOUYSqCGg0YFmHQZNCSbn5YazmB7epfwxn4mvg==
X-Received: by 2002:a63:e30a:: with SMTP id f10mr7422254pgh.331.1578702011266;
        Fri, 10 Jan 2020 16:20:11 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id c14sm4013510pjr.24.2020.01.10.16.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 16:20:10 -0800 (PST)
Date:   Fri, 10 Jan 2020 16:20:10 -0800 (PST)
X-Google-Original-Date: Fri, 10 Jan 2020 16:19:54 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: Re: linux-next: build warning after merge of the bpf-next tree
CC:     Stephen Rothwell <sfr@canb.auug.org.au>, daniel@iogearbox.net,
        ast@kernel.org, netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, zong.li@sifive.com
To:     alexandre@ghiti.fr
In-Reply-To: <a367af4d-7267-2e94-74dc-2a2aac204080@ghiti.fr>
References: <a367af4d-7267-2e94-74dc-2a2aac204080@ghiti.fr>
  <20191018105657.4584ec67@canb.auug.org.au> <20191028110257.6d6dba6e@canb.auug.org.au>
Message-ID: <mhng-0daa1a90-2bed-4b2e-833e-02cd9c0aa73f@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 14:28:17 PST (-0800), alexandre@ghiti.fr wrote:
> Hi guys,
>
> On 10/27/19 8:02 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> On Fri, 18 Oct 2019 10:56:57 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>> Hi all,
>>>
>>> After merging the bpf-next tree, today's linux-next build (powerpc
>>> ppc64_defconfig) produced this warning:
>>>
>>> WARNING: 2 bad relocations
>>> c000000001998a48 R_PPC64_ADDR64    _binary__btf_vmlinux_bin_start
>>> c000000001998a50 R_PPC64_ADDR64    _binary__btf_vmlinux_bin_end
>>>
>>> Introduced by commit
>>>
>>>    8580ac9404f6 ("bpf: Process in-kernel BTF")
>> This warning now appears in the net-next tree build.
>>
>>
> I bump that thread up because Zong also noticed that 2 new relocations for
> those symbols appeared in my riscv relocatable kernel branch following
> that commit.
>
> I also noticed 2 new relocations R_AARCH64_ABS64 appearing in arm64 kernel.
>
> Those 2 weak undefined symbols have existed since commit
> 341dfcf8d78e ("btf: expose BTF info through sysfs") but this is the fact
> to declare those symbols into btf.c that produced those relocations.
>
> I'm not sure what this all means, but this is not something I expected
> for riscv for
> a kernel linked with -shared/-fpie. Maybe should we just leave them to
> zero ?
>
> I think that deserves a deeper look if someone understands all this
> better than I do.

Can you give me a pointer to your tree and how to build a relocatable kernel?
Weak undefined symbols have the absolute value 0, but the kernel is linked at
an address such that 0 can't be reached by normal means.  When I added support
to binutils for this I did it in a way that required almost no code --
essetially I just stopped dissallowing x0 as a possible base register for PCREL
relocations, which results in 0 always being accessible.  I just wanted to get
the kernel to build again, so I didn't worry about chasing around all the
addressing modes.  The PIC/PIE support generates different relocations and I
wouldn't be surprised if I just missed one (or more likely all) of them.

It's probably a simple fix, though I feel like every time I say that about the
linker I end up spending a month in there...
