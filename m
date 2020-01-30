Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7942DC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F67720702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUsBAZ71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgA3Mfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:35:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36373 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3Mfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:35:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id g15so2964045otp.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 04:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JChikV2eDuxHeLtfwZM5oT2t0AhKhE72FILijwgC87M=;
        b=YUsBAZ71sBC1TVR1hKRZFi1hmpwB9zhsnlhdWL3ICTqBooSAMFFMXZbSBFSKgdRiRs
         2xsfHXBBEj7yGw0MZ0CGqRBIfoJlZVnnBAVwixr97b3sdPC7zE3bdgnIZiMsmjnl4kta
         7otz7uWSguPylhanlVvJmGvb9wkkGJn83byq0JK2qzqW2QxovIam5kWVILEYi++eLZgC
         3Bjd4uumjplegcu8AiADFuzxLn05QfbOtY/PhGncK+3qM6wwUm/c/CpY0o8suWm3UiMl
         3zkdHX1df6YOWpCuAAolzgzgxy3/itRkFubaSIbf2WSQVtTZWmGp5EfW8hnz0rWRvHCY
         /HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JChikV2eDuxHeLtfwZM5oT2t0AhKhE72FILijwgC87M=;
        b=ofKSCWH1oDofmbH5spCyGiuHrDix4c36ML5+645Aa0fRz2hE/C02tnzR1GczGt4RJ7
         zQbNAuLNSoVJGYJfdiHCPOXitu/DjpLZJefBVl0UPu7sYwaEwkXpVdnSxrhKiXRLeovO
         kI2Q0LvemHz/5Fthvb2fGWtEu74pBH8Mn3jFrIleZykhEU3jFmxbRz1/lT23TSEjeSXK
         5j0ztwdbpocXdK5hfZ3brni8KDLSUNeA8+i9cP+J4a43Nt4qSfCjNkAoFbvsckEAfcdQ
         4dOApLwk1TZXvV9xGxCMlk8oI87I0GSbnwYJSKAN2g95MCl5J9gdInXCmQWPW8gwmA3Y
         4Yrw==
X-Gm-Message-State: APjAAAUTlwKLd6CbSFuZnCCeuKWggec/EYtAql8bIEqHuctGG60PVzC5
        DFRkD8O+jkNpWM0fqOW8j+zMsSE/t77+OUQcRrSGXw==
X-Google-Smtp-Source: APXvYqxlMiItmIGzWpPjTehVgqmQudgnyMa5XuMeysm+8SBqlIDbsQDGlMs2wwGLilvOTimeqi4YyHBwdOczbyzWLKQ=
X-Received: by 2002:a9d:4711:: with SMTP id a17mr3422842otf.233.1580387729374;
 Thu, 30 Jan 2020 04:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20200130042011.GI6615@bombadil.infradead.org> <1135BD67-4CCB-4700-8150-44E7E323D385@lca.pw>
In-Reply-To: <1135BD67-4CCB-4700-8150-44E7E323D385@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Thu, 30 Jan 2020 13:35:18 +0100
Message-ID: <CANpmjNNr_Kq6Do+UYrR-3aF0sO3++psUfN7Ppt8mmgcF5ynzrA@mail.gmail.com>
Subject: Re: [PATCH] mm/util: fix a data race in __vm_enough_memory()
To:     Qian Cai <cai@lca.pw>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, dennis@kernel.org,
        tj@kernel.org, Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 at 12:50, Qian Cai <cai@lca.pw> wrote:
>
> > On Jan 29, 2020, at 11:20 PM, Matthew Wilcox <willy@infradead.org> wrot=
e:
> >
> > I'm really not a fan of exposing the internals of a percpu_counter outs=
ide
> > the percpu_counter.h file.  Why shouldn't this be fixed by putting the
> > READ_ONCE() inside percpu_counter_read()?
>
> It is because not all places suffer from a data race. For example, in __w=
b_update_bandwidth(), it was protected by a lock. I was a bit worry about b=
lindly adding READ_ONCE() inside percpu_counter_read() might has unexpected=
 side-effect. For example, it is unnecessary to have READ_ONCE() for a vola=
tile variable. So, I thought just to keep the change minimal with a trade o=
ff by exposing a bit internal details as you mentioned.
>
> However, I had also copied the percpu maintainers to see if they have any=
 preferences?

I would not add READ_ONCE to percpu_counter_read(), given the writes
(increments) are not atomic either, so not much is gained.

Notice that this is inside a WARN_ONCE, so you may argue that a data
race here doesn't matter to the correct behaviour of the system
(except if you have panic_on_warn on).

For the warning to trigger, vm_committed_as must decrease. Assume that
a data race (assuming bad compiler optimizations) can somehow
accomplish this, then the load or write must cause a transient value
to somehow be less than a stable value. My hypothesis is this is very
unlikely.

Given the fact this is a WARN_ONCE, and the fact that a transient
decrease in the value is unlikely, you may consider
'VM_WARN_ONCE(data_race(percpu_counter_read(&vm_committed_as)) <
...)'. That way you won't modify percpu_counter_read and still catch
unintended races elsewhere.

[ Note that the 'data_race()' macro is still only in -next, -tip, and -rcu.=
 ]

Thanks,
-- Marco
