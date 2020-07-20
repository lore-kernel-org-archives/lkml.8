Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79BCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B643B22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595289276;
	bh=boeIuvMyvV6JO24brtbKi8T/TPGTvsvSpquc1M1znxU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=yUcKJ8Z6W8tQsAMdRrsvrK+x2zOcqFh+bNVk2/mI2E/nf3bmfovh4tRL8vKAYCifc
	 edZk91GJzjht6a4HkyKy+GyOpyWiUDKni1XRNdB4ShxAZLswM9OmFoUnDHzBbea8P7
	 PLo7Dd8jbRBhAdW9cn61UcCpC5kEAJuQcZdn42Hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGTXye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgGTXye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:54:34 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC89C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:54:33 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x83so15785939oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=if+J3IVB9GmBlt0xwkKvRDuHXhNcTWZ9ERH3YUDWulU=;
        b=PpZ7kO7OncEuLolD3qAx3ZaBqS9vrWM95lqFbasCA2aXj+MZ+rVQtPZWEMNIanGf61
         Na6Oe+TcO5HMaPI7RB6zH6J/H5pLbYS/aukNu9udrsSzXPLt1r/0zM+8w1IfpiP1XrwB
         AkuqoV0NW1nuCu6cUp39D3jYjEPD/Wm2wFo3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=if+J3IVB9GmBlt0xwkKvRDuHXhNcTWZ9ERH3YUDWulU=;
        b=FOnVx/13f7x8XKAMPN3/tbAupcxSS0KmoVM+7xwZYTI0RJc//mBDZ4siPBO5FIBPmM
         Vt+5HWWNr7+PyR5tgfdyv+8zGiM+/QAp7KilVU366HPeJuN4+SHY9ha3louEMBvlzL5G
         6c4FutQ7tQxPXV5Weu8DHxvQWgBY4Fq0DlB+qasd9ViOn6bJjrDNfwcQHh+4k61VPiI6
         obigHejetWGPHs9P0unq2MLDOlRF2kAuNEi7aMbf86oU6sdTx7mrDQ/zHg2HIccPsKtM
         evETTYYZ70oIq1Cv1Sn2R4Vmk++ceWGszlQzxaX4z/1cHKoqc/MvJKUTuwm4SThbEYd8
         0KUA==
X-Gm-Message-State: AOAM533zg/tdIbOARiErweZnYOUQdJBX3q9pOwWrT0035j2VRklmG2V2
        QijtPmwk82VZ1MqWSsEVEZlAog==
X-Google-Smtp-Source: ABdhPJyDkBbrRB4Iv7wLrYZEpKoiuxvmE0USp8a8BxXTGbsstY3eCXpSVmnlfwVnDfDA0j21MXvBSg==
X-Received: by 2002:a05:6808:199:: with SMTP id w25mr1215562oic.38.1595289273305;
        Mon, 20 Jul 2020 16:54:33 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h16sm285021otr.10.2020.07.20.16.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 16:54:32 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/58] 4.4.231-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b089dde4-8f8b-908b-9131-52939b42a6a8@linuxfoundation.org>
Date:   Mon, 20 Jul 2020 17:54:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 9:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.231 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Jul 2020 15:27:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.231-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

