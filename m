Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C6FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D667C2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="0Nl6Ipet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405987AbgE1SiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405786AbgE1SiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:38:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9204C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:38:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh7so5053260plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=+s1IaVbmnL9yBRcZ3BjJ3ucj5/q4zxOlTyNgvpB+MwY=;
        b=0Nl6IpetJJlL2sY/xdUrtiGf71qCqKaMz3tYwG0BjLShyZFuWH3MzGQgD05EWh8Ki8
         1CwnGi3TFGVjxMg/fK9XJlA9N2ExT5nYc3g+MJkaYSTy639r4LxBWQZ2jDAoOJ8Tg2jn
         G+skcjEedXqRJ+VRDnL2vtJdSh8T9MHVN0SvBUrmtzCTfnG2UpGejhCjBoAXmCWnvTi+
         x0gpLK11fRau3FTi9e2fGJ51AP7Z+92Gv9BYKDKBIZODOhJxrTG8zo5+er8AT6Db9v08
         Xgere7E42Z3/7kxWz68YHFqtTSx/aNIYb+AKpfjnHcr9NcdlMiqurbhwxeFeOlNOgNQT
         GNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+s1IaVbmnL9yBRcZ3BjJ3ucj5/q4zxOlTyNgvpB+MwY=;
        b=TQHvoWb7a4UL2pT0AIbPvc0NVVKdWqxbgYe2IJMiOQ7hb8T8hj4kGgD1cjdjFsRmMr
         M+mmZKpGNPyZTWGEviQ7ncBUiBvdD0urH/y/whLkJDhH92K/EQ4aTqczsY4DHzUfKGe4
         HE9bHMz7zFj/objGhQUf0Be7z8Dwmx3RM3+GO7jtyW+NVtWlJkCMChlZ93MWQkiyRGaA
         vGAqII0BNcLMQMMCHTiM3m86bSb0YXKID/Mra4jO6amFUP38X6fc3ZUyha6XSJ9q8fdU
         VCldPpWod0a7rCfCLIYlAXWb5NJwUq2WBInfHgFgdvki7iuR09pBrVGXmclPrDMDDxEj
         TneA==
X-Gm-Message-State: AOAM530MbrDVvnClQMaanaxmlS9vXVE6T804dC7FIcz0nrCP9yj8e2/d
        3RY2QPyhpmBt6XdzKhQC6WqQvw==
X-Google-Smtp-Source: ABdhPJyM7C3Oox9ZE5dQwghEseeqHdY1i0Kbp/kZqkxtjWNV6S40kso18zAIiU5+94/1wOhze+nIog==
X-Received: by 2002:a17:90a:950d:: with SMTP id t13mr5580197pjo.102.1590691086116;
        Thu, 28 May 2020 11:38:06 -0700 (PDT)
Received: from [192.168.86.238] (c-73-170-200-117.hsd1.ca.comcast.net. [73.170.200.117])
        by smtp.gmail.com with ESMTPSA id j26sm5378855pfr.215.2020.05.28.11.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 11:38:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Date:   Thu, 28 May 2020 11:38:01 -0700
Message-Id: <7A3EBAB0-B3B3-4CB7-AA6A-FDF29D03E30D@amacapital.net>
References: <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
In-Reply-To: <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
To:     Don Porter <porter@cs.unc.edu>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 28, 2020, at 10:40 AM, Don Porter <porter@cs.unc.edu> wrote:
>=20
> =EF=BB=BFHi Thomas,
>=20
> On 5/28/20 6:29 AM, Thomas Gleixner wrote:
>>> Until recently, we were doing proof-of-concept research, not product
>>> development, and there are limited hours in the day.  I also hasten to
>>> say that the product of research is an article, the software artifact
>>> serves as documentation of the experiment.  In contrast, the product of
>>> software development is software.  It takes significant time and effort
>>> to convert one to the other.  Upstreaming code is of little scientific
>>> interest.  But things have changed for our project; we had no users in
>>> 2015 and we are now un-cutting corners that are appropriate for research=

>>> but inappropriate for production.  For a research artifact with an
>>> audience that knew the risks, we shipped a module because it was easier
>>> to maintain and install than a kernel patch.
>> I understand that and with a big fat warning and documentation from
>> start I wouldn't have complained so vehemently.
>=20
> This is a fair point.  We will fix this ASAP, and I will be more careful a=
bout this going forward.
>=20
>>=20
>> Sorry for that innuendo. Now that my anger and general frustration about
>> this whole disaster have calmed down, I surely would not write that
>> again.
>=20
> I appreciate you saying so.  Thank you.
>=20
> I can also understand how frustrating the history was with this feature, a=
nd we missed an opportunity to help sooner.  There is a lot I still don't un=
derstand about the process of merging and testing patches in this community,=
 but if it makes sense for us to help now, we would be willing.
>=20
>=20

With my x86 hat on, I have no particular expectation that you would be famil=
iar with the particular problems wi TV FSGSBASE. One sequence that will kill=
 the kernel is to use WRGSBASE to load a negative value (e.g. ~0), then set E=
FLAGS.TF and do SYSENTER. I=E2=80=99m adding a test like this to the x86 sel=
ftests.

One useful test for the actual kernel patches would be to run your SGX workl=
oad on a loaded core.  That is, do
something like taskset -c 0 graphene_thing and, simultaneously, write a triv=
ial infinite loop program and run that under taskset -c 0 as well. For good m=
easure, you could have perf top or perf record running at the same time.  Lo=
ok for kernel errors, but also look for any evidence of your workload malfun=
ctioning.

=E2=80=94Andy=
