Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E987FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BBD20884
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgFRKaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:30:21 -0400
Received: from relay.sw.ru ([185.231.240.75]:43156 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727037AbgFRKaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:30:01 -0400
Received: from [192.168.15.188]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1jlrnt-0004ei-3s; Thu, 18 Jun 2020 13:29:53 +0300
Subject: Re: Re: [fuse] 6b2fb79963:
 WARNING:at_fs/fuse/file.c:#tree_insert[fuse]
To:     Miklos Szeredi <mszeredi@redhat.com>,
        Vasily Averin <vvs@virtuozzo.com>
Cc:     Maxim Patlasov <maximvp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200615005036.GU12456@shao2-debian>
 <ea00a67e-5a61-2e70-215e-004e3dcc57c1@virtuozzo.com>
 <CAOssrKdTTZEBEfwFm+3dYJ5XB9FsFAeF5g5ydeSo7ZPKkqjJXQ@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <104a01ad-7861-19ab-119c-cada740872a2@virtuozzo.com>
Date:   Thu, 18 Jun 2020 13:29:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAOssrKdTTZEBEfwFm+3dYJ5XB9FsFAeF5g5ydeSo7ZPKkqjJXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16.06.2020 15:35, Miklos Szeredi wrote:
> On Mon, Jun 15, 2020 at 7:59 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>>
>> On 6/15/20 3:50 AM, kernel test robot wrote:
>>> FYI, we noticed the following commit (built with gcc-9):
>>>
>>> commit: 6b2fb79963fbed7db3ef850926d913518fd5c62f ("fuse: optimize writepages search")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>>> [ 1030.995703] ------------[ cut here ]------------
>>> [ 1030.997563] WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
>>> [ 1031.021943] RIP: 0010:tree_insert+0xab/0xc0 [fuse]
>>> [ 1031.057802] Call Trace:
>>> [ 1031.060015]  fuse_writepages_fill+0x5da/0x6a0 [fuse]
>>> [ 1031.062536]  write_cache_pages+0x171/0x470
>>> [ 1031.064933]  ? fuse_writepages+0x100/0x100 [fuse]
>>> [ 1031.067419]  ? terminate_walk+0xd3/0xf0
>>> [ 1031.069707]  ? _cond_resched+0x19/0x30
>>> [ 1031.072140]  ? __kmalloc+0x274/0x280
>>> [ 1031.074407]  fuse_writepages+0x8a/0x100 [fuse]
>>> [ 1031.076599]  do_writepages+0x43/0xe0
>>
>> It is  WARN_ON(!wpa->ia.ap.num_pages);
>> however tree_insert() was called from fuse_writepages_fill() with ap->num_pages = 0;
>> In submitted PATCH RFC we have used
>>
>> +static int tree_insert(struct rb_root *root, struct fuse_req *ins_req)
>> ...
>> +       pgoff_t idx_to   = idx_from + (ins_req->num_pages ?
>> +                               ins_req->num_pages - 1 : 0);
>>
>> Though committed patch version have
>>
>> +static void tree_insert(struct rb_root *root, struct fuse_writepage_args *wpa)
>> ...
>> +       pgoff_t idx_to = idx_from + wpa->ia.ap.num_pages - 1;
>> ...
>> +       WARN_ON(!wpa->ia.ap.num_pages);
>>
>> Miklos,
>> do you have any objections if I return to our initial proposal?
>> Am I missed something and it is not allowed now?
> 
> No objections, but you need to explain with a comment why that special
> casing of num_pages == 0 is needed.  I don't understand it yet.

Currently here is already a bomb in mainline kernel.

This fuse_writepages_fill()->tree_insert() with num_pages == 0 corrupts fi->writepages tree.
Normally we have half-closed intervals in the tree:


         [5, 6)
        /      \
  [1, 3)        [7, 9)

But tree_insert(num_pages == 0) adds an abnormal interval with both ends included:

         [5, 5]
        /      \
  [1, 3)        [7, 9)


This may seriously confuse a reader iterating a tree, which does not know about special case (num_pages == 0).
As I see, nobody in the code cares about num_pages == 0, and there is no comment about that case.

This will fire soon or later. I think we should stop insert abnormal intervals (num_pages == 0) there.

Reasons fuse_writepages_fill() does use this (num_pages == 0)?!
