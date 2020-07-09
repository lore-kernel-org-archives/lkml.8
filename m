Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5558C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF88D2053B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAof9Wa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgGIFQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 01:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgGIFQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 01:16:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C68AC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 22:16:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g67so453798pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 22:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=91cgWNdNTjuywuMBqdp6jcGvPo/gEqZWR0GA9Vdmqs4=;
        b=eAof9Wa/baDPpwGfDSvNMqcmulK5NTQAeiso5xODHHXSCnA7z0K8xb7mPwhjRxAT4g
         //EVlIUYHqZRywU/+4bUNf0Um8uANMgERfnimmksPGhYlwJGVdZAhjPbMIu5XQySJHBR
         rH1fNakfNGRf/FVCr4kpUBENfwoDxeNdlHlDqTRpFi4NJwj+2+SHgWwykkdZyX+7K5zC
         6xEQ/rVbbUNcx7C3pPclpH4+PjU/qSJkah6E4PInFLfuvnMud5WO7gYvwStZDHaAy8li
         ER+dx9FjTtt4fA1XzoIP4tuX9Z1QUieuuhg2NM+bXbeFtGhSlTmJYjbXgRAD6KFWKp8Y
         q2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=91cgWNdNTjuywuMBqdp6jcGvPo/gEqZWR0GA9Vdmqs4=;
        b=mcVRk+mpAwHAEbp61QsqN35LcvJP5IA9zXwhiXPLqw7YLzmpNDSidV41k53sFTZI1F
         UFf6BdfAW5Qe9h2cNgUyJuckeh8aUgWt8nNDqgpOJTRpIUs6DrqV2z5ZSKSIsT+xLMwB
         o4VTCHbp5iICtJqsIeguw/ICdJmSoyM5lcUThse/fggeJDNS0uESxUAt88Y5Is45K0Bv
         92JNGHUUxn5yDmBNKPAeB90qBqKkUpInRXF8mLEpzJrl3E0pXkisS5NY56GdIl0RRYmw
         b/t4W9nbdXv+/r2s8Dau7g8KshUbEWt0t4PfNNMVY22urQm4F50IXNxiRiptaWpa+NDE
         ocmg==
X-Gm-Message-State: AOAM530/N6bnFc9z+yXUsPpqZmHFrkmCKtwyT+2PBjze+3zVWgFElTfE
        VZwzggRsNuVMxUaq9DGGOzc=
X-Google-Smtp-Source: ABdhPJxRAWzAVCj+ltV+EgEao0QfDkJRJJOJBELElndaan+ZHkjQ8rK4N5zzVlmHvJ9UnYHcWwS4TQ==
X-Received: by 2002:a63:a558:: with SMTP id r24mr54074568pgu.70.1594271790216;
        Wed, 08 Jul 2020 22:16:30 -0700 (PDT)
Received: from ?IPv6:2001:470:67:5b9:5dec:e971:4cde:a128? ([2001:470:67:5b9:5dec:e971:4cde:a128])
        by smtp.gmail.com with ESMTPSA id h3sm1056943pjz.23.2020.07.08.22.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 22:16:28 -0700 (PDT)
Subject: Re: BUG: KASAN: global-out-of-bounds in is_affected_midr_range_list
 on arm64
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        linux-arm-kernel@lists.infradead.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>, james.morse@arm.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        saiprakash.ranjan@codeaurora.org, steven.price@arm.com,
        suzuki.poulose@arm.com, Mark Rutland <mark.rutland@arm.com>,
        ascull@google.com, Marc Zyngier <marc.zyngier@arm.com>
References: <CA+G9fYs3EavpU89-rTQfqQ9GgxAMgMAk7jiiVrfP0yxj5s+Q6g@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <559c5a04-a2ab-bfa2-c26e-4fbbf6d273ed@gmail.com>
Date:   Wed, 8 Jul 2020 22:16:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYs3EavpU89-rTQfqQ9GgxAMgMAk7jiiVrfP0yxj5s+Q6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/2020 9:36 PM, Naresh Kamboju wrote:
> While running LTP cpuhotplug test on mainline 5.8.0-rc4 the kernel BUG noticed
> on arm64 Juno-r2 KASAN config enabled kernel.
> 
> steps to reproduce:
> - boot KASAN enabled Juno-r2 device
> - cd /opt/ltp
> - ./runltp -f cpuhotplug
> 
> metadata:
>   git branch: master
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   git commit: 63e1968a2c87e9461e9694a96991935116e0cec7
>   kernel-config:
> https://builds.tuxbuild.com/wc75HkrGrWgQCdI-l_1jUw/kernel.config
>   vmlinux: https://builds.tuxbuild.com/wc75HkrGrWgQCdI-l_1jUw/vmlinux.xz
>   system.map: https://builds.tuxbuild.com/wc75HkrGrWgQCdI-l_1jUw/System.map
> 
> Test log:
> Name:   cpuhotplug02
> Date:   Thu Jul  9 00:09:24 UTC 2020
> Desc:   What happens to a process when its CPU is offlined?
> 

Just sent a tentative fix:

https://lore.kernel.org/linux-arm-kernel/20200709051345.14544-1-f.fainelli@gmail.com/
-- 
Florian
