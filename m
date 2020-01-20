Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F245C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 02:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4AA206ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 02:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SjjfKJ+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgATC5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 21:57:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35613 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgATC5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 21:57:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so12542896plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 18:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lL6iVMmM5FZ4RvYRtuuFami6NaDQhGQQ9qR5Ay6sAFs=;
        b=SjjfKJ+FDmOJ+uTtb4EnvhQr7orxOzRbOi9ecJ/NQ78M3AeHtn+4wkeyl4CdcTHDst
         Eh0q8VmkA/Yqft9zNnawSA9cLpPC6v6cwPHl1BchbsrNyVdsKB9gr6oJ6dI1l8yhhAAa
         xwauWK3WBYb+5MZYrNr1HfILtD4Bs2x4h+838rKtpkPlRfRY+cy5PBm4G0YUZcBPqYOB
         /yCAA5FnceANrO0J5oRTcQiT3QaMWOhZO/75L91KXTmyUE+/kk6txj2mBGEMuzolSnPQ
         trqbGP9MCVKFxZEF5iNMSf94KkwBE+lGMkot2sEa9B2xVQIxKpH0D5FU/V1m3ILap/TI
         9/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lL6iVMmM5FZ4RvYRtuuFami6NaDQhGQQ9qR5Ay6sAFs=;
        b=BQmW6nGrByDKcIAXR6/J4HDWc5kqD/Vku7PhV5zwCbaw03cb4SsmKeTdlZ27Qie/Z9
         DaOyzWQmnbfGqApOFuwg7o8JdYk49CV2j2St4COYG44dIQDHaeyr97deoHj/Xp9OFk6Q
         /ubEhrrV8jc2lsH3OIp7JWSQC/3J8zefiWISQYPYa5oeI35MSreX8v2NAo4I0dq2IkAy
         cQQgWEXVPtvOWNZHOD8FEiIwxJU3dR80hJflwU4fUwS8E3sps1e3g8e9aPcVomE8d/3k
         GU1AbHIOeRWg6+wVZ+Y+hvxQqGXu4Jx6W4wPWW7KI9xmEA3grxhCiz0t9gkOsQptvs/d
         I0OQ==
X-Gm-Message-State: APjAAAXZbZ0jRyrUZvQOA74+UC4HEPG8vkfB+Z1mvhSkMQVjB6eah7/j
        DhVK0V+dXu/sacdxEI5zSNSDH3NWnXA=
X-Google-Smtp-Source: APXvYqyb9jl2Kpipboz2mtxHgmWbjzquRNedlGqEpzfQA/Q0QXm2Z8/kbOOtoJQ7EsgEolYE/aw60w==
X-Received: by 2002:a17:90a:d143:: with SMTP id t3mr20741568pjw.106.1579489040694;
        Sun, 19 Jan 2020 18:57:20 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z16sm37959284pff.125.2020.01.19.18.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2020 18:57:20 -0800 (PST)
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
From:   Jens Axboe <axboe@kernel.dk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
References: <20191220123614.5f11d2e3@canb.auug.org.au>
 <f6ff3aa5-e08b-8b25-454a-9aa51b8b5c37@kernel.dk>
 <20200120124051.2fdcfc61@canb.auug.org.au>
 <e0af609c-aa1b-5a8b-89d4-ea6aff779c67@kernel.dk>
Message-ID: <c37a907f-03d0-2789-7b8d-fc4e496de530@kernel.dk>
Date:   Sun, 19 Jan 2020 19:57:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e0af609c-aa1b-5a8b-89d4-ea6aff779c67@kernel.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/20 7:45 PM, Jens Axboe wrote:
> On 1/19/20 6:40 PM, Stephen Rothwell wrote:
>> Hi Jens,
>>
>> On Thu, 19 Dec 2019 22:34:59 -0700 Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 12/19/19 6:36 PM, Stephen Rothwell wrote:
>>>>
>>>> Today's linux-next merge of the block tree got a conflict in:
>>>>
>>>>   fs/open.c
>>>>
>>>> between commit:
>>>>
>>>>   0a51692d49ec ("open: introduce openat2(2) syscall")
>>>>
>>>> from the vfs tree and commit:
>>>>
>>>>   252270311374 ("fs: make build_open_flags() available internally")
>>>>
>>>> from the block tree.
>>>>
>>>> I fixed it up (see at end, plus the merge fix patch below) and can
>>>> carry the fix as necessary. This is now fixed as far as linux-next is
>>>> concerned, but any non trivial conflicts should be mentioned to your
>>>> upstream maintainer when your tree is submitted for merging.  You may
>>>> also want to consider cooperating with the maintainer of the
>>>> conflicting tree to minimise any particularly complex conflicts.  
>>>
>>> Thanks Stephen, I may just pull in the vfs tree to avoid this conflict.
>>
>> I looks like Al has rewritten the branch you merged from his tree and
>> caused various conflicts in my merge of the block tree today.  I used
>> Al's new versions of the conflicting files.
> 
> That's a bummer. I guess I'll have to rebase on top of the new one. Al,
> is the new one going to be persistent?

Stephen, I rebased and pushed it out, verified that the io_uring bits
are identical to before. So at least this should be painless for you on
next pull.

-- 
Jens Axboe

