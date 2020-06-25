Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BA7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BE520857
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="bEpzzfX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405824AbgFYPa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405780AbgFYPa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:30:57 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E268C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 08:30:57 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id a14so2956521qvq.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1d1NDHziB2+Z4wmOF87q1mDb9V/Ga/3Nh2+lEySJ0oM=;
        b=bEpzzfX5ovYKTLDfG8FDmcha3pVIaMAvsWsN2XSoEhpaxvgMT6s0MatgMF0SHR3Ca4
         nSrOA9eTQ5oru48OqNngYtOaezX8NXn2KTOhEIT+0B7MoUHoK/U/Ec+7nLGVHuP7C174
         mnFYFscNBvV9r5R04SPiCADbe9GLiLiH2vSIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1d1NDHziB2+Z4wmOF87q1mDb9V/Ga/3Nh2+lEySJ0oM=;
        b=oZwa7V+75VdsGjW8ELRNcCsILUdG9P6fPJ+MdJaRf5oZecT5vPeYGzh5VHg38Cspfq
         gh/qRG4hYvFZgZQLfBJQHwFLWbD93tkA6a15m9s2XYTT4ujaVRCH8JOemHvRZd4MD6pI
         5lzRob+H52q+14cKj2aqUQnD/TQb6TulVSdLaPyPLgilzLaPIoVm1679ZsMV5z64+V0f
         UATFZcTPLX6QJ93gKchI9QqZxwwE0Ul9nUvTsXF2e2LuPNfy69ejA8FVZ9aRqsVNG6Dv
         IUxOM5gV+rOM0h1mhIlkTP+0vw0poyHlQloJv3bhhsjye8pN8OWdla0/xdaCqAtXRATu
         drcw==
X-Gm-Message-State: AOAM531uIbTfxG4M0Ym2oicWQ9LqLF9RIZEAIR46dNOfQWz2mZNZupa7
        nve40iI21Urv69SHiQWnXN+Wkg==
X-Google-Smtp-Source: ABdhPJy6be7ZwQwcNo3PTY8zPDmZY2DbKYKTEC4nt5gqtdutoO/L+q7XdG2/3KQ7dspaMruFGYtdvg==
X-Received: by 2002:ad4:4687:: with SMTP id bq7mr20652440qvb.12.1593099056536;
        Thu, 25 Jun 2020 08:30:56 -0700 (PDT)
Received: from pepe.local (71-142-124-255.lightspeed.rlghnc.sbcglobal.net. [71.142.124.255])
        by smtp.gmail.com with ESMTPSA id u58sm6896432qth.77.2020.06.25.08.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 08:30:55 -0700 (PDT)
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
References: <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <87h7w7qy18.fsf@nanos.tec.linutronix.de>
 <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
 <87d06opd3a.fsf@nanos.tec.linutronix.de>
 <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
 <20200528191910.GC2147934@linux.intel.com>
 <20200528194157.GB1407771@sasha-vm> <20200529030715.GA6182@linux.intel.com>
 <20200529031016.GB6182@linux.intel.com>
From:   Don Porter <porter@cs.unc.edu>
Message-ID: <d0db9590-5c0f-d41c-906f-c5cd0981f138@cs.unc.edu>
Date:   Thu, 25 Jun 2020 11:30:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200529031016.GB6182@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 11:10 PM, Jarkko Sakkinen wrote:
> On Fri, May 29, 2020 at 06:07:23AM +0300, Jarkko Sakkinen wrote:
>>
>> Is there something then readily available to test such workload with SGX
>> enabled? Or should I go patching Graphene? Not sure what I should take
>> from that comment :-)
>>
>> For me the main point is that I need a tool to create arbitrary work
>> loads and run them inside enclave, once the SGX support reaches the
>> upstream. It's not just about testing this particular series.
>>
>> The reason why I've been passive with this work so far is that I've been
>> busy combining updating of SGX series for over two years and maintaining
>> work. Now is the first time when I have time for this.
>>
>> Actually I found this by searching lore.kernel.org whether anything has
>> happend with this. Have had a bullet in my backlog for ages.
> 
> Just need the info if anyone else is going to do something to Graphene
> or not in near future. If not, I will do it myself.
> 
> /Jarkko
> 

In re-reading, I realized you didn't get a clear answer.

We are merging the changes to Graphene to run a patched 5.7 kernel with 
these patches, so it should work for you (or anyone else) once all of 
the changes are merged.  I'd be happy to talk, perhaps off this thread, 
about how we can help you with any other SGX-related kernel testing in 
the future, or issues with running Graphene.

-Don
