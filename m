Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56078C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D932063A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jonmasters-org.20150623.gappssmtp.com header.i=@jonmasters-org.20150623.gappssmtp.com header.b="olbb2NiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgDQGe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 02:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728028AbgDQGeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 02:34:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D37AC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 23:34:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ay1so624498plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AGtrib0SEzkR/i2V3s4NGjpmeVSFBI11mJRr1zQWoZ0=;
        b=olbb2NiOwt83kdgpCRfGruCS9PsmIXJiG7v/4yuq2xN+fK5WmfIqyEsNMhGLmgFS6H
         T6v8kzROEUmkQxcbYbsDIRgPKDEpeI7yIeZdsOObmTq94npTByiAYZVSH7bJ564in3xJ
         lLysV9TQFWgvbCXhBDBufX6NdXmdbgDf8vlhAYtKDcz4jRkaw7ya2/cd3KUgVq6ftnLx
         +PoC4yWKRe7YaqhlcFWKBbtbmB6ONuuajtXm4hCL+FNo1SNDtatWveDr5BoK/XEST1bl
         sl7HPDpg3b9xOHqKWoK549yrBv00rzIjPzHoKUdW3buvLU96QMxx+MfUtdeOd+7Zv3kD
         IDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AGtrib0SEzkR/i2V3s4NGjpmeVSFBI11mJRr1zQWoZ0=;
        b=sVo79GbjprDhMcRXlM99Pww+akKOXKtf+tq3hd04ocuOe3bJiyX3ncJj9mh3kSbiJh
         YZppjNUJQyvX12YJcl1prccDlqI8zvlMXtL9ShOEzog87wCgMG/bWFuUnLsOCGRcnJ+a
         dS9G9KImYlX6kkFLi4QdQvW1LNiOcsYDsCbyadHlY2bvaGbLtdq8Bfi2bV8iVmDDWsK3
         uFVFWbHm+py+K/49pVLmI93VqSOMPd7OIloizUl5/HuHO+dQDPixKovoQVjB5K+zhpxD
         Izjvyx1asUwNy8DGOe3h4pQb4UHfgy/RxjCkYqyUd0sQZu5gYX6siSagOI11HCUwX8tv
         4cpw==
X-Gm-Message-State: AGi0PuYxVqvD+Dt0J+RZAyMiOHdwtTfXPC/Sx9OvzIQ4eVGY2YfVSaIZ
        8dW6c2NJlEMMyz4l6Sl/lQDqVYkPORc=
X-Google-Smtp-Source: APiQypIcuKO7DdOeAFhZLcOccIk4KE+dqVYWfOtGK7UqgbvAcMxBVzSjJZDCDStvQmzF+njQAdYZhg==
X-Received: by 2002:a17:90a:a402:: with SMTP id y2mr2653604pjp.55.1587105264879;
        Thu, 16 Apr 2020 23:34:24 -0700 (PDT)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id o125sm17063631pgo.74.2020.04.16.23.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 23:34:24 -0700 (PDT)
Subject: Re: SPCR and default serial port
To:     "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>
References: <364e0ff5da091ed7faa0232302b6181ac30000de.camel@amazon.com>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <2e2fe044-251d-eca9-3692-8f3182db3905@jonmasters.org>
Date:   Thu, 16 Apr 2020 23:29:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <364e0ff5da091ed7faa0232302b6181ac30000de.camel@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/20 2:04 AM, Herrenschmidt, Benjamin wrote:
> Hi !
> 
> Today, arm64 allows the serial port specified in ACPI SPCR table to be
> selected as a default console, but x86 doesn't (second argument to
> acpi_parse_spcr).
> 
> I understand while we might have been worried of breaking existing
> setups back then but should we re-think this, maybe via a CONFIG option
> ?
> 
> It makes a lot of sense to have firmware tell us which of the
> potentially many serial port in a system is our active console, along
> with its configuration...
> 
> This also shouldn't cause problem on systems that already specify a
> console explicitly on the command line.
> 
> Any opinion ?

I think it would be /great/ if x86 followed Arm. A config option would 
allow it to be easily ignored by those who don't want it, but you'll 
want to get data from e.g. distros on how many systems have weird BIOSes 
that provide a non-useful table today.

Jon.

-- 
Computer Architect
