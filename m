Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16059C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99B1206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="X9PKelU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgDUQtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbgDUQtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:49:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15264C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:49:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p25so6817432pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=aXQ+tKv7yM2RIdO+2j+mqBkH0iRU4y4xiq34PtotHKs=;
        b=X9PKelU8PsBWVvU2kKie6jeG7Kg+HQDOJ1W+XXPckx3ZxWu9ot+AxGTPpPiAzm6joe
         OO7PAaQiKmo1+E0g4p+qhDG1+tGmCsBofXbALtmfoX5IwuVrWU5aaUQY5G+H3jmRxGz+
         gSVK6urVF1ru6waw9TUDhHVnVTgVWcmHMAA2nAENjXBln45jqOaeyHquXoxWKp3olDjc
         MHqMJGqMD6c0wxChF4AZ7Q6byaMLyPE5VCEpoqob0OusggJtdtyKAH1Kd0YGegq8iSyI
         OudFw5jVvtrSTnWzayBKbbE111meBF2L6IAicQp4o4IHfumhJN4orQfS36Wfc9NJ5MJk
         Efag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=aXQ+tKv7yM2RIdO+2j+mqBkH0iRU4y4xiq34PtotHKs=;
        b=bUPY6hquvCOAO7BuW15lGYo3w7Le8VgBmQ5HdvbMPNlNiiR+8Mi3OoMsWZQM3sZKaE
         KvOT59jXBJwg728En5CWBgaqpE22pJpQL+FJp9uRYHwCBWHmFS9k2nCO1toz0CpeltPO
         OJ4Z0bS2kZNJhgC77I34v5tPrfAQCHgpo8MJmR+5RQFwGQTVPjsMIyDkjXpnzUu/Objo
         OosZzPVvsaabA2/KMwlmISA7/stWozMNZHegunmqeaurO2WNICurj9OmaBIH5KOwDUM1
         xfKPAoOCSWRuOb4y2V/lEfQjypr96aJRqmyzpC4goRi+069lI6kWYXfaT25eYOf1LM7D
         4+Lw==
X-Gm-Message-State: AGi0PuZNdUTIC8o61mf0+7LphImJHmc1wunWLcMLPUEN9IwfYFrhtIiY
        HNQqGS8HWCNyJUNOCgIB/tcC1w==
X-Google-Smtp-Source: APiQypIKxYU5yhAEqu05C3uXIhNkFvi2mbuTQUzu1zMuiUmsTm3CiToG9DmAArRlohHoZD285nmZFg==
X-Received: by 2002:a62:ce82:: with SMTP id y124mr22944903pfg.69.1587487753474;
        Tue, 21 Apr 2020 09:49:13 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:5127:6b53:f5db:198? ([2601:646:c200:1ef2:5127:6b53:f5db:198])
        by smtp.gmail.com with ESMTPSA id 1sm2929595pff.180.2020.04.21.09.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 09:49:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Date:   Tue, 21 Apr 2020 09:49:11 -0700
Message-Id: <BB51CFEA-A635-4664-821C-B57094AE95F0@amacapital.net>
References: <20200421160622.GJ1809@sasha-vm>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421160622.GJ1809@sasha-vm>
To:     Sasha Levin <sashal@kernel.org>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 21, 2020, at 9:06 AM, Sasha Levin <sashal@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Apr 20, 2020 at 07:14:46PM +0200, Thomas Gleixner wrote:
>> Andi Kleen <ak@linux.intel.com> writes:
>>>> the *gdb developers* don't care.  But gdb isn't exactly a good example
>>>> of a piece of software that tries to work correctly when dealing with
>>>> unusual software.  Maybe other things like rr will care more.  It
>>>=20
>>> rr is used to replay modern software, and modern software
>>> doesn't care about selectors, thus rr doesn't care either.
>>>=20
>>> Please stop the FUD.
>>=20
>> There is absolutely no FUD. Being careful about not breaking existing
>> user space is a legitimate request.
>>=20
>> It's up to those who change the ABI to prove that it does not matter and
>> not up to the maintainers to figure it out.
>=20
> I think that this is a difficult ask; "prove that god doesn't exist".
>=20
> Andi's point is that there is no known user it breaks, and the Intel
> folks did some digging into potential users who might be affected by
> this, including 'rr' brought up by Andy, and concluded that there won't
> be breakage as a result of this patchset:
>=20
>    https://mail.mozilla.org/pipermail/rr-dev/2018-March/000616.html
>=20
> Sure, if you poke at it you could see a behavior change, but is there
> an actual user that will be affected by it? I suspect not.
>=20
>> This sits in limbo for months now just because Intel doesn't get it's
>> homework done.
>>=20
>> Stop making false accusations and provide factual information instead.
>=20
> If there's no known user that will be broken here, can we consider
> merging this to be disabled by default and let distros try it out? This
> will let us find these users while providing an easy way to work around
> the problem.

No.  Once it=E2=80=99s merged, people will write user code using the ABI, an=
d that means we need to get the ABI right.

The very early versions had severely problematic ABIs. The new ones are prob=
ably okay except for, maybe, ptrace.  If we had merged the old ones, then we=
 might have gotten stuck with the old, problematic ABI.

>=20
> --=20
> Thanks,
> Sasha
