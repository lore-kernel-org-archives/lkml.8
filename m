Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F2FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7594720801
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="tsoc9/qU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgFKOT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFKOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:19:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12945C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:19:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y17so2375160plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xBaF+w6LnZVzJq3FVqNA7JT76VY8RlPchNLooih4/Ww=;
        b=tsoc9/qU8zBQKtmUoZ6DWf09hKxrSujxH/3HNog5hexqWofv5GkpN6gd7V+FPuwaRK
         DttX6/hgGOuUcewWly2LE09+/g1ULXkcC2fS6j0/A+4C8pd4bzx37CEhF0rNrc9guytH
         yPstRNa0kDLHC6NhauC2ET5IbSHyk3MMwwGd77AuQaOndkEpkiAQ3Xi8gKu0o7raRxJW
         wYkgbJ1MlQNrKdvsYKqriLim/UunGst9o5bY1MGnEz481F4U3OcYXvP3hQbGXgX4iIs+
         sSZZNDkRbOGQh3uEzq9pj5pGzusRVucF2EYeWB+F85gElVTQl/so5GU1yHGjq6Vf3Wj9
         JFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xBaF+w6LnZVzJq3FVqNA7JT76VY8RlPchNLooih4/Ww=;
        b=RpROUECDxmQOxGRriJ5O5mDof8Wt0Uyav2jUkXBkSh7I7Z5m2uyeytAZrFg37fx66h
         LAvF2brx4tnzYR5IgLTemkkSzTBr4LUSCAvAiTZBt3jCW66wEPhKRLTV0oswBUoH+w7F
         PVarP8Kuhpbq0EAWBSzSaJgAtREuIF1g6q84pzIFvNc451MKYSKJGtOzn62SkXllV/2V
         qq60iU6uaKR56xNO+mi563eYR2e9ukV4uXYKUryCu/Zjj3mA2V7kaXD81PX4425Wa6xl
         QfIcJ3k//3A+7Sr2ZyqsoyQaeO4C9rS5S8DkE85vG++mObrmGvfHWbkRH5ADR91lxM/Q
         QDXg==
X-Gm-Message-State: AOAM530+tx4banLziWww3GOlt4p9vDtA0PXEaYyjVW6J7dn8CZLlFTR5
        zjDsYcfbW872LnxIZqNeDhEeXg==
X-Google-Smtp-Source: ABdhPJykW8l0KeT06XcVC73Wf1HaWXi48P4QxNNErccsMyHTWP3GQEDs9YSoa+LVaVQQww7aEgMBNw==
X-Received: by 2002:a17:902:7d89:: with SMTP id a9mr7206240plm.309.1591885195577;
        Thu, 11 Jun 2020 07:19:55 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:fca7:1989:2b32:63f0? ([2601:646:c200:1ef2:fca7:1989:2b32:63f0])
        by smtp.gmail.com with ESMTPSA id a12sm2616306pfr.44.2020.06.11.07.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 07:19:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
Date:   Thu, 11 Jun 2020 07:19:53 -0700
Message-Id: <301D30B5-26F7-454B-8C0C-A5DFC73222CF@amacapital.net>
References: <20200611091822.GA30352@zn.tnic>
Cc:     Petteri Aimonen <jpa@git.mail.kapsi.fi>,
        Andy Lutomirski <luto@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20200611091822.GA30352@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 11, 2020, at 2:18 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFOn Thu, Jun 11, 2020 at 10:36:08AM +0300, Petteri Aimonen wrote:
>> Hi,
>>=20
>>> How about putting the file you frob in
>>> /sys/kernel/debug/selftest_helpers/something_or_other.  The idea would
>>> be that /sys/kernel/debug/selftest_helpers would be a general place
>>> for kernel helpers needed to make selftests work.
>>=20
>> Seems like this is the consensus for now.
>>=20
>> Any opinions on whether the module should remove "selftest_helpers"
>> directory on unloading, or not?
>>=20
>> 1) Removing would break if other test modules will use the same dir.
>> 2) Not removing will leave the directory dangling.
>> 3) Remove only if empty is one option, though I'm unsure how to
>>   cleanly check if debugfs directory is empty.
>> 4) E.g. /sys/kernel/debug/x86/ is created centrally and a symbol is
>>   exported for its dentry. But I'm not sure if it really makes sense
>>   to add another exported symbol just for selftest_helpers.
>=20
> I'd say you do the simple thing and cleanup after you're done, i.e.,
> remove the dir. When something else starts using it, then it would need
> to be taught to deal with multiple users.

Seems good to me. Let=E2=80=99s have at least two users before we go nuts wi=
th the architecture :)

>=20
> Thx.
>=20
> --=20
> Regards/Gruss,
>    Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette
