Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E818C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A8420CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MzJVhEfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgANB5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:57:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44201 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgANB5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:57:54 -0500
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 00E1vSqQ1582716
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 13 Jan 2020 17:57:28 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 00E1vSqQ1582716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019122001; t=1578967049;
        bh=73sdd0gKwzsK+W5DK5KjaAPkEWXgfp6lmaX6TIBl45s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MzJVhEfUnp/Ys8ckWAFzhRGYURhonr2Q9hWGSdWR04Jr57keXilDA7+WG/tSAnoFr
         TmEgFiKdkULKEe6LPNqhaAffJ9+2bx1kwN3DqwIxmn0MVvF35Hr9NT9nULqIjYQB0j
         35GcW2/gSDI+KbF+dLMaef3o3r+VsWDGDWM59fac/6j9E00JndWk6VTcHUU4gnzYDq
         PWq4unzGORLkvhhlz1WnPuH/pqaV3CABiwK9Uk/O6jonmmks/GnGmE3ATRbRtzBbaw
         W74mEB4pj4x3QtyRSsQg3Y/UZUn5AfkvXs6X+w1IqzRil4S8ULmEJ60bQ6Evy4t9yi
         lvmI1OuAbGunA==
Subject: Re: [PATCH v3] x86/vmlinux: Fix vmlinux.lds.S with pre-2.23 binutils
To:     Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <261ae869-4169-296e-f673-5c08ff34bdde@zytor.com>
Date:   Mon, 13 Jan 2020 17:57:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <202001131750.C1B8468@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-13 17:53, Kees Cook wrote:>>
>> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
>> index 3a1a819da137..bad4e22384dc 100644
>> --- a/arch/x86/kernel/vmlinux.lds.S
>> +++ b/arch/x86/kernel/vmlinux.lds.S
>> @@ -144,10 +144,12 @@ SECTIONS
>>  		*(.text.__x86.indirect_thunk)
>>  		__indirect_thunk_end = .;
>>  #endif
>> +
>> +		/* End of text section */
>> +		_etext = .;
>>  	} :text =0xcccc
>>  
>> -	/* End of text section, which should occupy whole number of pages */
>> -	_etext = .;
>> +	/* .text should occupy whole number of pages */
>>  	. = ALIGN(PAGE_SIZE);
> 
> NAK: linkers can add things at the end of .text that will go missing from
> the kernel if _etext isn't _outside_ the .text section, truly beyond the
> end of the .text section. This patch will break Control Flow Integrity
> checking since the jump tables are at the end of .text.
> 
> Boris, we're always working around weird linker problems; I don't see a
> problem with the v2 patch to fix up old binutils...
> 

Why not add the marker into a separate section instead of leaving it as an
absolute "floater"? Very old binutils would botch that case, but I think that
has been long since addressed well below our current minimum version.

	-hpa



