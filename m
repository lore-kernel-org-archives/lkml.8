Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E20CC433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE3A20809
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595900095;
	bh=wz5fEphdEHFwbTF0r9Ufc3xB+OXgMXkFzETS0fohnBE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=LzfCshnLcmiKQ8xupMRfCLb1oor6D0fpQFfUcVoyQw3je7Dr7KwxfT+hHmRgCSCBC
	 5hC5lsa2IXoUYDyu/IrnzhEcoAXNWnlKhlP8PXmFHZIs86v9yvobYjJrMUp+wicpty
	 ENSu+y387YdgVLql4YmRS1ymyDlPxIKSLR8t8/Cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgG1Bex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgG1Bev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:34:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC6EC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:34:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w17so16074939oie.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qZuvweddU5J1p0ldIWDpQIeg9reANpSyYykBNpL31Uw=;
        b=N1H/5fG+ho1wfw1vPmaFLrfJ49foDv1nj7jiIop7PCQ2amb7rJBcDtfLN+psz8aDSX
         aHmj0Nhn7GJHSs1fZII7VYceefJYq7uSrd4A0AO4PxMPqiwmToxVq+dqlqZDt7yEfdqQ
         JRbXn0tKLEcB2bR+hEH7pViIAw+qWrXNAmzbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZuvweddU5J1p0ldIWDpQIeg9reANpSyYykBNpL31Uw=;
        b=uOOGCeEnA+HY68cPUs5i5oIhNafpccJei/MuNeZEthfbhqbK0dCZTjU1MCSNO97U1k
         1TVwwCHCRpLWP9LrHwyyp4CzVRpJdGyvsrPbK84H79KqOclaQni1pd6LPmSQdwnjJEqu
         KDeJTjJsDO5/p4nuPULhiliuDwKn0JbYDwyCxqfyZ+DkOmn9+JvDIWfsedgUv7kFFXfP
         gT8YVPi6URlwlbRK0T6QEhlxKoj/2OtSTk1WsoiJ/+uWclXMDkmKllpKqh87A5nYXz8t
         ikWFMp21mZdtgIbl3dI1gU6a9ytbDn7Mq0+i4uKijVMe2YQ1MP5i/JtlIaY1PskWMOAz
         OtzQ==
X-Gm-Message-State: AOAM532nFrN5tgjVVjsIBI4jK+31jBrafFTkJjb/p45MGOy7PBJ3Wigc
        3PfDa66S0+0xi8FiuUHUit+uTg==
X-Google-Smtp-Source: ABdhPJz1sITJi5IKCVov8wsHCStG/A7yy14dwSvPYj3vrFOMIzGhXvPbgBMYiVE4km5BpdFCQGCxIA==
X-Received: by 2002:aca:bcd6:: with SMTP id m205mr1712566oif.149.1595900090460;
        Mon, 27 Jul 2020 18:34:50 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q17sm3678462otc.25.2020.07.27.18.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 18:34:49 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/138] 5.4.54-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2ef9cd1c-9bcc-c199-cb36-656f2a8441c8@linuxfoundation.org>
Date:   Mon, 27 Jul 2020 19:34:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 8:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.54 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Jul 2020 13:48:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.54-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
