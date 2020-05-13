Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACB1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92538205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ewIInpz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390210AbgEMSjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389581AbgEMSjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:39:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ECFC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:39:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j5so739961wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QevyPaB54vabz1NgQweuhMZ/4PP5dMX078Hx9aqjxfc=;
        b=ewIInpz3Jv/IrkCkWkGiBC6UAat93L2zYEJfVB/67p9YtVYuw3NEVn0LJQPhSBnoBR
         pZUumCJ55i5Nmpq7zEeDDK+k0WKMCo5B9vDp02gV9BZTg4fT1dN/flqFNi79peEEs67R
         mFiPZ7/V5n0/0I8UIXjKTwwVnG1krpdxHa9WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QevyPaB54vabz1NgQweuhMZ/4PP5dMX078Hx9aqjxfc=;
        b=jgFJSCbZ2ZUuUAhp5SFUohPks8zj+oWfboyvCEN94jYXQ7mtfJMpP+1PbzyI9wSlM+
         6qg6NZ0Dyxs0qUGJKzz6rsgejfDlfF0jS1J9QRyeUlljldPveFtEqGiGUd1hb8oXc5c1
         bzcBhWDG/yp6hXojd8Hxbo14mRqxSmzQQdA9BywiRL9TUdBIxHTUcGCE4zPmZAVsxJHK
         9K/PNABArH7bdPenoCXbcPuJ6ucrbpJEZ66qxZa/zdc6EZCIpkRKWO75tX1L6eqEpsKx
         Yt1qhGieavfuoW/E1HFSr2Fw0+QPynrd+nodWG+reSVo8Ph19Q4WfCPj+6TqIj8mBMdi
         oSLg==
X-Gm-Message-State: AOAM532LRd3fTl9b9xpk//y11Xa19zJMDol0fsYxloxxB323iu7DUyZ4
        5uVOfsaGjkvSFpxq67QBt6Hlyg==
X-Google-Smtp-Source: ABdhPJzhf+mYsAycvYoLOXU1WHfMH8XPnenYApwbY7dPsUsGlZ8N8UGzdao3+8+YZVroo8SME6sfvg==
X-Received: by 2002:adf:e38b:: with SMTP id e11mr706640wrm.343.1589395177524;
        Wed, 13 May 2020 11:39:37 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x24sm501774wrd.51.2020.05.13.11.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 11:39:36 -0700 (PDT)
Subject: Re: [PATCH v5 6/7] misc: bcm-vk: add Broadcom VK driver
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Brown <david.brown@linaro.org>,
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
        Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-7-scott.branden@broadcom.com>
 <20200513003830.GJ11244@42.do-not-panic.com>
 <60372b2f-c03d-6384-43a7-8b97413b6672@broadcom.com>
 <20200513065046.GA764247@kroah.com>
 <20200513123033.GL11244@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <2eaa3047-4833-8d1c-d8c7-fc602468eae3@broadcom.com>
Date:   Wed, 13 May 2020 11:39:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513123033.GL11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for link.

On 2020-05-13 5:30 a.m., Luis Chamberlain wrote:
> On Wed, May 13, 2020 at 08:50:46AM +0200, Greg Kroah-Hartman wrote:
>> On Tue, May 12, 2020 at 11:31:28PM -0700, Scott Branden wrote:
>>
>> That's not how kernel drivers in the tree work, sorry.  They do not
>> contain "older kernel support" in them, they work as a whole with the
>> rest of the kernel they ship with only.
>>
>> Otherwise all drivers would be a total mess over time, can you imagine
>> doing this for the next 20+ years?  Not maintainable.
> Scott, now imagine the amount of cleanup you'd need to do to your driver
> to get it to a state where it doesn't depend on any old kernel. That's
> the exact shape of the driver we want.
>
> To backport, you can look into the backports project which strives to
> backport drivers automatically [0] to older kernels.
>
> [0] https://backports.wiki.kernel.org/index.php/Main_Page
>
>    Luis
Will drop legacy support from patch and look closer at this.

Thanks,
  Scott
