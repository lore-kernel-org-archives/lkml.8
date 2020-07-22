Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001EEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D201D20771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFI/F6on"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbgGVULD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:11:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59227 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgGVULD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595448661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+z8Sjy8ZptOYQPBj+H820e2EKukutEsqDOT5iiJ3PDM=;
        b=YFI/F6onfTPy859uWiW4y+mYExQ6TcfQmCBeorkF4J6L6xqj70gQxQGv9n0DtlZVxTSuHp
        r1auikkcfi1FnatLezCbA2zDZZ299eGayp3hbuqTloxS11NQeqLJLFpsiWX5cfHMR75R8z
        +gaY6Ol1gx640keM/pPKpat4KZnG8C0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-DATXNlbRMde62i8CrBzfFA-1; Wed, 22 Jul 2020 16:11:00 -0400
X-MC-Unique: DATXNlbRMde62i8CrBzfFA-1
Received: by mail-qk1-f199.google.com with SMTP id h4so2202968qkl.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+z8Sjy8ZptOYQPBj+H820e2EKukutEsqDOT5iiJ3PDM=;
        b=FE3usbBMpGDn0huTpwgRj+/+zNqj5OnMlVfHFbF+7+kBV2SglfSFxSngO7lh8VeZQW
         GYVulmYP6NPXqqWzAKaqggfJim8Bw6ELP73VYE9e1p+lzDrz5j7+uNwEzio8DQWxUXQD
         IATSO1pXgL06fB9sMVuVt4jVXD7EO7o5B0kV1ymOtXKYRiUJk82tVpvRBaPhqCS8/j76
         oH8nKEKnNcZm6rfQD/+VNlgL/80ER35Xx+h4R1PX2Ly2bZDnFUTw5PDTXLK5A/yJ7p9O
         6iwC+I8jvFiSPQO0gUpV4nNYSmgnrqBrAyXRMi5D2YO166svmDePqFxan4QlYAAH1CpF
         nXiA==
X-Gm-Message-State: AOAM5301ECUu6ntGbDmjw9OKL0HrmupWuGJrOE+Wls4BECTnv/0C9ZuI
        YSNuTiZEFLfNVbm7rtCTSCWF2UoMgtaGj56d7Dn/9cIAh5fleGSjNTaOA3UneaJqYlsgrRorVW1
        OfQBUQqm3fH59SVvytmpoW0iR
X-Received: by 2002:a05:620a:230:: with SMTP id u16mr1636733qkm.387.1595448659274;
        Wed, 22 Jul 2020 13:10:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh0P/cdl6d05hqmcebLmXrq3sWiqikrcPUldQ6BQFsWF/cpmfObT/Kf16aCA1SldNDaH+SmQ==
X-Received: by 2002:a05:620a:230:: with SMTP id u16mr1636711qkm.387.1595448659017;
        Wed, 22 Jul 2020 13:10:59 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o2sm743539qkh.102.2020.07.22.13.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 13:10:58 -0700 (PDT)
Subject: Re: [PATCH v2] KEYS: remove redundant memset
To:     Joe Perches <joe@perches.com>, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, jmorris@namei.org,
        serge@hallyn.com, denkenz@gmail.com, marcel@holtmann.org
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200722134610.31947-1-trix@redhat.com>
 <2bdd6b8ec731d180023d593b679afc66def19b4f.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e36c364e-22f4-c520-04da-ca1196fec049@redhat.com>
Date:   Wed, 22 Jul 2020 13:10:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2bdd6b8ec731d180023d593b679afc66def19b4f.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/22/20 1:02 PM, Joe Perches wrote:
> On Wed, 2020-07-22 at 06:46 -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Reviewing use of memset in keyctrl_pkey.c
>>
>> keyctl_pkey_params_get prologue code to set params up
>>
>> 	memset(params, 0, sizeof(*params));
>> 	params->encoding = "raw";
>>
>> keyctl_pkey_query has the same prologue
>> and calls keyctl_pkey_params_get.
>>
>> So remove the prologue.
>>
>> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> At best, this is a micro optimization.
Yes
> How is this appropriate for a Fixes: line?
Removing unneeded code is not a fix?
>
>> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> []
>> @@ -166,8 +166,6 @@ long keyctl_pkey_query(key_serial_t id,
>>  	struct kernel_pkey_query res;
>>  	long ret;
>>  
>> -	memset(&params, 0, sizeof(params));
>> -
>>  	ret = keyctl_pkey_params_get(id, _info, &params);
>>  	if (ret < 0)
>>  		goto error;

