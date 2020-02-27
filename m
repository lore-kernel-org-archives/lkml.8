Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B59C3567B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79861246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582821926;
	bh=avk6uX+4BTbbcHe3QMpkfnMDgU6Bb2r2GlZdK/J3X/A=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=YTqo20mofrEOUXEhktQ64ig/lEddYNbqYC450GynkOzZE409iR1T3h7JGSFy+5elj
	 poevkTMQR2sKMSn2PeXMkb3s5edwwtAoaoMMWy7KE4VyaQFIKbzd/kVs9kGO9dSOmw
	 WnS2RzwuGZOeKUOYyp36oIpL/U9+c/rNKAKMOqOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgB0QpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:45:25 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34110 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbgB0QpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:45:24 -0500
Received: by mail-io1-f67.google.com with SMTP id z190so200727iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 08:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rS6KqBFssX9ZUdW6+MPkG1KvIc6wVLI2emiU+QF0qwg=;
        b=XaBoABkOukH7Nu7mt4lsMgCefNzcJQuXa2aVFVbkfZpp6Tb5s+73tbFVKvoyGjA/de
         rmZCbRd35i75iH1YaR3+beQ0/MRPNMdEGj3CTigZMKUY3xL+M1uKsj1ZAx7tdcdtuV87
         YOAZpAJF4zquagazdIfTcwOMiCpDIc/iUts64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rS6KqBFssX9ZUdW6+MPkG1KvIc6wVLI2emiU+QF0qwg=;
        b=UTpd3rFqij24pv0TBIZqpF/8rIk39Ovc4HGBurccOyAy1SL9MAVsCLpkRK8WV5Rya9
         IM3hZMAswujtHf4EtDMPtwm7E9MjfF8/Y0x5K8u8skMJ7hFEKEaApyGFy+SDkfK4l+HL
         NGP0/ciIYTNxod0fvsQZmlNVKeQpj/RIo7CXaBGZ3n6RUfW3sZGU1YRJ3oF/izy0Qw/g
         xlOXM0pXAzxQ/geeMqlgMYFiEQO/Q69isaUOdNwYGc5R1WRJI23XxwjzsoQsoDcNv0cH
         sqNKaI9M5RDLak5mi8MdU4PpzHghxQkb3mFKJzHr8iUplH638RYv2s4Rth19zEIWYLF+
         Nnjw==
X-Gm-Message-State: APjAAAU5L/CksgSLF0tWWBqCAxfhI+z1xpodgNo60Xktr4CJ40U3mpgA
        Vl3i1/USqvpcNcAjKpabzQfXFw==
X-Google-Smtp-Source: APXvYqx/a5Dli7aKEcWZrJspfguzTO9DfNqargT1han0HSOgIYlEsoiSlvvxXv/MLc1HIIpISgSXpg==
X-Received: by 2002:a6b:700e:: with SMTP id l14mr187328ioc.170.1582821924223;
        Thu, 27 Feb 2020 08:45:24 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i16sm1978584ils.41.2020.02.27.08.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 08:45:23 -0800 (PST)
Subject: Re: [PATCH] selftest/lkdtm: Use local .gitignore
To:     Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <e4ba4f716599d1d66c8bc60489f4b05764ea8470.1582812034.git.christophe.leroy@c-s.fr>
 <202002270817.1C32C98@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f804d7bc-134d-27f8-daa5-6bbf9f28b54d@linuxfoundation.org>
Date:   Thu, 27 Feb 2020 09:45:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202002270817.1C32C98@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 9:17 AM, Kees Cook wrote:
> On Thu, Feb 27, 2020 at 02:07:10PM +0000, Christophe Leroy wrote:
>> Commit 68ca0fd272da ("selftest/lkdtm: Don't pollute 'git status'")
>> introduced patterns for git to ignore files generated in
>> tools/testing/selftests/lkdtm/
>>
>> Use local .gitignore file instead of using the root one.
>>
>> Fixes: 68ca0fd272da ("selftest/lkdtm: Don't pollute 'git status'")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Yeah, that's better. Thanks!
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 

I will apply it for next rc.

Thanks. I should have noticed the problem in the previous version.
It slipped by me. :(

thanks,
-- Shuah

