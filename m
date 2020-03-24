Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39382C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114A920774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ac0mxzqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgCXOx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:53:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43695 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgCXOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:53:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id u12so9119875pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QVduhjXWCW00OJd/ZTpW4kWOwCgt6BaHgBSZwaL9YvA=;
        b=ac0mxzqnJvdjFusvzY2BcTccxLg8YyQ7c51h0qnsozG+IkL7o2DXPkmarhaV7Yup8b
         HKL2RWBDzs9HmfCFgoxwZOz7D3MUcIEv1NZi5G0JvQxw/3Gz5IS0l4fdaH4UEmWHPGHb
         og1Xaejyn/+UVhB4irSmT0vqPb8awJjwUUyCK+btX8LNEqmIcSG1bN7qvSlkZT0apWEF
         5DwTJQNYW3y2vh1iuscQVR2PoO8U/+eM360Bft4YNgKBJgt+gxtrDgFjra/2+PqMQDpg
         qcrRYNAwLVYYfFZLJtVca2CS20FiXvrjic9yLq7i04iiBwlDDVSXSsy1hrbCnJ7mFHPN
         1IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QVduhjXWCW00OJd/ZTpW4kWOwCgt6BaHgBSZwaL9YvA=;
        b=OLwcdXMLzWzcdijbc7hJY64goCYsf1GVqADsN3m4WC2NlO2UXX0sD9/WRJVO08Ex9i
         bR/qc+mSn2XL4CexsFzIAGAB/2dPdQ1Gl3vwuk0bjq8W8SeoHb46a4BjM8TI/zEQ2VuP
         tb49Z2iUNV4PT8uF1i5dxtCuy8hHUWt6KmVgCUQqOxhq/Vz27tk0T7wk27RI7I+OiFw3
         daW+83PP+W+tqmlnmSMpAHWpJpl/bzPeJIRS9INv4B4go5x/b2n9OYVmBEbCM6CEKaJA
         Gk1TqAA5hVaT1vxjlwmOpuczgIgNQZYHWWD3N+mZMuJdG/kLfwW0Qf0n9sq93rluupxQ
         g2Lw==
X-Gm-Message-State: ANhLgQ02TiX6TPvkxMB7r05uDlCezgQkTYsTkyCveTgdF1Lm3gty3u8w
        8FC1ybpZ0KOaPkXl09PkOg05dWWFrprRyA==
X-Google-Smtp-Source: ADFU+vtpua5I87p/4y8NFbZWT4Wgn5mB76vtJd0xqd+xckxhQ93AleIpG7Npipof2OjCFaYwvpCsIA==
X-Received: by 2002:a05:6a00:2cb:: with SMTP id b11mr415184pft.42.1585061633502;
        Tue, 24 Mar 2020 07:53:53 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id b25sm16218138pfd.185.2020.03.24.07.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 07:53:52 -0700 (PDT)
Subject: Re: locks use-after-free stable request
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <52be02d3-3a6a-c8b8-4177-5cc1d67aedd4@android.com>
 <20200324144338.GA2507446@kroah.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <29c96b7a-5964-5d89-304a-92673b68e8ef@android.com>
Date:   Tue, 24 Mar 2020 07:53:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324144338.GA2507446@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/20 7:43 AM, Greg KH wrote:
> On Tue, Mar 24, 2020 at 07:24:49AM -0700, Mark Salyzyn wrote:
>> Referencing upstream fixes commit dcf23ac3e846ca0cf626c155a0e3fcbbcf4fae8a
>> ("locks: reinstate locks_delete_block optimization") and commit
>> 6d390e4b5d48ec03bb87e63cf0a2bff5f4e116da ("locks: fix a potential
>> use-after-free problem when wakeup a waiter") and possibly address
>> CVE-2019-19769.
>>
>> Please apply to all relevant stable trees including 5.4, 4.19 and below.
>> Confirmed they apply cleanly to 5.4 and 4.19.
>>
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>>
>> Cc: stable@vger.kernel.org
>>
>> Cc: linux-kernel@vger.kernel.org
>>
>> Cc: kernel-team@android.com
>>
> These are all queued up for the next round of 5.4 and 5.5 stable
> releases,but they do not seem to apply to 4.19.
>
> And why do you think they apply to 4.19, that's not what 6d390e4b5d48
> ("locks: fix a potential use-after-free problem when wakeup a waiter")
> says.

When I used my tool to apply the pair by sha, I failed to notice that 
they were _both_ skipped because they are _both_ already present and 
read that as clean without looking at _what_ got applied or not.

(I will be fixing my tool)

> confused,

<sorry>

>
> greg k-h


