Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECE1C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1553C2074D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583969521;
	bh=pqH2gD8vz1tcgbvk8nKS/2i0+P0FgUGY6BHcL+Tkx3A=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=YL5woNwKgR7VvLnMlJHAZ49gDmZhKIoOIjWeg8WFfpTl2//2FLRgo/Wez+wDJp9fz
	 bl5AFRwF3O56qc1WL/ifiSZwsF/RaYTicpIpuFJ6mLQxfH0c5dxWUaoNzyfpA10C8/
	 tTcLpzoxhjgP8nJ5z1hzVuIq1z+BP7h3Nx0XrKs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbgCKXb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:31:59 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:44652 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731364AbgCKXb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:31:59 -0400
Received: by mail-il1-f196.google.com with SMTP id j69so3734486ila.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tWMg+vrny6yAnLZ7P1+Uq3GSafHzz2ZiJHHvFx+tZ+Q=;
        b=VrP/U/elKH+pog6YRt0R7QB8ZGkgty6E35ojdAtd5sL2GKz1jEg4osj8N6DyDrDTDA
         yhzO33zMD9xi3xkYRBLOyYTpGe9X9BroyoGSgiwHdiFEDKOdbAGPv5xeJBo83VP4fpjP
         Bh+gNtxZNR1ji390quo6DWINdj8nVunK0fGGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tWMg+vrny6yAnLZ7P1+Uq3GSafHzz2ZiJHHvFx+tZ+Q=;
        b=kpOUkhKpqzD0g85IQqev9v7sXfolgTqf8YrKai1fz1FnsfKUFayUsX7EPXbbPA/sSY
         yWT89uxGlKqyi0dl+NO9TIWwOkZxjGROtVb9s/EvI9np5uQyiWY+q+mGGPO0L9Ev1g06
         0jJbm7qlViDpbBmQV1ZwcwzBBMCSFd1aYmrOPKw/hY3NtSrst8zRIqHSVjrQAs/fJ55U
         olmBF0N4ZHbaZNcNrcKQkrHvSknZz8fbT3VNRVdlxv7GXrkrcogBqZ9wxB9bQaMEw6uL
         KKjiEXu5FucupYL59jFJ0X1SVJDy2K8c4VreNl8VS84cNJ2aWpQuwlAocRIWb+u2IXCn
         2Iag==
X-Gm-Message-State: ANhLgQ3MdQ99AmrBL/6Tqj/3ePnZpbGGWMorVkl3z7jlprsVIrXFE5W4
        yBHUH9OEPA+w9aGRnc5ZbhoI1Q==
X-Google-Smtp-Source: ADFU+vtFXxSt5AFuuZzVRZiUmKdtjk4VJ4VPJuuo7GpY1CyX4omGF7b4hkWMjEmRoqTiTD61+FeMeA==
X-Received: by 2002:a92:88d0:: with SMTP id m77mr5234082ilh.282.1583969518243;
        Wed, 11 Mar 2020 16:31:58 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b5sm2334097iln.64.2020.03.11.16.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 16:31:57 -0700 (PDT)
Subject: Re: [PATCH 1/4] selftests: Fix kselftest O=objdir build from
 cluttering top level objdir
To:     Kevin Hilman <khilman@baylibre.com>, shuah@kernel.org
Cc:     mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
 <58d954867391c90fe0792d87e09a82bda26ba4fc.1583358715.git.skhan@linuxfoundation.org>
 <7hwo7qijn0.fsf@baylibre.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ceb910b1-2ab7-b27f-7e53-c445d96cdeb1@linuxfoundation.org>
Date:   Wed, 11 Mar 2020 17:31:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7hwo7qijn0.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/20 4:58 PM, Kevin Hilman wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> make kselftest-all O=objdir builds create generated objects in objdir.
>> This clutters the top level directory with kselftest objects. Fix it
>> to create sub-directory under objdir for kselftest objects.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Only somewhat related to this patch, another problem that wasn't in your
> doci is that the current O= support doesn't support relative paths.
> 

Yes I am aware of it and it is in the document as something that will
be addressed later.

"Note: Relative paths don’t work - supporting relative paths breaks 
work-flows e.g:
powerpc. Explore fix. Compile work-flows. Not planning to support at the 
moment."

> For example, using O=/tmp/build-arm64 works, but O=build-arm64 doesn't.
> Try this:
> 
> $ make ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 defconfig
> $ make ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 kselftest-all
> make[1]: Entering directory '/work/kernel/linux/build-arm64'
> make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
> 	ARCH=arm64 -C ../../.. headers_install
> make[4]: ../scripts/Makefile.build: No such file or directory
> make[4]: *** No rule to make target '../scripts/Makefile.build'.  Stop.
> Makefile:500: recipe for target 'scripts_basic' failed
> make[3]: *** [scripts_basic] Error 2
> Makefile:151: recipe for target 'khdr' failed
> make[2]: *** [khdr] Error 2
> /work/kernel/linux/Makefile:1220: recipe for target 'kselftest-all' failed
> make[1]: *** [kselftest-all] Error 2
> make[1]: Leaving directory '/work/kernel/linux/build-arm64'
> Makefile:179: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
> 

I am looking to address build and install issues first.

thanks,
-- Shuah
