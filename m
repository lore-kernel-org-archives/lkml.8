Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8C8C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B163D24680
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pg9j5KJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgCJOBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:01:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44613 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgCJOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:01:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id l18so5936641wru.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AnADibbBZNTbkXF8oP66EJ2LJrhavRvEH5BdYa4Z43I=;
        b=Pg9j5KJ9zBcxILALXyg3gWGW7/Stl3nDwqDBu50I4TaRt3m76JyHsQ33/vAbB8E4DS
         N2SVSJq3bfMIINej22L0ObEE9D9LOT7ZNOVxV/QW+oMokDluh7G9hVa2LZdTtbK3YmwQ
         9vkoPwdSUFk4Zd5ENqC82QO9dpU3c/lWcUaZxzAmUl1crb4+IeC7Od0byO1kFeKaMMwm
         GC1TzchHvo2y7X6XRjlXvM8h7shcu2xmS4xB+5QQCTVMU457W3C8Zk/oYH+/QkO5D7U/
         dGz/XCd8UC82saEVqT9/blCgLTBUhqxfDqIizN6Z8bmny0ZTKiZx2YeJCnQLtxSRY714
         zI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AnADibbBZNTbkXF8oP66EJ2LJrhavRvEH5BdYa4Z43I=;
        b=NSbF+UNmcprGd1cbnZonqUpX/z+lTvQF6s/jrVNHcNbwg9jTBInJ152jdRWtbjoGCs
         fLMOFQBBCFQUWk2ySMPqGJHesfEhWff2zjPMUH+gXzwiPcAj3m1jZ0Aq3F4HAPBl50gk
         MP34a/e5v2uwOS37YyCzUMu6+e3P2JyOEaWxym86Rrjx48ZXChfFYE4H9/+bNaSJUfu7
         B3LkaKowkISGJpID3AU7zYhT6IPS6eAcHDHn/dYBe382kRsoKmOtmMZLz/84TfJLQRZj
         auNaLHM6vAOjBMjF6n6CIFGyIllxNO7Tb0uosKeqHl7m7qaTYP/hbHYRarsI7jazsMQn
         5aQA==
X-Gm-Message-State: ANhLgQ1HpZ1zEsTaMpqP5/XhjGpo199geq6D8zZa943+LgDw2qkw28Dk
        L+Xv6xzE95HKVOS4ePNWTA/QXfIuqUQ=
X-Google-Smtp-Source: ADFU+vtrFiSPgHeTnpNZFmkHKh2VMNUzxHfW2YQYEVtGmsqDarT61MtKoEjE1bMeApA7NHSvLPnpKg==
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr27238694wrs.272.1583848890432;
        Tue, 10 Mar 2020 07:01:30 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q7sm12887765wrd.54.2020.03.10.07.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 07:01:29 -0700 (PDT)
Subject: Re: [RFC PATCH] soundwire: bus: Add flag to mark DPN_BlockCtrl1 as
 readonly
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200309173755.955-1-srinivas.kandagatla@linaro.org>
 <d94fca16-ed61-632a-6f8c-84e3a97869c7@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <92d3ae1b-bace-1d20-ef99-82f7e1a0a644@linaro.org>
Date:   Tue, 10 Mar 2020 14:01:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d94fca16-ed61-632a-6f8c-84e3a97869c7@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2020 18:05, Pierre-Louis Bossart wrote:
>  > My recommendation would be to add a DisCo property stating the
> WordLength value can be used by the bus code but not written to the 
> Slave device registers.

Does something like "mipi-sdw-read-only-wordlength" as slave property, 
make sense?

--srini
