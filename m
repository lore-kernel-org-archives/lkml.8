Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65201C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380B221775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7CM7K1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBGQW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:22:27 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:42387 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgBGQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:22:26 -0500
Received: by mail-oi1-f181.google.com with SMTP id j132so2488754oih.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 08:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jdQ0C78bvYtTRSyKc6vh194BPwvbLFB4WV8OutGW238=;
        b=S7CM7K1bz2ss907tTG3Dt7JaijcjvM18yJxeOKsHgqqYuYvTZF0PYiNzfeN2leAOCV
         +2i1XZj0343U6/at8uD4PtQZIU/6hAmZIzXixg+3RqvcfIkuzzFQXgtzzeeLcro3mzNR
         GavAxCwtNDf18MeMdHRVVOf2yUaX/GcF+5ya5XqsX9A+AH6AGT21kayU48Y0YoxkpLkj
         h+DNqsi4rFKtz9zlAuEaEdMxAdOLKYJsIDsjWoUyN4vb6ttMOAyWth2ARbd5YbVcW7vI
         AGgnSEKK24NmLQHC9N10wPZzOYq6nl5XhN16/9BH9oQGmw46v4MyooMdn9/MsZPhpbhM
         Lr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jdQ0C78bvYtTRSyKc6vh194BPwvbLFB4WV8OutGW238=;
        b=s3sCrxdinusK++eDnRPEp9is0/SMhyfjJ2hbPj8Oz3qI1G1l3OStduMl6RyEX/4tXD
         SPDqVJmunXI737xnHKNsTp9SL+FnH9DdQ7LITHMwhsPL9Dlr2YxNKtWMdXfga0MLOOB2
         MN41oIn1nj23kuU47YWnkbjhBBCtM41/a2NIdV/At3VRIe5vwclCcdXwONu19bGXEgC3
         Zggx+qLP8b+vZhYzPNHZy0sspjkYQ8yt5tms0B3qGd9qq66jJvVmRQTLS40VhH1FDthU
         nSDTzUOm31/AXW2Y4dC1eZyYEd4Trju3tO0/KoI30ni7Hpl1SlOs5N8lsB4D0OtwyvSh
         ZK/w==
X-Gm-Message-State: APjAAAUpryTscF9ZnMuGKCF5rbiLnWMUD9ahkwf/auEOEia+RfdVKcUZ
        ljzuUT77AI1OWs6K9YzfnHCFng+9
X-Google-Smtp-Source: APXvYqxkjvMDIX9W+zPg4+6XY6HNJTuMTmSEQZclfAK2NQaAHD6sneGyDv3aspVxbpO9A+wlurlq0Q==
X-Received: by 2002:aca:5588:: with SMTP id j130mr2490993oib.122.1581092545897;
        Fri, 07 Feb 2020 08:22:25 -0800 (PST)
Received: from [192.168.1.120] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id m11sm1140225oie.20.2020.02.07.08.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:22:25 -0800 (PST)
Subject: Re: Error building v5.5-git on PowerPC32 - bisected to commit
 7befe621ff81
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Tom Anderson <thomasanderson@google.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <0fb64c98-57c2-b988-051c-6ba0e460ad37@lwfinger.net>
 <20200207131201.GX13686@intel.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <3119d2a6-04c4-e35a-e14b-d2da413076dd@lwfinger.net>
Date:   Fri, 7 Feb 2020 10:22:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207131201.GX13686@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 7:12 AM, Ville Syrjälä wrote:
> On Thu, Feb 06, 2020 at 04:46:52PM -0600, Larry Finger wrote:
>> When building post V5.5 on my PowerBook G4 Aluminum, the build failed with the
>> following error:
> 
> It shouldn't be in 5.5

It isn't in 5.5, but in the transitional code between v5.5 and v5.6.0-rc1.
> 
> There's a fix queued
> https://cgit.freedesktop.org/drm-misc/commit/?h=drm-misc-next-fixes&id=e1cf35b94c5fd122a8780587559fc6da9fc2dd12
> 
> Does that work for you?

Yes it does fix the problem.

Thanks,

Larry
