Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F436C54E4A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 20:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF8820A8B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 20:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589055901;
	bh=6V1qJdRSgOyhSZnyoH+LPJ3fzToxauAOuUOEAPqdvlo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lU+rI+QenHAqSxOH8HWnjFHdf0QgSfOa5v48bN7cD3kIjzpe4v2QAVanx8WEffk7P
	 9Y72YkqtZLPoeTskoalogvNZAGRHQazEL6Upd+LWQJZB2CKNiTHDXqHyIuxRM/U6vA
	 gCEe6nRrR+byvJyse6CfnNYTD+67wTKFE0rhXz6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgEIUZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 16:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgEIUY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 16:24:59 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A944C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 13:24:58 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id s10so4332558edy.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 13:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rq3EROYQxDfNBT0wVZ0AqkaD6tlVAw2P3CKf/Rs8tQg=;
        b=Z96Q63QMe9Gpsp6AeXzJLinw3niN6+LUAC3oCMCbateqa07K/sPjLmTGDwByhw59b9
         UXCxV70CR0zudA48gJhwUKM8r72YcyACiVcdEj6M/nBu7IVXDtigWGZYpPDlWvyhkTlw
         m40LV53bx4dKUuBDMcU/qCxfUEgtlul3KpXxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rq3EROYQxDfNBT0wVZ0AqkaD6tlVAw2P3CKf/Rs8tQg=;
        b=o8zNlV0Hwf06o4Y20/mJcdQoz/tIxGnLsvgj4cmYp1O9rMWsOFmZPdL1kgOanPdg02
         NU8ErHV3JCy2e6BNfdrCvQJGqWr07Yr6UlRQxTxfWTlOg/sdUzR3WLPPUwNvQMNmq9GO
         +TvWr43E4gkORQGv1m2wKE3YdFRc7XHcGL4xpAOgpDsBLGXynZQ+JfjPphIcl5cOIqm6
         zCpef4Ud2tRoD/AlT6HFCGT1C94VWhpgzqOBKQm/dsYFDB58J1Uq77BCQSK92lstox3c
         ETkTcbVKQiJBk1I+kUTKUmQo/4/LyaAshRAlaqlwi3F75g3Zeo1Fq3o6wVSK3AlejIrT
         lwzg==
X-Gm-Message-State: AGi0Pubi8GG8JL7wUOwB5xkeKFqEIlykB1L5GYTQxH+2U7m0iuKXgrK4
        UE3tE5vXFeWiQSpj4twU4jgvN/4OgT0=
X-Google-Smtp-Source: APiQypKx+SqtqNJjU/XmeJ1Fr/kITfObWWBHcxMO09zajW4OhIxYr5yhvIde2rAd0FvXxPLROvTDJg==
X-Received: by 2002:aa7:c9c9:: with SMTP id i9mr3317774edt.166.1589055896657;
        Sat, 09 May 2020 13:24:56 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id r4sm612641ejz.28.2020.05.09.13.24.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 13:24:56 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id nv1so4372240ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 13:24:56 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr5604536lji.201.1589055429344;
 Sat, 09 May 2020 13:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87eerszyim.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87eerszyim.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 13:16:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=0nAA9qGAogiFjpf0oCDcjkQE-u6umWCW-PkhrC8jrQ@mail.gmail.com>
Message-ID: <CAHk-=wg=0nAA9qGAogiFjpf0oCDcjkQE-u6umWCW-PkhrC8jrQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 12:45 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Instead of recursing in search_binary_handler have the methods that
> would recurse return a positive value, and simply loop in exec_binprm.
>
> This is a trivial change as all of the methods that would recurse do
> so as effectively the last thing they do.   Making this a trivial code
> change.

Looks good.

I'd suggest doing that loop slightly differently:

> -       ret = search_binary_handler(bprm);
> +       do {
> +               depth++;
> +               ret = search_binary_handler(bprm);
> +               /* This allows 4 levels of binfmt rewrites before failing hard. */
> +               if ((ret > 0) && (depth > 5))
> +                       ret = -ELOOP;
> +       } while (ret > 0);
>          if (ret >= 0) {

That's really an odd way to write this.

So honestly, if "ret < 0", then we can just return directly.

So I think would make much more sense to do this loop something like

        for (depth = 0; depth < 5; depth++) {
                int ret;

                ret = search_binary_handler(bprm);
                if (ret < 0)
                        return ret;

                /* Continue searching for the next binary handler? */
                if (ret > 0)
                        continue;

                /* Success! */
                audit_bprm(bprm);
                trace_sched_process_exec(current, old_pid, bprm);
                ptrace_event(PTRACE_EVENT_EXEC, old_vpid);
                proc_exec_connector(current);
                return 0;
        }
        return -ELOOP;

(if I read the logic of exec_binprm() right - I might have missed something).

                Linus
