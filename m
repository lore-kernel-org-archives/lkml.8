Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D43C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F8020663
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594226556;
	bh=ZRDDwON5eZyQUuI20HosGv8ed8x41zdMhb/ukC+6R/k=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=V1yYwCJLfuiMJirz7d8TvEoK7UnApR5hH5q8XeLAhy3IOEgqnr23tTwnwnW741QO/
	 BsD2mTY7pZxUvua+RtvKDfD6VYuzt2H6PkOQzVKEGMKGetHNPH8MqVVNZJrt6RryAu
	 2KKnHXy6W9voTjqryR+iPTb+LT65WCEmiKQw2dd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgGHQmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgGHQme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:42:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F86C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:42:34 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id o5so47597926iow.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AJF6ghJhY51xyqqJfdaCuA4fh0Dk+yVUi+dArBV5bG0=;
        b=EYFpxsH2IaEtZNWMgMEazNrufq+70MnqTY9RRKm0YJR1uGc6MnDQayIEWhud6bu3oZ
         5O/yIzFoHA9G67uAj+PHN++kiRvvucErUMinOTG8Oiy28xu08qNjMy/6nyIeLJKf/VIM
         o7p+Q89EWGS8hX4zaXRJrIlr0GkRCuz40j4+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AJF6ghJhY51xyqqJfdaCuA4fh0Dk+yVUi+dArBV5bG0=;
        b=PyrlCIUqTau6bSAu3M1EjJHNrQy9r8MslAsAhYf6gkrv0/Rcl7DD5i7O5Vh/EWpz7d
         avxIUXH843b9NEbRvyZCnv2s44YjpBuc5oJCXpYsUI7XxklQ13KORbhugJV+nJrMH2rd
         h0+XYj/sk/ATIf92eDG3++B7uOUS56Wm/e0UVUiy55BuFhi4c218ZfFg4DGtrNjzIiO7
         0iv6Rh0pWg7xOjizlznMNEJigMqtkI6RWTDcdlt/2CGRsvPcaG+kUEgaiMoBuwQf80L8
         ewN9NL6K61JVMigyB2BI6wUKuCbKXWhQo3FVjrPnqAKbSM7KzRCZlxWzmfn2QsFsB+ng
         OMcg==
X-Gm-Message-State: AOAM532LmjGHPssTdfcqS5b4++bbRqHaY7EQv7rmAle/CiAYymmbGmcx
        Qeg/slF3PwmYpaUJt0QDDr9HXg==
X-Google-Smtp-Source: ABdhPJyDDZj4AdNOQWVxoOj+aPSSFpHOVQ0M1bYCH7ln+iGyQeokXxFNQNF8og21xL8rlPHb5eTZgA==
X-Received: by 2002:a6b:e20b:: with SMTP id z11mr36687689ioc.2.1594226553920;
        Wed, 08 Jul 2020 09:42:33 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z20sm342436iot.15.2020.07.08.09.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 09:42:33 -0700 (PDT)
Subject: Re: [Tech-board-discuss] [PATCH v2] CodingStyle: Inclusive
 Terminology
To:     Dan Williams <dan.j.williams@intel.com>, corbet@lwn.net
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, Dave Airlie <airlied@redhat.com>,
        torvalds@linux-foundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b0d5cc51-a675-858f-6897-03ab9a63af1f@linuxfoundation.org>
Date:   Wed, 8 Jul 2020 10:42:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 1:23 AM, Dan Williams wrote:
> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.
> 
> Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> Cc: Jonathan Corbet <corbet@lwn.net>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Dave Airlie <airlied@redhat.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: SeongJae Park <sjpark@amazon.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Chris Mason <clm@fb.clm>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v1 [1]
> - Drop inclusive-terminology.rst, it is in the lore archives if the
>    arguments are needed for future debates, but otherwise no pressing
>    need to carry it in the tree (Linus, James)
> 
> - Update the recommended terms to include replacement for 'master' and
>    'whitelist' (Kees, Andy)
> 
> - Add 'target' as a replacement (Andy)
> 
> - Add 'device' as a replacement (Mark)
> 
> - Collect acks and signed-off-bys. Yes, the sign-offs are not reflective
>    of a submission chain, but I kept "Signed-off-by" if people offered
>    it.
> 

Dan,

Looks like you missed my Signed-off I sent for v1

Please add my Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>


thanks,
-- Shuah
