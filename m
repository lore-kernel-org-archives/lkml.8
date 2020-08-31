Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B283DC43461
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924FB20678
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/51J3vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgHaSUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:20:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51265 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729544AbgHaSUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598898037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTgWVCfmD2ZFmUsGbcmjOpx9gO63OLfuS/6GjWgQa9A=;
        b=Z/51J3vl7Xk42MplChspxcGBOUNVgLuTcadec6nuomihB7sKmLjAQHRLXMUdNdA2gLe1c5
        UybS+h0WosrAiUztFjUsPcbEYXIB1Fj9GIhcG46ol+U3nOYnZggGr3SMb0OVPVlNX3mr3B
        eFCsIB46KG7B4gpSH22HzaWEgu4GqW8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-rKPRpvjIN3OYANQEvp9WTA-1; Mon, 31 Aug 2020 14:20:35 -0400
X-MC-Unique: rKPRpvjIN3OYANQEvp9WTA-1
Received: by mail-io1-f70.google.com with SMTP id n16so4658470iop.19
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vTgWVCfmD2ZFmUsGbcmjOpx9gO63OLfuS/6GjWgQa9A=;
        b=Ry3UfmvIhE0Oglyy+dV+zkkGClx21nkpHYRi7/3N9iEFqTeR6kTwsB/fNrXZVz3u/O
         bTt8QBLcK+bCUwfHGkc3soCTDXxYlEFG4LGuRDhy7LT7YvNM0s9IVkFtr5xfOikyYpqt
         M4Oi6B2mJH3S7y+Vts1Mz0+Z8XmTNBKHszjfo6Qw02tN5YcZcINMXzL13cMS5bsCsxwy
         qg/0zwcLmrrjhktedziLpK0+/oQejquzlEaqLUnhHToJLvCsAoq7wS2g/RXDKw3k7VYA
         GoSlpU6+DC3gnMVr3pqznLlDs1BXv2XIBAnGTcO8YeR3fVOrq22qi7ZIQtXWS1qsbr+g
         TCsw==
X-Gm-Message-State: AOAM530CTmREVJq/VJxohpP9E7cHRLZY1EAJPzKCYgls/Wyyv8AEi2n2
        FJ9tLLO/+c+Ubopc5j2rHWQJyCWlPx8JVl8SlcQblYuuyvFJDxrAhed7R/i6ROCND4hscrf7gs/
        coCNc95U6DmJAmLK8j4POwqkt
X-Received: by 2002:a5e:c305:: with SMTP id a5mr2368699iok.142.1598898034116;
        Mon, 31 Aug 2020 11:20:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLriSxML/IerKOXIK8xnZB+A7cvbKwq6xgY3i4W7WSOXvQE3qytcTFpIpivB6aS71HlTgt6Q==
X-Received: by 2002:a5e:c305:: with SMTP id a5mr2368679iok.142.1598898033818;
        Mon, 31 Aug 2020 11:20:33 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i14sm4939106ilb.28.2020.08.31.11.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:20:33 -0700 (PDT)
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
From:   Tom Rix <trix@redhat.com>
Message-ID: <5f9c8819-cd0f-6fb9-1b0f-b34f390ae65e@redhat.com>
Date:   Mon, 31 Aug 2020 11:20:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnn6eMqJsL=aJ8n5dWWoHjXUL0LBSyVwZPGCKpkBSLHXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/20 10:48 AM, Nick Desaulniers wrote:
> On Mon, Aug 31, 2020 at 10:47 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>> On Sat, Aug 29, 2020 at 8:35 AM <trix@redhat.com> wrote:
>>> From: Tom Rix <trix@redhat.com>
>>>
>>> clang static analysis flags this problem
> Also, Tom, please use ./scripts/get_maintainer.pl on your patches to
> CC our mailing list; clang-built-linux@googlegroups.com.

gcc is still doing the building, so it this appropriate ?

Asking because i have been sed-ing clang-build-linux out.

Tom

