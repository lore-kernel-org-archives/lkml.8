Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901D1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C97207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="A0kLDZtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405790AbgFYP1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405766AbgFYP1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:27:32 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BAFC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 08:27:31 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id d12so2957529qvn.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cylvILSn15rb2wKQGtwoa9WDT8sAaEmN5gAld/QWM1o=;
        b=A0kLDZtz+ww2LKNJ3eYbFTrVCOqWDN42mdH4D2IoZyKVnCOJsxf5uz2LxgAuVhOCtf
         LvQAH3Cxj75bevZVL5/he/74Gm8iNpgXUy0NTKiP4iGtPzjv4ohk2o9ilByo10GWty08
         LZ9tw4wYfJOhssTVzY4oItgiRVQE5i/8ZvGio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cylvILSn15rb2wKQGtwoa9WDT8sAaEmN5gAld/QWM1o=;
        b=VfznOK++2DMRr1q2QqIS8dT8G8H/2k15Kkw1/s8K+dJlWqwd5Oic99xHh7SMWML+sz
         GthK2fhENSKQGxtPf5YQibXKeURqW77F8jf9xPnV8atQAqkaKqvFZWwc0yr32iCghZrp
         rRObTt3R89NZxtmkXCBLeXoKQeb9v9oxcWbEtokxfE51EKl1VOJU1zw1q7idLcmqD9Kn
         HYaUdm2xVnw8G0ba5JXMk32AQQEJXN0lnqBhZ5wDbxV4bHRt1cYyQ7ccvp412NF+2vp8
         BHaGsZGa5Nskc9yLFf7lc5HV2yZj3rQiOzlJJ3beVuY/ito/eEBJc0rFbccjBSqQsXTP
         +khA==
X-Gm-Message-State: AOAM531ZfM5QZ5NuJyrb6kt4CrMzj0OSV49YSg5Dn2M2l7yPQrNTFP5B
        VOepinQYHZVXGv2kpFT2FomckvoVw34=
X-Google-Smtp-Source: ABdhPJzDRkNHphlcLh0YCdDxSUh1iC1IKf2KMQMmzokveaco066nkTyccCQ6E5nVHdjE74MYQ9ESPA==
X-Received: by 2002:a0c:f388:: with SMTP id i8mr36556390qvk.224.1593098850992;
        Thu, 25 Jun 2020 08:27:30 -0700 (PDT)
Received: from pepe.local (71-142-124-255.lightspeed.rlghnc.sbcglobal.net. [71.142.124.255])
        by smtp.gmail.com with ESMTPSA id b22sm5445299qka.43.2020.06.25.08.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 08:27:29 -0700 (PDT)
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
To:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
References: <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
 <7A3EBAB0-B3B3-4CB7-AA6A-FDF29D03E30D@amacapital.net>
 <20200529152756.GA7452@invisiblethingslab.com>
From:   Don Porter <porter@cs.unc.edu>
Message-ID: <ef8bbdff-e891-bee3-677d-3606474ecc10@cs.unc.edu>
Date:   Thu, 25 Jun 2020 11:27:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200529152756.GA7452@invisiblethingslab.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/20 11:27 AM, Wojtek Porczyk wrote:
> On Thu, May 28, 2020 at 11:38:01AM -0700, Andy Lutomirski wrote:
>> One useful test for the actual kernel patches would be to run your SGX
>> workload on a loaded core.  That is, do something like taskset -c
>> 0 graphene_thing and, simultaneously, write a trivial infinite loop program
>> and run that under taskset -c 0 as well. For good measure, you could have
>> perf top or perf record running at the same time.  Look for kernel errors,
>> but also look for any evidence of your workload malfunctioning.
> 
> We currently run as part of CI several workloads[1], among them LTP tests[2],
> and sometimes it's not pretty, because we encounter stability problems in
> Graphene+SGX even without the patchset. We'll pick some stable subset and
> will let know. Right now we'll have to retool CI for custom kernels, which
> will take some back and forth with uni's admins.
> 
> [1] https://github.com/oscarlab/graphene/tree/master/Examples
> [2] https://github.com/oscarlab/graphene/tree/master/LibOS/shim/test/ltp
> 

Following up: we have been running a patched 5.7 kernel with v12 of this 
series on one of our CI workers.  As Wojtek mentions, infrastructure and 
other orthogonal issues took some time.

We have run our complete SGX testing pipelines successfully several 
times with no issues: no errors in Graphene or suspicious kernel messages.

I also did Andy's suggested test:
* Graphene running nginx pinned to core 0
* infinite loop on core 0
* perf top running
* Exercised with non-SGX apache bench several times (~10 minutes of 
testing time) also from core 0

Again, no apparent issues, nothing in dmesg.  I ran a similar setup with 
our SGX-specific Graphene (PAL) unit tests.  Same story: everything 
looks good.

Let us know if we can be of any more help here.

Thanks,
Don
