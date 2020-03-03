Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441F7C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4EA2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583246572;
	bh=gOMn5LCg5e7fNrOxYgzCF5W1Ir/YCpTghxwifZIKk0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jyxZIuuZA16TCV1wKMrmXkRX0VzwrsmfZAAZt18UjbfK9QvSS0Bw9vk1UmhdnMNbu
	 yMEyS3pKAic4THtOaGP+4hG05XcQw3iArPXI2nzIJW/kRO4Hc8/8K8CldsU/Dp1vUA
	 xQT+8xX880SNDTx5VVoLJgUvXkZH3ZECmNGatvUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgCCOmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:42:51 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:48275 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgCCOmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:42:50 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 023Egi6G014433
        for <linux-kernel@vger.kernel.org>; Tue, 3 Mar 2020 23:42:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 023Egi6G014433
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583246565;
        bh=OZPR8E1gKqj7x19auK7Ryu3yKgbXudkqxAgoxHakHGA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0jnD3RDk9BYy2NQMUngVV1FC+komfYvHHShnJax7BOFXmoItTQxvDVGj4oSyIU/AC
         G1hXDb/S4+yuP+ZUB/rW7fiLrSiT4Y/tJqDF4o+tRXv7Tjtx+Ap2oegecRfCVcq4pY
         j/R4wR0/79wTBWCq2VWbROBc17d4Nfed277DsoJWpKqKXjaUne6OKpCdLGdn0T7as2
         pWtpanTlgsSmirh2N0OQmGXIlzWNXDijQm/kf02n+5MUxZzLpmFjZOMZ14Jr/q908/
         gI9vWIF78fyKkO+7s/mdDJ37/QvjN0mFaUm/v8VbSaILTE7w4Lyet1GLdd+RguV4br
         LPGATgVmW+ZhQ==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id y23so1213163ual.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:42:44 -0800 (PST)
X-Gm-Message-State: ANhLgQ2aMSAnPQbuSq3dOqr8Z6MZF5me/NpSm1Yy9LFQct+j3uvrPjoT
        iEbHKx7sca2R58AhF9VDOMdAozLsExnjIJ6zhns=
X-Google-Smtp-Source: ADFU+vtHs66vAeAYRgf9G93axs9SOayEFyaQ32KcJjDKoDRKx/t9vMva0IGEkqfLnxAy6bRjuk2Hmt9ZEyMY5iluYr8=
X-Received: by 2002:ab0:2ea6:: with SMTP id y6mr2947145uay.25.1583246563247;
 Tue, 03 Mar 2020 06:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20200226142608.19499-1-jeyu@kernel.org>
In-Reply-To: <20200226142608.19499-1-jeyu@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 3 Mar 2020 23:42:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZAgobbTTTpLKNActYCYP7UdVgdE-Oz+pvvRxsxd_uaw@mail.gmail.com>
Message-ID: <CAK7LNAQZAgobbTTTpLKNActYCYP7UdVgdE-Oz+pvvRxsxd_uaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] modpost: rework and consolidate logging interface
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:26 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> Rework modpost's logging interface by consolidating merror(), warn(),
> and fatal() to use a single function, modpost_log(). Introduce different
> logging levels (WARN, ERROR, FATAL) as well as a conditional warn
> (warn_unless()). The conditional warn is useful in determining whether
> to use merror() or warn() based on a condition. This reduces code
> duplication overall.
>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
> v2:
>   - modpost_log: initialize level to ""
>   - remove parens () from case labels
>
>  scripts/mod/modpost.c | 69 +++++++++++++++++++++++----------------------=
------
>  scripts/mod/modpost.h | 22 +++++++++++++---
>  2 files changed, 50 insertions(+), 41 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 7edfdb2f4497..3201a2ac5cc4 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -51,41 +51,37 @@ enum export {
>
>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>
> -#define PRINTF __attribute__ ((format (printf, 1, 2)))
> +#define PRINTF __attribute__ ((format (printf, 2, 3)))
>
> -PRINTF void fatal(const char *fmt, ...)
> +PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
>  {
> +       char *level =3D "";


You can add 'const'.


          const char *level =3D "";



>         va_list arglist;
>
> -       fprintf(stderr, "FATAL: ");
> -
> -       va_start(arglist, fmt);
> -       vfprintf(stderr, fmt, arglist);
> -       va_end(arglist);
> -
> -       exit(1);
> -}
> -
> -PRINTF void warn(const char *fmt, ...)
> -{
> -       va_list arglist;
> +       switch(loglevel) {
> +       case LOG_WARN:
> +               level =3D "WARNING: ";
> +               break;
> +       case LOG_ERROR:
> +               level =3D "ERROR: ";
> +               break;
> +       case LOG_FATAL:
> +               level =3D "FATAL: ";
> +               break;
> +       default: /* invalid loglevel, ignore */
> +               break;
> +       }
>
> -       fprintf(stderr, "WARNING: ");
> +       fprintf(stderr, level);



If I apply this patch, I see this warning:

scripts/mod/modpost.c: In function =E2=80=98modpost_log=E2=80=99:
scripts/mod/modpost.c:77:2: warning: format not a string literal and
no format arguments [-Wformat-security]
  fprintf(stderr, level);
  ^~~~~~~


Please write like this:


     fprintf(stderr, "%s", level);




Or, you can delete 'level', then write
string literals directly in fprintf().


switch(loglevel) {
case LOG_WARN:
        fprintf(stderr, "WARNING: ");
        break;
case LOG_ERROR:
        fprintf(stderr, "ERROR: ");
        break;
case LOG_FATAL:
        fprintf(stderr, "FATAL: ");
        break;
}




> +       fprintf(stderr, "modpost: ");
>
>         va_start(arglist, fmt);
>         vfprintf(stderr, fmt, arglist);
>         va_end(arglist);
> -}
>

<snip>

> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 64a82d2d85f6..631d07714f7a 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -198,6 +198,22 @@ void *grab_file(const char *filename, unsigned long =
*size);
>  char* get_next_line(unsigned long *pos, void *file, unsigned long size);
>  void release_file(void *file, unsigned long size);
>
> -void fatal(const char *fmt, ...);
> -void warn(const char *fmt, ...);
> -void merror(const char *fmt, ...);
> +enum loglevel {
> +       LOG_WARN,
> +       LOG_ERROR,
> +       LOG_FATAL
> +};
> +
> +void modpost_log(enum loglevel loglevel, const char *fmt, ...);
> +
> +#define warn(fmt, args...)     modpost_log(LOG_WARN, fmt, ##args)
> +#define merror(fmt, args...)   modpost_log(LOG_ERROR, fmt, ##args)
> +#define fatal(fmt, args...)    modpost_log(LOG_FATAL, fmt, ##args)
> +/* Warn unless condition is true, then use merror() */
> +#define warn_unless(condition, fmt, args...)   \
> +do {                                           \
> +       if (condition)                          \
> +               merror(fmt, ##args);            \
> +       else                                    \
> +               warn(fmt, ##args);              \
> +} while (0)


Hmm, warn_unless() is not intuitive naming...

You could use modpost_log() directly in C code,
what do you think?


            modpost_log(allow_missing_ns_imports ? LOG_WARN : LOG_ERROR,
                        "module %s uses symbol %s from namespace %s,
but does not import it.\n",
                        basename, exp->name, exp->namespace);







--
Best Regards
Masahiro Yamada
