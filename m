Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8098BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5812074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgIDPgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:36:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27818 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726446AbgIDPge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:36:34 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-WZkioUXCMYqYZnwVHscj1g-1; Fri, 04 Sep 2020 11:36:31 -0400
X-MC-Unique: WZkioUXCMYqYZnwVHscj1g-1
Received: by mail-ed1-f69.google.com with SMTP id y15so2862566ede.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nh0UdzX3nOW85WcLnyIxxzPsl9fTzKFB/JN5jwTHSIA=;
        b=iBxANQ+UeVUDM8C+txyq7wipRz7dRwDD25MN9vl5XEiY2cmjKNwta7VUDEOlnuTR1S
         uhxOxA4f2YidXlKWY3rV6Qa+Rd9vQhaZPY1jYzauYOyQxPKmCrpp1DukeFQfkgeVvqvf
         RG3Fx0WX/A3UWEF/WER6fM+AGzJ76ypTl6jhu4xcPh6D+OMX0ntb3EMXvEfpY4kCl7cb
         YbhYFlWsCqC1v1NXWxtppJ/ZQIy2mHrtAKCbGL6zeOypMN4hMNnLkRcdOlBc2mQ1NLZ2
         iliyD0q5naAlSgM7vKG+3wT/5Ct2jQoPjDLnERDfdS/BDlcYyKYZ0X7COQvnZwzov53L
         TUvQ==
X-Gm-Message-State: AOAM531twvdnp/WSKGtrLJgrvLPF/+wA/5/jONu6YVaHro/Rk+SJtfok
        FJz061DNvoyDIDU9o8AlyL85PdnYbeP40xL6ehYxGLQXiD54weupvrKF0nMpLitBEaqPFptA3t1
        7/CpmJsOQlMjvMGh0GSCSoYVd
X-Received: by 2002:a50:ed16:: with SMTP id j22mr9359989eds.104.1599233790059;
        Fri, 04 Sep 2020 08:36:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze70cigcxJZHzavPb8gmQTBwt8P1ab4OFT/cVutE9S+W2LHQk/QXoudkFMgm2Mpyv9oVKB+w==
X-Received: by 2002:a50:ed16:: with SMTP id j22mr9359958eds.104.1599233789812;
        Fri, 04 Sep 2020 08:36:29 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id i35sm6425372edi.41.2020.09.04.08.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 08:36:29 -0700 (PDT)
Subject: Re: [PATCH v3 00/10] Make check implementation arch agnostic
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
References: <20200904152755.32372-1-jthierry@redhat.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <c74c803a-82de-188f-d2c7-6d75bfa8104a@redhat.com>
Date:   Fri, 4 Sep 2020 16:36:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200904152755.32372-1-jthierry@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Apologies again about the duplicate. It seems like I have issues sending 
batched emails...

This thread can be ignored.

On 9/4/20 4:27 PM, Julien Thierry wrote:
> Hi,
> 
> The current implementation of the check subcommand has various x86 bits
> here and there. In order to prepare objtool to provide check for other
> architectures, add some abstraction over the x86 specific bits, relying
> on objtool arch specific code to provide some necessary operations.
> 
> This is part of the effort to implement check for arm64, initiated [1]
> by Raphael. The series is based on top of the separation of check & orc
> subcommands series[2].
> 
> I've push both series base on top of tip/objtool/core at [3].
> 
> - The first two patches make it simpler for new arches to provide their
> list of kernel headers, without worrying about modifications in the x86
> headers.
> - Patch 3 Moves arch specific macros to more suitable location
> - Patches 4 and 5 add abstraction to handle alternatives
> - Patch 6 adds abstraction to handle jump table
> - Patches 7-10 makes unwind hint definitions shared across architectures
> 
> Changes since v2 [4]:
> - Rebased on v5.9-rc1
> - Under tools/objtool/arch/x86/, rename arch_special.c to special.c
> - Rename include/linux/frame.h to inclide/linux/objtool.h
> - Share unwind hint types across architectures
> 
> [1] https://lkml.org/lkml/2019/8/16/400
> [2] https://lkml.org/lkml/2020/6/4/675
> [3] https://github.com/julien-thierry/linux/tree/arch-independent-check
> [4] https://lkml.org/lkml/2020/7/30/424
> 
> Cheers,
> 
> Julien
> 
> -->
> 
> Julien Thierry (9):
>    objtool: Group headers to check in a single list
>    objtool: Make sync-check consider the target architecture
>    objtool: Move macros describing structures to arch-dependent code
>    objtool: Abstract alternative special case handling
>    objtool: Make relocation in alternative handling arch dependent
>    headers: Rename frame.h
>    objtool: Only include valid definitions depending on source file type
>    objtool: Make unwind hints definitions available to other
>      architectures
>    objtool: Decode unwind hint register depending on architecture
> 
> Raphael Gault (1):
>    objtool: Refactor switch-tables code to support other architectures
> 
>   arch/x86/include/asm/nospec-branch.h          |   2 +-
>   arch/x86/include/asm/orc_types.h              |  34 ----
>   arch/x86/include/asm/unwind_hints.h           |  50 +-----
>   arch/x86/kernel/kprobes/core.c                |   2 +-
>   arch/x86/kernel/kprobes/opt.c                 |   2 +-
>   arch/x86/kernel/reboot.c                      |   2 +-
>   arch/x86/kernel/unwind_orc.c                  |  11 +-
>   arch/x86/kvm/svm/svm.c                        |   2 +-
>   arch/x86/kvm/vmx/nested.c                     |   2 +-
>   arch/x86/kvm/vmx/vmx.c                        |   2 +-
>   arch/x86/xen/enlighten_pv.c                   |   2 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_msg.c           |   3 +-
>   include/linux/frame.h                         |  35 -----
>   include/linux/objtool.h                       | 134 ++++++++++++++++
>   kernel/bpf/core.c                             |   2 +-
>   kernel/kexec_core.c                           |   2 +-
>   tools/arch/x86/include/asm/orc_types.h        |  34 ----
>   tools/include/linux/objtool.h                 | 134 ++++++++++++++++
>   tools/objtool/Makefile                        |   2 +-
>   tools/objtool/arch.h                          |   2 +
>   tools/objtool/arch/x86/Build                  |   1 +
>   tools/objtool/arch/x86/decode.c               |  37 +++++
>   tools/objtool/arch/x86/include/arch_special.h |  20 +++
>   tools/objtool/arch/x86/special.c              | 145 ++++++++++++++++++
>   tools/objtool/check.c                         | 137 ++---------------
>   tools/objtool/check.h                         |   7 +-
>   tools/objtool/objtool.h                       |   2 +
>   tools/objtool/orc_dump.c                      |   7 +-
>   tools/objtool/orc_gen.c                       |   5 +-
>   tools/objtool/special.c                       |  48 +-----
>   tools/objtool/special.h                       |  10 ++
>   tools/objtool/sync-check.sh                   |  27 ++--
>   tools/objtool/weak.c                          |   2 -
>   33 files changed, 561 insertions(+), 346 deletions(-)
>   delete mode 100644 include/linux/frame.h
>   create mode 100644 include/linux/objtool.h
>   create mode 100644 tools/include/linux/objtool.h
>   create mode 100644 tools/objtool/arch/x86/include/arch_special.h
>   create mode 100644 tools/objtool/arch/x86/special.c
> 
> --
> 2.21.3
> 

-- 
Julien Thierry

