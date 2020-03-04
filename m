Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AAEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278FB2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qNkSBjnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgCDLYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:24:54 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41142 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgCDLYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:24:53 -0500
Received: by mail-qk1-f194.google.com with SMTP id b5so1158327qkh.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 03:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=KmlYKKcnxp0xUf+Q/ijvadcck+k5qHRJOLBpEFhtRdg=;
        b=qNkSBjnf2aR6RgjanokMRTxLacwrp//7hYWYDDFAP2WDKFupuwuKnL4pNzwmR/f79g
         f44aqKSLTSTkJfMajw4oK59jHhmNXsBM6i15eGiQpAo8JQ5k36edLSh1zr+d3QcWPb6Q
         hekjzqeY5ksYVjTV+aohnmxcJcY/JhgKuWIC+gKVtWpgFnwJNXFA3bmNv3DMW5FK9fLH
         luVPyZU84Mg5ubOg0rMlYu9qb3ggaJuRuqeJPNJuAUOl1QW6vFupc/Zf6NeNhp2BSGvU
         mBu2De7n2MJHyQ0Q56KwzcNH9igajBHAyQaXnFZ8xBIJN/E5ZQlpJH7f9DaVFf2/sG7w
         W9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=KmlYKKcnxp0xUf+Q/ijvadcck+k5qHRJOLBpEFhtRdg=;
        b=jofp+UntObeV7bhHvPkEB1pcQeBzcbI8UiRFVoLz/XqK+xpRIrjyYss6h97xZzHIpk
         yi8Lkf5AAglgExwMis+oZo5QBBHWV2cG6ef9qoVBi5gfH116tCDDm11vwdkx6o0GP5JQ
         r47etK6b+NvsF4RohyR5g+Gc1P4K/TBWqokYf//oQYk5xz/tAOP/DDe+gzqAfs8u/3D+
         nMYtwH4oB53JgI6Sz78L7uKHKN6E7Gp9DiWzGMEkZiNY3EF7evOE5fSTL5ZGG2m2C2je
         y4oo7BKk/ryxRXUQ0rsQEzZOtkr92PHGH4wNefJMi4FN3imY+7RsTdajyRMow25EkOM2
         6gmA==
X-Gm-Message-State: ANhLgQ247xDWw346nrOnfm+RHIqccjXxq89B7ljkLcEWahURN9FUcnj4
        t8skGNo//9l1IDNCvMjEOS59Bg==
X-Google-Smtp-Source: ADFU+vvoGA39/cCr7/iCTBZypULP1WwCjBWt61zX1Tm5O+VwP+snJrEHZeh45BQRBnQHw4AHbPDXxA==
X-Received: by 2002:a37:387:: with SMTP id 129mr2472915qkd.293.1583321092904;
        Wed, 04 Mar 2020 03:24:52 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l3sm6137838qkl.100.2020.03.04.03.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 03:24:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] tick/sched: fix data races at tick_do_timer_cpu
Date:   Wed, 4 Mar 2020 06:24:51 -0500
Message-Id: <93F1BB73-8891-46EB-99E0-DD6C87209945@lca.pw>
References: <20200304095647.GL2596@hirez.programming.kicks-ass.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, fweisbec@gmail.com,
        mingo@kernel.org, elver@google.com, linux-kernel@vger.kernel.org
In-Reply-To: <20200304095647.GL2596@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2020, at 4:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> Worse:
>=20
> +    if (cpu !=3D READ_ONCE(tick_do_timer_cpu) &&
> +        (READ_ONCE(tick_do_timer_cpu) !=3D TICK_DO_TIMER_NONE ||
>=20
> Doing that read twice is just utterly stupid. And the patch is full of
> that :/
>=20
> Please stop this non-thinking 'fix' generation!

That is an oversight that could easily be fixed. However, blaming about =E2=80=
=9Cnon-thinking=E2=80=9D is rather harsh. Do you know I had spent weeks read=
ing about memory-model.txt and alike just to get better at it?=
