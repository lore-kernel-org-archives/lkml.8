Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A92CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71233207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="MZQChu7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405623AbgE1Rhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405372AbgE1Rhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:37:31 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E06BC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:37:31 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e16so766611qtg.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4D6oc2aAM2Z3zwgP8rvrzBXzf14PvHe0z0eLDVTjiR0=;
        b=MZQChu7Xs6nShlS7SiHlThZ/i/aBsOsT86aPA/kMrDQ8RZftybTUf4gmtmOlSwJgW8
         5r0i3br0PpiKXaawz9HHPY0fHpS/pfwfRXhRfY9fq3+K0O9PmH0+rBsGiRWgKxIfGno2
         f+RzadBkWYiRnolsVYIm2YCqng/k0GLRPwf4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4D6oc2aAM2Z3zwgP8rvrzBXzf14PvHe0z0eLDVTjiR0=;
        b=cB2shxouS6VpSCvboEccKe7SSXHn9yAdqdskkIIs7x9dxabZUdP5f9+CgGY5Z3rdW0
         0zrSCnAQq1+auE3Syl7GSvAHyGNrWZoQyCbeZyC/yAKLCZdRBGQ5GkrsxJgnjMfFzhJ5
         V35lttXDyX1L33A6Tld6rOIBEYmobtGBqY4mOmTbDs/8hxNvggkFi6WEeEy2HnSlKOyW
         dt5OOC3SLv70APsOgPoDUpE5DXwJ3EiPP+oTULHZfpfK2bRPF02Etl1sfzNxM7CNkt7h
         8SdHtxc+XpdR2ImZ4nXdkD8Kfwu+Wc+voDiggjUABNsTLcFs7HGg4z4AeXNLgpg8uFGu
         MY/g==
X-Gm-Message-State: AOAM531S0k845mZTJfirCyCfr6HDpzJ7Cce60oYReFQq64+Ep+S40hYW
        M3UsxvIGvEhg/LOurM2sM3e7cg==
X-Google-Smtp-Source: ABdhPJzmBexkt2yGDZeAZQKSW78lFZM+3/zMd8hLMDLQMWzYMlCzbWVJ6AkfklehmzH+Wo88mSEupA==
X-Received: by 2002:ac8:6d1c:: with SMTP id o28mr4358558qtt.388.1590687450408;
        Thu, 28 May 2020 10:37:30 -0700 (PDT)
Received: from pepe.local (71-142-124-255.lightspeed.rlghnc.sbcglobal.net. [71.142.124.255])
        by smtp.gmail.com with ESMTPSA id a82sm5410800qkb.29.2020.05.28.10.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 10:37:29 -0700 (PDT)
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
To:     Sasha Levin <sashal@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
References: <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
 <20200518153407.GA499505@tassilo.jf.intel.com>
 <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <87h7w7qy18.fsf@nanos.tec.linutronix.de>
 <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
 <20200526202739.GG33628@sasha-vm>
 <7a25e82a-9ef1-f13b-be42-2d7a693592b4@cs.unc.edu>
 <20200526225120.GH33628@sasha-vm>
From:   Don Porter <porter@cs.unc.edu>
Message-ID: <39df26f2-9d17-b0f2-6a55-48195542637b@cs.unc.edu>
Date:   Thu, 28 May 2020 13:37:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200526225120.GH33628@sasha-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 6:51 PM, Sasha Levin wrote:
> On Tue, May 26, 2020 at 06:03:35PM -0400, Don Porter wrote:
>> On 5/26/20 4:27 PM, Sasha Levin wrote:
>>> I'm really worried about the disconnect between how you view the current
>>> state of Graphene (and the industry) vs Intel and the various cloud
>>> providers.
>>>
> 
> Sorry, I wasn't trying to suggest that all cloud vendors are pushing
> Graphene, but rather than SGX enabled platforms became a commodity
> product, users will end up using Graphene-like applications.
> 
> Let me provide an example:
> https://www.alibabacloud.com/blog/protecting-go-language-applications-with-the-graphene-library-os-on-intel%C2%AE-sgx%C2%AE-secured-alibaba-cloud_594889 
> 
> - a "practical" guide on how to run Graphene in production environment
>    on one of the big cloud vendor platforms.

You have convinced me there is a concerning disconnect here, and we need 
to be proactive as a project to correct this.  We are adding warnings to 
the project with all due haste.
