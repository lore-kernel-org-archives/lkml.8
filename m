Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BADC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02FF22B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596576110;
	bh=4R5Sd3HIF4qoYkoB6KuHcc7FaDf1cRMOEoKZ1jkn6wo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Cna6toNv2XKozcz4aYsGrcSRljApD+q/jvVNjMaYfRgd3Fsdyde80TW7LOaB3h2Yw
	 tlTGKi1my/kHxDeNfQgFH6iEAwcHQVin9CH5c20CRoxlU5KS4QT80jTxw2KtjMDyeK
	 UI2PBuigcc1MHWxu8414Gs5SY1aMil6R7C1NzkqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgHDVVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgHDVVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:21:49 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC4C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 14:21:49 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c4so6169844otf.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O4M2hw9rW/9hpO9QOqBXY3WQaDo2SJeJsBzFNR5ZUh8=;
        b=fSo4CKHmbZ0Uf258Pnm9fO7Z4oxT58PDd5fN96+4FvzdegY7XPpBNyrTILYWeRthrD
         vcv3e9eRPV0Z/0gej0gr5Kp5+3nJy1kRY8KvxNiQ9QHj5Hj2mjgJW0z1MqWBm8BC9fYk
         5sOlWZy63bI89hbqlAfjoNQ8cMXWMy6mv+o/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O4M2hw9rW/9hpO9QOqBXY3WQaDo2SJeJsBzFNR5ZUh8=;
        b=K94ycBfdMzms6WcYnN+u50iufvMBH+Z11akfjwJAtDUHWo38o+Zb44KQZBhhUYm+uh
         Qb1COzbAfDNplKFv9El7GrW6EpdXeP4/DlmcJLfel8uB24b6gU1TOfhYUobhSYdm+I0a
         lSbIP2nLvM3EO9BRosxdPIBwHRrucR7/T6runD/UdB6jxSUgp8Rg9By0oavxLsQxg0/8
         AG+9S8d/5Tqd3eBbMFcU6xMZDrJxXt+dl/6t4c22z2mN+po2v5QM2m+YU80QZjvoBSZW
         o9fK9tl8XEN4oFd3RX8af1QPUzAkhdTZicVdcdhXef3nmgbT9+0wK7zN/XUIR5AhDi8J
         Da7w==
X-Gm-Message-State: AOAM533gbN0ZFR7SmHhGW37iqzfp8IYvySL25GOpFG4z3UH6HHwwUVpK
        RgsvAG71G+9rQ8EYweaCD7evaw==
X-Google-Smtp-Source: ABdhPJyNDZblvigSgCyDfSxEYihQqaT1ilcpihTTWEKhHE2yeJKHy5OeY+Qp1rQYnV9plfSPqZ6v2g==
X-Received: by 2002:a9d:774d:: with SMTP id t13mr75726otl.22.1596576107841;
        Tue, 04 Aug 2020 14:21:47 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e184sm8989oif.13.2020.08.04.14.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 14:21:47 -0700 (PDT)
Subject: Re: [PATCHv3] selftests/timers: Turn off timeout setting
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>,
        linux-kselftest@vger.kernel.org
Cc:     shuah <shuah@kernel.org>, sboyd@kernel.org, tglx@linutronix.de,
        John Stultz <john.stultz@linaro.org>, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200318024215.5270-1-po-hsu.lin@canonical.com>
 <CAMy_GT9g48Xf=U==FeFd-8CaFM97u4WMkDBT013uzfjeqKMcfw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cf6c08ff-5d59-47ad-77e9-1f614cd7b3e9@linuxfoundation.org>
Date:   Tue, 4 Aug 2020 15:21:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMy_GT9g48Xf=U==FeFd-8CaFM97u4WMkDBT013uzfjeqKMcfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 3:01 AM, Po-Hsu Lin wrote:
> (Adding Shuah's linuxfoundation mail)
> Hello,
> do you need more changes / tests for this test?
> 
> Thanks!
> Po-Hsu
> 

I was hoping to get Ack from timers test maintainers.

Will pull this in for my fixes update.

thanks,
-- Shuah
