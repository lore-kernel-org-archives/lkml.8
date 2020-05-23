Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04EBC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3BE2070A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgEWSdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:33:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42426 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgEWSdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:33:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id 124so352809pgi.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cBFw/ySYPuYh7W7gWO72H2s2PdHaMcpBNHanIcU0gJA=;
        b=f59khgc9twkPF3qN1vH2IB1s8LNze+vlaQzHe9D8sPy6aSn7veczd0DG4m5sEEoUlo
         aGCRjpAkMXYf3/yIlpei2XT/oJNt6wWIectbLAOhA0Jbyy+/5uR4zxAOvPrPxkPqEYDe
         3iSufJczaekTghDNWJHS3KLXKZJqP983pLoEE9dSiig+Q8rzCfxFlV31MvAe0z6ZENy4
         YwUI49ZP5O5cFxB/+VtBHmSYjQAFp86N0zZN+xSPHWnnDiqOb3j9Ncg+87HiRelP2up5
         aqbHJoak2P9V7hZ9E4r7Jp6QQ0EyMTfS9b92dP/kDLkb28tZue+vVjtGBtt3k1Mi0BDf
         dN9w==
X-Gm-Message-State: AOAM533+HE0coms6r67YLGnQ2I0b5eNHrnrMCI5jVy5tl/i0YMCsMYMz
        WkN8pI2s/ChMpQNd38a84KI=
X-Google-Smtp-Source: ABdhPJzaDT9FgdyXPht3W6HFL4139O9L7TVeP5Pm+4VYw73/HxWrIBVx7dWKr7M9xdv1Usqhv/QZPw==
X-Received: by 2002:a63:f854:: with SMTP id v20mr1591311pgj.0.1590258797973;
        Sat, 23 May 2020 11:33:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:89ea:f77d:d990:dc8c? ([2601:647:4000:d7:89ea:f77d:d990:dc8c])
        by smtp.gmail.com with ESMTPSA id m14sm8584739pgn.83.2020.05.23.11.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 11:33:17 -0700 (PDT)
Subject: Re: [PATCH] linux/blkdev.h: Use ilog2() directly in blksize_bits()
To:     Kaitao Cheng <pilgrimtao@gmail.com>, axboe@kernel.dk
Cc:     damien.lemoal@wdc.com, ming.lei@redhat.com,
        martin.petersen@oracle.com, satyat@google.com,
        chaitanya.kulkarni@wdc.com, houtao1@huawei.com,
        asml.silence@gmail.com, ajay.joshi@wdc.com,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20200523155048.29369-1-pilgrimtao@gmail.com>
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
Message-ID: <714861ac-50aa-465c-c28f-dce7e16d0313@acm.org>
Date:   Sat, 23 May 2020 11:33:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523155048.29369-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-23 08:50, Kaitao Cheng wrote:
> blksize_bits() can be achieved through ilog2(), and ilog2() is
> more efficient.

If Jens agrees, how about removing the blksize_bits() function entirely
and to make all callers use ilog2() instead of blksize_bits()?

Thanks,

Bart.
