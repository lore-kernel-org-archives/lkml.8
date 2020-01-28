Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4408C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A52B2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ENuHELy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgA1UEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:04:35 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:41806 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgA1UEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 15:04:34 -0500
Received: by mail-io1-f41.google.com with SMTP id m25so15855933ioo.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 12:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vddfp0PbrX4PW/A1Mqvi8srsFEuPF2XDyAWEjCxTh2k=;
        b=ENuHELy6ViQg2MjTLKxdy0jThc5QeNPOoQwP2tBdY3c8F+q0eW/F5V9HJfkBakNaNV
         jfwg0YNw2vbuMPiRbyTF/CR83vOeD5yfKlN6CdvYftx8JiDXroK4gv6f0RaOhh/o0J9f
         NZDWqlFa35PBXD92DJjQft6c5JE3RFRMemo+/jytTS/UxR2pHwx5tnu1EIAi13V9O5Z3
         ORIvo7ulwoXkEz7yF/XaWlnNEhtegl328UNxRhlXZV5nzL2dL3VtJ/QhTL/bfhC6Ljxu
         0TdCW0jpqdVXEz+/Ri4OVH5yPzrp8BZvk0Sn2l5hKRyisIzNL4iPje4h8l++R31sPC20
         wZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vddfp0PbrX4PW/A1Mqvi8srsFEuPF2XDyAWEjCxTh2k=;
        b=EO+KM7OURsm8HEI3lo2M/xCS2IKzRbB07Xd6TVwJvpkzXkKjVjsFlV1vYDO6GhUvki
         rdxFfb0PNBPNujs9BA0ML2ZFCoeQxa5/tdSveJaKgIhw52v6InwyvPFWZSAgjazk5kgj
         nbwEarvdzWrtyD0gdliV814KKYulFR3IcBasQMuUJC58QUYu+PdYD4NZsuMhUIyyGzVr
         Xq0RWV9pWDavLmwmuvHXjV7zOoXXgqIBvRY92MC7co13yV9bONsn07ju8K3A3Bm1mnI6
         qxks+e9cFl1KhFVG2Jdc/IiXBFDu3Y8rpIr56ca7CQc/Fc2uSti5RQ7jd1fxj7g2J7kW
         a7RQ==
X-Gm-Message-State: APjAAAVg92OyD9HUEgZXbmFaLlU9bbvJtieWtXlcgQFbpsOa5KxAFefp
        nUxhW6DOP8dGf1O/v8Uv2fZvqBn/yk0=
X-Google-Smtp-Source: APXvYqz5ciwG0gPyaQUDltVRK9IVglCDUBy3Jpl37nxADs0sUa5PFtrNozVFJXq8o9Vp8JT2qGuRfw==
X-Received: by 2002:a02:cc59:: with SMTP id i25mr13905690jaq.78.1580241873734;
        Tue, 28 Jan 2020 12:04:33 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e23sm2035213ild.37.2020.01.28.12.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 12:04:33 -0800 (PST)
Subject: Re: [GIT PULL] io_uring changes for 5.6-rc
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <edc14d52-b3d7-9860-097a-357164150e85@kernel.dk>
Message-ID: <884006c1-facc-0b9c-597a-61f3f6bd85db@kernel.dk>
Date:   Tue, 28 Jan 2020 13:04:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <edc14d52-b3d7-9860-097a-357164150e85@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/20 12:59 PM, Jens Axboe wrote:
> Hi Linus,
> 
> Here are the io_uring changes for 5.6. Note that this is sitting on top
> of Al's work.openat2 branch, and was rebased about a week ago as Al
> rebased that. So consider this a pre-pull request, ready to go as soon
> as you've pulled the work.openat2 stuff from Al.

We changed the sibling ring support somewhat, so I pruned this tag. I'll
re-send this pull request in a few days.

-- 
Jens Axboe

