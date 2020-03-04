Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAF3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B42214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5i5pswg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbgCDLOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:14:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46290 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCDLOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:14:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id j7so1858541wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 03:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ytJyZne6tZeakYNWCLvFS4U17Dxs6Z9j14ft6YAqs1Y=;
        b=E5i5pswg8Xz0wg1+iNVXwEiKmUyrezTIOvhxCawnzSfY7oSbglTIWwQ0fgct0doFOi
         mX+7kSfBVuPVFpPEzCEhDEhh8GRrgD7j3tcFB/LdMVYLhvEBIouIGY6Njh19ca9EDkKJ
         d6Bd79K4jVPC5eHh9WqltbZ+JYvFwDPe7mnhnLO9oUS9ucehEhKqGvMgvjO8pPBRtD+h
         NPNWOeh7FQ0sF2/HHfhwoNJwe0fRGCRfjz15HiKDhYbDBI/pBxD8kUJgL6hDMuqW+kKH
         dldnc7ZSthkpYEydmwGC1M4kEc8foQKPUPsF/QFx2DA77PKyWN6EHOgatRhJAneAzk2e
         SsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ytJyZne6tZeakYNWCLvFS4U17Dxs6Z9j14ft6YAqs1Y=;
        b=fLC21giaaD/hwbVG8uQIcXIjTygebTYyGXWtOVeK2h1dr6BM+4Vw/rz4j4VcHUoLHH
         FeE9JZWzIElDe3rfQ67wvNa362FvX9pxYnKWZ3/Df+1zeKuMywFfTcw24cDAaUa5OZT8
         0ND5n2dvxcEGBQRPbPsNMe1XfTb26gqkHWPFrHh9me3kNs+SDXjn4UJlLVjzt0Y80mSO
         khfFG2CKUXYFq38qJVxe0Mbi1BsaxCU7HxMr5nZM6rs9onPTNij4Wt7vBI+Y1C56S1o2
         kmrzQD2V2mK4dWI+fz3elN0NYh9fNxSNVwVL0lKPKMLbNuA+VtOJSE5daAtrQYnSPvPR
         2t2A==
X-Gm-Message-State: ANhLgQ0JNzt3dUkYj9YPQijsZB9N08XgJlZ9LFSXFgrF4hm62/FT3Ivq
        HrfMMhVn7VEsYvdTtD87ip09Xw==
X-Google-Smtp-Source: ADFU+vttUA1RjZh+6g6P/+H5oxlXGPf7GeFqGD016HHhrN0Eg/GSxV29/Z9pASyta+tTx4cC2FeNiA==
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr3597686wru.329.1583320463015;
        Wed, 04 Mar 2020 03:14:23 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id 133sm3877459wmd.5.2020.03.04.03.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 03:14:22 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:14:22 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] modpost: rework and consolidate logging interface
Message-ID: <20200304111422.GA66900@google.com>
References: <20200226142608.19499-1-jeyu@kernel.org>
 <CAK7LNAQZAgobbTTTpLKNActYCYP7UdVgdE-Oz+pvvRxsxd_uaw@mail.gmail.com>
 <20200303145736.GA16460@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200303145736.GA16460@linux-8ccs>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 03:57:36PM +0100, Jessica Yu wrote:
>+++ Masahiro Yamada [03/03/20 23:42 +0900]:
>>On Wed, Feb 26, 2020 at 11:26 PM Jessica Yu <jeyu@kernel.org> wrote:
>>>
>>>Rework modpost's logging interface by consolidating merror(), warn(),
>>>and fatal() to use a single function, modpost_log(). Introduce different
>>>logging levels (WARN, ERROR, FATAL) as well as a conditional warn
>>>(warn_unless()). The conditional warn is useful in determining whether
>>>to use merror() or warn() based on a condition. This reduces code
>>>duplication overall.
>>>
>>>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>>>---
>>>v2:
>>>  - modpost_log: initialize level to ""
>>>  - remove parens () from case labels
>>>
>>> scripts/mod/modpost.c | 69 +++++++++++++++++++++++----------------------------
>>> scripts/mod/modpost.h | 22 +++++++++++++---
>>> 2 files changed, 50 insertions(+), 41 deletions(-)
>>>
>>>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>>>index 7edfdb2f4497..3201a2ac5cc4 100644
>>>--- a/scripts/mod/modpost.c
>>>+++ b/scripts/mod/modpost.c
>>>@@ -51,41 +51,37 @@ enum export {
>>>
>>> #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>>>
>>>-#define PRINTF __attribute__ ((format (printf, 1, 2)))
>>>+#define PRINTF __attribute__ ((format (printf, 2, 3)))
>>>
>>>-PRINTF void fatal(const char *fmt, ...)
>>>+PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
>>> {
>>>+       char *level = "";
>>
>>
>>You can add 'const'.
>>
>>
>>         const char *level = "";
>>
>>
>>
>>>        va_list arglist;
>>>
>>>-       fprintf(stderr, "FATAL: ");
>>>-
>>>-       va_start(arglist, fmt);
>>>-       vfprintf(stderr, fmt, arglist);
>>>-       va_end(arglist);
>>>-
>>>-       exit(1);
>>>-}
>>>-
>>>-PRINTF void warn(const char *fmt, ...)
>>>-{
>>>-       va_list arglist;
>>>+       switch(loglevel) {
>>>+       case LOG_WARN:
>>>+               level = "WARNING: ";
>>>+               break;
>>>+       case LOG_ERROR:
>>>+               level = "ERROR: ";
>>>+               break;
>>>+       case LOG_FATAL:
>>>+               level = "FATAL: ";
>>>+               break;
>>>+       default: /* invalid loglevel, ignore */
>>>+               break;
>>>+       }
>>>
>>>-       fprintf(stderr, "WARNING: ");
>>>+       fprintf(stderr, level);
>>
>>
>>
>>If I apply this patch, I see this warning:
>>
>>scripts/mod/modpost.c: In function ‘modpost_log’:
>>scripts/mod/modpost.c:77:2: warning: format not a string literal and
>>no format arguments [-Wformat-security]
>> fprintf(stderr, level);
>> ^~~~~~~
>>
>>
>>Please write like this:
>>
>>
>>    fprintf(stderr, "%s", level);
>>
>>
>>
>>
>>Or, you can delete 'level', then write
>>string literals directly in fprintf().
>>
>>
>>switch(loglevel) {
>>case LOG_WARN:
>>       fprintf(stderr, "WARNING: ");
>>       break;
>>case LOG_ERROR:
>>       fprintf(stderr, "ERROR: ");
>>       break;
>>case LOG_FATAL:
>>       fprintf(stderr, "FATAL: ");
>>       break;
>>}
>>
>>
>>
>>
>>>+       fprintf(stderr, "modpost: ");
>>>
>>>        va_start(arglist, fmt);
>>>        vfprintf(stderr, fmt, arglist);
>>>        va_end(arglist);
>>>-}
>>>
>>
>><snip>
>>
>>>diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
>>>index 64a82d2d85f6..631d07714f7a 100644
>>>--- a/scripts/mod/modpost.h
>>>+++ b/scripts/mod/modpost.h
>>>@@ -198,6 +198,22 @@ void *grab_file(const char *filename, unsigned long *size);
>>> char* get_next_line(unsigned long *pos, void *file, unsigned long size);
>>> void release_file(void *file, unsigned long size);
>>>
>>>-void fatal(const char *fmt, ...);
>>>-void warn(const char *fmt, ...);
>>>-void merror(const char *fmt, ...);
>>>+enum loglevel {
>>>+       LOG_WARN,
>>>+       LOG_ERROR,
>>>+       LOG_FATAL
>>>+};
>>>+
>>>+void modpost_log(enum loglevel loglevel, const char *fmt, ...);
>>>+
>>>+#define warn(fmt, args...)     modpost_log(LOG_WARN, fmt, ##args)
>>>+#define merror(fmt, args...)   modpost_log(LOG_ERROR, fmt, ##args)

The only thing that bothered me a bit was the inconsistent naming with
'merror'. I know `error` is reserved, but refactoring this whole code
(thanks for that!) seems like a code opportunity to clean this up. (Or
is it just me?)

Cheers,
Matthias

>>>+#define fatal(fmt, args...)    modpost_log(LOG_FATAL, fmt, ##args)
>>>+/* Warn unless condition is true, then use merror() */
>>>+#define warn_unless(condition, fmt, args...)   \
>>>+do {                                           \
>>>+       if (condition)                          \
>>>+               merror(fmt, ##args);            \
>>>+       else                                    \
>>>+               warn(fmt, ##args);              \
>>>+} while (0)
>>
>>
>>Hmm, warn_unless() is not intuitive naming...
>>
>>You could use modpost_log() directly in C code,
>>what do you think?
>>
>>
>>           modpost_log(allow_missing_ns_imports ? LOG_WARN : LOG_ERROR,
>>                       "module %s uses symbol %s from namespace %s,
>>but does not import it.\n",
>>                       basename, exp->name, exp->namespace);
>
>Yeah, I wasn't sure if I should expose modpost_log() and call it
>directly, so I wrapped it in warn_unless(). But I think it's not a big
>deal, so I'll just change it to a direct call. Thank you for the review!
>
>Jessica
