Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215DAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F122620656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgF2WKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:10:25 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56811 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgF2WKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:10:25 -0400
X-Originating-IP: 176.88.144.104
Received: from [192.168.1.4] (unknown [176.88.144.104])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 29A3A20007;
        Mon, 29 Jun 2020 22:10:20 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Doug Anderson <dianders@chromium.org>
CC:     Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 30 Jun 2020 01:10:19 +0300
Message-ID: <173022188f8.2bfa.85c738e3968116fc5c0dc2de74002084@kernel.wtf>
In-Reply-To: <CAD=FV=XWYKqHEMDt-0PYHty_syJ9MO6Oz8DVBbacNZS5zGXk9A@mail.gmail.com>
References: <20200629153756.cxg74nec3repa4lu@holly.lan>
 <20200629205012.3263-1-cengiz@kernel.wtf>
 <CAD=FV=XWYKqHEMDt-0PYHty_syJ9MO6Oz8DVBbacNZS5zGXk9A@mail.gmail.com>
User-Agent: AquaMail/1.25.0-1628 (build: 102500003)
Subject: Re: [PATCH v2] kdb: remove unnecessary null check of dbg_io_ops
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On June 30, 2020 00:16:54 Doug Anderson <dianders@chromium.org> wrote:

> Hi,
>
> On Mon, Jun 29, 2020 at 1:50 PM Cengiz Can <cengiz@kernel.wtf> wrote:
>>
>> `kdb_msg_write` operates on a global `struct kgdb_io *` called
>> `dbg_io_ops`.
>>
>> It's initialized in `debug_core.c` and checked throughout the debug
>> flow.
>>
>> There's a null check in `kdb_msg_write` which triggers static analyzers
>> and gives the (almost entirely wrong) impression that it can be null.
>>
>> Coverity scanner caught this as CID 1465042.
>>
>> I have removed the unnecessary null check and eliminated false-positive
>> forward null dereference warning.
>>
>> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
>> ---
>> kernel/debug/kdb/kdb_io.c | 12 +++++-------
>> 1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
>> index 683a799618ad..4ac59a4fbeec 100644
>> --- a/kernel/debug/kdb/kdb_io.c
>> +++ b/kernel/debug/kdb/kdb_io.c
>> @@ -549,14 +549,12 @@ static void kdb_msg_write(const char *msg, int msg_len)
>> if (msg_len == 0)
>>        return;
>>
>> -       if (dbg_io_ops) {
>> -               const char *cp = msg;
>> -               int len = msg_len;
>> +       const char *cp = msg;
>> +       int len = msg_len;
>
> kernel/debug/kdb/kdb_io.c:552:14:
> warning: ISO C90 forbids mixing declarations and code
> [-Wdeclaration-after-statement]

Oops!

Sorry for that..

I admit I didn't compile check my second attempt.

/me ducks and covers

Will fix it asap.

Thanks!

>
> -Doug



