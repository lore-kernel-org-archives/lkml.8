Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254BEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F288320772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594392132;
	bh=OsQRD2q3FFSC+Hr2eELzlPhknJSqCGsOyM/wRaQIOoI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=JCQ8tutwZgUbnhutL5qguO4PrWoQk162SatLH2ID09OYjDZoaRJ6MkqAW3M8pTNId
	 LqzT+0zZIp3gFI/lJ0QBqTf6K5umS+9GjIhkXrBqDHjbjA0yQJHIZp4oeT9kxBZT9M
	 wwnFhs7RYaWpcRU6wnMJ6Z+KweDkp7v42ImX8Qf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgGJOmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:42:10 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDDEC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:42:10 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w17so4957892oie.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ExMs+y6Mw4TrsX6EmWrdA2mMgSpw5cS9CeNTmOH0Bz8=;
        b=OaICqlmH0BTTjIIyurx2hc5a8IBY0BOoeWNypqGAnRAY5QkqCCxrbtKvlkhaSkv04I
         LyzAiApi4ovNyDawJ/Fape8eWAq6cEdNS1Jx7BGqNGe/liC3rJa15aOlOY/T+iQ7flZm
         G8AG22zr6Fc/uRfx0nThD8IXGw5BjQce/eVno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ExMs+y6Mw4TrsX6EmWrdA2mMgSpw5cS9CeNTmOH0Bz8=;
        b=sMT+Cu1z6DF4qPe2XedepMa8vdc31vRj5NmbLqPeG+tjfe1MM7Yr10Jd4+pOF1N/Tw
         l7tbh6qOHg9USOCO+BBK9o2OkfzuN4bLzdpzYfbCRXfPM2QgWg7c/fL9nIUdjZmlYT+u
         s70ewKi04a5/qwETUyrkawcb2Y+zAe6Ph7/cr5hhV2duZTcVtYF6zctAyL88EWvZd413
         9H3zJUXEfOeGkW3FcxiwAv8KE3zwztxDOJrDueKy0fUDVq3UWfVwd5cXUQnenOa51dKb
         MpHg7WuiqrU2Q1J+EH5xa+gf97Hc0DHsWGolpjL3A3+cThSKN+XP2TvVljlYtqxyyywY
         KiAA==
X-Gm-Message-State: AOAM533mU5N/H3xy0OGrniq8yU6svZ9wLz7E8/I6xSmMBjL5Az7/eWSp
        aLyzeM1k0Y6UKEyGFLkYf2HKfg==
X-Google-Smtp-Source: ABdhPJzwI4IBtamvcpLgm7tNl3maUTvJW8Y5ZglEgX0qJoA8Armz+wMIgmMx+8Rl5rZKZbE7Umu15A==
X-Received: by 2002:a54:4884:: with SMTP id r4mr4444065oic.74.1594392129607;
        Fri, 10 Jul 2020 07:42:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z2sm1123720otq.17.2020.07.10.07.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:42:08 -0700 (PDT)
Subject: Re: [ANNOUNCE][CFP] Kernel Dependability & Assurance Micro Conference
 - LPC 2020
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        "lukas.bulwahn@bmw.de" <lukas.bulwahn@bmw.de>,
        "devel@lists.elisa.tech" <devel@lists.elisa.tech>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <675ed25a-3fa8-e288-1be4-41710a807d1f@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <34aa3ed4-7405-d1b2-f884-30ee5ad279aa@linuxfoundation.org>
Date:   Fri, 10 Jul 2020 08:42:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <675ed25a-3fa8-e288-1be4-41710a807d1f@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/20 2:58 PM, Shuah Khan wrote:

+ devel@lists.elisa.tech <devel@lists.elisa.tech>

> This is the call for proposals for the Kernel Dependability & Assurance
> Micro Conference at the Linux Plumbers Conference 2020. It will take
> place online during the Linux Plumbers Conference on August 24th-28th,
> 2020.
> 
> The Kernel Dependability & Assurance Micro Conference is intended to
> bring the safety-critical systems community and the kernel community
> together to start a dialogue and collaboration on making sure that the
> kernel is fit to be used in safety-critical systems and that questions
> from the safety community and other wrt. software quality can be
> answered adequately.
> 
> The goal for this conference is to explore kernel dependability as it
> relates to safety-critical applications in the areas of uptime, tooling,
> and processes. The focus is going to be on the following topics.
> 
> - Kernel Quality Assurance beyond Testing and CI?
> 
> - Understanding the User's Expectations on Software Quality for
>    business-critical systems
> 
> - Define safety requirements for overall kernel: features, tests etc.
> 
> - Define run-time characteristics and requirements
> 
> - Identify missing features necessary to operate in safety critical
>    environments.
> 
> - Discuss safety features
> 
> - Regression Testing for safety: Identify configurations and tests
>    critical and important for safety quality and dependability
> 
> - Discuss and identify gaps in tests.
> 
> - Add tests and add configurations to existing test rings.
> 
> - Understanding the Kernel Development Organization and Management
> 
> - Assessing, Measuring and Evaluating the Development Process
> 
> We encourage submissions that do not present a final solution. Instead,
> that serves to get feedback from the community, to point to action items
> for future development, and that can result in patches for the Linux
> Kernel and Linux ecosystem in the future.
> 
> Please submit your proposals on the LPC website at:
> 
> https://www.linuxplumbersconf.org/event/7/abstracts/#submit-abstract
> 
> And be sure to select "Kernel Dependability & Assurance MC" in the Track
> pulldown menu.
> 
> Proposals must be submitted by August 2nd, and submitters will be
> notified of acceptance by August 9th.
> 
> thanks,
> -- Shuah

