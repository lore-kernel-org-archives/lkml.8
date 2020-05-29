Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD2AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E10C2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590763247;
	bh=i2sYxK+w8XDQKVVht9PQJZpQaZcjLydGD4ENA0FFa28=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=c+cNhLk/URo9ChR9d7g+ovRDorS5ycEh34QwN+E0IgR6NIcZawBHyooFq44RJ57XU
	 MwEck5bW7qlls8bfGsIApsdB9gAvVTBXiuRUGAUeWK78Lv3f/2KKeTzZrjvDc6iYAc
	 fxp7wZvI0FWK9Hfu8xaXSuYspmDBQ+wPEhoqcmaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgE2Okq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgE2Okp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:40:45 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014A3C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:40:45 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u23so2056670otq.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AVORNgD2f5sSdFOY/zQ4dvax6TxhlkGn3vffNCnlGTg=;
        b=JASYw63/GvhCifu9uHwC1FtZSEgCQGrlQdPF96BT+IM2BlwT4QVrBOOv6pEZgzCZMO
         EHL6uvP2ZejA6ExAH6zHEfd1YY8h/CF1Mws6BPsKm7di9dBSxq6FoNrkWcG2CEL8PaKN
         E1Sbq81+G6kAjTOCcWbZA/lrecjX7GviF9hYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AVORNgD2f5sSdFOY/zQ4dvax6TxhlkGn3vffNCnlGTg=;
        b=r7RhEpVRbjLyTixQcJmTPXgRzgVBIJC7Upg9N0K2x2Q+ExWJZm7qEoG74g08BK+gNT
         rHgq+rsASUiqDXc9M2xOJWNbRAb2IUaxcmNeewz/ZNiNvyV7JuuyO8mrs5DUjS6kn7j/
         sKe71ltmYLJY65uZBARkS6kA1UG9jRzLNFKIi/5WNtMO0hPzRweEo3r8IxZfIWqSvANB
         JIU6ajjeqyexgYn9JziU5h7D8C83WnudM7aG/lC5OVilaFfkQMZSNs/LcUXA39iESJk7
         XduOtEbbhvMVfZQMYjF5yIEK25iKDYPFwh49kZMEfjxuwLqpesFIhxUVOfFcTTudnJE7
         2HwQ==
X-Gm-Message-State: AOAM533J/LTqDf/DmTu35VtkPzY+VtdLr/hBuz1RriZwiYTKw4LWm/JJ
        CweC3BKh0/+HWBZoJGt9+zPlmQ==
X-Google-Smtp-Source: ABdhPJxu9dpekrciIoQgCabfTXj5neu3B9mnsdneC4icqUhUGCoAON6A0+ENrTho6Uva1EQHgV8GNg==
X-Received: by 2002:a05:6830:22d6:: with SMTP id q22mr6222902otc.274.1590763244376;
        Fri, 29 May 2020 07:40:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a8sm2491716otp.65.2020.05.29.07.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 07:40:43 -0700 (PDT)
Subject: Re: [PATCH v13 15/16] selftests/x86/fsgsbase: Test GS selector on
 ptracer-induced GS base write
To:     Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        luto@kernel.org, ak@linux.intel.com
Cc:     corbet@lwn.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        shuah@kernel.org, gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200528201402.1708239-1-sashal@kernel.org>
 <20200528201402.1708239-16-sashal@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d51d8e60-cb5f-fa97-a00c-9c6a2e42b42b@linuxfoundation.org>
Date:   Fri, 29 May 2020 08:40:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528201402.1708239-16-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 2:14 PM, Sasha Levin wrote:
> From: "Chang S. Bae" <chang.seok.bae@intel.com>
> 
> The test validates that the selector is not changed when a ptracer writes
> the ptracee's GS base.
> 
> Originally-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   tools/testing/selftests/x86/fsgsbase.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
> index 15a329da59fa..950a48b2e366 100644
> --- a/tools/testing/selftests/x86/fsgsbase.c
> +++ b/tools/testing/selftests/x86/fsgsbase.c
> @@ -465,7 +465,7 @@ static void test_ptrace_write_gsbase(void)
>   	wait(&status);
>   
>   	if (WSTOPSIG(status) == SIGTRAP) {
> -		unsigned long gs, base;
> +		unsigned long gs;
>   		unsigned long gs_offset = USER_REGS_OFFSET(gs);
>   		unsigned long base_offset = USER_REGS_OFFSET(gs_base);
>   
> @@ -481,7 +481,6 @@ static void test_ptrace_write_gsbase(void)
>   			err(1, "PTRACE_POKEUSER");
>   
>   		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
> -		base = ptrace(PTRACE_PEEKUSER, child, base_offset, NULL);
>   
>   		/*
>   		 * In a non-FSGSBASE system, the nonzero selector will load
> @@ -489,11 +488,21 @@ static void test_ptrace_write_gsbase(void)
>   		 * selector value is changed or not by the GSBASE write in
>   		 * a ptracer.
>   		 */
> -		if (gs == 0 && base == 0xFF) {
> -			printf("[OK]\tGS was reset as expected\n");
> -		} else {
> +		if (gs != *shared_scratch) {
>   			nerrs++;
> -			printf("[FAIL]\tGS=0x%lx, GSBASE=0x%lx (should be 0, 0xFF)\n", gs, base);
> +			printf("[FAIL]\tGS changed to %lx\n", gs);
> +
> +			/*
> +			 * On older kernels, poking a nonzero value into the
> +			 * base would zero the selector.  On newer kernels,
> +			 * this behavior has changed -- poking the base
> +			 * changes only the base and, if FSGSBASE is not
> +			 * available, this may not effect.
> +			 */
> +			if (gs == 0)
> +				printf("\tNote: this is expected behavior on older kernels.\n");

Let's add what is "this" for context in this message.

> +		} else {
> +			printf("[OK]\tGS remained 0x%hx\n", *shared_scratch);
>   		}
>   	}
>   
> 

thanks,
-- Shuah
