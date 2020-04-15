Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CC2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9847020732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392856AbgDOCJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:09:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40080 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387800AbgDOCJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:09:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id x3so841094pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 19:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tr5twKza5uks5edzAznFN80I06R+2ta5GJDnpgzqtnU=;
        b=eGS2xXNzfwKkZ0IIB0lYx5LAVeva7sapWtUuETZI4OnVsAYzbqxqxq6NgZqMq9zYxH
         PvZYX4y30RSZYWuO2EaHXCKc+I2ZDsOX0sHYh9go7wcBM5LiZk5bGFR1QrxRQGQ85Os6
         bzJ6ZlBEpQqK3+eKvQYEhAOqDxDaFkQ1fkO8RkRXYImEt84cwP6R5x4ExUYYTV1AVYY3
         o7BtSJFgk4Jem2y2GU6EaIisgdy6dX3Knxyr27eg6nQTsRA2KBKzc1j0fu+g6aUmPRd3
         hiFwImdVFEApFp65uagTpH2iviRV1hxLnfY92Hz7JFQvBWfa3C2bdg5xQ690OPMRoKR7
         GM6g==
X-Gm-Message-State: AGi0PuZ7wRb6poJtiL8/MNSqVAiQzRvLEPrK1CX84vDT2ZSpnXxfMwCE
        NTtg6SSlSKr3Squ34dX0E8M=
X-Google-Smtp-Source: APiQypLs9wZRyBTkb80xPDKWPp4wiSuy+EGXasInkBTTJ7UcE/ElJr6zaZT/N4JajgGPrLI7fPwLGw==
X-Received: by 2002:a62:6385:: with SMTP id x127mr19524738pfb.276.1586916576584;
        Tue, 14 Apr 2020 19:09:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3d9e:6f43:1883:92f0? ([2601:647:4000:d7:3d9e:6f43:1883:92f0])
        by smtp.gmail.com with ESMTPSA id g22sm5282215pju.21.2020.04.14.19.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 19:09:35 -0700 (PDT)
Subject: Re: Compilation error for target liblockdep
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>,
        mingo <mingo@kernel.org>,
        "alexander.levin" <alexander.levin@microsoft.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
References: <tencent_221B7250536E082573770ABA@qq.com>
 <SN4PR0401MB359876ED2A2D503638658A679B1A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <2ec4aed8-a03a-aa1a-3e01-719f3c2b161d@acm.org>
 <SN4PR0401MB35983B3ACED57F66634CF90E9BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <825bc318-cde1-f80c-972c-436a4fef4ecf@acm.org>
Date:   Tue, 14 Apr 2020 19:09:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35983B3ACED57F66634CF90E9BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-14 06:08, Johannes Thumshirn wrote:
> These files aren't unit tests for lockdep, so they can't be converted to 
> KUnit. liblockdep is a stand alone library bringing lockdep's 
> functionallity to pthread via LDPRELOAD, see also:
> https://lwn.net/Articles/536363/

How big is the user base of liblockdep? How many alternatives exist for
liblockdep? Are these alternatives better or worse than liblockdep? See
also:
* https://clang.llvm.org/docs/ThreadSafetyAnalysis.html
* https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual
* http://valgrind.org/docs/manual/hg-manual.html

Bart.


