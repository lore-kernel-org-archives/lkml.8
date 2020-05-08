Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DCDC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5540F21655
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588950450;
	bh=7O1iHp5LDwSY3xeGUz4PChwvzF0fvPux042FyNdD/vo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=UMHwzKuoTb/spqYtLhXyBfw3W1PhQHUjngjFn2tMYuL2a9qSk75C58m0gpwxoa9y0
	 o4ik1UbBBb1DZUhpFKdvk0pm1bwYjCmYRzbw0Qz6V9FsM6KyEZrR/jsWTtS1HRtxp9
	 7Z9BM00d8+UCEiiXi6fGlk/wLarDB2e9/3BOWggw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgEHPH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgEHPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:07:29 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ABFC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 08:07:28 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id m5so1680301ilj.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XfW90zo6T5KAPuSOZK0m1rceAYunAO3tCus7Ecsk/44=;
        b=DrZ7dJBMb2gXPW/MlynB0PhMDYS5RWpgZDN3qhCWiYnfMsQIs0JfrwfzCjqNFYgSgj
         siIgfrxvC4CefgaMBVAqwJXjVn0A/zoV+eEmn7OSIAK6GBpFkjIQQuLBuagyA/NUCwen
         3UywojBNh+0E6JpECOLO8Cc9n+XCDwqTHTFx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XfW90zo6T5KAPuSOZK0m1rceAYunAO3tCus7Ecsk/44=;
        b=jooCSisTjReaMpNOLYQ9G60px1W+0Lwlz3oVyQrdz2TN+KZ9nM9pevkYSU6KMykqcJ
         QJlpx5AY3e+Bv7gzJJMMZnGQfwIysalB8ul0HT+0ak8jBk0HQGEXrCzPO4KEviJlZ2rq
         M01ehiQp0BHrXxyTUEH34d5OKtfnYTiC0JXg54nvDnc8LhhNWm3RURwpATvLxo4dPmnl
         xtNam9VXP+NDU//Ow0QW8QEvqI535ePaRdSPah23gS2+teIsxoALsHizwj7GcPI+HZdp
         GrhCKdMFRK1pT9HwAX1DGI4ZAyQJR3LEtIz82OajWjlQF/+CAYLEvxdlDdzWTrrg6Pe0
         LqSw==
X-Gm-Message-State: AGi0PuY8kIMFxmqADOmamX6efURv79nP5NLtbXqaSVPKOEgu4baWdJu6
        e9fTxUaPqxhdsxiRWiqEQiQUVZPhyi8=
X-Google-Smtp-Source: APiQypLZ6wdxpHO7TnlOBfCn3vWaqdrCHX8bZENsqHjjjQiZYcM/1t27BVtHr2oouk546ImkXT2xWA==
X-Received: by 2002:a05:6e02:ca:: with SMTP id r10mr3308743ilq.41.1588950448273;
        Fri, 08 May 2020 08:07:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n65sm905604ila.69.2020.05.08.08.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 08:07:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] fs: avoid fdput() after failed fdget() in
 ksys_sync_file_range()
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     axboe@kernel.dk, zohar@linux.vnet.ibm.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1588894359.git.skhan@linuxfoundation.org>
 <31be6e0896eba59c06eb9d3d137b214f7220cc53.1588894359.git.skhan@linuxfoundation.org>
 <20200508000509.GK23230@ZenIV.linux.org.uk>
 <20200508002422.GL23230@ZenIV.linux.org.uk>
 <20200508022139.GD11244@42.do-not-panic.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7d3e7bf5-22e4-ab3d-798e-33d3657e1cf1@linuxfoundation.org>
Date:   Fri, 8 May 2020 09:07:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508022139.GD11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/20 8:21 PM, Luis Chamberlain wrote:
> On Fri, May 08, 2020 at 01:24:22AM +0100, Al Viro wrote:
>> On Fri, May 08, 2020 at 01:05:09AM +0100, Al Viro wrote:
>>> On Thu, May 07, 2020 at 05:57:09PM -0600, Shuah Khan wrote:
>>>> Fix ksys_sync_file_range() to avoid fdput() after a failed fdget().
>>>> fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
>>>> in fd.flags. Fix it anyway since failed fdget() doesn't require
>>>> a fdput().
>>>>
>>>> This was introdcued in a commit to add sync_file_range() helper.
>>>
>>> Er...  What's the point microoptimizing the slow path here?
>>
>> PS: I'm not saying the patch is incorrect, but Fixes: is IMO over the
>> top.  And looking at that thing,
>> {
>>          struct fd f = fdget(fd);
>>          int ret;
>>
>> 	if (unlikely(!f.file))
>> 		return -EBADF;
>>
>> 	ret = sync_file_range(f.file, offset, nbytes, flags);
>>          fdput(f);
>>          return ret;
>> }
>>
>> might be cleaner, but that's a matter of taste...
> 
> This makes it easier to read.
> 

Yes it does. I will make the changes and send v2.

thanks,
-- Shuah


