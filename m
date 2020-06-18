Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED7DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCAD6217A0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5W1UFSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFRGO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgFRGOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:14:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D87C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 23:14:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so2188170pjv.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 23:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9qR0fuoqIBy0xUAm2ITtA1DoU0HgxEgx3YBhTm/3Gek=;
        b=j5W1UFSmkVhTt7/aLu+Byy4gWGen8wWhvgWZRToHhZS3+p4zloJZgwWyU6X7QkGagZ
         KkPK+JeL+QUF7Z5xWGU9ZLRq8HzH7LmNtPKB/tGZyjA/n5xQeWRs+DGYiYgEJcoSoN9T
         aTXyVSaMrW2VWoC2pqXkVaTeErWrzJ6UUTFnO57U2oVwMmtqExRPcSfR65E4AOnHxW8X
         6MvFC2YBrWgfl7z3rPrFfTa4ZZGWd/whgnn78dlKw8Fm55IGCtlv15C/U6Z/iL7sek4p
         agPvgixAMciwE7dz0w8i+SNYxsQR+GbIUim3y3IBDgA5TMZCm9ynoyrq3+/F/AqxK+06
         +vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9qR0fuoqIBy0xUAm2ITtA1DoU0HgxEgx3YBhTm/3Gek=;
        b=q4nI5AWqwKf6MRlTD8K6A+3HgKdYKqkAL4kyj6+TdjpBfQiWeHvZVB9bYBh6Wt75lx
         YhmG3rlG/3Hi7rcluGn4NhGK/k2932WHVaendtF67A+R1YqNmJ2pom/k2Pbet2URqqqM
         ilbifrNy1A8rugADubW/GHRb1UOBlVxq4E0TAmt7X1RZq8fg4UsPWDxskwaVE6DwzZ5+
         sAtGhBiWzlULUWb3lk2fT9YdkW/RifgPgTnKyR3wE1mu9ZKwBmog6i7KI02I3mtPe8J0
         zSvqojjbVJElBYchKiVi3g7URtxvYZXionG7FyQglLNZE22lOTZfpR+mQxJahugUCVNM
         CZ+g==
X-Gm-Message-State: AOAM533oxMvpTmy2HK9LLHQT9ml65efEo2oy58pQtOcQPpCTo/CsDUm9
        Cle8iukOAPKlm74/sEZkfWMQxA==
X-Google-Smtp-Source: ABdhPJx1/jxhXBS8AN8LHrbnqRktjYWNTZxxEd020DnwsWjMOLk/3LSKicpt+yNaq9ciJ4xxgJmn5w==
X-Received: by 2002:a17:902:b403:: with SMTP id x3mr2394513plr.240.1592460863990;
        Wed, 17 Jun 2020 23:14:23 -0700 (PDT)
Received: from localhost ([122.172.119.132])
        by smtp.gmail.com with ESMTPSA id r132sm1689881pfc.96.2020.06.17.23.14.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2020 23:14:23 -0700 (PDT)
Date:   Thu, 18 Jun 2020 11:44:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH 2/2] cpufreq: arm_scmi: Set fast_switch_possible
 conditionally
Message-ID: <20200618061420.5q7xsldakax2zro5@vireshk-i7>
References: <20200617094332.8391-1-nicola.mazzucato@arm.com>
 <20200617094332.8391-2-nicola.mazzucato@arm.com>
 <20200617124753.GA15211@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617124753.GA15211@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-06-20, 13:47, Sudeep Holla wrote:
> This is first step towards avoiding polling based cpufreq set if firmware
> has fast access registers that bypass normal mailbox based messaging.
> 
> If you happy with this and provide ack, I will take this along with scmi
> changes via ARM SoC. Hope that is fine by you.

Sudeep,

I am not sure how it concerns me frankly :)

AFAICT, this is enabling fast switch based on some mechanism (internal
to scmi) and so either the cpufreq driver will have fast-switch
enabled or not, and both are fine by the cpufreq core.

And so I am confused on why my Ack is important here :)

-- 
viresh
