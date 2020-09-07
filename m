Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E1BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA212080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgIGRxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:53:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37345 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgIGLYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:24:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id z4so15431078wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 04:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J4+2saA0WM472pWg2AwLjD2nWWme4gZAQcTGCzryCrc=;
        b=FXGuHxB9gwytXP8Qo5WMwdqs4ze/lm13bmwOBaKUmaYfL+KRN3J7MIzhwvy6slYvXn
         HFXBLLQXU4asaYwSbjKjujKj0uAaaeJS38Rs0oCZ/VwqgXYs5gdeCumuBTGIdIrKE5x3
         rezFbIBz5ZEp1/P3rqu9GO0DjdrhQlUWstY6YQXl4RsEWsyUASlCtsTfgMqMrfQ++w/+
         1g7nh3PTW4qLBogl0WJnm9+enZwV+3aIBn7qrdfdBZyNj7sP7LkUF3glRrs18yOMpE3Y
         cKa0z+uDRPsvRg7FdvFGa89r8454r7Nwt8JbAvtO3HRrSluwfl4AJmIqk9f7Wjllc+Lt
         p8tw==
X-Gm-Message-State: AOAM533bST84MPaxPK5TIBxfKhayervJCgcKBGdCI2661AuNI/bMMGyP
        w6DwpJ6kWaJ05GlRWRUMuQJevbHHL5Y=
X-Google-Smtp-Source: ABdhPJxK6yPlTc/cIPKHLTVoB0MuCP995A/4jGusu1ANcLYMVz7kuPox8yEsSdaYQiRmw2Mj6Spv1Q==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr21383630wrt.409.1599477851313;
        Mon, 07 Sep 2020 04:24:11 -0700 (PDT)
Received: from [10.9.0.22] ([185.248.161.177])
        by smtp.gmail.com with ESMTPSA id t1sm24718017wmi.16.2020.09.07.04.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 04:24:10 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v2] stackleak: Fix a race between stack erasing sysctl
 handlers
To:     Muchun Song <songmuchun@bytedance.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        miguel.ojeda.sandonis@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20200828031928.43584-1-songmuchun@bytedance.com>
 <CAMZfGtWtAYNexRq1xf=5At1+YJ+_TtN=F6bVnm9EPuqRnMuroA@mail.gmail.com>
From:   Alexander Popov <alex.popov@linux.com>
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 j3lCqPk=
Message-ID: <8c288fd4-2ef7-ca47-1f3b-e4167944b235@linux.com>
Date:   Mon, 7 Sep 2020 14:24:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtWtAYNexRq1xf=5At1+YJ+_TtN=F6bVnm9EPuqRnMuroA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.2020 05:54, Muchun Song wrote:
> Hi all,
> 
> Any comments or suggestions? Thanks.
> 
> On Fri, Aug 28, 2020 at 11:19 AM Muchun Song <songmuchun@bytedance.com> wrote:
>>
>> There is a race between the assignment of `table->data` and write value
>> to the pointer of `table->data` in the __do_proc_doulongvec_minmax() on
>> the other thread.
>>
>>     CPU0:                                 CPU1:
>>                                           proc_sys_write
>>     stack_erasing_sysctl                    proc_sys_call_handler
>>       table->data = &state;                   stack_erasing_sysctl
>>                                                 table->data = &state;
>>       proc_doulongvec_minmax
>>         do_proc_doulongvec_minmax             sysctl_head_finish
>>           __do_proc_doulongvec_minmax           unuse_table
>>             i = table->data;
>>             *i = val;  // corrupt CPU1's stack

Hello everyone!

As I remember, I implemented stack_erasing_sysctl() very similar to other sysctl
handlers. Is that issue relevant for other handlers as well?

Muchun, could you elaborate how CPU1's stack is corrupted and how you detected
that? Thanks!

Best regards,
Alexander

>> Fix this by duplicating the `table`, and only update the duplicate of
>> it.
>>
>> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> changelogs in v2:
>>  1. Add more details about how the race happened to the commit message.
>>
>>  kernel/stackleak.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
>> index a8fc9ae1d03d..fd95b87478ff 100644
>> --- a/kernel/stackleak.c
>> +++ b/kernel/stackleak.c
>> @@ -25,10 +25,15 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
>>         int ret = 0;
>>         int state = !static_branch_unlikely(&stack_erasing_bypass);
>>         int prev_state = state;
>> +       struct ctl_table dup_table = *table;
>>
>> -       table->data = &state;
>> -       table->maxlen = sizeof(int);
>> -       ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>> +       /*
>> +        * In order to avoid races with __do_proc_doulongvec_minmax(), we
>> +        * can duplicate the @table and alter the duplicate of it.
>> +        */
>> +       dup_table.data = &state;
>> +       dup_table.maxlen = sizeof(int);
>> +       ret = proc_dointvec_minmax(&dup_table, write, buffer, lenp, ppos);
>>         state = !!state;
>>         if (ret || !write || state == prev_state)
>>                 return ret;
>> --
>> 2.11.0
>>
> 
> 

