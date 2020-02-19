Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B0C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FE721D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="02bdATzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBSKn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:43:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40707 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgBSKn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:43:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so36887wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 02:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uu178h4Sn9VpLsAwrPceV0KSap9/ps5hFk6MJzLCOtU=;
        b=02bdATzxAmoFVgM99p2MGiOluR4xHHNS4c5NfrSi5BxO4RkYbZ3BBjd1lob/gTFE92
         nWHXI33K66qyD+N6M8F+E3140V4WAGc4yJzS9ZHjUEc6UlCzJbBvcs2R9HgVIFm8qxEc
         WaSoY4g4ZJ6vsivGbNfVQ1tMkz+VkFnfFspX0Z0B4vZvx9IYUJTVztOINVubutus35Qs
         09Ci8IJE0V/r5OFWfFLh9GjgKLL08p6UjQnc0OYtYEK1u8vsICytra8wXW+0FfK/utAh
         /YWf8djFy29yAMuz6eDs3EQfZVIRpoffMgSUzReLi4Qaswtnv6vCecBFIQHyIP3RfTK8
         CqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=uu178h4Sn9VpLsAwrPceV0KSap9/ps5hFk6MJzLCOtU=;
        b=P55iWJksDjIJFxgzmUDnuwmjSJ4jq/CHfJFjAlGzVpnpsy5/svPq6VmuLNQBkdFCYc
         bAxE6rD97V6AhBK5HEoRXsUxhZuDunfqT2rTxk30z9+MerL7CwpUXJE4Lampd1GimUU0
         AG4tu5AmqSIKqbvpbi7SygxDVTFFbHooKav/xOK0194gdHX17FaOOfFIt6mkocOid3q/
         uy/N/6aUz1TUcT8MYcCix6urVI+C5ZmaDkkjjl/BrDULfT3wiITR/P/SEnu0kpeC4t0b
         6jrI7AUvOhws01rKGMJGN1GD9+8I5NbHZeaIzbrh6eVU9HYQfr5GG3UZrhoO1jPvpd6y
         5qfw==
X-Gm-Message-State: APjAAAUiASkdFm34Uis+GzFzYiYEUHnucD16AAyn7Qqy0qrWUTSLXF3Y
        d2k4y9yJjQ1Ft8EMdPkDBacPerdMX9U=
X-Google-Smtp-Source: APXvYqyGKqyBbQFNU7n7BCFc+gH0YF3RVTIAFIrc3i0FwABXFz2+PyclndFMVuYMcYfqybMtUM4iXA==
X-Received: by 2002:a7b:cab1:: with SMTP id r17mr9217850wml.116.1582109034556;
        Wed, 19 Feb 2020 02:43:54 -0800 (PST)
Received: from [10.0.0.1] (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id h2sm2547507wrt.45.2020.02.19.02.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 02:43:53 -0800 (PST)
Subject: Re: [RFC] eventfd: add EFD_AUTORESET flag
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Davide Libenzi <davidel@xmailserver.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200129172010.162215-1-stefanha@redhat.com>
 <66566792-58a4-bf65-6723-7d2887c84160@redhat.com>
 <20200212102912.GA464050@stefanha-x1.localdomain>
 <156cb709-282a-ddb6-6f34-82b4bb211f73@redhat.com>
 <cadb4320-4717-1a41-dfb5-bb782fd0a5da@scylladb.com>
 <20200219103704.GA1076032@stefanha-x1.localdomain>
From:   Avi Kivity <avi@scylladb.com>
Organization: ScyllaDB
Message-ID: <c5ea733d-b766-041b-30b9-a9a9b5167462@scylladb.com>
Date:   Wed, 19 Feb 2020 12:43:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219103704.GA1076032@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/02/2020 12.37, Stefan Hajnoczi wrote:
> On Wed, Feb 12, 2020 at 12:54:30PM +0200, Avi Kivity wrote:
>> On 12/02/2020 12.47, Paolo Bonzini wrote:
>>> On 12/02/20 11:29, Stefan Hajnoczi wrote:
>>>> On Wed, Feb 12, 2020 at 09:31:32AM +0100, Paolo Bonzini wrote:
>>>>> On 29/01/20 18:20, Stefan Hajnoczi wrote:
>>>>>> +	/* Semaphore semantics don't make sense when autoreset is enabled */
>>>>>> +	if ((flags & EFD_SEMAPHORE) && (flags & EFD_AUTORESET))
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>> I think they do, you just want to subtract 1 instead of setting the
>>>>> count to 0.  This way, writing 1 would be the post operation on the
>>>>> semaphore, while poll() would be the wait operation.
>>>> True!  Then EFD_AUTORESET is not a fitting name.  EFD_AUTOREAD or
>>>> EFD_POLL_READS?
>>> Avi's suggestion also makes sense.  Switching the event loop from poll()
>>> to IORING_OP_POLL_ADD would be good on its own, and then you could make
>>> it use IORING_OP_READV for eventfds.
>>>
>>> In QEMU parlance, perhaps you need a different abstraction than
>>> EventNotifier (let's call it WakeupNotifier) which would also use
>>> eventfd but it would provide a smaller API.  Thanks to the smaller API,
>>> it would not need EFD_NONBLOCK, unlike the regular EventNotifier, and it
>>> could either set up a poll() handler calling read(), or use
>>> IORING_OP_READV when io_uring is in use.
>>>
>> Just to be clear, for best performance don't use IORING_OP_POLL_ADD, just
>> IORING_OP_READ. That's what you say in the second paragraph but the first
>> can be misleading.


Actually it turns out that current uring OP_READ throws the work into a 
workqueue. Jens is fixing that now.


> Thanks, that's a nice idea!  I already have experimental io_uring fd
> monitoring code written for QEMU and will extend it to use IORING_OP_READ.


Note linux-aio can do IOCB_CMD_POLL, starting with 4.19.


