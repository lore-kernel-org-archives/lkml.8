Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85319C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6392720738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="clV4Tc1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgEVWtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731254AbgEVWtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:49:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB06C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:49:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so5004534plr.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5Niesz+2MAyLragVp6DehMUQoLdj3CSU9Zt3Gj3FZgA=;
        b=clV4Tc1EUrpbmdlkOwp9Wqgo/P+RrtzAqyiBFRgmTC2+VaIklkFaWnVYOb9yytjlAB
         BulBPRmlvjlGei3ckNGeX2wlknWoMlQT+cyUkjqnYa5t+kqpJ2/0vmhYkNnIfzhTwXHN
         w4WMZhUpzH+IPlUgR8oEKOUisnTq7wpWMPPm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5Niesz+2MAyLragVp6DehMUQoLdj3CSU9Zt3Gj3FZgA=;
        b=WadGBVzG9iluN8SIR7tuMz6nzB9k1mCYvHYw4mcBJHH4DofsbPoHoGwBBjMBx3ncrF
         O2/hI3oLsDIk9GIUDuynSu6v1lYRF9HUCaGj32ozuVdqw7sM1hMfyXHje+zaG8cy4IqQ
         kZ/pgWEB1a4GeT+8zh4rgDawt856Lvj49tUCEu6cBMHi7kgS4hMUDvEHAWhJK6d3HmIz
         nr2fffY8/29LA6HjvfpIY/tNxbTTZpyJ5sn3eubMJquYtfCOvBIuFbnkPRC1HMeEfySq
         ea4KXR9vt9FdnIE7/lZGrBZHX3W22UjSDjrbGhPKShRBbbg80uMSNnaTCCHRtD/T836u
         4w1A==
X-Gm-Message-State: AOAM531lDVjg9yExxLuafCnDYNheBmMW0bSGDwuuQh4RVIaMgckfJpzK
        krLjoMc+IUh3Dgb3jFKihhBd4Q==
X-Google-Smtp-Source: ABdhPJy/3Z+8W3/h6QRK7NWHSKVeWfJ0+rwlb37Q0sp37fUTStq6KXecUdx34b/Znd6BtcfLNZMcvg==
X-Received: by 2002:a17:90a:c004:: with SMTP id p4mr7433745pjt.170.1590187757163;
        Fri, 22 May 2020 15:49:17 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z18sm7049152pgi.68.2020.05.22.15.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 15:49:16 -0700 (PDT)
Subject: Re: [PATCH] firmware_loader: change enum fw_opt to u32
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <20200522214658.12722-1-scott.branden@broadcom.com>
 <20200522224508.GE11244@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <d87aabd0-1195-64ae-d871-b0771be832a8@broadcom.com>
Date:   Fri, 22 May 2020 15:49:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522224508.GE11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 2020-05-22 3:45 p.m., Luis Chamberlain wrote:
> On Fri, May 22, 2020 at 02:46:58PM -0700, Scott Branden wrote:
>>   
>>   /**
>> - * enum fw_opt - options to control firmware loading behaviour
>> + * fw_opt - options to control firmware loading behaviour
>>    *
>>    * @FW_OPT_UEVENT: Enables the fallback mechanism to send a kobject uevent
>>    *	when the firmware is not found. Userspace is in charge to load the
>> @@ -33,15 +33,13 @@
>>    *	the platform's main firmware. If both this fallback and the sysfs
>>    *      fallback are enabled, then this fallback will be tried first.
>>    */
>> -enum fw_opt {
>> -	FW_OPT_UEVENT			= BIT(0),
>> -	FW_OPT_NOWAIT			= BIT(1),
>> -	FW_OPT_USERHELPER		= BIT(2),
>> -	FW_OPT_NO_WARN			= BIT(3),
>> -	FW_OPT_NOCACHE			= BIT(4),
>> -	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
>> -	FW_OPT_FALLBACK_PLATFORM	= BIT(6),
>> -};
>> +#define FW_OPT_UEVENT			BIT(0)
>> +#define FW_OPT_NOWAIT			BIT(1)
>> +#define FW_OPT_USERHELPER		BIT(2)
>> +#define FW_OPT_NO_WARN			BIT(3)
>> +#define FW_OPT_NOCACHE			BIT(4)
>> +#define FW_OPT_NOFALLBACK_SYSFS		BIT(5)
>> +#define FW_OPT_FALLBACK_PLATFORM	BIT(6)
> Everything looked good up to here. The enum defines each flag.
> We just want to use an enum for *one* flag represetnation, not
> a bundle.
I do not know exactly what you are looking for then.  The FW_OPT_* 
values are OR'd
together in the code.  You still want the fw_opt enum above left in 
place entirely
and then the values used in OR'd together?

>    Luis

