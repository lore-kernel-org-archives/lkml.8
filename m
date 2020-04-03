Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59327C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305FE20737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="rDaFXJ97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390665AbgDCK3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:29:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54637 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390633AbgDCK3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:29:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id c81so6618701wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 03:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qDDpKbX/Hxwly8HQ4p/vXSXmAl1qLd9RXGXIMyMKlB0=;
        b=rDaFXJ97iS7SKZcftRg6IP7wNZbU81ndPSFY5cBjR3nhWtaef0+a451Gi5EUPv5h9C
         6L6x7WqqizbPjYKic8GTQLIlky1FtGs2xOpRisKa7dW4bbrRbxOyxd9bybZWjkkf2Jwv
         ab8AhdJ4y8XXfn91stzUtMre+bwSECP0jUJjtpBF+oQXMFkzlSocd8FDDer21HsGNn/r
         dm4uJJJ2DpRfr+NRZ/2/K768EhU3WV1DTUHARN/XZUTWDEzaJSdyPx76DG7I/4Y+Qiqy
         IIcqHHQBkmmCw29oxjzQd20NsbvZmQZbNQ4R+12E3bC/oMs2UVBIRqLWLQ/Qg20j+VJY
         lgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qDDpKbX/Hxwly8HQ4p/vXSXmAl1qLd9RXGXIMyMKlB0=;
        b=DxIQi3mdGlvBWz9LrwjhK2n2Itu7DwfSJS6eZ461MoOC31UMr8+XgY6mjek3mdPzDI
         52tuNytHS14XptX8KGUSvaBbgt8DrMkYxHmcdXSz5HitVqNaZrfB0q/a+M7VE2Uiyh/v
         WmktA3eiVVUCDz9rGVt1Nk9rvfzaANI6G9qIp/9JtdWZVw+I4JPQvIxFLz6MqfmwHYFJ
         QLOz+UhcFNl5t+9FLwxuXm+8rp/3mbMlReaI8I8UdSktzRYVAy2zAcOC9epr5W+9C2tU
         KFUC18HuLVQkuIaDZ13ErCs90DFHTe804XAOT1PeLkiFlqKJTuYj2zMSs8iKwipMfvnx
         QQ/Q==
X-Gm-Message-State: AGi0PuZtPxO9KCleXaETge1FOzFnkbEkIUZuCIKGufVUCLehX3pHw1UT
        FNOrDOG2eHXukVi7+ULkJ8aEzzBF0lUAZQ==
X-Google-Smtp-Source: APiQypKUIx/BqyMhU3xK/1yn5HaMBf0wTS8vKdIUd0gda4oqFr5twfQ1HHvwuWA8NCyIeo6IfgHe1w==
X-Received: by 2002:a1c:9a87:: with SMTP id c129mr7585709wme.149.1585909768966;
        Fri, 03 Apr 2020 03:29:28 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([79.132.236.184])
        by smtp.gmail.com with ESMTPSA id o16sm11640075wrw.75.2020.04.03.03.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 03:29:28 -0700 (PDT)
Subject: Re: [PATCH] mptcp: move pr_fmt defining to protocol.h
To:     Geliang Tang <geliangtang@gmail.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, mptcp@lists.01.org,
        linux-kernel@vger.kernel.org
References: <34c83a5fe561739c7b85a3c4959eb44c3155d075.1585899578.git.geliangtang@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <9674b6ce-3888-557e-8f32-230671363903@tessares.net>
Date:   Fri, 3 Apr 2020 12:29:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <34c83a5fe561739c7b85a3c4959eb44c3155d075.1585899578.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geliang,

On 03/04/2020 09:57, Geliang Tang wrote:
> Some of the mptcp logs didn't print out the format string "MPTCP":
> 
> [  129.185774] DSS
> [  129.185774] data_fin=0 dsn64=1 use_map=1 ack64=1 use_ack=1
> [  129.185774] data_ack=5481534886531492085
> [  129.185775] data_seq=15725204003114694615 subflow_seq=1425409 data_len=5216
> [  129.185776] subflow=0000000093526a92 fully established=1 seq=0:0 remaining=28
> [  129.185776] MPTCP: msk=00000000d5a704a6 ssk=00000000b5aabc31 data_avail=0 skb=0000000088f05424
> [  129.185777] MPTCP: seq=15725204003114694615 is64=1 ssn=1425409 data_len=5216 data_fin=0
> [  129.185777] MPTCP: msk=00000000d5a704a6 ssk=00000000b5aabc31 status=0
> [  129.185778] MPTCP: msk ack_seq=da3b25b9a233c2c7 subflow ack_seq=da3b25b9a233c2c7
> [  129.185778] MPTCP: msk=00000000d5a704a6 ssk=00000000b5aabc31 data_avail=1 skb=000000000caed2cc
> [  129.185779] subflow=0000000093526a92 fully established=1 seq=0:0 remaining=28
> 
> So this patch moves the pr_fmt defining from protocol.c to protocol.h, which
> is included by all the C files. Then we can get the same format string
> "MPTCP" in all mptcp logs like this:
> 
> [  141.854787] MPTCP: DSS
> [  141.854788] MPTCP: data_fin=0 dsn64=1 use_map=1 ack64=1 use_ack=1
> [  141.854788] MPTCP: data_ack=18028325517710311871
> [  141.854788] MPTCP: data_seq=6163976859259356786 subflow_seq=3309569 data_len=8192
> [  141.854789] MPTCP: msk=000000005847a66a ssk=0000000022469903 data_avail=0 skb=00000000dd95efc3
> [  141.854789] MPTCP: seq=6163976859259356786 is64=1 ssn=3309569 data_len=8192 data_fin=0
> [  141.854790] MPTCP: msk=000000005847a66a ssk=0000000022469903 status=0
> [  141.854790] MPTCP: msk ack_seq=558ad84b9be1d162 subflow ack_seq=558ad84b9be1d162
> [  141.854791] MPTCP: msk=000000005847a66a ssk=0000000022469903 data_avail=1 skb=000000000b8926f6
> [  141.854791] MPTCP: subflow=00000000e4e4579c fully established=1 seq=0:0 remaining=28
> [  141.854792] MPTCP: subflow=00000000e4e4579c fully established=1 seq=0:dcdf2f3b remaining=28

Good idea to uniform that.
I think it can be useful for MPTCP devs to add a different prefix in 
each MPTCP .c files but this small improvement can be done later.

LGTM, thanks Geliang!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
