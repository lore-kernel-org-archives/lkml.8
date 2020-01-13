Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7323EC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E0021739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WKqIN2x4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAMRJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:09:06 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34133 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgAMRJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:09:04 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so10607571iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 09:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HwOMSNU0BOcmSRdPEWKuyZX5aZw+rCZHEo3YxXXPbFY=;
        b=WKqIN2x4arw2oKUauJg3IzH0Qjl/mB5DQfhbHOo9RwqOxk1NJAI/DXrWhbYvac3FUU
         6z14DZZMo1fvXjZbp/NMHMaMWa3xcDbxdnXLXMKhGK0DYjmHTKtTpAyFbGxMVFVSK4mQ
         1M6o9th63zQJ7uVxLbmFHDx+V1IVk0PBWnWfHNjj+DAROwY9Sz1zLTOGUkAyjytc3LXw
         TNAFCePAGIquBokzfdvjK5TWHwCsRtCc2XevcbVtPPT5OePT53zNlRKrZNAEC982It9U
         98EWBsgK2gb1Hf8NPxoFa/rIm/s4UpeMeR4NOEZDdBcoKet82/f4Me+lSg19PNK4sKHP
         i49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HwOMSNU0BOcmSRdPEWKuyZX5aZw+rCZHEo3YxXXPbFY=;
        b=OH3n56R6usOVSFxARnZnsh8h0zV4GWoPUfWYNeAc7CmC/4f2OObd2IbmVSsUrdpyMd
         64F4jrOqs02rExySt7/iUdhmo6UcbPNONGWg92IUAAqKcQTrES+whX0tGGkfosJJci1o
         8H92D9eHCR6rltND3Bd8CsdhfgNfDNMg2KFfazua/wMZhXPoCntqbiLSA28SNnoTLeHy
         oVZq8Zq5sLtIxaDouLS0nPnWjvp/qBNuhYPp3RGgAAGHpe1wHsZFUy9ftOuRenauWGdh
         4rC2cyd6DDVp5IhcJA5u54wFsQTZqf3HobnBrF2yvM4RblXDKbfUpWbXzRaFb9B+DIg0
         zplA==
X-Gm-Message-State: APjAAAWmlN9JqClPXaraIHFntsmF1H+GtVGk6wrPKrH++0lDKMs76+vu
        CvcaGpmRoX21XoZ4u5uxE2MxJDYinQY=
X-Google-Smtp-Source: APXvYqy68d9Ng4v1S+3XbifY4an9Sl2hEGBXR3rUtx/ooElUc+fi5+WPRSFy8jmCisZsF0cjR9P+zg==
X-Received: by 2002:a6b:c986:: with SMTP id z128mr13473801iof.8.1578935343131;
        Mon, 13 Jan 2020 09:09:03 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x62sm4000954ill.86.2020.01.13.09.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 09:09:02 -0800 (PST)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
References: <20200106123027.1a162197@canb.auug.org.au>
 <e9a87175-64c9-46da-4737-72987a53e836@kernel.dk>
 <20200112183235.GO8904@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b177c427-ca94-bbbf-b09d-6f2faef4121c@kernel.dk>
Date:   Mon, 13 Jan 2020 10:09:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112183235.GO8904@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/20 11:32 AM, Al Viro wrote:
> On Mon, Jan 06, 2020 at 09:04:01PM -0700, Jens Axboe wrote:
>> On 1/5/20 6:30 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> After merging the block tree, today's linux-next build (arm
>>> multi_v7_defconfig) failed like this:
>>>
>>> fs/open.c:977:12: error: conflicting types for 'build_open_flags'
>>>   977 | inline int build_open_flags(const struct open_how *how,
>>>       |            ^~~~~~~~~~~~~~~~
>>> In file included from /home/sfr/next/next/fs/open.c:36:
>>> fs/internal.h:127:12: note: previous declaration of 'build_open_flags' was here
>>>   127 | extern int build_open_flags(int flags, umode_t mode, struct open_flags *op);
>>>       |            ^~~~~~~~~~~~~~~~
>>>
>>> Caused by commits
>>>
>>>   4e9e15c9426e ("fs: make build_open_flags() available internally")
>>>   3bba3e571bc8 ("io_uring: add support for IORING_OP_OPENAT")
>>>
>>> interacting with commit
>>>
>>>   0a51692d49ec ("open: introduce openat2(2) syscall")
>>>
>>> from the vfs tree.
>>>
>>> I have applied the following fix up patch for today:
>>
>> Thanks Stephen - I'll pull in the VFS tree and rebase the 5.6 io_uring
>> bits on that. Then I'll send it out for review again, haven't heard from
>> Al on the non-block open change.
> 
> FWIW, I don't believe that your approach is workable.  First of all,
> *ANY* transition out of RCU mode can lead to blocking.  You need to
> acquire several references (mount and dentry, at the very least).
> Suppose the last one fails (->d_seq mismatch).  Now you suddenly
> have to drop the one(s) you've acquired.  And both dput() and mntput()
> are fundamentally blocking operations.
> 
> It simply does not work.  You could cobble up something that kinda-sorta
> works, if your added flag had
> 	* caused hard failure on unlazy_child()
> 	* caused hard failure on unlazy_walk() with any symlinks in stack
> 	* caused hard failure on unlazy_walk() if it would've been required
> to grab root
> 	* made unlazy_walk() go through very careful dance if it's just
> about nd->path; I'm not sure how well that could be done, but theoretically
> it's not impossible.
> 
> But for open() it's not going to work at all.  Any open for write => you
> will have to wait if you run into fs freeze.  O_TRUNC => you've got IO
> to do.  Worst of all, once you've dropped out of RCU mode, *YOU* *CAN'T*
> *FAIL*.  Because that means blocking operations.  So you need to verify
> that you won't run into a blocking ->open(), IMA deciding to play silly
> buggers and read through the entire file, etc., etc. _before_ dropping
> out of RCU mode.
> 
> do_last() is messy enough as it is; adding _this_ is completely out of
> question.

Thanks Al, that's useful! Sounds like the lookup is doable, but the open
part is just a wasp nest of "don't even go there". For now, I'll drop
the lookup change and just have the io_uring open punt to async. With
that, I don't need any non-blocking guarantees. That is workable for
now.

> Jens, if you have a workable plan on that non-blocking open of yours,
> post it in full details.  Until then - NAK, and that's about as hard one
> as I ever had to give.

It's like the other io_uring opcodes - we prefer to try a non-blocking
attempt first, and if that fails, then we go async. I have no grand
async open design, was just hoping I could make it work with minimal
effort. That's obviously not doable. I would not mind working on
actually making it doable, but that's a bigger project than I originally
wanted to take on.

So the most likely outcome longer term is for io_uring to adopt a syslet
type of approach to this, where we always just just call the open
helper, and if we need to block/reschedule, then we move context to an
appropriate worker thread. Time is better spent there rather than trying
to make every useful system call provide a sane non-blocking path, I
think.

-- 
Jens Axboe

