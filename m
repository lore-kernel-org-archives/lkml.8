Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C2C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EFB2084E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583747960;
	bh=0sP2HCSbp1hFImJrXuJEJrwE1KAk2T96fyJpUDGb184=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0AyCdLzSyRzRubYYxPnEuWUoXMYyZhzbjWxZyk2jlHXAnoj+trLxYAPuxuDHVGEOi
	 Iqus0qmikZ7iQmshi9VEvxDaeUKZXNk5AgUuRknfKF0LvXY3Fby6KCCTlmNJoIaERb
	 9AOWDjWxcKYSwo4CSRqLXmxIb5fAABUk7p/O3yGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCIJ7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIJ7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:59:19 -0400
Received: from linux-8ccs.fritz.box (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F53520828;
        Mon,  9 Mar 2020 09:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583747958;
        bh=0sP2HCSbp1hFImJrXuJEJrwE1KAk2T96fyJpUDGb184=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUOHarpJ+5l89Tl4H9ZQXsnTA9Cq9db0NMUv+pLczhyDmAQYbCHG7gQ7XMjDnOv00
         rUn4p/fprUebD3XQEH3j0o9636RzTEF5MKGI4NBOq/ApZfYIfepJ/5ENlTHVWjieQx
         6agd6fm4ZcO++X+FNseKsoVxjpN1ukLKeY0rKoes=
Date:   Mon, 9 Mar 2020 10:59:14 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] modpost: rework and consolidate logging interface
Message-ID: <20200309095914.GA18870@linux-8ccs.fritz.box>
References: <20200306160206.5609-1-jeyu@kernel.org>
 <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [09/03/20 09:40 +0900]:
>Hi Jessica,
>
>
>
>On Sat, Mar 7, 2020 at 1:02 AM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> Rework modpost's logging interface by consolidating merror(), warn(), and
>> fatal() to use a single function, modpost_log(). Introduce different
>> logging levels (WARN, ERROR, FATAL) as well. The purpose of this cleanup is
>> to reduce code duplication when deciding whether or not to warn or error
>> out based on a condition.
>>
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>> ---
>> v3:
>>         - remove level variable from modpost_log and just call fprintf in each
>>           case
>>         - remove warn_unless and just call modpost_log() directly
>>         - fix checkpatch error:
>>                 ERROR: space required before the open parenthesis '('
>>         #102: FILE: scripts/mod/modpost.c:61:
>>         + switch(loglevel) {
>>
>>  scripts/mod/modpost.c | 68 ++++++++++++++++++++++-----------------------------
>>  scripts/mod/modpost.h | 14 ++++++++---
>>  2 files changed, 40 insertions(+), 42 deletions(-)
>>
>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>> index 7edfdb2f4497..a2329235a6db 100644
>> --- a/scripts/mod/modpost.c
>> +++ b/scripts/mod/modpost.c
>> @@ -51,41 +51,34 @@ enum export {
>>
>>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>>
>> -#define PRINTF __attribute__ ((format (printf, 1, 2)))
>> +#define PRINTF __attribute__ ((format (printf, 2, 3)))
>>
>> -PRINTF void fatal(const char *fmt, ...)
>> +PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
>>  {
>
>
>This series looks good to me.
>
>I can queue it up to kbuild tree
>if there is no objection.
>
>
>I just noticed one nit.
>
>Now that modpost_log() is the only user of PRINTF,
>we can delete PRITNF, and directly add the attribute
>to modpost_log(), like this:
>
>
>void __attribute__((format(printf, 2, 3)))
>modpost_log(enum loglevel loglevel, const char *fmt, ...)
>{
>       ...
>}
>
>
>If you agree, I can modify it when I apply it.

Yes, I agree with this change. Thank you!

One more thing, it's not immediately obvious to me why the first patch
would cause those kbuild warnings :-/ I'll see if I have any luck
reproducing them locally..

Thanks,

Jessica

