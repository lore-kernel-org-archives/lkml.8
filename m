Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9707AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768F72074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgCXOja convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:39:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43444 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgCXOja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:39:30 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jGkiF-0003q8-T7
        for linux-kernel@vger.kernel.org; Tue, 24 Mar 2020 14:39:28 +0000
Received: by mail-pf1-f199.google.com with SMTP id h125so14102016pfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=olThx3NRWCqmpK/TmIWWUGZYC0Mn3E0rSf0fKwVxX7o=;
        b=dWbbxHzPN7+H3GjcdAJqO4Q2/EjC0gCnzoFZtxzYt4AU7cqWBNvN1N2PzCa6u9yDaH
         T+6Q1jl+paFe2qnTAKrGy0OpOfsJD9IJTKffXy7LK2g8p3nffmJMubQOAPwDn+pfq01Z
         QKlCcz8jQ7Qo0Xo9bQWXmjyO0TuAGC5C66m7LaWtwxtY7ckbzYyvE1/C9+IoaUESze2D
         sLe2g7SraXUkcSjfXdgKnDLmpRS6pJYQwoBiAcSst2+7dZkUjqBh7o4PpPUdvIhes4lB
         p8GX33x10JUTErFx+5RjFpXlWZ9HZPQHaollU3orShRFrfnG9KXx11uaNofcWdbp6h7D
         Gszw==
X-Gm-Message-State: ANhLgQ1+E1ow7/jUlm5x7gdDcac6sxSBuwWVbxhvCLYA3drsbz/tGnIE
        T15yTn0upi+5M6tDe2Np7IwhRlosDDM+ccMzzxC83SaJ3gQLSnaJ71KAdsJaX+9/7ZNw+NZ2ZEL
        roXI65P2sNNeFtsAL515KwaIe5S/50XxqVJYlw5/g8A==
X-Received: by 2002:a17:90a:c695:: with SMTP id n21mr5744131pjt.133.1585060766305;
        Tue, 24 Mar 2020 07:39:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvUsIoUP8bwD6fmxkTSnpSBTMMDUBbvngGa5KE9+xnM+hNmrTdAQxjevFGk/KpoCFU8s4+isw==
X-Received: by 2002:a17:90a:c695:: with SMTP id n21mr5744097pjt.133.1585060765945;
        Tue, 24 Mar 2020 07:39:25 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id f5sm83318pfq.63.2020.03.24.07.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 07:39:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] i2c: nvidia-gpu: Handle timeout correctly in
 gpu_i2c_check_status()
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200324134124.GL1922688@smile.fi.intel.com>
Date:   Tue, 24 Mar 2020 22:39:22 +0800
Cc:     ajayg@nvidia.com, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C CONTROLLER DRIVER FOR NVIDIA GPU" 
        <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <AF4DCBBE-FF35-4B58-92EE-8BD804A502C4@canonical.com>
References: <20200324130712.12289-1-kai.heng.feng@canonical.com>
 <20200324134124.GL1922688@smile.fi.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> On Mar 24, 2020, at 21:41, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> On Tue, Mar 24, 2020 at 09:07:12PM +0800, Kai-Heng Feng wrote:
>> Nvidia card may come with a "phantom" UCSI device, and its driver gets
>> stuck in probe routine, prevents any system PM operations like suspend.
>> 
>> When the target time equals to jiffies, it's not included by
>> time_is_before_jiffies(). So let's use a boolean to make sure the
>> operation is done or timeout.
> 
> Thank you for an update, my comments below.
> 
>> 	unsigned long target = jiffies + msecs_to_jiffies(1000);
>> 	u32 val;
>> +	bool done = false;
>> 
>> 	do {
>> 		val = readl(i2cd->regs + I2C_MST_CNTL);
>> -		if (!(val & I2C_MST_CNTL_CYCLE_TRIGGER))
>> -			break;
>> -		if ((val & I2C_MST_CNTL_STATUS) !=
>> -				I2C_MST_CNTL_STATUS_BUS_BUSY)
> 
>> +		if (!(val & I2C_MST_CNTL_CYCLE_TRIGGER)
>> +		    || (val & I2C_MST_CNTL_STATUS) !=
>> +				I2C_MST_CNTL_STATUS_BUS_BUSY) {
> 
> Bad formatting. But see below.
> 
>> +			done = true;
>> 			break;
>> +		}
>> 		usleep_range(500, 600);
>> 	} while (time_is_after_jiffies(target));
>> 
>> -	if (time_is_before_jiffies(target)) {
>> +	if (!done) {
>> 		dev_err(i2cd->dev, "i2c timeout error %x\n", val);
>> 		return -ETIMEDOUT;
>> 	}
> 
> 
> Overall it can use simple tries since you already have sleep inside, but
> moreover, you may simple switch to readl_poll_timeout() this entire
> loop.

Yes that can make the retry loop much simpler.
I'll send a v3 based on your suggestion.

Kai-Heng

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

