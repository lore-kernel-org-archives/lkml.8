Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612C6C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335C820CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mliCvyk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgA3JlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:41:07 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51453 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgA3JlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 04:41:06 -0500
Received: by mail-pj1-f65.google.com with SMTP id fa20so1089036pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 01:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k7VhYF3e/sARPLan/V1Yqu6nJSGsIRzlv9MbK2wkhnE=;
        b=mliCvyk7YzNEVOZjQ9FCwlwTBNDQRI0mN7HCXieXUcJ+csRPgurtulsFjuqoxh+jjo
         LNiROltQVQJRNpSXlrAneBT4RMiH2ygpXcQ1Uxyt2f9bEQhm2BhKdVq5N2PxVgNgfCnu
         m6217MhQCX/pems2fxt6fi0PxDqz+H/ZEubdfaUklcduWX1eUKNh6jtEccLSZiZD0dAm
         9Ivpjtr5eXBeA2ufA8Fr/JrabtmJZQu00j+NuBRSJ3WvzVydHR55fXGdIudHgylt8Amr
         4R/T7IWVtensNLMUltwCKhyPltXGnGe1ZZAhLuOozBMlaqiylpzWh/qiG/lWKWefY5qD
         moSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k7VhYF3e/sARPLan/V1Yqu6nJSGsIRzlv9MbK2wkhnE=;
        b=jU45e1zEmb7sUzkHoTHM50RWUEYZOi7/h3sI+yt0zL+0L7Sr6Zb1oEBbJdGBzd7BY/
         JL6mcxRCDY16PwKhkCuBUEG1BO2XdeNhPW0gK3EaO6BU0gl9eurFBk8fKgvjx6heHZ0P
         Zwdphj9Ntzi0pdNwVAtrkfC12qTD1LHx4DLeqd1QZR7Fe3dWq1v4vwAjvyrxD6XMqyNN
         fV6gmBJ0TRSvxLoKSBPyyKoRAmzEuCZPZYgH388N1lwWtEdza7zv6ZSm0vkvdtHKoJ2l
         vTRzH5KxQ0o8WqAjLWsKSSkOLGE+CIuHwk/OGx/hQ174YwBuaCFXk6tNkBJWki0w1nvU
         5YRw==
X-Gm-Message-State: APjAAAU1eMPwGv5MeN2VSTEegFfFvTsb9mb16EpRXL+sJOi6ak8ITjSn
        GC9iDlxsIVYP9lvOPhkquZAcRg==
X-Google-Smtp-Source: APXvYqy9bHlTd3eyG9EWGtdzjvaCC1P9Ti1DatOjR/A72jF8DmoTBv7/g4fpCjE1zZasFI6yOR/W/w==
X-Received: by 2002:a17:90a:2223:: with SMTP id c32mr5167336pje.15.1580377266051;
        Thu, 30 Jan 2020 01:41:06 -0800 (PST)
Received: from localhost ([122.172.141.204])
        by smtp.gmail.com with ESMTPSA id o16sm5685937pgl.58.2020.01.30.01.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 01:41:05 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:11:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V5] firmware: arm_scmi: Make scmi core independent of the
 transport type
Message-ID: <20200130094103.mrz7ween6ukfa4fk@vireshk-i7>
References: <CAN5uoS_A9TYU2aWf3WVq3KGna6oVswfut+hC7sJWvhfYggMwTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS_A9TYU2aWf3WVq3KGna6oVswfut+hC7sJWvhfYggMwTA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-01-20, 10:25, Etienne Carriere wrote:
> I've made a first port (draft) for adding new transport channels, next
> to existing mailbox channel, on top of your change.
> You can find it here: https://github.com/etienne-lms/linux/pull/1.
> 
> I don't have specific comments on your change but the one below.
> I think SMT header should move out of mailbox.c, but that may be a bit
> out of the scope of your change.

If it is guaranteed that someone will end up using those routines
apart from mailbox.c, then surely it can be done.
 
> I would prefer an optional mak_txdone callback:
> 
>     if (info->desc->ops->mark_txdone)
>        info->desc->ops->mark_txdone(cinfo, ret);

So you are sure that mark_txdone won't be required in your case? I can
make it optional then.

-- 
viresh
