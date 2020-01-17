Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE47C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3529020748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="YpgoWq+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgAQEQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 23:16:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42987 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgAQEQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:16:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so10995356pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 20:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mRpBlfriiKBtpHdle3gY+6OvDi0xi+PHO3+1yxBhNW0=;
        b=YpgoWq+f5KBHqJRceCkoXiAZ2cahZQK+2UyaAJe+K9OIe+XXcWUZL8U209yNlM3H75
         KA7pvnOh+24zjdkJ7WMUJ3KA1+3nkIcrRF31rPO++SI7wQlThs4GJGs5B3nYoQLKW5HT
         2eh3iHvTi3Xy88JGMBRbo122EsU8mcdZ/ksMWQv5AaykeNtw4L241TPf0aaaNgQ6oplO
         UcCJxtf9XAGTsWbYYHU+gy2NpZnW2+Cl0nQVAovymBpgWIrdrUczQb4tNfSu/jIOSSvr
         fG9ZirxeCQXz5lZPNcJRcNLxJM6Wbp3fKAwDJBz0ddZdtMZOh9o+PFBxxH/QKym4+LGz
         VCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mRpBlfriiKBtpHdle3gY+6OvDi0xi+PHO3+1yxBhNW0=;
        b=NqhYsCwO61Q5ixt4AxnXprVH4O0ypq009IZrPEB2LkbPzVVY0kkigWX1hMLEfJzxcg
         e4JTeQDos0GEonpDkkPs1FEAfdlt3oNohhYNLLrOdTBMmqoRLRcPejeYr5sIxCoLiYuu
         DSVgVsVotVJR+jXRAbMFhry0OhozQF9Kw1+xrGS9/o0Lv/wbJ6iacdiuM3vEIWL2LrPc
         K3vBuq8JhYIt3+3wwVK64qtXftk4RRKWC37JSVEF7K//fhqY3PhB6Ifq2xP0NkXiSqgd
         d0I8f+4h4byfMrlem75xZzzgzdz5pzFPq5BQpSYRDNVc09+k0v1UOt7D7xBO7jKc1fxK
         oZdA==
X-Gm-Message-State: APjAAAWdLi75GEkl4cMMr2jfAGkFM3WrJ/yel2saaHb5b/1INpOsBwt1
        kKE0+7RnGk7Y7QyENNpNgk3nsQ==
X-Google-Smtp-Source: APXvYqxeLUKQP31a9O4MOSQTYDXXhKgO23RrfuN2OHejqkFLLCBgUZ8QQnxFYMZQ3Ktxo8BDhU+O2Q==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr1054005pfh.92.1579234591085;
        Thu, 16 Jan 2020 20:16:31 -0800 (PST)
Received: from [192.168.11.4] (softbank126112255110.biz.bbtec.net. [126.112.255.110])
        by smtp.googlemail.com with ESMTPSA id l66sm26355096pga.30.2020.01.16.20.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 20:16:30 -0800 (PST)
Subject: Re: [PATCH RESEND v4] reboot: support offline CPUs before reboot
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-pm@vger.kernel.org
References: <20200114110620.164861-1-hsinyi@chromium.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <a701522f-73aa-2277-4a25-f84a27f38118@landley.net>
Date:   Thu, 16 Jan 2020 22:20:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200114110620.164861-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 5:06 AM, Hsin-Yi Wang wrote:
> This patch adds a config ARCH_OFFLINE_CPUS_ON_REBOOT, which would offline cpus in
> migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> checking online cpus would be an empty loop. If architecture don't enable this
> config, or some cpus somehow fails to offline, it would fallback to ipi
> function.

I'm curious:

> +# Select to do a full offline on secondary CPUs before reboot.
> +config ARCH_OFFLINE_CPUS_ON_REBOOT
> +	bool "Support for offline CPUs before reboot"
> +	depends on HOTPLUG_CPU

The new symbol can't be selected without the other symbol.

> +	select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU

And the other symbol automatically selects the new one.

Why are you adding a second symbol that means the same thing as the existing symbol?

> +#if defined(CONFIG_PM_SLEEP_SMP) || defined(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
> +extern int freeze_secondary_cpus(int primary, bool reboot);
> +#endif

Couldn't that just test HOTPLUG_CPU? What's the second symbol for? (You can have
empty stub functions when architectures don't support a thing...)

Rob
