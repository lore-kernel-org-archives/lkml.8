Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CB2C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F1C206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LjQwNHd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgBVQYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 11:24:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVQYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=tfEsnk1+KpKAKA991WyR6/b0YuEnsP1eg5dSBJauod4=; b=LjQwNHd7Wwuug5QTpCLzdmWxoX
        uaoPtFkMmfCc2si41D6fCGzmbkAjwOVi5DtZf3tmGw58aoVw2uQG4OL6gQT5Cdyl8TQoyDdclv6Hq
        E9lSAVpvxVBtyQir7d5WuymBK6xf6nLEBwIjhLdjEjDzusvhJ250ilRBo2Hujknj8qWq0rgBed07M
        MV80VIgatRUX3z+2ZhU+MLmr7scoNTGsdVJjiPNHt3/r1NpAfvC4aTEfTd497FtfjdQ4PodlBo14f
        oDaDr2TiZ+6YxHY16MJQF+DE6T+n1NoxX4Gse8AyjVydgFPoeD0hjMmw/H/QiZz7WFWc9lpBcLzx2
        SBD8k1hw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5XZT-0007jg-6X; Sat, 22 Feb 2020 16:24:03 +0000
Subject: Re: [PATCH v3 1/2] bootconfig: Prohibit re-defining value on same key
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <158227281198.12842.8478910651170568606.stgit@devnote2>
 <158227282199.12842.10110929876059658601.stgit@devnote2>
 <536c681d-a546-bb51-a6cb-2d39ed726716@infradead.org>
 <CAMuHMdURcRPXo7Q-2E7bS7X9w73NvYP8ffdJeNk37wdQgVxThw@mail.gmail.com>
 <20200222234147.7525a2d527ebbf53f06b5734@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dcd31dc2-a555-1d5a-c5f5-56ee5c3e6405@infradead.org>
Date:   Sat, 22 Feb 2020 08:24:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200222234147.7525a2d527ebbf53f06b5734@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/20 6:41 AM, Masami Hiramatsu wrote:
> On Sat, 22 Feb 2020 10:31:17 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
>> Hi Randy,
>>
>> On Sat, Feb 22, 2020 at 5:30 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>> On 2/21/20 12:13 AM, Masami Hiramatsu wrote:
>>>> --- a/Documentation/admin-guide/bootconfig.rst
>>>> +++ b/Documentation/admin-guide/bootconfig.rst
>>>> @@ -62,7 +62,16 @@ Or more shorter, written as following::
>>>>  In both styles, same key words are automatically merged when parsing it
>>>>  at boot time. So you can append similar trees or key-values.
>>>>
>>>> -Note that a sub-key and a value can not co-exist under a parent key.
>>>> +Same-key Values
>>>> +---------------
>>>> +
>>>> +It is prohibited that two or more values or arraies share a same-key.
>>>
>>> I think (?):                                   arrays
>>>
>>>> +For example,::
>>>> +
>>>> + foo = bar, baz
>>>> + foo = qux  # !ERROR! we can not re-define same key
>>>> +
>>>> +Also, a sub-key and a value can not co-exist under a parent key.
>>>>  For example, following config is NOT allowed.::
>>>>
>>>>   foo = value1
>>>
>>>
>>> I'm pretty sure that the kernel command line allows someone to use
>>>   key=value1 ... key=value2
>>> and the first setting is just overwritten with value2 (for most "key"s).
>>>
>>> Am I wrong?  and is this patch saying that bootconfig won't operate like that?
>>
>> I think so. Both are retained.
>> A typical example is "console=ttyS0 console=tty", to have the kernel output
>> on both the serial and the graphical console.

Yes, I was aware of that one also.

> Right, it actually depends on how the option is defined and its handler.
> If the option is defined with module_param*() macros, those will be 
> overwritten.
> But if it is defined with __setup() or early_param(), the handler function
> will be called repeatedly. Thus, overwrite or append or skip later one
> depends on the option handler.

OK, thanks for that clarification.

> I think the bootconfig is a bit different from legacy command line at
> this moment. The legacy command line can be modified by bootloader,
> whereas the bootconfig is a single text file which user can update
> each value. Of course bootloader will support the bootconfig to append
> some key-values in the future.
> So I would like to introduce another "overwrite" operator (":=") and
> "assign default" operator ("?=") too. With those operators, the
> bootloader can just add their own key-value without decoding the
> current bootconfig.


-- 
~Randy

