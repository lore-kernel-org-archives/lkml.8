Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15611C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87EA207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591303166;
	bh=ZjCuH0s4Quw+6l2GM9voM+T+YkPqo6yKG43nOHMB7UI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=GZuxVq7l49gQcG87PKnfvQiEcCmC70GUTg8Oqp3ZUHOhOfEDH9HkKA5+Z5Vriuz7P
	 72KWYFvXaKW086y0gTrOi7e9hStIq5tOZLg2P/LLIkeRXoj0ontkzSqoecaTUaUDpU
	 XxnSCMuha/ot2BkY9i32SlhpInCf074oIjpFoP08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgFDUjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgFDUjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:39:20 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2674C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 13:39:20 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 69so5870371otv.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n4qcFbrYrQboDsoGvWR4IKKjkBw2HOoEx50CuF4/sRg=;
        b=X+1urrchhlAJ6Ly5eKLEwlLZBlos/tPMbW2qcDX2ccbNN0J0XQByplLqMfeDaRcNHQ
         EvnZLIGtALIexNJWE7WZhaFK5yQsyRt8/i1DxNLSpK+1LzHPWpUKOETN1BYjFdCjB+Vl
         /AP5kdUUtAL9HKi1PmPBX5OXwcuOL94Gi6dhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n4qcFbrYrQboDsoGvWR4IKKjkBw2HOoEx50CuF4/sRg=;
        b=F8+l5aFlxUzknwOPn0422YI2xzoyxRdKdzB2ickIUDy/XkgrKQmLZrPaUaC1sd2bY+
         ziDaZJ1+jtl/M4DWBMa60AGCX9pSHNDjNEZkPoBqE3Q5Qgv+/PdzkuVl3lE5+/j/TAq/
         q4iOpZktHT/PuQe8yht7Rn4k0WuOhHTnFnPCrEDIjG+BN0VIAnmF/+u1IawGj+WmFZI5
         wrfLv98RwuqS6FbrdN2YsEdv13O6/bH5lZC/Sz4kYWDd3j0Hy92g/+DgwG4wVcezUS32
         MI2BOQWqf2YxbAG1bMSXWGUct05PiFPbt2brFl23aDlKg/4LNtXWEzNQtKWpLf3dzvHN
         Pk1w==
X-Gm-Message-State: AOAM531LjQVVzc45yEhOKkVXqE9+yJvl71a0nwqkYMVbOKQj1V2zRV3K
        7Q00ZLSejyzZ34JuO1oxuF5hdA==
X-Google-Smtp-Source: ABdhPJy7AdFjBepNhW8xq/grKYoy25Pw+/agwirtqSpnQR9W3AmaDRAKSPoazBhBoL3dX678SmP4sw==
X-Received: by 2002:a9d:7f8c:: with SMTP id t12mr2603935otp.66.1591303160057;
        Thu, 04 Jun 2020 13:39:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f2sm1527259otc.45.2020.06.04.13.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 13:39:19 -0700 (PDT)
Subject: Re: [PATCH] scripts: add dummy report mode to add_namespace.cocci
To:     Julia Lawall <julia.lawall@inria.fr>,
        Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        YueHaibing <yuehaibing@huawei.com>, jeyu@kernel.org,
        cocci@systeme.lip6.fr, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200604164145.173925-1-maennich@google.com>
 <alpine.DEB.2.21.2006042130080.2577@hadrien>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bf757b9d-6a67-598b-ed6e-7ee24464abfa@linuxfoundation.org>
Date:   Thu, 4 Jun 2020 14:39:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006042130080.2577@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/20 1:31 PM, Julia Lawall wrote:
> 
> 
> On Thu, 4 Jun 2020, Matthias Maennich wrote:
> 
>> When running `make coccicheck` in report mode using the
>> add_namespace.cocci file, it will fail for files that contain
>> MODULE_LICENSE. Those match the replacement precondition, but spatch
>> errors out as virtual.ns is not set.
>>
>> In order to fix that, add the virtual rule nsdeps and only do search and
>> replace if that rule has been explicitly requested.
>>
>> In order to make spatch happy in report mode, we also need a dummy rule,
>> as otherwise it errors out with "No rules apply". Using a script:python
>> rule appears unrelated and odd, but this is the shortest I could come up
>> with.
>>
>> Adjust scripts/nsdeps accordingly to set the nsdeps rule when run trough
>> `make nsdeps`.
>>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Fixes: c7c4e29fb5a4 ("scripts: add_namespace: Fix coccicheck failed")
>> Cc: YueHaibing <yuehaibing@huawei.com>
>> Cc: jeyu@kernel.org
>> Cc: cocci@systeme.lip6.fr
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Matthias Maennich <maennich@google.com>
> 
> Acked-by: Julia Lawall <julia.lawall@inria.fr>
> 
> Shuah reported the problem to me, so you could add
> 
> Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> 

Very cool. No errors with this patch. Thanks for fixing it
quickly.

thanks,
-- Shuah



