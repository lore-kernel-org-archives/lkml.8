Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2460C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF51D20781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7WQX0n+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbgGAQbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731951AbgGAQbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:31:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664E8C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 09:31:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so24710426wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e8vy04L3oFjB+e/NYPznyy+y32Vl8W+XrBMmiEvQygo=;
        b=i7WQX0n+MjYFWRQdP/C4E5Y8PrAvqnDQ+SRHQo1ZgBlWV9OTIaai3ugazH8MLJkVx1
         zeTMNmJUTIJJptEvMMoQTz/UwYei08/DDc08TrlbZTUXyCYiOHLKoTXXpFHsLnfhUc6O
         o5waCOOCPz4ai73p3a6QdYCaUDsKgLzrfV6lLC57MeJO1ubXc8waeRngBnB5tH9K6P4L
         Ap4ldEgE27AZ60TDc1mv5XCEZOnryj7Q7PPOBaNSfmyHMStZV0FJKyztp/UpI/t8u/BT
         JehJqzdjTNlJGIBAU7JS25hEN0U5uMV0UDc9FrpeJYYxxayPJEItBcElxldaTmH+eMdo
         fFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8vy04L3oFjB+e/NYPznyy+y32Vl8W+XrBMmiEvQygo=;
        b=iJq+5pgR5YVWQDDCaxjdFVQpIbWvrmM69b4XpYwJucaqjbj+9wAQaoOhJzltP3uDKk
         yV6bO0hqkpvS6M5rAwKlY9fVAHehlzv3DhSo9VtACSqMhOXjv9+UiUygNSb0+k44Qyx2
         4yZiGse1G/Nsr6YYRQ8uXGp5DjKkSsfaih+A9QpK37lMlm9ymBXXmWDakumMN9av7CjU
         qh8UlIThu0rULAESoYsgOanRc7rVBt6lTxTQotja/2BMUdOhkBtE0Z+3bUh1iu32gHDN
         OU79kn3N/Xh1vGlSNb5LQXvNGtzIPhNOwK0c0VD2DyIFps/FPtMHbOE6TLqXnjl9fBo5
         wh1A==
X-Gm-Message-State: AOAM533hC1tmjBSHv+x3gcl0h9FIXQFvmA1bfuvbmxD6KNZwaEKewt2H
        69VC/Znl90osZ4nqRlGPHOHXdJLjEhM=
X-Google-Smtp-Source: ABdhPJycStsO9NSKdJwwQC1Ey6TfMk0zkrit19oTnMJW6fodmR8V6XBI+iJZYojl6ReFnLaszZblJg==
X-Received: by 2002:a5d:658a:: with SMTP id q10mr23546055wru.220.1593621090716;
        Wed, 01 Jul 2020 09:31:30 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id n17sm7752105wrs.2.2020.07.01.09.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 09:31:30 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] thermal: core: genetlink support for
 events/cmd/sampling
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     rkumbako@codeaurora.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <20200625144509.17918-4-daniel.lezcano@linaro.org>
 <73150ef4ca536368f087672b917dd9773417020e.camel@intel.com>
 <23458be6-1e5f-7397-4935-c5268b9f52a6@linaro.org>
 <171936e84c416d7647756d9b453ef2d4475ebdc8.camel@intel.com>
 <4c8abeb4ddff2355d9ba397f50b7844a7734c2e9.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8526622b-cb31-4d40-95b6-e209b3101563@linaro.org>
Date:   Wed, 1 Jul 2020 18:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4c8abeb4ddff2355d9ba397f50b7844a7734c2e9.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2020 17:49, Srinivas Pandruvada wrote:
> 
> [...]
> 
>> Then I'd prefer we only introduce the events that are used or will be
>> used soon, like the tz disable/enable, to avoid some potential dead
>> code.
>> We can easily add more events when they are needed.
>>
>> Srinivas, do you have plan to use the trip add/delete events?
> Yes and also trip modify.

Ok I will keep those then.

> Also I need to have one more event for heartbeat like event which needs
> confirmation from user space to hardware the user process controlling
> thermal is active not dead. So whenever hardware wants to check health 
> it will send an event, which user space should acknowledge

Could it be the opposite? The userspace sends periodically a message to
tell it is alive instead of having the kernel asking the userspace?

Is it ok if we add this in a separate series ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
