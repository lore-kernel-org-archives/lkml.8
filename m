Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC9DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E2A24681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Z2sdRUs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgA1MxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 07:53:03 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37332 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgA1MxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:53:03 -0500
Received: by mail-qv1-f68.google.com with SMTP id m5so3035372qvv.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=9DB/J78WdEiWma3kq2rh8LijmEsmMv+++6cwRIocUY4=;
        b=Z2sdRUs8Buc7E9wpla0h4AStuy50Jk4R5HebWGCJIzXTd1rq7t8xOB5VxRIMXax+G7
         icOLYCCj5Dq9wAGFJCSXu95kasvVSrJjJYyF6ZXxMDnylQpHbl+5rfWBArQDYbXZEAyA
         Vmt9yVBzGLGlNWL+7x9tfhRSo8+/ZwoH+0TZKFSBYZ4zLwVnN63e4s9nZG3uZbTY1XHT
         mb3P60MOjrS0xRETGaEc+mzS/2AdFL/LMJJYlP/BRcCJW4yWlv6bswn/IjA9WgIozy2k
         uR4QUF5gp9B23nXO7BgpGTpfX+9EfjsW4vcwzvX9v6W9uETalGbqjfcfzvTOuqwpD6/W
         2DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9DB/J78WdEiWma3kq2rh8LijmEsmMv+++6cwRIocUY4=;
        b=ZNIggmmVll6l7UvRXRd3IDudY2jaRQEKtOTtxQS9wgRP2cprRXIO5z1X9UCjG+2/1B
         AHoBtK7g6pca8KFbjCLE6IPJWcIL7MGA0iYBtIVkSt3wvBkcIxtqpVn9kt3JBgdc7RZB
         TvdeQMMMfo0gSPSFl+asKFVVb4IVlgmpOe8qO+IUEprvfiCJoUawcBacWTIPy9+C7swR
         yH2yinp2el4ofsNo/NWJisqvY2c0ZJlH24O2KN+d6t7DExVpI1EuacF0oaWdSoz7yMu4
         cOWu5sH19DxmRZslmLWG43J/tydFeyuoKGnxS4FZUoC+2h0M2kwdE71KmXtG5XM6t4uJ
         YfVg==
X-Gm-Message-State: APjAAAWBvP4RwA3eZjbWbNZ3ZtZ3gXhfAqiMQl1iREY0qCR30jM9jvSY
        IPndFedwX8VpjB0G42oAVyJhgg==
X-Google-Smtp-Source: APXvYqyviDzAp9s8jtdTg8JKk0z8GVoI+Gm81CekqKyt6p3E1i2Z5rqHw302+GwftT5+g00pbwZQEA==
X-Received: by 2002:a05:6214:965:: with SMTP id do5mr21816222qvb.202.1580215982182;
        Tue, 28 Jan 2020 04:53:02 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n55sm12637616qta.91.2020.01.28.04.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 04:53:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Date:   Tue, 28 Jan 2020 07:53:00 -0500
Message-Id: <C50F23AD-7CCA-423B-9C13-E06596CB4399@lca.pw>
References: <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
In-Reply-To: <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 28, 2020, at 6:46 AM, Marco Elver <elver@google.com> wrote:
>=20
> Qian: firstly I suggest you try
> CONFIG_KCSAN_REPORT_ONCE_IN_MS=3D1000000000 as mentioned before so your
> system doesn't get spammed, considering you do not use the default
> config but want to use all debugging tools at once which seems to
> trigger certain data races more than usual.

Yes, I had that. There are still many reports that I plan to look at them on=
e by one. It takes so much time that cause systemd storage lookup timeouts a=
nd I needed to manually get out of the emergency shell.

>=20
> Secondly, what are your expectations? If you expect the situation to
> be perfect tomorrow, you'll be disappointed. This is inherent, given
> the problem we face (safe concurrency). Consider the various parts to
> this story: concurrent kernel code, the LKMM, people's preferences and
> opinions, and KCSAN (which is late to the party). All of them are
> still evolving, hopefully together. At least that's my expectation.

I=E2=80=99ll try to reduce splats as many as possible by any data_race(), di=
sable the whole file or actually fix it. Any resolved splat will hurt the ab=
ility to find the real data races at some degrees.

>=20
> What to do about osq_lock here? If people agree that no further
> annotations are wanted, and the reasoning above concludes there are no
> bugs, we can blacklist the file. That would, however, miss new data
> races in future.

This is a question to locking maintainers. data_race() macro sounds reasonab=
le to me, but blacklisted the file is still better than leaving it as-is.=
