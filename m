Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42B5C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8007820757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdboRjN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgIGQaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729848AbgIGO0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599488764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zTmBPadsM0369P4dgmmlV6u5vQHhp1sa+9yqI7VZ1Zk=;
        b=cdboRjN+jFkmDdy3Ss9SYupEsnkOd8kYKVAtUv3NAf0u2/OPLK9mR5WOoT4SCF+4q2xmE+
        Me+C7zJ9aqUOFGEtBiq7hVMafl9cp7HMIJY9zRqPqNUzNQ8jU6rF1WYjMBSKdkNsfOAso9
        I+wsQXhmbZNMI2n9rWDKvEQU2XLODug=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-60pEeXMKMmyWVfkLA9jJHg-1; Mon, 07 Sep 2020 10:26:02 -0400
X-MC-Unique: 60pEeXMKMmyWVfkLA9jJHg-1
Received: by mail-qv1-f71.google.com with SMTP id bo17so7694018qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 07:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zTmBPadsM0369P4dgmmlV6u5vQHhp1sa+9yqI7VZ1Zk=;
        b=soK4JKzoaYaJis5v/SMOP+LwRzNR814yFx72O3tmNrdTxjJaVFIoRS/W/lrPgrFHZ6
         s6seUqEivSd/YJkW3dFC+tEegJLnuT0A95TC8DZoJoOVESQxQ9vanGwcyqXixaPk+VvB
         tHvPIThr/7Qsd/X3+5U1rqEm0yeMbptXxRa+mJlww6UWiB59bi/X7Ago3LyW+n2UFgiE
         Yxkb6rSaahuTjXOibrYwQk3HjKtYKAzRiCIDr7fP2Iw6oSaF9DMH8qaCT0DE4BoW2YJB
         uD2qSE4lbQ7qnGBABVcsDEOJhRjdJkA3xiMOLYmE1bI8drPZQ2pm5TDLo8aP2OhOO42x
         iYjQ==
X-Gm-Message-State: AOAM532zC17SObsR4HwktQEZ+RxuL+YFcq+WU/wtKkZzDZulvSAv1kBL
        YWPzHn1ExMCyDZiJGlPE0RZWj+OvXHjbZ4WyshvhX7qxjPmptDxSp1ZeQxCwR9xvu+2IpfjsKnU
        WCSefkOVnoSbEVk3FgRrSJ5Zr
X-Received: by 2002:ac8:501:: with SMTP id u1mr21438779qtg.261.1599488762420;
        Mon, 07 Sep 2020 07:26:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhGRYnA5hTdPLhq0TFkWqjOkagkQnP39SW4Ctvj8U0kr+dtoORI0W4y5NuudcQmcnN+v9EwA==
X-Received: by 2002:ac8:501:: with SMTP id u1mr21438763qtg.261.1599488762185;
        Mon, 07 Sep 2020 07:26:02 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k48sm12271020qtk.44.2020.09.07.07.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 07:26:01 -0700 (PDT)
Subject: Re: [PATCH] soundwire: stream: fix an invalid free
To:     Vinod Koul <vkoul@kernel.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        guennadi.liakhovetski@linux.intel.com,
        kai.vehmanen@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20200905192613.420-1-trix@redhat.com>
 <20200907141402.GC2639@vkoul-mobl>
From:   Tom Rix <trix@redhat.com>
Message-ID: <93b672ef-76c9-e87c-4526-897b0af01945@redhat.com>
Date:   Mon, 7 Sep 2020 07:25:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200907141402.GC2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/7/20 7:14 AM, Vinod Koul wrote:
> Hello Tom,
>
> On 05-09-20, 12:26, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analyzer reports this problem
>>
>> stream.c:872:2: warning: Argument to kfree() is a constant
>>   address (18446744073709551092), which is not memory
>>   allocated by malloc()
>>         kfree(stream);
>>         ^~~~~~~~~~~~~
>>
>> In sdw_shutdown_stream() the stream to free is set by
>> a call to snd_soc_dai_get_sdw_stream().  The problem block
>> is the check if the call was successful.
>>
>> 	if (!sdw_stream) {
>> 		dev_err(rtd->dev, "no stream found...
>> 		return;
>> 	}
>>
>> When snd_soc_dai_get_sdw_stream() fails, it does not
>> always return null, sometimes it returns -ENOTSUPP.
>>
>> So also check for error codes.
>> Fixes: 4550569bd779 ("soundwire: stream: add helper to startup/shutdown streams")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  drivers/soundwire/stream.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>> index 6e36deb505b1..950231d593c2 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -1913,7 +1913,7 @@ void sdw_shutdown_stream(void *sdw_substream)
>>  
>>  	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
>>  
>> -	if (!sdw_stream) {
>> +	if (IS_ERR_OR_NULL(sdw_stream)) {
> Thanks for the patch. Please see commit 3471d2a192ba ("soundwire:
> stream: fix NULL/IS_ERR confusion") in soundwire-next. This has already
> been updated to IS_ERR() and Bard has already sent patches for
> snd_soc_dai_get_sdw_stream() to return proper values.
>
> So I you can rerun this on next, you should see this fixed.

I am working on linux-next, so I will see Bard's patch when it lands there.

Sorry for not working on soundwire-next, but since i am fixing everywhere linux-next is easiest. 

Thank you for the update.

Tom

>

