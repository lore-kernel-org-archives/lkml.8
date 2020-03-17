Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADD5C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8F920738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iu9j9MII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCQNIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:08:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37297 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbgCQNIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584450525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTW6T5TxiZ2w06AMn3cxcvzt8yOIHUmc0wdV4dyBwN4=;
        b=iu9j9MIIB8q6yZ9YNYbYm083edPp/dNQv4scUHeX/tS9tAtp9Ptc8fWsT68vDMjbWpQhUK
        U4w0GGudqcZUG1YY4c6meBpTbQbfPUf8Vlo/nYPPN7VgXODKmm+XSxHnBmnRfXJs7ELsGP
        3L5Lc2/7AfZoXqBxQQ5f1ibIYUEbjhI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-5i45v5mTMTa4K0z6m1NLQg-1; Tue, 17 Mar 2020 09:08:42 -0400
X-MC-Unique: 5i45v5mTMTa4K0z6m1NLQg-1
Received: by mail-wr1-f69.google.com with SMTP id h17so987647wru.16
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gTW6T5TxiZ2w06AMn3cxcvzt8yOIHUmc0wdV4dyBwN4=;
        b=Mgv6vbGegJqZYyJr2o6WWb4Hfgsi1HWAvOA1XLiutD1KnWtR8G3baPSgTW97ysdf9i
         hDVSgrV6ZO8zQJuGRnZmrtjJ1lrIjil0auOFGtebBwK2Fs2s0YJ7eCEhc20rbt4lI/W8
         ig+8m4m8Pb5wAuREZoGqMlz4VA9iarFe40Vlm4o84+EHyIFIcsJIDuvLF8QtPX0oaGZp
         VsyzIt3OS59uYnXt+56KagkNsDPa7BL6GXFLk9IUtvyFJ8lUtKna7HK+S7mJNPViKzEW
         ZtiGEZcxnl7A2y/oRgjKw4ANRXOKgQK+RQJZ6lIf42i7Yt8fmM2Bev1TtFI0PYp7sryk
         bLqw==
X-Gm-Message-State: ANhLgQ2RAX0jL0mT9o5MxNgKV9KsS/9hzOIk3mpI+1qmB2jgmt3Hg2sf
        ZOAkCqTXgt9cuxQsVOCXW9grRFENpRTKnh225MiHi1SgzS1JIywSZ5AtmPBD00LOVRSm1i56ij3
        +2g6VtBO8goC3r1WgnVYJyV5I
X-Received: by 2002:adf:a285:: with SMTP id s5mr6375119wra.118.1584450520502;
        Tue, 17 Mar 2020 06:08:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvukE9TuGFMVvx92iKdGpCIM4J5ocm16YibpYHueIsBilciiqPioFrCH092XLesRfAMw4vOSw==
X-Received: by 2002:adf:a285:: with SMTP id s5mr6375104wra.118.1584450520318;
        Tue, 17 Mar 2020 06:08:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id l8sm3981010wmj.2.2020.03.17.06.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 06:08:39 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] x86/purgatory: Disable various profiling and
 sanitizing options
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200312114951.56009-1-hdegoede@redhat.com>
 <20200313182815.GF8142@zn.tnic>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <aee4ff4d-05f0-9d55-eb19-1d8df520e6c9@redhat.com>
Date:   Tue, 17 Mar 2020 14:08:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313182815.GF8142@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/13/20 7:28 PM, Borislav Petkov wrote:
> On Thu, Mar 12, 2020 at 12:49:50PM +0100, Hans de Goede wrote:
>> Since the purgatory is a special stand-alone binary, we need to disable
> 
> Pls use passive voice in your commit message: no "we" or "I", etc, and
> describe your changes in imperative mood.
> 
> Also, pls read section "2) Describe your changes" in
> Documentation/process/submitting-patches.rst for more details.

Ok, fixed for v6 and I've also rebased the series on tip/master for v6.

Regards,

Hans



> 
>> various profiling and sanitizing options. Having these options enabled
>> typically will cause dependency on various special symbols exported by
>> special libs / stubs used by these frameworks. Since the purgatory is
>> special we do not link against these stubs causing missing symbols in
>> the purgatory if we do not disable these options.
>>
>> This commit syncs the set of disabled profiling and sanitizing options
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.
> 
> Those two review comments apply to patch 2's commit message too, pls fix
> them there too.
> 
>> with that from drivers/firmware/efi/libstub/Makefile, adding
>> -DDISABLE_BRANCH_PROFILING to the CFLAGS and setting:
>>
>> GCOV_PROFILE                    := n
>> UBSAN_SANITIZE                  := n
>>
>> This fixes broken references to ftrace_likely_update when
>> CONFIG_TRACE_BRANCH_PROFILING is enabled and to __gcov_init and
>> __gcov_exit when CONFIG_GCOV_KERNEL is enabled.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v5:
>> -Not only add -DDISABLE_BRANCH_PROFILING to the CFLAGS but also set:
>>   GCOV_PROFILE                    := n
>>   UBSAN_SANITIZE                  := n
>>
>> Changes in v4:
>> -This is a new patch in v4 of this series
>> ---
>>   arch/x86/purgatory/Makefile | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> $ test-apply.sh -g /tmp/01-x86-purgatory-disable_various_profiling_and_sanitizing_options.patch
> checking file arch/x86/purgatory/Makefile
> Hunk #1 FAILED at 17.
> Hunk #2 succeeded at 27 (offset 2 lines).
> 1 out of 2 hunks FAILED
> 
> This happens because tip/master already has KCSAN merged in and it adds
> 
> KCSAN_SANITIZE  := n
> 
> there.
> 
> Please redo the patches against current tip/master.
> 
> Thx.
> 

