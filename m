Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5D4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFE720672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593463080;
	bh=JaToVEPg96WlYm3ztJ5uXKp0r8nvTwnJt6eGF53wvDg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=zYSJSoLcFQPGghdRmc4XP81kpS3fqfADfoeK0zMqaOSGAZVL267ek1ROKDpGUuBIJ
	 w0Gc6J5bFRoOgNvD2dNPElREXyTiScxBlbmSujThpQEVXbpcN2jgc3B/21ZqirawFh
	 TKYvXkgLkyCKkmbQvOGmX45keaH5zPmmk1XkJ2Ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbgF2Uh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388942AbgF2Uh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:37:56 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14501C03E97A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:37:56 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 76so2265343otu.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fm46DHlI8TQvkZHu+cmRB2IdIOYCe5xNqBHbvb86YyI=;
        b=V2Y3vTGJ12Ll/zYo3s2cphA4SCNvy6j4fT/a3ty8OKVVsQYsdqWJ227S2Q04r/yETO
         h+WFXtp2g82jsnVpQ55K1BaUAT6r6jDmYafNQeIrtx27I17+9xkY5SMcWC1b7EuJVqW7
         J5tQYaClR7vkxyDmmz3EYV/8sbafzTBaw0184=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fm46DHlI8TQvkZHu+cmRB2IdIOYCe5xNqBHbvb86YyI=;
        b=kmkvA2QoI+9MGO4i2VqfZll8hIVOdrZh90wktnpoTLEBkgA/3g7QXclAfj+2oqKLYD
         VQWl4aAVoNqATt6kkUJTc5TVjabBVtFWqhhbyn9S7kSr4qrtZ3jFhXSbHLL+4xfBj9wf
         HFCOeuRE0EX+NGnW9SO9D0Jwl72zqaCSIUuk6sf+RBcyoTHFe50aWPMNhcTH097ogNym
         Bxt3Ivbw98fosEx5nX8NWVgqqbWb+ZNMRW7ENum/EVLkHOX3uixOZLihSfGUL2r+vFk3
         YN6aRRuBsXamSNRoz5o2K3mgJr6J3+fnTXEL6gu6gI6eVyf5QY8xQJdApUkan0+PtX2A
         h27g==
X-Gm-Message-State: AOAM531MgW4u8y6I3+rPy0xfRcvFvXqgQVUqCH6nUaVEcnxKhioBbVy7
        qAYKjslaZsfyxYoAeQgSAQCAbA==
X-Google-Smtp-Source: ABdhPJzNAvuk+0W2NxftJEP+MRskEe2g3Brg83ppvWRminnOPpTlroZr/g6WX21bBuN68CdAychIPg==
X-Received: by 2002:a9d:4a8f:: with SMTP id i15mr15826182otf.77.1593463075332;
        Mon, 29 Jun 2020 13:37:55 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g126sm187086oia.41.2020.06.29.13.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 13:37:54 -0700 (PDT)
Subject: Re: [PATCH 5.7 000/265] 5.7.7-rc1 review
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <42dadde8-04c0-863b-651a-1959a3d85494@linuxfoundation.org>
Date:   Mon, 29 Jun 2020 14:37:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On 6/29/20 9:13 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.7.7 release.
> There are 265 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 01 Jul 2020 03:14:48 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.7.y&id2=v5.7.6
> 

Looks like patch naming convention has changed. My scripts look
for the following convention Greg uses. Are you planning to use
the above going forward? My scripts failed looking for the usual
naming convention.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.6-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.7.y
and the diffstat can be found below.

thanks,
-- Shuah
