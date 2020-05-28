Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD0CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9AB7206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKu9Ceaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389831AbgE1Mhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389734AbgE1Mha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:37:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA24C05BD1E;
        Thu, 28 May 2020 05:37:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bg4so6210603plb.3;
        Thu, 28 May 2020 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RM0jC6/bK9EWgc1Qw8f8+WAZXDRRPqoeOxNOPG73+XE=;
        b=hKu9CeaaS+mslu3Q1X0iGY0CW6r39ADgkAiRHv1Yh7yNQc/dlCRWfnBARzeqToqJGl
         LHsEQn3Vf5hTe7KFbvXmmh7FT6dwSuLzG5uC0GTOr92P6HJLB1vl5MTCq3rnztYCqABP
         RRWmqvbKeSQTunoMpuN28/Eg41A45vKTDzHBwYO0kOrcAcLW5uUm3ZgZs/XK8MUSzGOY
         J8mSM5bg5rOj1QRVAPuQpvJvjzhwQybYhEVPH7FbpSrZ9bbITw50HtYg8wDmpMLEBuFA
         4Sr+Rr2F0Hl8J6i+61rSJR9CehfRRqMzu1wWVXstI3F+OynaTv92fR13DBn/KUJ91t7y
         CUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RM0jC6/bK9EWgc1Qw8f8+WAZXDRRPqoeOxNOPG73+XE=;
        b=AZgLH+7s6NAGk7vG9qx5zRbQ3S7a1iEKsrMRpHaYpy+r38XNKLwsS3zCOc5/reH4u0
         qYmyyJhfkTbmdXETyyLOvksAYaHs/Mt+d7NhOgyhvtJkJEcPTGEtpX3AEFJclS1WJDwE
         YEQtLJmklvNkezjo0m4VVZAhC3hfvdpDXjFmotF3mOm6ks/0HxCuBG0uRSex02PlJJ99
         BTm5nE90ni0YFfMqO7gJYXVH/y+0PN0C4njtDUht/o+sy07ail3bpwW7XlX3a04Ru/5T
         lObHz/u1tuPEaWu/LBIO4b0cH3NG6HzjNqPXCZuGG+sgeOhyR7f4yRzvg3wGCRxfrh9T
         Vy5A==
X-Gm-Message-State: AOAM5327v503AnBvLWaOdRCMPJ8KFhHceH2OD684zA7ChXCDxHZIUhQe
        aLdmVVkJ+J0hbggARL5mb4ryIRR8
X-Google-Smtp-Source: ABdhPJx7z9QuO4L0+TpymOSFszjMcFDePZFwW4qWwGFP/4My3SJTa6YvRHDPBlJWIc+q9/c4MbHx7w==
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr3057047pla.99.1590669449950;
        Thu, 28 May 2020 05:37:29 -0700 (PDT)
Received: from [0.0.0.0] ([198.211.10.140])
        by smtp.gmail.com with ESMTPSA id n205sm4842592pfd.50.2020.05.28.05.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 05:37:29 -0700 (PDT)
Subject: Re: [PATCH] of/fdt: Remove redundant kbasename function call
To:     Rob Herring <robh@kernel.org>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200512154909.279788-1-arch0.zheng@gmail.com>
 <20200527182708.GA2458626@bogus>
From:   Qi Zheng <arch0.zheng@gmail.com>
Message-ID: <ab0ce429-a70e-990b-bef4-290deb36ddab@gmail.com>
Date:   Thu, 28 May 2020 20:37:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527182708.GA2458626@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your review.
I will send you a patch of v2 later.

Yours,
Qi Zheng

On 2020/5/28 上午2:27, Rob Herring wrote:
> On Tue, May 12, 2020 at 11:49:09PM +0800, Qi Zheng wrote:
>> For version 1 to 3 of the device tree, this is the node full
>> path as a zero terminated string, starting with "/". The
>> following equation will not hold, since the node name has
>> been processed in the fdt_get_name().
>>
>> 	*pathp == '/'
>>
>> For version 16 and later, this is the node unit name only
>> (or an empty string for the root node). So the above
>> equation will still not hold.
>>
>> So the kbasename() is redundant, just remove it.
> 
> There's 2 occurrences of this. Can you remove the other one too.
> 
> Rob
> 
