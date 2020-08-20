Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303BDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013EA2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EUF9uV3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgHTVK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgHTVKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:10:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8E3C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:10:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d19so1722238pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=H7cC+z7RQpq0L5vf2H813jv/FwgSYGxlIxzFYi1mC7U=;
        b=EUF9uV3GRF3iffTeTaQLIg2GlCcopbN/jMxcjN6JP47piXndTpnv1f6QVVtGBtKfwd
         AaGvLdfDRx+PSRh8mCf41rol0PpJbxmEo1J3gCEGTUupXOvt/2F9xir4J9/OwY2eVnFc
         hmaTLAhMsb9n191FVkycXsD6Uuvb8r9bm1CLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=H7cC+z7RQpq0L5vf2H813jv/FwgSYGxlIxzFYi1mC7U=;
        b=dbhbmOP/KS0t/SaTNFlm+sTJKaav2lJjripsqxeZLjSC19QhxGxFRSc7OaW6Yq876/
         nhGv4aGPRL/FSt3tYO1TrSZhTVoSi571K6Xv8AaLrdjU8qJ0R473Z08cWf0J6X/iaQFs
         H9qLaZKimgz2JuZOeujFh3e8MxoypfGnG98CX+Y31zVi2sa1v6937DxyqIWC7ZMZTj5n
         icfHINm5ezj16ZtqDDeJdysSeqeghNKVwURDeiVl9BfCwmKqCCAIeG0ILQodPzGNLqnt
         NLnbEYV1VIdxIdHqPFwFxA4pSVV3afyk/8eLdoLIlo50p2/UECaCfXfI4aFmGY15GH9I
         atxA==
X-Gm-Message-State: AOAM533+Clo247Q7Mw/StlMaPmJbFiWmlykVhIAlrz1lBwIMa7JY6tUO
        ywww7V0pjdkwJhvU5SC2nhPMVA==
X-Google-Smtp-Source: ABdhPJza8mSlwKZsIrWJWSXCWNXCHJPeoSSbdq5+mHPFcupFg7/CGYCGwYv0H7EzLsLS26eWABLmyA==
X-Received: by 2002:aa7:854f:: with SMTP id y15mr462505pfn.298.1597957824548;
        Thu, 20 Aug 2020 14:10:24 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q5sm3565280pfg.89.2020.08.20.14.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 14:10:24 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] bcm-vk: add bcm_vk UAPI
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20200806004631.8102-1-scott.branden@broadcom.com>
 <20200806004631.8102-2-scott.branden@broadcom.com>
 <20200818135313.GB495837@kroah.com>
 <8894c3c4-4d5c-cb94-bc90-a26833ebf268@broadcom.com>
 <20200818174451.GA749919@kroah.com>
 <4adbd70e-c49b-c2d4-84c7-5e910f05e449@broadcom.com>
 <20200819070044.GA1004396@kroah.com>
 <fdbb7404-03c3-22b1-d409-5b6d8745ff2b@broadcom.com>
 <202008201353.F342E59EC@keescook>
 <ec24beca-fad8-5591-f09d-b87c21a745b2@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <fc0745bd-d1a7-c2ae-c9c6-c945dbce0b52@broadcom.com>
Date:   Thu, 20 Aug 2020 14:10:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ec24beca-fad8-5591-f09d-b87c21a745b2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-08-20 1:57 p.m., Florian Fainelli wrote:
> On 8/20/20 1:55 PM, Kees Cook wrote:
>> On Thu, Aug 20, 2020 at 09:37:46AM -0700, Scott Branden wrote:
>>> On 2020-08-19 12:00 a.m., Greg Kroah-Hartman wrote:
>>>> On Tue, Aug 18, 2020 at 05:35:04PM -0700, Scott Branden wrote:
>>>>> On 2020-08-18 10:44 a.m., Greg Kroah-Hartman wrote:
>>>>>> On Tue, Aug 18, 2020 at 10:23:42AM -0700, Scott Branden wrote:
>>>>>>>>> +#define VK_FWSTS_RELOCATION_ENTRY	BIT(0)
>>>>>>>> <snip>
>>>>>>>>
>>>>>>>> I thought BIT() was not allowed in uapi .h files, this really works
>>>>>>>> properly???
>>>>>>> I did some investigation and it looks like a few other header files in include/uapi also use the BIT() macro:
>>>>>>> include/uapi/misc/uacce/uacce.h
>>>>>>> include/uapi/linux/psci.h
>>>>>>> include/uapi/linux/v4l2-subdev.h
>>>>>> Does the header install test target now fail for these?
>>>>> I do not understand the question above.  make headers_install works.
>>>>> But I guess the above headers would have similar issue with the BIT macro.
>>>> Try enabling CONFIG_UAPI_HEADER_TEST and see what happens :)
>>> I enabled CONFIG_UAPI_HEADER_TEST and then
>>> built using "make" and "make headers_install".
>>>
>>> There didn't appear to be any issue with the BIT macro in the headers.
>> FWIW, other subsystems have not been so lucky:
>>
>> https://git.kernel.org/linus/23b2c96fad21886c53f5e1a4ffedd45ddd2e85ba
>>
>> It may just be better to avoid BIT(), even if it works "by accident"(?)
>> for some header combinations...
> Since we ship a copy of unifdef.c in tree, we could certainly teach it
> to undo the BIT() definition and replace it with an appropriate constant
> definition.
That sounds appealing given the rest of the code wants us to use the BIT macro.
