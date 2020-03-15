Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E567EC18E5B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 21:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AE420674
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 21:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNQS/5ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgCOV5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 17:57:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40752 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgCOV5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 17:57:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id f3so11872138wrw.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 14:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HLihB9dC29PEmBSGEnLAUB0v7jZbe0wOo+ZjC92so+E=;
        b=pNQS/5dsMT2cPgmXpzLLY/wpmbaYMOgwn06it0C7G6X/0Q2PbO/OcRHTUhXVWGwnCp
         pDQ2IJ0+aAptWSVDFctX3/+BCrOPMhTYaQ4QK0bUgXj4MPq57o8h0ulDxEW8vR9YBqJl
         ELJEtWmYSoYBqWQWPA5s93ituercEF9Nbe5LQTewH6qjD8/KoecUbSqAOwd9LPUM4BEC
         qxJCQ/FV32Mkm+iXU7ygsaMpxIdtS2ATd7Fc73V0iURJQJ6Q9XS4uTqMD9c3RURsqPxE
         q+LO89B4EK7SqxugmjegpALlmg/8G54VfRMxjleSXaWr041zzDRIRnDj0eOLqOX5Mvi3
         WyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HLihB9dC29PEmBSGEnLAUB0v7jZbe0wOo+ZjC92so+E=;
        b=lh765edzuGuxIKHpZrG2f3Rzfp0ji6Q/mBKOywwq6J4JuCCIGVBerv42Vv13rQ8FFI
         WAx7B7SijXr04ltWVdrs/PXmFWZ0243y0MNbi7jpeuM/OHLp2LnmgxlQzTs++RUeo2DD
         OnBv7plOgXohWI3qikKainyFFWebBpYnK/haRU/cwI58jlUAy+kz7vsDZVE9V9ns93ap
         AC2kFVUlwrkoUifZjLnTwtLKPakusxN4V8/J9phllboS6eNPy7jJkREiFi8Z1d+zGoYt
         Wj+ilAH/XhwISpozbYX5e+pxlU/xlHcbAjNmM9cWXJu5S3ISyvffBi1pDt1x7BeyLDCq
         gk8w==
X-Gm-Message-State: ANhLgQ0M4lTrqYjhnpJn85auk9J3vy9xZv78iemtR+qVO7c+fBicQd37
        6vw4K6zdA4c5ilfC+1d76ys=
X-Google-Smtp-Source: ADFU+vvRB2qgHnmLpUNtf8qGKJ2z1nOnKGdiEZFikcsvlkM8vdQ3CGWyBpA5+6T3RXZs3BuQK02+Hg==
X-Received: by 2002:adf:e881:: with SMTP id d1mr31301356wrm.262.1584309418504;
        Sun, 15 Mar 2020 14:56:58 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id g127sm28318338wmf.10.2020.03.15.14.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 14:56:57 -0700 (PDT)
Date:   Sun, 15 Mar 2020 21:56:57 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, mhocko@suse.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2] x86/mm: Remove the redundant conditional check
Message-ID: <20200315215657.hojujnc2ru5jd26n@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200311011823.27740-1-bhe@redhat.com>
 <20200314151006.gnkyf4xpqve6b3wx@master>
 <20200315124913.GA3486@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315124913.GA3486@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 08:49:13PM +0800, Baoquan He wrote:
>On 03/14/20 at 03:10pm, Wei Yang wrote:
>> On Wed, Mar 11, 2020 at 09:18:23AM +0800, Baoquan He wrote:
>> >In commit f70029bbaacb ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
>> >the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY. Before
>> >commit f70029bbaacb, CONFIG_HIGHMEM && !CONFIG_MOVABLE_NODE could make
>> >(N_MEMORY == N_NORMAL_MEMORY) be true. After commit f70029bbaacb, N_MEMORY
>> >doesn't have any chance to be equal to N_NORMAL_MEMORY. So the conditional
>> >check in paging_init() doesn't make sense any more. Let's remove it.
>> >
>> >Signed-off-by: Baoquan He <bhe@redhat.com>
>> 
>> The change looks good. While I have one question, we set default value for
>> N_HIGH_MEMORY. Why we don't clear this too?
>
>This is for x86_64 only, there's no node_state for N_HIGH_MEMORY.
>

Thanks, I see it in arch/x86/Kconfig.

-- 
Wei Yang
Help you, Help me
