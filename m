Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B0CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F102075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591886304;
	bh=0cNL9Y50KOPGEFeuugvNsaM91oPo8A1C+37diLn4Bs8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=M//tK5izGnck9TwHR7CCU58RPR1+HQVKtoR9q7IrtrcZQJ/XnCM/UgI2I1Tc9NNux
	 G986n9JsfkfACXi959jQ4Uq0uLFIXzzLjn8Nq2DSAg6X58jzzjexrcqzSfrAo/h8WI
	 20VOcEQe7l2ZUYXeF8rqlcZa5e4FzyL5wduFfSHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgFKOiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgFKOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:38:21 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B447FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:38:20 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id h3so5594149ilh.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dF3hNbjUBSQwM8/VdlOfSEew66M2+2X1iPt+T7+avfg=;
        b=UcfRzKubbiAogehSYuWmlXFgR4RDmCojE9/+/FKzFy9BzQIdhIhFAQKDSb1ssre2iT
         NPWOPP6Z+CiFr1rdOA8Kh1aSWwSMXk18FGwfVeBpEw/9ubjLLyQFe0Tzb0nGvFEIaKl9
         8o8mLqA7fldwmvH3GN4AsDZBvtmrua29LoXWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dF3hNbjUBSQwM8/VdlOfSEew66M2+2X1iPt+T7+avfg=;
        b=bP7HG5Q0FOrVALXphH6YoKeybvRAn+brugtl3b4TSDjNrBvIAE+Ug4xFV/SUlsYW/f
         q+4tMcgvNIKxktITAwqGnF5j2iAUB8trLPy0Jn7h3igzjwRcDLcJRsd0vcnoIVhxDztY
         KdYqPAxjJ9N/uafKUmKuZjkjbKvQodWAzMEAb+fPNxDwYb/8USr+l69k56u7hGlluoXl
         FLJCmT7vi+Wv6XociwjCV46aBclFHmv0eeEUSleJYrvo77Eb9jCCvjQ2sn4EaPFKqlWt
         NwNafgGtfFh21sZhWa87bsbJXKcPHGemT4ZjJ/ZnC3yn1kyOhRLM45fzzTA3e46kz6CR
         Jmwg==
X-Gm-Message-State: AOAM532TEaP8wmMvtWNepwHvOKfg0/I46Z96HNdtf7TPnEHYriE5shMx
        SMQOPMMkdpm6JuZYiJGrJP4TbQ==
X-Google-Smtp-Source: ABdhPJzKn2AV05PUIQzBsSu2r27bMvUJlu31y880zGD5aJYE7pVuAlx5fF7g/lZPrbDYUx84Y04BxA==
X-Received: by 2002:a92:dacf:: with SMTP id o15mr7828271ilq.36.1591886300106;
        Thu, 11 Jun 2020 07:38:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n7sm1561133ile.76.2020.06.11.07.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 07:38:19 -0700 (PDT)
Subject: Re: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
To:     Petteri Aimonen <jpa@git.mail.kapsi.fi>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <8b1f0bfa-79b0-74e4-0241-8b2a94491807@linuxfoundation.org>
 <C6F6F6E4-CBD8-4E72-812B-99F008ECAA4F@amacapital.net>
 <b4629042-21c7-2b38-4c3f-44f9be469cca@linuxfoundation.org>
 <20200603051946.GF17423@lakka.kapsi.fi>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f5f80b20-c8e8-4f75-c5b2-dbd7ce56ca41@linuxfoundation.org>
Date:   Thu, 11 Jun 2020 08:38:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603051946.GF17423@lakka.kapsi.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/20 11:19 PM, Petteri Aimonen wrote:
> Hi,
> 
>> Is it correct to assume the stuff checked differs from test to test
>> and done in user-space.
>>
>>> undo_evil_state();
>>
>> Is it correct to assume undoing evil differs from test to test
>> and done in user-space, provide it can be done from userspace.
> 
> Yes, currently the test works like:
> 
> do_test_setup();
> read_from_debugfs_file();
> check_results();
> 

You will need a 4th clanup step step of undo_test_setup().

> and the middle step stays the same. But of course in general case there
> could be argument passing etc, even though the test for this issue
> doesn't need them.
> 
> Myself I don't see the problem with just adding a file under debugfs and
> bind to its read.
> 

thanks,
-- Shuah

