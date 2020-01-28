Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E55EC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151EA2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgA1Ium (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:50:42 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:40220 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgA1Ium (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:50:42 -0500
X-Greylist: delayed 2285 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jan 2020 03:50:41 EST
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1iwLz6-0007ql-Fw; Tue, 28 Jan 2020 08:12:32 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1iwLz2-00039A-Mv; Tue, 28 Jan 2020 08:12:31 +0000
Subject: Re: [RFC v1 2/2] arch: um: turn BTF_TYPEINFO support off
To:     Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com,
        richard@nod.at, akpm@linux-foundation.org, changbin.du@intel.com,
        yamada.masahiro@socionext.com, rdunlap@infradead.org,
        keescook@chromium.org, andriy.shevchenko@linux.intel.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com
References: <20200127193549.187419-1-brendanhiggins@google.com>
 <20200127193549.187419-3-brendanhiggins@google.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <b49a0bf2-eaf7-b2b3-a7f2-db0f280d42ff@cambridgegreys.com>
Date:   Tue, 28 Jan 2020 08:12:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127193549.187419-3-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/01/2020 19:35, Brendan Higgins wrote:
> Currently CONFIG_DEBUG_INFO_BTF=y doesn't work on UML:
> 
> scripts/link-vmlinux.sh: line 106: 17463 Segmentation fault      LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> objcopy: --change-section-vma .BTF=0x0000000000000000 never used
> objcopy: --change-section-lma .BTF=0x0000000000000000 never used
> objcopy: error: the input file '.btf.vmlinux.bin' is empty
> Failed to generate BTF for vmlinux
> Try to disable CONFIG_DEBUG_INFO_BTF
> make: *** [Makefile:1078: vmlinux] Error 1
> 
> So turn off ARCH_HAS_BTF_TYPEINFO support off for the UM architecture.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>   arch/um/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 0917f8443c285..53e13d8b210e0 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -6,6 +6,7 @@ config UML
>   	bool
>   	default y
>   	select ARCH_HAS_KCOV
> +	select ARCH_NO_BTF_TYPEINFO
>   	select ARCH_NO_PREEMPT
>   	select HAVE_ARCH_AUDITSYSCALL
>   	select HAVE_ARCH_SECCOMP_FILTER
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
