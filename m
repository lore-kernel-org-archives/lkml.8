Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8B5C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 00:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527752072B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 00:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRTq8VWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDDAkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 20:40:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41632 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgDDAkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 20:40:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id a24so4441034pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 17:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tAgxV2Mx2tEoH3/n8njjHOTY7Xv1RNdnq1oeOLGcdWw=;
        b=lRTq8VWX1bpLn4dLrWlGfqfwsgkiJJ7ykirmVp5TVssF4qc6+DbiJ4a0Sd4fZ9pcoX
         qF3DN4b18kfMXatIWcFcwrbOjbLKAUsm0x7tU3Xz0zUR2C5cE11o2YWuESVWZDMdFlF8
         KCj5vo05CCASThwVF8t6eqIi/GOtgbDKWSpCHxAkUBPhMmI8I+Ricb8RyCjRFQife44G
         zay4Id6u8dAJSvgEBOSV/T6jIS2RIzOwwMoHfR/KMaJYHhc44Jq1MpX+klYxs2s2PcL+
         ePgI2CSbQ1sOfyQ8FW0wvXm7wUEbE9cSJWjp8114kDQYg82zpdDgvFmcpXLmJdFTwTpM
         9m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tAgxV2Mx2tEoH3/n8njjHOTY7Xv1RNdnq1oeOLGcdWw=;
        b=p7F5h7EEnJzDs1w5d0AdmETX7TdJOG3KHDsbs0n6zYUTPj3CNnwm47brbVoQK7+h4C
         YSkxExv0uNDM7pkGVO+lLcBi7ec22gHXrhUQYEhpSdaRcU7E6q2hLU1166UdAq5SsrhF
         iMAFcACuMe5n6eQMSIQSSXpU8OWPQW3XuovblxGjbWj7fomCmXi0HOqIOUTh8F0TWryi
         7nMRScQGmMZIsi9OMZ8YNiM/ReBib1U9pw6uDRYkpAzum9VNB1T7E+09Fu3fPOiVdln3
         e989XlBkTCu6F1d8HRcg+sS8Z56i8tbxLfdTSyydpdwn+w97B5dIhZ4DUGc8rvI54/TX
         3aDw==
X-Gm-Message-State: AGi0PuYtlt6VDQOKl3Ti6yMK8VZg5uVCMm+n685vhGwgJEVYaVsHq/L+
        ZLLfl5ny3Rkz2lIe5TAxCHcWvw==
X-Google-Smtp-Source: APiQypJ9HAHD47+2nEL+0hUg9udMsodf9rUFIwQ2IhnsWsbdRe8BpTZ99dRH/DaE8VuvJh70PntS9w==
X-Received: by 2002:a63:8c5b:: with SMTP id q27mr9497123pgn.301.1585960823589;
        Fri, 03 Apr 2020 17:40:23 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id c190sm6570392pfa.66.2020.04.03.17.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 17:40:22 -0700 (PDT)
Date:   Fri, 3 Apr 2020 17:40:20 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] elfnote: mark all .note sections SHF_ALLOC
Message-ID: <20200404004020.jilng63qqyccbgke@google.com>
References: <20200325231250.99205-1-ndesaulniers@google.com>
 <CAKwvOdm8tQaa6BW7EQAz4TxFZETnJCS3z9isY4HvcU7UYqWZUA@mail.gmail.com>
 <20200403222458.GA49554@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200403222458.GA49554@ubuntu-m2-xlarge-x86>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-03, Nathan Chancellor wrote:
>On Fri, Apr 03, 2020 at 03:13:34PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
>> dropping Jeremy; I got bounceback from the email address. Ping for review?
>>
>> On Wed, Mar 25, 2020 at 4:13 PM Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>> >
>> > ELFNOTE_START allows callers to specify flags for .pushsection assembler
>> > directives.  All callsites but ELF_NOTE use "a" for SHF_ALLOC. For
>> > vdso's that explicitly use ELF_NOTE_START and BUILD_SALT, the same
>> > section is specified twice after preprocessing, once with "a" flag, once
>> > without. Example:
>> >
>> > .pushsection .note.Linux, "a", @note ;
>> > .pushsection .note.Linux, "", @note ;
>> >
>> > While GNU as allows this ordering, it warns for the opposite ordering,
>> > making these directives position dependent. We'd prefer not to precisely
>> > match this behavior in Clang's integrated assembler.  Instead, the non
>> > __ASSEMBLY__ definition of ELF_NOTE uses
>> > __attribute__((section(".note.Linux"))) which is created with SHF_ALLOC,
>> > so let's make the __ASSEMBLY__ definition of ELF_NOTE consistent with C
>> > and just always use "a" flag.
>> >
>> > This allows Clang to assemble a working mainline (5.6) kernel via:
>> > $ make CC=clang AS=clang
>> >
>> > Link: https://github.com/ClangBuiltLinux/linux/issues/913
>> > Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
>> > Debugged-by: Ilie Halip <ilie.halip@gmail.com>
>> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
>Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

I asked on binutils@sourceware.org whether GNU as is willing to change.
https://sourceware.org/pipermail/binutils/2020-March/109997.html
I'll also ping that thread.


Reviewed-by: Fangrui Song <maskray@google.com>

>> > ---
>> > Ilie has further treewide cleanups:
>> > https://github.com/ihalip/linux/commits/elfnote
>> > This patch is the simplest to move us forwards.
>> >
>> >  include/linux/elfnote.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/include/linux/elfnote.h b/include/linux/elfnote.h
>> > index 594d4e78654f..69b136e4dd2b 100644
>> > --- a/include/linux/elfnote.h
>> > +++ b/include/linux/elfnote.h
>> > @@ -54,7 +54,7 @@
>> >  .popsection                            ;
>> >
>> >  #define ELFNOTE(name, type, desc)              \
>> > -       ELFNOTE_START(name, type, "")           \
>> > +       ELFNOTE_START(name, type, "a")          \
>> >                 desc                    ;       \
>> >         ELFNOTE_END
>> >
>> > --
>> > 2.26.0.rc2.310.g2932bb562d-goog
>> >
>>
>>
>> --
>> Thanks,
>> ~Nick Desaulniers
>
>
>-- 
>You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200403222458.GA49554%40ubuntu-m2-xlarge-x86.
