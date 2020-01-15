Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86360C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDC524656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Iy8ExdmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAOS2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:28:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40327 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgAOS2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:28:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id v25so16629632qto.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ud9sKkESHZCvlOGq+OII/g18ehi1Yr+QEsKY+qUAW/c=;
        b=Iy8ExdmKNNKeOPRDcBp3UY9/M0kErvkEBHObzl6AB6V14bSPS8o1UyZ48UBsz75qZ+
         PcjRe/WEMMJo+/zE/INIotPn2cJksHCM05RloFyznyM03VCSBVrHQTwoqA/VexVNE3HG
         ervRpyujz/CLVCn7+1Poj2J2uxcbUPkzW/KmuNnvt1P8LAZq/OhezBdDqBk/f84X/5g9
         PCeCewOASgCIGuuHOFVCtRYPJm7oIPJegdK/R7vKD9q6E4soIPbYNwDbnuhWRVS0su1R
         3GglFHMz5aokGbceRwIUUsKh6tGw+52KJqD8HuD48PRlfrkmkZvWrgMmTVd/ZfaATFod
         zpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ud9sKkESHZCvlOGq+OII/g18ehi1Yr+QEsKY+qUAW/c=;
        b=MwrkQgOtX7SYAvHcI5FQUqA1oG3BWWiliyKk0B3gSLHlqJ6z8CYhExVoNBCPf/OdTA
         GthPkZQRaTC2TMf4wCQclmb0xXodk2jJOxS1SkjDHNbsouiy+T5AkrHorMrKJn9kujsu
         1vJIspCmSaQOCqltQMUX2ZWJaxybCzeHcxidpM/5DUYTEUVR2YHMLYosTCYuODgl2b2p
         zXiKd2DHRdGYKoS4fiyo3jAhMoE1RZCOnwRdZJ01vaaMa5+JGqEzno2QYh627ui97B0o
         nd38SsEd42sWTKcH544T/CViM+rzUsTvlG8K/0lfHFp+lWMGdjLsezbR55s6QeAFtlIw
         aEUg==
X-Gm-Message-State: APjAAAXbuZ8JHF6jSIQzpBnCzefuqD6wAo17t32C3XIjxpOaZygrkMsv
        SByyJRcgL7LfXCgn23S5itcWaw==
X-Google-Smtp-Source: APXvYqyFqyexR7OAogh9jzo/cgEw1VMYGtAqIm3elkgWOkibsmXAJwDgFqg1kLrybKlF4YY+tVD3lQ==
X-Received: by 2002:aed:3c52:: with SMTP id u18mr4964380qte.382.1579112879921;
        Wed, 15 Jan 2020 10:27:59 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b24sm9784122qto.71.2020.01.15.10.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:27:59 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] mm/vmscan: remove prefetch_prev_lru_page
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200115082947.GA21018@infradead.org>
Date:   Wed, 15 Jan 2020 13:27:57 -0500
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5F5B735-2BEA-4B9D-8939-B24B9D9AA940@lca.pw>
References: <1579006500-127143-1-git-send-email-alex.shi@linux.alibaba.com>
 <FC618797-2F5E-4F73-A244-0DC19AA1CB74@lca.pw>
 <20200115082947.GA21018@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 15, 2020, at 3:29 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
> On Tue, Jan 14, 2020 at 08:46:21AM -0500, Qian Cai wrote:
>>=20
>>=20
>>> On Jan 14, 2020, at 7:55 AM, Alex Shi <alex.shi@linux.alibaba.com> =
wrote:
>>>=20
>>> This macro are never used in git history. So better to remove.
>>=20
>> When removing unused thingy, it is important to figure out which =
commit introduced it in the first place and Cc the relevant people in =
that commit.
>=20
> No, it isn't.  It is at best nice to have, but for a trivial macro
> really doesn't matter.

A more of personal taste what the trivial macro is. I=E2=80=99d rather =
be on the caution side
when removing code especially nowaday developers may not even compile
test the patch properly given how many arches we have here which will =
only waste
time on other people when things goes wrong.=
