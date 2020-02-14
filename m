Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ACAC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED313217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgBNF5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:57:47 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54544 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgBNF5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:57:46 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so3398599pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 21:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zFkudLdUe1aXz1L7vZPBh9QlF9AR7Hj9OMsuNmAOQWY=;
        b=BWmCUd87QR6hXipLSHBpmo75x/ZHmCCC2mHE+D7b7xy42qS5NgjjuXMn+I8M6bxZx8
         ZwBzFlxnUuK3gKxQNDGVai8dodOEvyZFAInqZ8Tt34eM3wqHRcE2FMLa48QHr6G11hbP
         AXzbu6bva4RjfaNdh09nw8NfxddilngZAhTpldtDXm7KEwxE09qKKBHl0QS2/nEIgWEZ
         e4j19v8yYhsVJxxmL1ZDe5CvGmZ6I8tkoMw5fc6q+B0EONaijqlvq+knKVk69gP5rsHu
         NnAgXQyNixrtPp2pFfomD2u7iJIkCG8YFGGe5u4N/Uc+CT4nvEmrQhlMUx8aPyAhyGdW
         BylQ==
X-Gm-Message-State: APjAAAUt/x4gDsupMFOBdyVuNO6MZm14UTrHoP8p//+7m7omePji9xFa
        5ODBNSUSgPPD7fpy1KmpMZM=
X-Google-Smtp-Source: APXvYqz7KKAf/wv76op6l3yUaGfQvSHbPmHf45gDsKn80M1ExdgdCdonMtNusKPBJvGPJNmz/J5vNg==
X-Received: by 2002:a17:902:124:: with SMTP id 33mr1756051plb.128.1581659865923;
        Thu, 13 Feb 2020 21:57:45 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:c4a9:d5d0:62d2:6a5d? ([2601:647:4000:d7:c4a9:d5d0:62d2:6a5d])
        by smtp.gmail.com with ESMTPSA id p23sm5565653pgn.92.2020.02.13.21.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 21:57:44 -0800 (PST)
Subject: Re: Compilation error for target liblockdep
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>,
        mingo <mingo@kernel.org>,
        "alexander.levin" <alexander.levin@microsoft.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
References: <tencent_221B7250536E082573770ABA@qq.com>
 <SN4PR0401MB359876ED2A2D503638658A679B1A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
Message-ID: <2ec4aed8-a03a-aa1a-3e01-719f3c2b161d@acm.org>
Date:   Thu, 13 Feb 2020 21:57:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB359876ED2A2D503638658A679B1A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-13 04:59, Johannes Thumshirn wrote:
> On 18/11/2019 10:20, Zhengyuan Liu wrote:
>> Hi, guys,
>>
>> I got a compilation error while building target liblockdep and I think I'd
>> better report it to you. The error info showed as bellow:
>>
>>          # cd SRC/tools
>>          # make liblockdep
>>            DESCEND  lib/lockdep
>>            CC       lockdep.o
>>          In file included from lockdep.c:33:0:
>>          ../../../kernel/locking/lockdep.c:53:28: fatal error: linux/rcupdate.h: No such file or directory
>>          compilation terminated.
>>          mv: cannot stat './.lockdep.o.tmp': No such file or directory
>>          /home/lzy/kernel-upstream/linux-linus-ubuntu/tools/build/Makefile.build:96: recipe for target 'lockdep.o' failed
>>          make[2]: *** [lockdep.o] Error 1
>>          Makefile:121: recipe for target 'liblockdep-in.o' failed
>>          make[1]: *** [liblockdep-in.o] Error 2
>>          Makefile:68: recipe for target 'liblockdep' failed
>>          make: *** [liblockdep] Error 2
>>
>> BTW, It was introduced by commit a0b0fd53e1e ("locking/lockdep: Free lock classes that are no longer in use").
> 
> This error still pops up here on current master
> HEAD: 0bf999f9c5e74c7ecf9dafb527146601e5c848b9

I'm not sure it's worth fixing the tests under tools/lib/lockdep since
keeping these tests working requires modifying the headers under
tools/lib/lockdep/include/ every time the kernel headers under include/
are changed. How about removing tools/lib/lockdep entirely and
converting these lockdep tests to the KUnit framework? KUnit is based on
UML and I think that's a much more robust approach. For more information
about KUnit, see also https://lwn.net/Articles/780985/.

Thanks,

Bart.


