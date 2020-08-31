Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35212C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8CF206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AI4L672M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgHaS5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:57:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25710 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727933AbgHaS5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598900234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b9PG3irLIE6N/QMI1mVLnwUslXXwXq1frH2lpMwMGik=;
        b=AI4L672MBC6o0ydbPBoqe3lA8DY6jrgWgVpETm6xQAYq/C+EEVsaxM0+YefM0Ze8ns8M1K
        hfL+8wr/zpCRmuKJzI3NXWP87Bd1VWH7eLqVylAzfdclLomOLZb2J46WmoExXWSk6cNqf/
        dBoF+7LtT2n8SS2NPDSHHLYwmlTT1Is=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-rU2DVE1IPRGIhIzBUpYYwA-1; Mon, 31 Aug 2020 14:57:10 -0400
X-MC-Unique: rU2DVE1IPRGIhIzBUpYYwA-1
Received: by mail-il1-f197.google.com with SMTP id b85so5850325ilg.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=b9PG3irLIE6N/QMI1mVLnwUslXXwXq1frH2lpMwMGik=;
        b=OckCm5/4tThs/1TzAU9z4XmgcFzQvWyuM4TMD39xmDsWVNWUZjqrVp5WcQNJwnyDmh
         dhFPlOovBG7IsdiLHO1TKZEV8WGOqyjIJWTO6380N5atrr0kyf/02+wrhdIp9GMU58X7
         OKbR6h0RmnzWh9VYcdkPUxWgAlxXDBf1DsAUlhTLUyEDAknY58gsrlYtcCgXoi9bC+vA
         fvdNL9fXTWB9HacM6447EY+jjFLMioCfuOBNhs+B1AUpxf9/fm1j/fzimwyGY7badXlm
         fqEOjPI7cBysnE5CHkxzIQCK9Ct5u0XskVMafNM9NDj40lx+G3PYgKdRBUmflvQncIXa
         TBdg==
X-Gm-Message-State: AOAM533WWvy5JNwYjQdGaiFuGaty1aVlfcqv1gB36E6KORugM3jFmqk0
        3cga57xv2QZh/qEH2BczhmJ6shod7/RQuf1qA+VIM4e8fift8ERLfnFtPBcy/pSrJSpjFyF2hEQ
        qG7QzYOcapU2FaK8MKGcvu5WN
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr2660993ilq.81.1598900229614;
        Mon, 31 Aug 2020 11:57:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6363cf0Fuegrl6FGpQzQ60cX6Kv8aPKaONFfhmnNPoiSsY3mJNJNJkBiSY0Os9JB6vSP3Rw==
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr2660958ilq.81.1598900229155;
        Mon, 31 Aug 2020 11:57:09 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i144sm4320996ioa.55.2020.08.31.11.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:57:08 -0700 (PDT)
Subject: Re: [PATCH] soundwire: fix error handling
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Vinod Koul <vkoul@kernel.org>, yung-chuan.liao@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        shreyas.nc@intel.com, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20200829153515.3840-1-trix@redhat.com>
 <CAKwvOd=+X2AakX3kTYCvyug-MK_Y+atDbkDSRxA0pUfOatQ3mA@mail.gmail.com>
 <CAKwvOdnn6eMqJsL=aJ8n5dWWoHjXUL0LBSyVwZPGCKpkBSLHXA@mail.gmail.com>
 <5f9c8819-cd0f-6fb9-1b0f-b34f390ae65e@redhat.com>
 <CAKwvOd=D=LWeSGYekOc9qs_aVOD_jpM2DVZO7=n_2L75Ad3Nxg@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <5075093a-0853-8030-1cbd-42a051ca3651@redhat.com>
Date:   Mon, 31 Aug 2020 11:57:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=D=LWeSGYekOc9qs_aVOD_jpM2DVZO7=n_2L75Ad3Nxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/20 11:39 AM, Nick Desaulniers wrote:
> On Mon, Aug 31, 2020 at 11:20 AM Tom Rix <trix@redhat.com> wrote:
>>
>> On 8/31/20 10:48 AM, Nick Desaulniers wrote:
>>> On Mon, Aug 31, 2020 at 10:47 AM Nick Desaulniers
>>> <ndesaulniers@google.com> wrote:
>>>> On Sat, Aug 29, 2020 at 8:35 AM <trix@redhat.com> wrote:
>>>>> From: Tom Rix <trix@redhat.com>
>>>>>
>>>>> clang static analysis flags this problem
>>> Also, Tom, please use ./scripts/get_maintainer.pl on your patches to
>>> CC our mailing list; clang-built-linux@googlegroups.com.
>> gcc is still doing the building, so it this appropriate ?
>>
>> Asking because i have been sed-ing clang-build-linux out.
> ah, right, you can use `--use-cc=clang` for analyses of builds with
> clang.  It doesn't hurt to include our mailing list, since we'd like
> to know if issues get reported with the analyzer itself.

Ok, i'll include it.

The only real issue so far has been https://reviews.llvm.org/D83984

which fixes reporting on a couple of files.

Tom

