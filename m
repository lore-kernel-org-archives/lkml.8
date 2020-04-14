Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781A1C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455B92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IFOXCWbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439743AbgDNL70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729583AbgDNL7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:59:19 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40462C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 04:59:19 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di6so313135qvb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=7+NC2RpkOf2SbI98FY1bSeaxQhjq9j8fWNpYmPilqT8=;
        b=IFOXCWbMzuDssZf6ycLUgkISxSiuf2CsSXEDQa2VAVyFmZsNGExERsa00yDBMwSY1u
         AMmX6M9VsTB3/0M3DwP5yHf0eyMfoJ4WF0qfdGvlttTqQ40phwndif0orRYexZKyDvU4
         /7SO8EaeSuU7esDAGWAL053wWZIQE6yJuoxt8mRJL1q6YqRpDsUBcezr5WOKqNmbvPJw
         q4wGqo2q8tGjDrY1OlrkUQZ/7yIdjXpXlqjX5r2e4QPt4deHgTb14RIQ+NCcqQvqYS2C
         9cOMkruOoLt36q/jfbJdbbVHSICik7pnsHoHhbyE+6wJBT2F2SIWfFFFKH182uzdhRlw
         FbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=7+NC2RpkOf2SbI98FY1bSeaxQhjq9j8fWNpYmPilqT8=;
        b=AKkV0kw+KtXcNtpYvyz957slLfwfoprDuRhLA1HVvlcUj8gCkcO0oK9azITAnlvzjH
         9f+f7htAp6GtCFFnGpCnN8Zev9duIMJlhF3KkufqNSY+jpotHm6OhidQMY26TqJE7DCO
         8sixH69MKhd5JBm5LCZpxtpeZ6WepuZ8uMY/Ib5LL2luinT8DUMhbINMEoMn21NofV4M
         +yxohm3kPqJDXIRGw4i6rZbyyaMVTszKzYbrc9DM8Th62AniwfwhQ/usooZmL/KuI4Ys
         80o1iXH6jJa+DNoN+AlvGR3x/L9KmygrC4ex+Dk4ows+DHmEpEEI4fTV3BjK8p0WwW27
         8hpw==
X-Gm-Message-State: AGi0Pubu3G/bVSIHPNxMWjx7HUiLiNBab5bzvp3eKY9M/BzHJZcIj77p
        WRkujDyTLZBZTtiW7TasRCYL2A==
X-Google-Smtp-Source: APiQypIGjOUH2uNHcQKWvPdZOxNKnIpWBKuay8+N4jyECDb2JDTqdXtv2gfs5yNy3EBgAH4Dam+RHA==
X-Received: by 2002:ad4:548b:: with SMTP id q11mr7157656qvy.129.1586865558333;
        Tue, 14 Apr 2020 04:59:18 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id w27sm10924164qtc.18.2020.04.14.04.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 04:59:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Date:   Tue, 14 Apr 2020 07:59:16 -0400
Message-Id: <04E78431-7B62-4FA1-8B1D-51DF7648D9C5@lca.pw>
References: <CACT4Y+ZE1XhYpTsjP1J1PyUsEHYKvchww71aHb7UnSk5=4xUrw@mail.gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Rue <dan.rue@linaro.org>
In-Reply-To: <CACT4Y+ZE1XhYpTsjP1J1PyUsEHYKvchww71aHb7UnSk5=4xUrw@mail.gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 14, 2020, at 7:13 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>=20
> How do these use-after-free's and locking bugs get past the
> unit-testing systems (which syzbot is not) and remain unnoticed for so
> long?...
> syzbot uses the dumbest VMs (GCE), so everything it triggers during
> boot should be triggerable pretty much everywhere.

There are many reasons that any early testing would not be able to catch ALL=
 the syzbot blockers.

The Kconfigs are different. For example, I don=E2=80=99t have openvswitch en=
abled, so would miss that ovs rcu-list lockdep warning. Same for that use-af=
ter-free in net/bluetooth and a warning in sound subsystem.

But, notifying Linux-next ML is a good start, so at least we could ask Paul o=
r Steve to pull out the commit which enabling rcu-list debugging by default w=
ith PROVE_RCU.

I learned through that restricted kconfig to some degree of minimal could sa=
ve a lot of troubles late on especially those options that I have no way to e=
xercise like net/bluetooth and sound currently. It is going to be extra work=
s though because those default options in Linux-next or even defconfigs are n=
ot always pleasant and would want to enable something I don=E2=80=99t need i=
f not given human intervention.=
