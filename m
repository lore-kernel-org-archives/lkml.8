Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C838C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424252070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C3Fefy49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCXAmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 20:42:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36101 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgCXAmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:42:08 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (jfdmzpr05-ext.jf.intel.com [134.134.139.74])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 02O0flDr2861616
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 23 Mar 2020 17:41:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 02O0flDr2861616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020022001; t=1585010513;
        bh=ke1kAyziepiePyP+htvTDh7NGoJIOKiP+G7v0bUp81s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C3Fefy49DZFK8vi6XqobK//wbTNg4mYvo1F8yH98i/BrhEpo2+7yCaIDcRTYSyh42
         vTnwAFRC4n4nxdu7mH9SeVCTmCakIf23XHmec5OAtdwoDihtjSq1z/0fuX0NupFccN
         /tipUCpRX5bevv9TmnkNdlnaaDZzO+2umCTe7L9AvXjAWKVtJRY4vi85B0ol1fuZhb
         OUA0o+W493WOyyA7fHEEUaXRn3pl8iOu/PYekYF1p33KZC3uNPP5j7mo3CXhyYo3wt
         +4UmqmGx9XKc5y7FMAxt742IH86FncIyvHf3dsYwj9AgtpIEhEYDhh/lA31UXOq7TG
         9rErR7oxqlMiQ==
Subject: Re: [PATCH] Documentation: x86: exception-tables: document
 CONFIG_BUILDTIME_TABLE_SORT
To:     Nick Desaulniers <ndesaulniers@google.com>, corbet@lwn.net
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20200323232214.24939-1-ndesaulniers@google.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6e26c798-1439-2bbd-6801-8fd21c4e6926@zytor.com>
Date:   Mon, 23 Mar 2020 17:41:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323232214.24939-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-23 16:22, Nick Desaulniers wrote:
> Provide more information about __ex_table sorting post link.
> 
> The exception tables and fixup tables use a commonly recurring pattern
> in the kernel of storing the address of labels as date in custom ELF
> sections, then finding these sections, iterating elements within them,
> and possibly revisiting them or modifying the data at these addresses.
> 
> Sorting readonly arrays to minimize runtime penalties is quite clever.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  Documentation/x86/exception-tables.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/x86/exception-tables.rst b/Documentation/x86/exception-tables.rst
> index ed6d4b0cf62c..15455b2f7ba8 100644
> --- a/Documentation/x86/exception-tables.rst
> +++ b/Documentation/x86/exception-tables.rst
> @@ -257,6 +257,9 @@ the fault, in our case the actual value is c0199ff5:
>  the original assembly code: > 3:      movl $-14,%eax
>  and linked in vmlinux     : > c0199ff5 <.fixup+10b5> movl   $0xfffffff2,%eax
>  
> +If the fixup was able to handle the exception, control flow may be returned
> +to the instruction after the one that triggered the fault, ie. local label 2b.
> +
>  The assembly code::
>  
>   > .section __ex_table,"a"
> @@ -344,3 +347,9 @@ pointer which points to one of:
>       it as special.
>  
>  More functions can easily be added.
> +
> +CONFIG_BUILDTIME_TABLE_SORT allows the __ex_table section to be sorted post
> +link of the kernel image, via a host utility scripts/sorttable. It will set the
> +symbol main_extable_sort_needed to 0, avoiding sorting the __ex_table section
> +at boot time. With the exception table sorted, at runtime when an exception
> +occurs we can quickly lookup the __ex_table entry via binary search.
> 

It is more than that. It not only saves the boot execution time needed
to sort the table, but it is required for early exception handling to
work -- and in the x86 code, we use the exception handling *extremely*
early (on i386 before paging is even turned on!), long before the kernel
would have had any opportunity to sort it.

So it is not just performance; it is also a correctness issue.

	-hpa

