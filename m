Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFDAC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF72C206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb4u650/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgICOl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:41:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59448 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728918AbgICOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599144094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dlXSpmpAiY7YS5kYtaeWA3wo80DV7Gum6Jwj3vtpgjg=;
        b=Tb4u650/EhrjifM8zHaSmMqai3pNgctiuE+sArtWYkPv0tXJjq8Q+5tYaNpfgFkYkhi9av
        Mz2zf0Uva5qADVd4ap88wtfgYy1GKeLvNccz2lrVxOwXsYzEVeBdvBEOVP9LPucO9UrFV8
        q0UNh5Ab8R55tjnoHjXDYJNC3mcQeIY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-uT69CP2lMYKvBuRTGEBTJw-1; Thu, 03 Sep 2020 10:41:31 -0400
X-MC-Unique: uT69CP2lMYKvBuRTGEBTJw-1
Received: by mail-io1-f70.google.com with SMTP id j4so2169786iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 07:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dlXSpmpAiY7YS5kYtaeWA3wo80DV7Gum6Jwj3vtpgjg=;
        b=SwpJYeHdZ9o9RdPhiRIPLMbCK/3LbcCKZ1J/pSrEZ4VRcUggWYPyeArZNRIipkJa2q
         lJYqPF6UlD/zEdpDRInUJzNyeX5w7qsPPdWAlujV+i4UFDejFxR8bfJFz2N/VjuFVIh6
         YLDjB4WKwZgp1TgqegfuyeESbVPFWqucmE2faPfovDjp/X9Aa54WApVz27Ymq6rLzH9X
         2YtAbHLqu1x/M9vBV+SYL/av7zZBPcr0+UoN5FnMQZKt6lrs5DzXR03t7fIrMBEyXi8F
         K1VpaYfXmF8rGrZiwsKT5koddfHt+8zVO3Gvet+PKg4ysUaCKFmHO2MwypQaLhE27kO4
         oMZQ==
X-Gm-Message-State: AOAM530qz/N7p2voBbujHhVZeg29OfPlxA8H5deMr2vCYYdSJjnU4vr+
        bbbsbhnO2STn/O5mcFQCn9SooVnaZlSDkeCN8L99rVPOlpcurivEXCZZdE1WLfYGbmx/ye2iEjj
        5VS2maQNCuR/VkOu4oy2RZtN6
X-Received: by 2002:a92:c78e:: with SMTP id c14mr3385275ilk.3.1599144090427;
        Thu, 03 Sep 2020 07:41:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCAl5Mf+O6dLNF91Wu0iMCa8KPqD4EBuQd+O1BKyeEB3KAYW3jsrXGYwXNu2cuFkUA/BFcLw==
X-Received: by 2002:a92:c78e:: with SMTP id c14mr3385251ilk.3.1599144090118;
        Thu, 03 Sep 2020 07:41:30 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s16sm1403323iow.47.2020.09.03.07.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 07:41:29 -0700 (PDT)
Subject: Re: [PATCH] media: dvb-frontends/cxd2099: report errors
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     jasmin@anw.at, o.endriss@gmx.de, rjkm@metzlerbros.de,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200722134126.31191-1-trix@redhat.com>
 <20200903161328.62378992@coco.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b274b6b1-e2ac-2b68-9fb8-502255ca6982@redhat.com>
Date:   Thu, 3 Sep 2020 07:41:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200903161328.62378992@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/3/20 7:13 AM, Mauro Carvalho Chehab wrote:
> Em Wed, 22 Jul 2020 06:41:26 -0700
> trix@redhat.com escreveu:
>
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this error
>>
>> drivers/media/dvb-frontends/cxd2099.c:420:2: warning: Undefined
>>   or garbage value returned to caller
>>         return val;
>>         ^~~~~~~~~~
>>
>> In read_cam_control, the call to read_io can fail.
>> When it fails val is not set.
>>
>> The failure status should be returned to the caller,
>> not the unset val.
>>
>> Similar problem with read_attribute_mem
>>
>> Fixes: 0f0b270f905b ("[media] ngene: CXD2099AR Common Interface driver")
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  drivers/media/dvb-frontends/cxd2099.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/dvb-frontends/cxd2099.c b/drivers/media/dvb-frontends/cxd2099.c
>> index f88b5355493e..9dfaf18fc4b4 100644
>> --- a/drivers/media/dvb-frontends/cxd2099.c
>> +++ b/drivers/media/dvb-frontends/cxd2099.c
>> @@ -387,12 +387,15 @@ static int read_attribute_mem(struct dvb_ca_en50221 *ca,
>>  {
>>  	struct cxd *ci = ca->data;
>>  	u8 val;
>> +	int ret;
>>  
>>  	mutex_lock(&ci->lock);
>>  	set_mode(ci, 1);
>> -	read_pccard(ci, address, &val, 1);
>> +	ret = read_pccard(ci, address, &val, 1);
>> +	if (!ret)
>> +		ret = val;
>>  	mutex_unlock(&ci->lock);
>> -	return val;
>> +	return ret;
>>  }
>>  
>>  static int write_attribute_mem(struct dvb_ca_en50221 *ca, int slot,
>> @@ -412,12 +415,15 @@ static int read_cam_control(struct dvb_ca_en50221 *ca,
>>  {
>>  	struct cxd *ci = ca->data;
>>  	unsigned int val;
>> +	int ret;
>>  
>>  	mutex_lock(&ci->lock);
>>  	set_mode(ci, 0);
>> -	read_io(ci, address, &val);
>> +	ret = read_io(ci, address, &val);
>> +	if (!ret)
>> +		ret = val;
>>  	mutex_unlock(&ci->lock);
>> -	return val;
>> +	return ret;
>>  }
>>  
>>  static int write_cam_control(struct dvb_ca_en50221 *ca, int slot,
> Hmm... Had you test this one on a real hardware? It is not
> uncommon to have some DVB devices that would fail reading
> when the firmware is on cold state.
>
> Without testing a patch like that at a real hardware, there's
> no way to know if this is intentional or if the original
> developer forgot to add a check for the error.

No, I do not have hw.  I understand your concerns, it is ok if you want to drop this patch, else i'll beef up the warnings.

Tom

>
> So, at most, it could print some warning message for
> non-zero return codes.
>
>
> Thanks,
> Mauro
>

