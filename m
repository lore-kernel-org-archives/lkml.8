Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DCB207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZe5uJMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgHLNmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgHLNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:42:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:42:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bo3so2288328ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3W8RrOcieXQTHbwagMgPr+h9faxaX5DdAWlD9cZaad8=;
        b=GZe5uJMKa6M7aZOFurAGN9HZW+E47x14RvVije8+4VEvriC8FqaaAmxuAbfh/vNXjI
         K8Fz+9UcesZrEUV8U3cmbM/MbXyDttUuOqRHBPoa5aoZsC44ZQFv5B8ZRwkqC0qlwIpz
         BJTi+EGpDG6HD/qV5gCGf4X5j0YCVwOsIM/VhLuV/KvaWiAPJQT3R+LQ+orGAwJOxR1D
         wdEpg4zSX453qYPv6keXc8ut7IeNYE1rhYcWzLtwAFRrFpRDvti6F7QZ8O6Opxacf1h0
         NnIXwmlk2b1h6v8pC9lO/ZHa/XaxMwdds/CjRDIV1dgXDvDriD10tQhJuZQSNq/39zB3
         XrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3W8RrOcieXQTHbwagMgPr+h9faxaX5DdAWlD9cZaad8=;
        b=PzgP/HOIBa5cuYGZQbJH5CFL4bX/AR3pNxxYdaSLUfv6bOwgi7w58OTPetcfbYV01n
         CJxhaqA3j/5hlwii1USfLsc/yb4DjX1Grx52AUT8uOJniy1zbof9PPTPpizDMroDH7sx
         aka699D8qgsPL41F/x9mAyTKLS9VI6DgQw1EASBX7BDrqxKfq94vwrXrdsV8wE52fzYU
         WDEW6FCCZsa8kJ/aVi+azUfU+JwQ368ZploDcuJgszGR6c8BV5J5yLGBVruzXtvFKlaE
         HfINCjYTA/C7EkleAlVaal+d7vYJA5skvTbM7HL8wAfGaCe6/QL6Dg70VFbLo6/kpKTJ
         /xIw==
X-Gm-Message-State: AOAM530/fAnpZFyv1hnegir24Q22mYOjwkoQ/8S0h2L+Uj7/paso9ZJ8
        NBuzTyN352kgU2zQTvvwuo0=
X-Google-Smtp-Source: ABdhPJz5PfpdpcG7CvEvziHljHL6qv3bHCRPg+EEp6qGqe5AMSuEHoC83YTMk3D0FiNYd5rGdhNvIg==
X-Received: by 2002:a17:906:cc4a:: with SMTP id mm10mr30488102ejb.451.1597239736717;
        Wed, 12 Aug 2020 06:42:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id n10sm1503001edo.43.2020.08.12.06.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 06:42:14 -0700 (PDT)
Subject: Re: RFC: How to adjust the trace pid?
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, daniel.vetter@ffwll.ch,
        Dave Airlie <airlied@gmail.com>
Cc:     Shashank.Sharma@amd.com, alexander.deucher@amd.com
References: <20200807133658.1866-1-christian.koenig@amd.com>
Message-ID: <1975d7d1-8f94-5852-6ccc-19fde4d4a919@gmail.com>
Date:   Wed, 12 Aug 2020 15:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807133658.1866-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping? Daniel, Dave any opinion on this?

Christian.

Am 07.08.20 um 15:36 schrieb Christian König:
> Hi everybody,
>
> in amdgpu we got the following issue which I'm seeking advise how to cleanly handle it.
>
> We have a bunch of trace points which are related to the VM subsystem and executed in either a work item, kthread or foreign process context.
>
> Now tracing the pid of the context which we are executing in is not really that useful, so I'm wondering if we could just overwrite the pid recorded in the trace entry?
>
> The following patch does exactly that for the vm_grab_id() trace point, but I'm not 100% sure if that is legal or not.
>
> Any ideas? Comments?
>
> Thanks,
> Christian.
>
>

