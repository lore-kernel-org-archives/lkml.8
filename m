Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81D5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9CE2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591118832;
	bh=Gnfk/L+yiqNttcIGgtJu5mVCUV/4/jFTeB4avBOhP6A=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=PK+xe+lOCOXNu0HGRs8C83K4c1OFdWocW5w0ExtYOERAFnLD/H3mxtlEPr6BREpfz
	 eCJcqSla+xNDnS1h0tEjuQdNhI5CZUMXk+ZvD3gnkqMM/igM6uJwDAtB4UHBr4fZP0
	 cEvRb5ip2Y0QlQkKzasy5Un9S1sp0NmrFLi08VAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFBR1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgFBR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:27:11 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6830AC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:27:11 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z9so12727872oid.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iesdJmddYmf/ykPLINC0s6duDM2tr0OEvrj44zXcoWc=;
        b=gmSYlDf/V9gk1oDLdqfWhPTpd0ui0RQveZg67Qxf3uEG7N8KrFAiBRsmN0mWSChTjZ
         7AGb/+0XeYTm8lQuTmndoUEhkq0NWu6EUKKbKDWl4JCosplCESefOJgCHte45MfAZy2I
         A7tMJQmcpPXT5n0JNXsHnO+Kln2hpnjZTnUwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iesdJmddYmf/ykPLINC0s6duDM2tr0OEvrj44zXcoWc=;
        b=J690b4z6TFBBvfKzp2UsQF6gFkvE4NeeHn5U9uC6+GVH+g5OX4A9eA1PG34zaFxxdF
         Kg8xk5RbW5D5hb3I1ZHXXtC87NYZZ3bZytmfKE4lLjZ6KhDp9FrWo/CWhCjYrPW2CC/A
         YAIvO9LV+Yh+zsC8IAIT31lpFFIawFXpfIPPjnAtrAuTQ3fLO2cMt945xLxcTDoWGvXC
         bxVDrBocilFnn6edcD9f1cgTVPAJgUFVWcjUoJnadooNzvGZHl26gBI1iYJMpRB+74rI
         H3KjIrrBVs5GpZObK2GbHteXsvg9eRto8wlbfeQNx9sxIoi2ZIoF61T3QycA/YpU4jsT
         DjSQ==
X-Gm-Message-State: AOAM532XzQlMgpl5J7bNXnOJMrbfxb1z9VUjS5xuIfcyCZUAQtmd3/ow
        imETXPTcx7yxRRJw8MrLe0tk3A==
X-Google-Smtp-Source: ABdhPJwuvWy1mX1kvJpSrtpxmEV7mhd6fK4xZjeDUVcnCfNb3AcH/5HO/U5fNs7fKLK+iQ2iGZfGhQ==
X-Received: by 2002:aca:3e46:: with SMTP id l67mr3859330oia.92.1591118830160;
        Tue, 02 Jun 2020 10:27:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k7sm213929oon.29.2020.06.02.10.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:27:09 -0700 (PDT)
Subject: Re: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
To:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>
Cc:     Petteri Aimonen <jpa@git.mail.kapsi.fi>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org
References: <20200602101119.GA11634@zn.tnic>
 <20200602102951.GE17423@lakka.kapsi.fi> <20200602105649.GB11634@zn.tnic>
 <CALCETrURrz=L5f-HHF3kZtUqV0dw5hAEGqSxWTsOjoZvOKaccw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8b1f0bfa-79b0-74e4-0241-8b2a94491807@linuxfoundation.org>
Date:   Tue, 2 Jun 2020 11:27:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrURrz=L5f-HHF3kZtUqV0dw5hAEGqSxWTsOjoZvOKaccw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/20 11:03 AM, Andy Lutomirski wrote:
> On Tue, Jun 2, 2020 at 3:56 AM Borislav Petkov <bp@alien8.de> wrote:
>>
>> Hi,
>>
>> On Tue, Jun 02, 2020 at 01:29:51PM +0300, Petteri Aimonen wrote:
>>> The kernel module is not actually x86-specific, even though it is
>>> currently only enabled for x86. amdgpu driver already does kernel mode
>>> floating point operations on PPC64 also, and the same module could be
>>> used to test the same thing there.
>>
>> Then make it generic please and put the user portion in, say,
>> tools/testing/selftests/fpu/ and we can ask ppc people to test it too.
>> People might wanna add more stuff to it in the future, which would be
>> good.
>>
>>> To deterministically trigger the bug, the syscall has to come from the
>>> same thread that has modified MXCSR. Going through /usr/sbin/modprobe
>>> won't work, and manually doing the necessary syscalls for module loading
>>> seems too complicated.
>>
>> Ok, fair enough. But put that file in debugfs pls.
> 
> I think I agree.  While it would be delightful to have general
> selftest tooling for kernel modules, we don't have that right now, and
> having the test just work with an appropriately configured kernel
> would be nice.
> 

Let's extend it to do what we want it to do. I will happy to take
patches. If you have some concrete ideas on what we can add, please
do a short summary of what is missing. I will find a way to get this
done.

> How about putting the file you frob in
> /sys/kernel/debug/selftest_helpers/something_or_other.  The idea would
> be that /sys/kernel/debug/selftest_helpers would be a general place
> for kernel helpers needed to make selftests work.
> 

Is this a workaround for the lack of selftest tooling for kernel
modules? In which case, let's us focus on fix selftest tooling.

thanks,
-- Shuah
