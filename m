Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA01C35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A435C20725
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NsTphQo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgEGWHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgEGWHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:07:44 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C178C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 15:07:44 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i68so6254830qtb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=en4GHRy/JYPyqA5v6A21rwrH4iUeiYDglj3PCm7zaTE=;
        b=NsTphQo3KrIot3EHRR9MKfhiB8/WsOHq01/hLgkb+H//7PrOqvCj5NTxbnaFUnfyCm
         0iwuvrNpoPVetfRb67BNbjybK6/uoNcUveymSiiNlXA45tEK0EtsQ5rzNJPrjzwGfrNZ
         RYuwS6foMYX9JtD8p/lE+cd5djCyYEqiAn3kIIyUNO+d5VF1/CTPg8jdMFLrI6/DZ95k
         OEh0TDXAiOnZ7ahcPGDPGCQcFv2LK27gK0aLjSyXsAk46ZO2MfZ0r/v4SpluZNwKJAUM
         2mQyVIqlXMDWClY69c2WULVjuPG+YFgSDAi+ZsWeevurvhZ45jn6p8zAOo30BIB1h9Sa
         LxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=en4GHRy/JYPyqA5v6A21rwrH4iUeiYDglj3PCm7zaTE=;
        b=Ohpgwo+mekmWgOQWkxiD+4hniSnlTEYM6Fz72fR8k7RRSAh81sp39J9YEigTkU8wri
         9ifGku9NaZPdLImJeEdDMMu/hrelZNK0RfEvBzi3n8Tx9HxWhX8Zni12QwCYw3qWfgWw
         EC8cdWDy6JD4rP+SQP02lepKcIf3UgBQTlD92WocepXTv9L2eAS2cpgZJ5tjFw5QG1Ps
         8HA3fy61pLd/WeFo7Gw+XThRprerkkEEuSyEyfMtUv92WTemASlXZhkwG5ygpjsMMlT1
         XDcZzi7Re64II2Gx9aON+49nYewQpceVjFQYt0wa6xp2rbpB+nev8TY/kIp50r5AvabT
         cgWg==
X-Gm-Message-State: AGi0PuZcEKZFGuPT7/GAsoCUtPMhOEWiBP+O0FFTWoIYl3r5S2hVeJOq
        zChgkyHvw9u7C8B3OYWJ7wYdWQ==
X-Google-Smtp-Source: APiQypLmtknqWg6mIBNX7BYpFLD0P6MpzAP9oT8r+HqSraCfQP4KlBhA65zzanXtvuiNlwwIZjxRSw==
X-Received: by 2002:aed:2dc1:: with SMTP id i59mr16899053qtd.182.1588889263247;
        Thu, 07 May 2020 15:07:43 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 10sm6045321qtp.4.2020.05.07.15.07.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 15:07:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] kernel: add panic_on_taint
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200507204219.GJ205881@optiplex-lnx>
Date:   Thu, 7 May 2020 18:05:27 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <27AA744E-930A-492A-BE87-05A119FE1549@lca.pw>
References: <20200506222815.274570-1-aquini@redhat.com>
 <C5E11731-5503-45CC-9F72-41E8863ACD27@lca.pw>
 <20200507204219.GJ205881@optiplex-lnx>
To:     Rafael Aquini <aquini@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 7, 2020, at 4:42 PM, Rafael Aquini <aquini@redhat.com> wrote:
>=20
> On Wed, May 06, 2020 at 10:50:19PM -0400, Qian Cai wrote:
>>=20
>>=20
>>> On May 6, 2020, at 6:28 PM, Rafael Aquini <aquini@redhat.com> wrote:
>>>=20
>>> Analogously to the introduction of panic_on_warn, this patch
>>> introduces a kernel option named panic_on_taint in order to
>>> provide a simple and generic way to stop execution and catch
>>> a coredump when the kernel gets tainted by any given taint flag.
>>>=20
>>> This is useful for debugging sessions as it avoids rebuilding
>>> the kernel to explicitly add calls to panic() or BUG() into
>>> code sites that introduce the taint flags of interest.
>>> Another, perhaps less frequent, use for this option would be
>>> as a mean for assuring a security policy (in paranoid mode)
>>> case where no single taint is allowed for the running system.
>>=20
>> Andrew, you can drop the patch below from -mm now because that one is =
now obsolete,
>>=20
>> mm-slub-add-panic_on_error-to-the-debug-facilities.patch
>>=20
> Please, don't drop it yet. I'll send a patch to get rid of the bits,
> once this one gets accepted, if it gets accepted.

Why do you ever want that obsolete patch even show up in linux-next to =
potentailly waste other people/bots time to test it and develop things =
on top of it?=
