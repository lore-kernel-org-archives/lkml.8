Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDCFC433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC6D206F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Jw7bbZnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgGULKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbgGULKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:10:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2738C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:10:16 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u64so5579305qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=H3jGQ+Q00bEAjs/SzGOhSf6h7ixnLICnjJ2zv+AV0Gw=;
        b=Jw7bbZnWwO2y5HGZtUYeJffra6s0naaeIP+Owlmy84iwUEIE20sjMU91V65yCcT/M4
         pxAcmFWWfFryF4HAg88/jRfyf2zGat2j2AI3TYZFTuP0mkY4dsQiwzKUCNPkMAfcHeff
         MdJM2UTj8CnVmynB1uTwpherDk6MvGTrt9RSDDsfVpQ1WI/kv1DHLInxl4mWGJJZmGNe
         C1Di1kOWFeFAS46Bcmz7Ok66rvO3ReXayFqSNwxt0dUhnmVSsRocluzpAiXgmU8Wien2
         TliC0rP2g6tue7tGcR7nLMjd+K3B2Qd8jdvB7JRa/MsozXLauIEtsx4k7EQwNGuSt8r/
         5PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=H3jGQ+Q00bEAjs/SzGOhSf6h7ixnLICnjJ2zv+AV0Gw=;
        b=lSXvyb575J2fiF8jAA4XTNv2gblhx4vxf1frlgQIqQDAM2PR1IQ6Q1tAYJK2RGI1u/
         BqGDhAmr3FeWR8Ag19mxo/9dFykc3vVhQppgAaUhMr6GQX1NFz2sCOxIdM8mLCLCzzhp
         p++QlU209QtEFdW1YLrWZGgyUMsq7iG8K1v3iubGlEXYRygzzO2uuTQSkBueurA4xr1o
         t7hWkfXq/FCH7t3Sv2WKxmz0QERDiWcfAk0fNO/4p74yOunxk73MplNYpzW8OlmKYnEH
         diP93MlNKcpff1QuQxbKr98Q9eQwCguctz6cXDrMeJPqACqtw8fk9luiKiAK99IEnqz5
         qpIg==
X-Gm-Message-State: AOAM530yYxLPqSp1T0LylC2hPKWbValuYEuVJoIYuS/12NcFUsFcNahM
        9AByVf+SmZRbft4tBoHlz8pbnQ==
X-Google-Smtp-Source: ABdhPJxY+MZ+2vyW+b7sxJZ2xM5AByPkCXheZ4c7LNt34yH68P/80cKmIIKlv/SGCoh1nUbZBWdN4Q==
X-Received: by 2002:a05:620a:16c8:: with SMTP id a8mr2560369qkn.81.1595329816067;
        Tue, 21 Jul 2020 04:10:16 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i10sm2602684qkn.126.2020.07.21.04.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 04:10:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Date:   Tue, 21 Jul 2020 07:10:14 -0400
Message-Id: <FCC3EB2D-9F11-4E9E-88F4-40B2926B35CC@lca.pw>
References: <20200721063258.17140-1-mhocko@kernel.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
In-Reply-To: <20200721063258.17140-1-mhocko@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 21, 2020, at 2:33 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> on a large ppc machine. The very likely cause is a suboptimal
> configuration when systed-udev spawns way too many workders to bring the
> system up.

This is strange. The problem description is missing quite a few important de=
tails. For example, what systems exactly are those? How many CPUs, memory an=
d NUMA nodes were you talking about? Which kernel version was it reported? H=
ow many workers from systemd-udev was =E2=80=9Cmisconfigured=E2=80=9D?=
