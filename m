Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AEAC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4C020777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7B8iwIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgCTPih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:38:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34404 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgCTPig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:38:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id s13so6910375ljm.1;
        Fri, 20 Mar 2020 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j6DQ/Qd3A1JCf0tsOt9+KVUKpk09g/ARGbV4TBwRWDI=;
        b=u7B8iwInH5wI88YYfjPWNLJ1g5C+IWECHRnBDrhq8A6QsZXrolcDT56feRjFFO5aiz
         HtN3pg3whE61P+VG654VWxyj6cprHfm6mXGCSesaZnlF0ecehfDeKgwHMaSHPe7T+S2Z
         opeLDSXl+Ee3sqxLEdf7k4c1xoJkB00i2SxsXCMTVW/SU4X7ATYQI7u3o4Fz7HwNHwCk
         e+Z1BprV46wiglmc4ukghNsgnlpiKQpvjP30PjWvNrN3sYzPkbHWQXmIKwBB1nPgwyXC
         Mz669FbmL0ulZRifIpM/v8ZeHC+HRF0m97SFCNY36c2K+OFKExJaoKdGlvtmUMJzs/Sa
         ylJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j6DQ/Qd3A1JCf0tsOt9+KVUKpk09g/ARGbV4TBwRWDI=;
        b=MophzOSVNT/wjbUiNDnse0SBjKk0S4eV+u/7+ysI/nKZw5AghL18jeqCkR3EBMrqLi
         IY/5tRpowSsC+CPW72Fl3ETHCTop+SnWGkoKl2q9ErFNQOLtKAjDkUaWotsxsx4fTvuK
         W8l9nGgQ9sM+7B1N1o1YFvqIx7Cd71bdhUJVqMGm5ogRE253cSKbQMzwFIomWDeIxlNh
         Cr56faY0kTgqhk1LPnh+viINZ5K4BNsDqYKZP991tH/x5S54AOQMDNdCMeIirhTcxmjb
         NXAQ2z/3FHJRPmF6d7bR7QgHqTRP4w94m7TAfl/pz0RK0v2guWtxYCZThvebN3iqNdJ9
         cwnw==
X-Gm-Message-State: ANhLgQ3poa8rHzn3uLZGjIc6S1hplFxtr6esgBieDJQ6NrJj+iPMdKGk
        GSm86HfrZmBcC0Q0Hhyko527G5BS
X-Google-Smtp-Source: ADFU+vtWSZ0bdDsUVLFMXqcEvrLFZtX4T8XrPkQfe8antWDczqJJP2zJ0bwQOaPNXP47K9FduB+Ozg==
X-Received: by 2002:a2e:a0cd:: with SMTP id f13mr5667476ljm.198.1584718714216;
        Fri, 20 Mar 2020 08:38:34 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id x14sm3472501ljh.33.2020.03.20.08.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 08:38:33 -0700 (PDT)
Subject: Re: [PATCH 2/7] clocksource: Add Tegra186 timers support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
 <20200320133452.3705040-3-thierry.reding@gmail.com>
 <48b2099c-dd83-d4dc-aab4-8c6f68a215cf@gmail.com>
Message-ID: <da2a0501-664a-c5d0-7b13-174e5347eaf7@gmail.com>
Date:   Fri, 20 Mar 2020 18:38:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <48b2099c-dd83-d4dc-aab4-8c6f68a215cf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.03.2020 18:11, Dmitry Osipenko пишет:
> 20.03.2020 16:34, Thierry Reding пишет:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Currently this only supports a single watchdog, which uses a timer in
>> the background for countdown. Eventually the timers could be used for
>> various time-keeping tasks, but by default the architected timer will
>> already provide that functionality.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
> 
> ...
>> +config TEGRA186_TIMER
>> +	bool "NVIDIA Tegra186 timer driver"
> 
> tristate?
> 
>> +	depends on ARCH_TEGRA || COMPILE_TEST
> 
> depends on WATCHDOG && WATCHDOG_CORE?

Actually `select WATCHDOG_CORE` for the WATCHDOG_CORE.
