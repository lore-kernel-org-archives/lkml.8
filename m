Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834A6C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BF024684
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="CwZ1wF/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgA0Uej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:34:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43094 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgA0Uej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:34:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so13205546wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 12:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DPa0PjKTZtNUp0zt2H3olFTtXXWAHB5OFSk99SyqalU=;
        b=CwZ1wF/kNjTbPxARQgUyyuvCrxwVKw1FRPcPOGsITxxMGHRcMx/pfUGKW/B78AIdkM
         x6pDc+McoBi1xYs4Gqx8CZ5QHTj9vfNI4L3Lf/ezuR2iXaJcZqHhYTIJ0pH7Eg1XFPue
         N/m3P2t2f1cxC5aeou66WWRNnXbtjcIFMBw6hDUZ1124P+QzrFZt6oEEsbD/qT/vlrGQ
         JdyURIXx0U38BX7xUprWwAxDKYDlAYDodwl61HN1fl8F6sj7gmx0KQdVuD2qHqBpkK1N
         eRKqPhyDhw7E1NOlj5i2zdKhia5DfmZhU8+l8/4q0jUjY3fC4w1yXWNs1kMymxFLb0oY
         mLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DPa0PjKTZtNUp0zt2H3olFTtXXWAHB5OFSk99SyqalU=;
        b=RfPar/zUrMibB88zyZkhSbShOV7Zw8xzVTcly/8beq5Uvkbo3UQy5pmDgXYcM6848F
         7TUQxLvg8DacD6/OmM9f6w3RmFH8MK/DpfdCZGVV27Ou6Hv5l83OqnAnpwto7ZaUYIB/
         av3v0D1y/l6oJ84MpuGYA+CjhSlOrJbIQgbrLFU+4PQpLWMQdm+fmiEkPtKVjvk89d1v
         DzkPQ8vl9Arku7G3lnHJnvQJvebTTvmM9oxvpHclR6kntqLCetTNHHNTaVstBLBr2D2u
         /fYJ9bm2N1qqPp/wy8iQedN0dHA3l9LXZbcjMyXZvkvUKF8RrHA88rtqQAp/TeZdkB95
         tvRA==
X-Gm-Message-State: APjAAAX5zjK8g/ZdQ0TlJ/biPYAS3wPUlQ6WG+6HbYVc8+Fmc3/WfoXA
        UAXhhKySBqMi57clh1NZbzxlww==
X-Google-Smtp-Source: APXvYqzrQJt7qCQBkTdZWFibEn09J1oSTcAz90o21elCX0FYPMZm0ixzwULecEwJi/gjllScGCx2HA==
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr23503394wrs.113.1580157276790;
        Mon, 27 Jan 2020 12:34:36 -0800 (PST)
Received: from tsr-lap-08.nix.tessares.net (19.234-201-80.adsl-dyn.isp.belgacom.be. [80.201.234.19])
        by smtp.gmail.com with ESMTPSA id o4sm22107974wrw.97.2020.01.27.12.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 12:34:35 -0800 (PST)
Subject: Re: [PATCH] selftests: settings: tests can be in subsubdirs
To:     shuah <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, mptcp <mptcp@lists.01.org>
References: <20191022171223.27934-1-matthieu.baerts@tessares.net>
 <c9ce5016-9e83-67c0-ae22-2d3c46427b25@tessares.net>
 <201911211018.D6CD68AC5@keescook>
 <602ab319-dcb9-4ac7-b2b8-f7b6072ddc03@tessares.net>
 <bcce12e4-f122-10ae-dbc7-cc199d9716b6@kernel.org>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <9bb525e5-12a1-9e27-81cd-cf7bc3d5dc2d@tessares.net>
Date:   Mon, 27 Jan 2020 21:34:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bcce12e4-f122-10ae-dbc7-cc199d9716b6@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On 27/01/2020 18:16, shuah wrote:
> On 1/27/20 9:05 AM, Matthieu Baerts wrote:

[...]

>> Kees, Thank you for this review!
>>
>> Shuah, I am sorry to send you this new request. It is just to inform 
>> you that the first selftests for MPTCP are now in "net-next" repo, 
>> ready for the future Linux 5.6.
>> We would then be very happy to see this patch here below for the 
>> kselftest framework accepted to avoid timeouts. Locally we apply this 
>> patch before running the selftests but we cannot ask everybody running 
>> MPTCP' selftests to do the same :)
>>
>>
> 
> I am sorry for the delay. My bad. Looks like I just missed it. I will
> make sure it gets into 5.6-rc1

That's alright, thank you for having applied this patch in your "next" 
branch!

Cheers,
Matt
-- 
Matthieu Baerts | R&D Engineer
matthieu.baerts@tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
