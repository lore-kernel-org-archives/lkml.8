Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EA1C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7EA20842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583247463;
	bh=17BPoUv4AbkxLyL0lck8CcA1q7wq05GylmZ4YPmG7eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=198xznMFSV8O/F0hov0Yqa6yX96bzrltKMY4RLbph7wmY6PuZ/fND0f4bJR4izIfe
	 J8SZymJPhgTYyjBY65P/1e78e+m9p1GUwXcdbkI+GqvWyZynIW0V1LgSbM7jR/SS9V
	 VHVz8cmbaxTdxr/R9Hkvf5wnXgoV4CK3z/LQAUXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgCCO5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:57:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbgCCO5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:57:41 -0500
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0BF120828;
        Tue,  3 Mar 2020 14:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583247460;
        bh=17BPoUv4AbkxLyL0lck8CcA1q7wq05GylmZ4YPmG7eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IvHqNCqhb3UVnLDPf8lMA4Z5lnKW2VdQgl+MscAIKrKFu7uBlmbD+Ntf8K01AF5sb
         E/11oiRRMQxLt5R/bDD5dmQwXRBOTGBP7f1b9O/CyY+u2zMllJEYb+SzfCrufxJbHn
         0pCqovWQL8zmFz3U+cz8WzALy+1i3LHpwMJO4z5E=
Date:   Tue, 3 Mar 2020 15:57:36 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] modpost: rework and consolidate logging interface
Message-ID: <20200303145736.GA16460@linux-8ccs>
References: <20200226142608.19499-1-jeyu@kernel.org>
 <CAK7LNAQZAgobbTTTpLKNActYCYP7UdVgdE-Oz+pvvRxsxd_uaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQZAgobbTTTpLKNActYCYP7UdVgdE-Oz+pvvRxsxd_uaw@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [03/03/20 23:42 +0900]:
>On Wed, Feb 26, 2020 at 11:26 PM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> Rework modpost's logging interface by consolidating merror(), warn(),
>> and fatal() to use a single function, modpost_log(). Introduce different
>> logging levels (WARN, ERROR, FATAL) as well as a conditional warn
>> (warn_unless()). The conditional warn is useful in determining whether
>> to use merror() or warn() based on a condition. This reduces code
>> duplication overall.
>>
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>> ---
>> v2:
>>   - modpost_log: initialize level to ""
>>   - remove parens () from case labels
>>
>>  scripts/mod/modpost.c | 69 +++++++++++++++++++++++----------------------------
>>  scripts/mod/modpost.h | 22 +++++++++++++---
>>  2 files changed, 50 insertions(+), 41 deletions(-)
>>
>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>> index 7edfdb2f4497..3201a2ac5cc4 100644
>> --- a/scripts/mod/modpost.c
>> +++ b/scripts/mod/modpost.c
>> @@ -51,41 +51,37 @@ enum export {
>>
>>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>>
>> -#define PRINTF __attribute__ ((format (printf, 1, 2)))
>> +#define PRINTF __attribute__ ((format (printf, 2, 3)))
>>
>> -PRINTF void fatal(const char *fmt, ...)
>> +PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
>>  {
>> +       char *level = "";
>
>
>You can add 'const'.
>
>
>          const char *level = "";
>
>
>
>>         va_list arglist;
>>
>> -       fprintf(stderr, "FATAL: ");
>> -
>> -       va_start(arglist, fmt);
>> -       vfprintf(stderr, fmt, arglist);
>> -       va_end(arglist);
>> -
>> -       exit(1);
>> -}
>> -
>> -PRINTF void warn(const char *fmt, ...)
>> -{
>> -       va_list arglist;
>> +       switch(loglevel) {
>> +       case LOG_WARN:
>> +               level = "WARNING: ";
>> +               break;
>> +       case LOG_ERROR:
>> +               level = "ERROR: ";
>> +               break;
>> +       case LOG_FATAL:
>> +               level = "FATAL: ";
>> +               break;
>> +       default: /* invalid loglevel, ignore */
>> +               break;
>> +       }
>>
>> -       fprintf(stderr, "WARNING: ");
>> +       fprintf(stderr, level);
>
>
>
>If I apply this patch, I see this warning:
>
>scripts/mod/modpost.c: In function ‘modpost_log’:
>scripts/mod/modpost.c:77:2: warning: format not a string literal and
>no format arguments [-Wformat-security]
>  fprintf(stderr, level);
>  ^~~~~~~
>
>
>Please write like this:
>
>
>     fprintf(stderr, "%s", level);
>
>
>
>
>Or, you can delete 'level', then write
>string literals directly in fprintf().
>
>
>switch(loglevel) {
>case LOG_WARN:
>        fprintf(stderr, "WARNING: ");
>        break;
>case LOG_ERROR:
>        fprintf(stderr, "ERROR: ");
>        break;
>case LOG_FATAL:
>        fprintf(stderr, "FATAL: ");
>        break;
>}
>
>
>
>
>> +       fprintf(stderr, "modpost: ");
>>
>>         va_start(arglist, fmt);
>>         vfprintf(stderr, fmt, arglist);
>>         va_end(arglist);
>> -}
>>
>
><snip>
>
>> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
>> index 64a82d2d85f6..631d07714f7a 100644
>> --- a/scripts/mod/modpost.h
>> +++ b/scripts/mod/modpost.h
>> @@ -198,6 +198,22 @@ void *grab_file(const char *filename, unsigned long *size);
>>  char* get_next_line(unsigned long *pos, void *file, unsigned long size);
>>  void release_file(void *file, unsigned long size);
>>
>> -void fatal(const char *fmt, ...);
>> -void warn(const char *fmt, ...);
>> -void merror(const char *fmt, ...);
>> +enum loglevel {
>> +       LOG_WARN,
>> +       LOG_ERROR,
>> +       LOG_FATAL
>> +};
>> +
>> +void modpost_log(enum loglevel loglevel, const char *fmt, ...);
>> +
>> +#define warn(fmt, args...)     modpost_log(LOG_WARN, fmt, ##args)
>> +#define merror(fmt, args...)   modpost_log(LOG_ERROR, fmt, ##args)
>> +#define fatal(fmt, args...)    modpost_log(LOG_FATAL, fmt, ##args)
>> +/* Warn unless condition is true, then use merror() */
>> +#define warn_unless(condition, fmt, args...)   \
>> +do {                                           \
>> +       if (condition)                          \
>> +               merror(fmt, ##args);            \
>> +       else                                    \
>> +               warn(fmt, ##args);              \
>> +} while (0)
>
>
>Hmm, warn_unless() is not intuitive naming...
>
>You could use modpost_log() directly in C code,
>what do you think?
>
>
>            modpost_log(allow_missing_ns_imports ? LOG_WARN : LOG_ERROR,
>                        "module %s uses symbol %s from namespace %s,
>but does not import it.\n",
>                        basename, exp->name, exp->namespace);

Yeah, I wasn't sure if I should expose modpost_log() and call it
directly, so I wrapped it in warn_unless(). But I think it's not a big
deal, so I'll just change it to a direct call. Thank you for the review!

Jessica
