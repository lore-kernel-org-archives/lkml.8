Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD28C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5084D207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590693243;
	bh=MnWgaBTeNmlOTB8V+xlxOASVA93eFmB3RvbSfIKHG2I=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=f+tQZrEBbe0DAtVYrou0NvpC6WT5iV8dLPItJplvnKUGlYhJSQ0JTrx1qH6P+pc8v
	 mJkydtiRaCuJDp71nLV1aQwe2/qQYyyVoZkI6o1fRLFH6/HCsm7qQarIidB6AjKE5d
	 k8I9E4yL/qRxlvbgWdz4Ej5plV8xuPkJauwmwHzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406246AbgE1TOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406204AbgE1TN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:13:56 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C83AC08C5C9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:13:56 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z9so217786oid.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Aid1A7qAbnqwEDuFuiLArV71skaojblrB/GGrrY4cY=;
        b=e/SbMRNYoY+hzrbh8kw6sZOUW7BIjelH8o7w/nPznUrHvOqGBfMGSY/ZJvwbvzX9b9
         ujhnDk+WqjX72eLW0c/Oi38lUQJGxsN4bJLsbijzFtd1H7cAGfx3r/ThZzPxX3EIUSBU
         fYXf/OsO7yEZJsIlQbVUCFveqN8DcltBNmHx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Aid1A7qAbnqwEDuFuiLArV71skaojblrB/GGrrY4cY=;
        b=YlovitW+VNsjC+zEHEKN7ftK8G2ADpeKMD6WNnjmNA/d7Kq68twaEdbtBMLIQrR6Kj
         bmQ3iSvzliXcerX9SDSgGoyvsIu0wPP0/YAQIuJjQ6qqGC8jhjvnwA/3+2mjcEKOLUys
         VgOyXGETrSd4ZIBl4REDeyrGXiR0WljNqXZMC3tvkSAAf3B9DGOWjGC8ZB+ntOPs7ByU
         jGYXXkKV8A8r8Jj55zM2J4KtUIKNd63qyGm5RCUP1mGeYZDfP0LeUv4PH7N0Ikw1X59M
         oNOdvidm8BB65Zc49hsrahjwVm6etpQCgYnVOAwqF1jxUMipM8vkGdAXl9pnW9O/5TTI
         8LQg==
X-Gm-Message-State: AOAM531DMDih2Ttl/+qebaUuI3GeIdwAA6X4Ks4hoei3seT8hTH7oZfX
        ZpbtlbtxqpLxGqk41RPA0d0MZw==
X-Google-Smtp-Source: ABdhPJy8uruNUiwWVk93BXNeRvSwBhf7iaLMvdmzo0+duEh9lWnm2W57Ul89YuTANAlkrm/ZuJlOKA==
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr3149973oie.143.1590693235796;
        Thu, 28 May 2020 12:13:55 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm829951oia.41.2020.05.28.12.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:13:55 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Enable as many KUnit tests as possible
To:     Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        David Gow <davidgow@google.com>, skhan@linuxfoundation.org
References: <20200511131350.29638-1-anders.roxell@linaro.org>
 <CADYN=9LkA2h6dANREfPQq4iDvVEJX1wAdxjv31mpVBkaM_g0ZQ@mail.gmail.com>
 <CAFd5g452oiRpMa3S=F9wFsb9SRKBYXJFuusge+6=zCEFX74kYQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <76811e1b-c26f-53ac-5703-104aacd06666@linuxfoundation.org>
Date:   Thu, 28 May 2020 13:13:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g452oiRpMa3S=F9wFsb9SRKBYXJFuusge+6=zCEFX74kYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 1:07 PM, Brendan Higgins wrote:
> On Wed, May 27, 2020 at 4:49 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>> Hi all,
>>
>> Friendly ping: who can take this?
> 
> Sorry, I just reviewed the last patch.
> 
> Shuah, do you mind picking this up for 5.8?
> 

Yup. Will do. I was watching this thread waiting for your
Ack. I will apply it once.

thanks,
-- Shuah

