Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E606CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B0E205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HiS3C7pV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgEDUbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgEDUba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:31:30 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B7EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:31:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s3so15140479eji.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iD+7rCv19A+JVwng0cwm3/xzNCTcSEjwlIiYKk9uiJc=;
        b=HiS3C7pVeSXcrkb235oy8Rnf/oLD0dVimUKrLc0zeeW/8XaSu203SAaOKchrWyKAxB
         Z9MjsQPaSAO2yPuBjYFgCll5xe7kHNJ66BXwMCPOffizsuBNB4WoiJGbKqr5FhwcTWL7
         epoa3TmJlDVEJqejcAW8n4Y+bHuwSpRaBkCJvukLd7/UaCkLY284LPMrm4Zi12c1pzhr
         NaT85hv/kpIrmtLG5IGEUpvfHioRj+H3SlIznGgpN3pbXQJHmyiQC9brFJZ5pojQ1BO5
         t38dnwRBT5lNXIzdfhUd7Cjwjgfq3tsYfJfii92eTR/RTHyoxrcmjRtQwuTpRc5Lr46K
         c6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iD+7rCv19A+JVwng0cwm3/xzNCTcSEjwlIiYKk9uiJc=;
        b=VKDc/Xgv1ST0yfApraUM2ADRZW3ScoTJIf42AF9r6y3eXrcJvPICx6o/vBPzGv5gbl
         zBTyFwlFifGmvRekOZ9EVtADVZmBJNlDms+0NfNvC3wbx8VhYqTYmKmfWDS7QS5stBXJ
         IHOl4V5cMKDzJj0l2GMFKjWRVdyVlUarAlXC92cg8eTzAsJNXn1oKug1775sbKWhN33n
         15d4UU5G4ccWvM/BfHJIXdzRJ8hkAEsNdf17YFk6GRx+GviUWrhr+5jOsbLdcBXY4MVt
         nM16ZHxcM98aQOf19szXXg/VDvyTX0g/RAAHZZOHKCsAKlZWaB38dFFNoTNFI/e0yd/i
         GTbg==
X-Gm-Message-State: AGi0PuZXKi5fy+iC6Azs198PCBYC6R1TA+9NSmyLbMC6Vu7/mJaAshd9
        TQzn6u8boFwl7dyQG2XIJoWuw8WiuCFYSUIl2jQEdkWnMDo=
X-Google-Smtp-Source: APiQypLjLLzJYSGQHmzKy9PL7/vfCx8HEa61JRW6aeMlPHl9r7osDVCErguI8BiMvjtked5EcSIjQgppbgkYxYAopd4=
X-Received: by 2002:a17:906:49c7:: with SMTP id w7mr16855566ejv.29.1588624288649;
 Mon, 04 May 2020 13:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <20200502143555.543636-3-pasha.tatashin@soleen.com> <202005041222.4A870DFEC@keescook>
In-Reply-To: <202005041222.4A870DFEC@keescook>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 4 May 2020 16:30:52 -0400
Message-ID: <CA+CK2bDyi-vncYc0_sSZZ9Wb4O7oNUYH-6SN=-XKkeEamB8W8A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] pstore/ram: allow to dump kmesg during regular reboot
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -static void pstore_register_kmsg(void)
> > +static void pstore_register_kmsg(int dmesg_all)
> >  {
> > +     if (dmesg_all)
> > +             pstore_dumper.max_reason = KMSG_DUMP_MAX;
>
> So, I'd like to avoid any new arguments in the API and instead add a new
> field to struct pstore_info, which will be valid when PSTORE_FLAGS_DMESG
> is set, and the max kdump reason can be set there by the pstore backends.

Hi Kees,

I am trying to verify that I understand the request correctly:

1. pstore_register_kmsg() -> remove argument.
2. pstore_info -> add a new field  max_kmsg_reason: contains the
actual reason value
3. Modify: pstore_register() to set this field in pstore_dumper prior
to calling pstore_register_kmsg().
4. remove ramoops.dump_all boolean parameter
5. add a new parameter ramoops.max_reason integer variable, which will
be set in pstore_register_kmsg
6. Modify other users of pstore_register() to provide the correct
max_kmsg_reason.

Is this correct?

Thank you,
Pasha
