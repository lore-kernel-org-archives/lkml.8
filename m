Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9DFC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 03:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2479E20714
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 03:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jR3JPOmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgBIDKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 22:10:13 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38047 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgBIDKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 22:10:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id z19so166387qkj.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 19:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=RgNOxX3qIQt6rj8+VVAfn54DI3bpWN6kUqMJ9GcZIT8=;
        b=jR3JPOmVnhLkZ3Eiwv/dxyZA08RRlVvuipzSv7BETbP0yQISUfrqfrQQaDe6BUTl/8
         V31RKNRgmvwHah3dFmG9heqsvA59RSYTgA6OA0eF/jgTqXtTtPZSh1DG3YmrnYf8apmO
         p4uov0Ur2LubH7l1ixGbNqyZjQotjHmVLJj2D74/Em+1CkgDjF3wUJ4ZTSYRNH2nyIMK
         IAGbNMGWtDei4k+rz5j50bdrsEVWTaCw4McKtrDAwX2Ga94PG215lGvwbspqxrOa3CCH
         qeEdEx4T95V3mYKhFhSZpTPJdA7wm11GoU6f/EdEj54fpThQAWB58YyyvECL2ck01vVH
         6iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=RgNOxX3qIQt6rj8+VVAfn54DI3bpWN6kUqMJ9GcZIT8=;
        b=PK1kGeXbviLukBWJSkGiTQRrg2Nu6dFzTPbF7TFXpoGsmhyghLfw4NG6knVd51XY2V
         r72YYjPCRLVVAvejx77PzXHQS4dgfEKGXKlmSeX6oQjItt1DIi3pMbAet80FbvDODWwL
         cnDzTTBsVlz588TWjD6MvJtI+obEx+aRAG03mH+RiISEruFQjLZv/P9p0cpGBmm0GwPw
         uyJlPn9vGD8dtEndGNRn1inydndgprecL4mVvWQCM+wT7caiFcftxCA5lnKE8K24pA+I
         UdrQ1ZQmXMNGXVm5W+lsNgshwfmzBkTMc92yv0qCkS/npM4TKpfXfGvm9scZguBsAUi0
         sT+Q==
X-Gm-Message-State: APjAAAUiYj/e0YOK9jBD1EA01nQYS6czfKLyCHSBfl+owyUq7QdF3rAE
        OtKWqCjte8TSGxDVKI1UqG1/TQ==
X-Google-Smtp-Source: APXvYqxnRXFBAMU/FDNtZNSv88E2AijpM9Uzm2+ZOT8S1dyIUT96Bi3jAMSvdQZVaG8O+tgTtQv/dg==
X-Received: by 2002:a37:9c8f:: with SMTP id f137mr5543455qke.276.1581217810409;
        Sat, 08 Feb 2020 19:10:10 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m204sm3796237qke.35.2020.02.08.19.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 19:10:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: fix a data race in put_page()
Date:   Sat, 8 Feb 2020 22:10:09 -0500
Message-Id: <8602A57D-B420-489C-89CC-23D096014C47@lca.pw>
References: <5402183a-2372-b442-84d3-c28fb59fa7af@nvidia.com>
Cc:     Marco Elver <elver@google.com>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, ira.weiny@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <5402183a-2372-b442-84d3-c28fb59fa7af@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 8, 2020, at 8:44 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>=20
> So it looks like we're probably stuck with having to annotate the code. Gi=
ven
> that, there is a balance between how many macros, and how much commenting.=
 For
> example, if there is a single macro (data_race, for example), then we'll n=
eed to
> add comments for the various cases, explaining which data_race situation i=
s=20
> happening.

On the other hand, it is perfect fine of not commenting on each data_race() t=
hat most of times, people could run git blame to learn more details. Actuall=
y, no maintainers from various of subsystems asked for commenting so far.

>=20
> That's still true, but to a lesser extent if more macros are added. In thi=
s case,
> I suspect that READ_BITS() makes the commenting easier and shorter. So I'd=
 tentatively
> lead towards adding it, but what do others on the list think?

Even read bits could be dangerous from data races and confusing at best, so I=
 am not really sure what the value of introducing this new macro. People who=
 like to understand it correctly still need to read the commit logs.

This flags->zonenum is such a special case that I don=E2=80=99t really see i=
t regularly for the last few weeks digging KCSAN reports, so even if it is w=
orth adding READ_BITS(), there are more equally important macros need to be a=
dded together to be useful initially. For example, HARMLESS_COUNTERS(), READ=
_SINGLE_BIT(), READ_IMMUTATABLE_BITS() etc which Linus said exactly wanted t=
o avoid.=
