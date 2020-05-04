Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6F2C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B83206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VVj/pe9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgEDQjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbgEDQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:39:04 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796D5C061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 09:39:04 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y26so95569ioj.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JxAAIfpNpwUCd+S1KM1zaeEL93agwMn4YypEzGqkuLU=;
        b=VVj/pe9h31jZ9BC24zr31t7JCOHFyRPQCPAJ025ajEZUYPlNXC1EkSQGzSMVxKi5oa
         1Zgby5Qev6yCDDxpfQLG6b/661M0PgEWnmU9MrLotQfY10WXkJzYIQNPqosjalo8aArv
         tfjsb0eG51dJVWpuSwEnrRgXCMGi0o9rsSCQ6zTg9XEiVTRNF5c5e6Rn1lpQG+lWDJP6
         9aSmP+x/s3ru63ux946NstDrfuFHMZl76CuJGq8sK22vBuaQtQh858u8D9c8cDyhcLYv
         QfhTXLQcTA6KQ9OWgZ3U13kBdvv9wYYtXFm1FHuZ3J4I/EjIGZHGDe29oBPhYEJ9dR6g
         92RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxAAIfpNpwUCd+S1KM1zaeEL93agwMn4YypEzGqkuLU=;
        b=KEOAipTYCr5RdXxqzhpac1aW8MXWFO/sM8IqdmWXyyOuEktilLE9JN7Xwk6gy8fEsd
         P3OAIxECKEXXwS4ZMjWvLA8aVON3wFGDUuqWFlStfJmHvCh4nhmjCRfrh+tF2tvhZ+yA
         l2rffs6+mz3B06tic47TdOyFfo9vZWODbXO7SrXXCxQGx7TgdidjyG5zZDs7rRNmMci4
         VnxMRnNY1c9LxibFPTNUeqZBLBp89F8kEdV9NiWxLrSyAyIin62PQJJ4E+XxgvvlyajI
         F2HV/O4Ie/A3VTkBLsGlbs4CuMv0hErnlv4+lhne6K4NZuWyxQq3l6jUwnV1Mu93aOk7
         Oyrg==
X-Gm-Message-State: AGi0PualQvf41CJHZQVbWZSzH8WYm8Eaap6O2gbiUwz0jjHNpliTONhj
        YNdiwooQQNl1sUJ7jEU/GiC1Yw==
X-Google-Smtp-Source: APiQypIROicnfbxMltoP3ylQlLtVjyiTXuPrv6L6ZLra+7cKohnNnqKXWBmx2tWnVOULqubYFhG+Eg==
X-Received: by 2002:a6b:8dd7:: with SMTP id p206mr16019607iod.205.1588610343525;
        Mon, 04 May 2020 09:39:03 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 200sm5466388ila.27.2020.05.04.09.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 09:39:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] splice: export do_tee()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jann Horn <jannh@google.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Clay Harris <bugs@claycon.org>
References: <cover.1588421219.git.asml.silence@gmail.com>
 <56e9c3c84e5dbf0be8272b520a7f26b039724175.1588421219.git.asml.silence@gmail.com>
 <CAG48ez0h6950sPrwfirF2rJ7S0GZhHcBM=+Pm+T2ky=-iFyOKg@mail.gmail.com>
 <387c1e30-cdb0-532b-032e-6b334b9a69fa@gmail.com>
 <b62d84b0-c5a8-402f-d62e-e0b8d41221bb@kernel.dk>
 <1007c4ff-2af0-1473-a268-a0ae245d8188@gmail.com>
 <9d43b5b5-577b-bc44-1667-fdd2055e63d7@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa9b2562-9e17-21b0-5522-3ef03299d44f@kernel.dk>
Date:   Mon, 4 May 2020 10:39:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9d43b5b5-577b-bc44-1667-fdd2055e63d7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/20 10:36 AM, Pavel Begunkov wrote:
> On 04/05/2020 17:03, Pavel Begunkov wrote:
>> On 04/05/2020 16:43, Jens Axboe wrote:
>>> On 5/4/20 6:31 AM, Pavel Begunkov wrote:
>>>> On 04/05/2020 14:09, Jann Horn wrote:
>>>>> On Sat, May 2, 2020 at 2:10 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>>> export do_tee() for use in io_uring
>>>>> [...]
>>>>>> diff --git a/fs/splice.c b/fs/splice.c
>>>>> [...]
>>>>>>   * The 'flags' used are the SPLICE_F_* variants, currently the only
>>>>>>   * applicable one is SPLICE_F_NONBLOCK.
>>>>>>   */
>>>>>> -static long do_tee(struct file *in, struct file *out, size_t len,
>>>>>> -                  unsigned int flags)
>>>>>> +long do_tee(struct file *in, struct file *out, size_t len, unsigned int flags)
>>>>>>  {
>>>>>>         struct pipe_inode_info *ipipe = get_pipe_info(in);
>>>>>>         struct pipe_inode_info *opipe = get_pipe_info(out);
>>>>>
>>>>> AFAICS do_tee() in its current form is not something you should be
>>>>> making available to anything else, because the file mode checks are
>>>>> performed in sys_tee() instead of in do_tee(). (And I don't see any
>>>>> check for file modes in your uring patch, but maybe I missed it?) If
>>>>> you want to make do_tee() available elsewhere, please refactor the
>>>>> file mode checks over into do_tee().
>>>>
>>>> Overlooked it indeed. Glad you found it
>>>
>>> Yeah indeed, that's a glaring oversight on my part too. Will you send
>>> a patch for 5.7-rc as well for splice?
>>
>> Absolutely
> 
> The right way would be to do as Jann proposed, but would you prefer an
> io_uring.c local fix for-5.7 and then a proper one? I assume it could
> be easier to manage.

Let's just do a proper one for 5.7 as well.

-- 
Jens Axboe

