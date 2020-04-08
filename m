Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75DCC2BA80
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 22:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E95B206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 22:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2AO+xIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgDHWT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 18:19:28 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35139 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgDHWT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 18:19:28 -0400
Received: by mail-il1-f195.google.com with SMTP id t10so3197085iln.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qniumfFvLliMhVFnxnrnB7Q2WNhjy7ZRmIrlX3T4sxk=;
        b=g2AO+xIkAkescIVWRA2GPbu6jSL6GUSozW16kCmcsLWRJYzFSv2OkLIX9SMR0nz6B9
         FiO5toadCf87F3YSjodNMUwO1DRG8iBbBQYFOPf1rGwzK14fKlPGqhA5JFonTHjdjjbR
         p3GvJT4dQKxEzlSzshcRqzcqaTyvCqZ1jDfkh+DO0hH7osrAYDUj7br8bFRy9nod6I4Y
         9jIEEXq5pQljiu/OH0vDK86GcEp249O6WuFiyBUqPts8oiktmGC2C6rMnzq9/uk2Arc6
         niRlCsxH/FSjqRhNieNzimE2XSN3kMykP9ZGodOQ6tBsSP8i8UYCzoC0BeRz8QBjOtOB
         JzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qniumfFvLliMhVFnxnrnB7Q2WNhjy7ZRmIrlX3T4sxk=;
        b=k39+Kl2ev3NpVqBL7hHknn76aC7vRhCiLNBZNuwNYXeK86/bpalWt46pX/R1Mb/cnr
         yoUpiwwx5gcoXh0ojOAPXKduK00w/gtDWY9gTYTJhZvozEndWS9Em9Dm9nMve9vOmITx
         2pkfM4zJ2nP2TEPo28waiLA1fLqwpkEBJN5ZSSpBupi7POoTgHxkxOQjTKjcc70ZIlOi
         DDnQ9YFV4Tjxi69n2VBM95cjgnTE91yW/sHkUUX4ZdNPJ61SW0+HD7C367cQE08IwPf9
         7zIaVTW+FEhnH/uxC1xQrAv/dvnx2dmJQDVAHgqm1gANMyCEC4BkaacMbzULLN7I2Nc+
         92YQ==
X-Gm-Message-State: AGi0PuY/Nir/7c8iHpJZS320I62Ib3K4iufjGWlszTGfGgvZBIRZAcAR
        LVo7/kPUOz8bI0qwYUcROsVq+qyqD5jCCw==
X-Google-Smtp-Source: APiQypJlQ4pCg3c6kRw4kbM5us3jsIhB7uNITvlnj8wNX6hNeoZOozNjSRwRazJUGvIwcGLTHcYMjw==
X-Received: by 2002:a92:9edc:: with SMTP id s89mr10655671ilk.229.1586384366878;
        Wed, 08 Apr 2020 15:19:26 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id w7sm5153940ior.51.2020.04.08.15.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 15:19:26 -0700 (PDT)
Subject: Re: [PATCH 1/3] remoteproc: fix a bug in rproc_alloc()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200403175005.17130-1-elder@linaro.org>
 <20200403175005.17130-2-elder@linaro.org>
 <CANLsYkx4pSs+j83ewJpOkQmY7=q=k71xg7N9A=sDWrDZKzzQTA@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <9695b13b-77e1-6a5f-9cff-e4c15c46f311@linaro.org>
Date:   Wed, 8 Apr 2020 17:18:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkx4pSs+j83ewJpOkQmY7=q=k71xg7N9A=sDWrDZKzzQTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/20 5:16 PM, Mathieu Poirier wrote:
> Hi Alex,
> 
> On Fri, 3 Apr 2020 at 11:50, Alex Elder <elder@linaro.org> wrote:
>>
>> If ida_simple_get() returns an error when called in rproc_alloc(),
>> put_device() is called to clean things up.  By this time the rproc
>> device type has been assigned, with rproc_type_release() as the
>> release function.
>>
>> The first thing rproc_type_release() does is call:
>>     idr_destroy(&rproc->notifyids);
>>
>> But at the time the ida_simple_get() call is made, the notifyids
>> field in the remoteproc structure has not been initialized.
>>
>> I'm not actually sure this case causes an observable problem, but
>> it's incorrect.  Fix this by initializing the notifyids field before
>> calling ida_simple_get() in rproc_alloc().
>>
> 
> Both Suman and I are meddling in function rproc_alloc() for our
> respective work [1][2].  I will add this patch to a set that refactors
> rproc_alloc() as soon as v5.7-rc1 comes out.  That way we can all base
> our work on the same foundation and Bjorn doesn't have to fix 3
> different merge conflicts.
> 
> Thanks,
> Mathieu

Fine with me.  Thanks a lot.	-Alex

> [1]. https://patchwork.kernel.org/patch/11456385/
> [2]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=261069
> 
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>  drivers/remoteproc/remoteproc_core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index e12a54e67588..59b6eb22f01c 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -2054,6 +2054,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>>         rproc->dev.class = &rproc_class;
>>         rproc->dev.driver_data = rproc;
>>
>> +       idr_init(&rproc->notifyids);
>> +
>>         /* Assign a unique device index and name */
>>         rproc->index = ida_simple_get(&rproc_dev_index, 0, 0, GFP_KERNEL);
>>         if (rproc->index < 0) {
>> @@ -2078,8 +2080,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>>
>>         mutex_init(&rproc->lock);
>>
>> -       idr_init(&rproc->notifyids);
>> -
>>         INIT_LIST_HEAD(&rproc->carveouts);
>>         INIT_LIST_HEAD(&rproc->mappings);
>>         INIT_LIST_HEAD(&rproc->traces);
>> --
>> 2.20.1
>>

