Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61794C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFEA2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fZa691zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgA2MZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:25:43 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36241 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgA2MZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:25:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so12627472qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 04:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=P5Dt2dH1joRUG7g3rFIqA/IEm4rCryr2l+IoRrIYc+k=;
        b=fZa691zxlM8/PJTWvAjVvOyAIwK0md/9eQKUpY4fOIYint3eJHeyBeSS58Qf9ho0yV
         4DD5NH38GD8PIaL46eBZMhdoUjPenGjLpIzHQDZfIYIP3b7YgYviRGtUqGJ7xsDUS8OU
         WdGIYnMT9NDRGVS+VO2AQa/6qHJzdcqSjHZOCeTW1y1Y1Sd1M8patjPq78Xtea/rfJTR
         RNa8Utyx4i/HcZz0CDl+eV2X049QsTBi7HHh+WTjOO2+++dj1ftGukMOPCfy6q1j/wzf
         /3cj5skE+bh3gvQZRLRk6z6zaGJqYsbLMfFSUZF6HwpnKAGQft4Rnmx5W4v5eK/mO+Gx
         p+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=P5Dt2dH1joRUG7g3rFIqA/IEm4rCryr2l+IoRrIYc+k=;
        b=iYL0e7fV6xepiHXHdU72dFMvkrR2S/dzZGj5qufgYzItrWa/9Q3hQECM9jKBbHapBG
         4Ge826ozKsREKqEpCn53ArfBaawiLZUHhGtxPF/Jf95zPVUgtF6oTbOHkM1Io+KE/zig
         nO4lFdzbBgbldC9mYy+3qKqbZaU7trX3nNxCVMupcaPHIYUulNqsxvepNhipHnxs56ik
         4jn/woIfq9e97Sain6Shvwz+KCjSoeJ9iuehnKCOF2CV1PdiLFTIWkmhmzBfDGQaSk7y
         G3Dm5X6llGr83V2gpO4YX7oCpRB1GhXcsmkbcau4LQy8ROatvNxdPazmbuyP0ZyJiJP0
         WTDQ==
X-Gm-Message-State: APjAAAWZAHifvYEYX9CPMl76hEPMsgGPhaako3zr47lWfQoUFNHQ9TR2
        S0RPXkFssev8MIauGXC98quHFK5zZGmVlg==
X-Google-Smtp-Source: APXvYqwEWkCWvO9EEpMi+Z6FMCIN1Z7CxF4fxPuVh9lX0A+QJ0UGpEg3ISsl/+aqCUKxTfc9H9S2Rw==
X-Received: by 2002:aed:2050:: with SMTP id 74mr26490917qta.217.1580300740519;
        Wed, 29 Jan 2020 04:25:40 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r185sm875146qke.102.2020.01.29.04.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 04:25:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_counter: fix various data races
Date:   Wed, 29 Jan 2020 07:25:39 -0500
Message-Id: <2D795DB7-66FE-4F01-872F-F8ACAE9505EF@lca.pw>
References: <59f892d0-5fc4-ae32-ce65-5a688d9180c8@I-love.SAKURA.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <59f892d0-5fc4-ae32-ce65-5a688d9180c8@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 29, 2020, at 7:13 AM, Tetsuo Handa <penguin-kernel@i-love.sakura.ne=
.jp> wrote:
>=20
> By the way, can READ_ONCE()/WRITE_ONCE() really solve this warning?
> The link above says read/write on the same location ( mm/page_counter.c:12=
9 ).
> I don't know how READ_ONCE()/WRITE_ONCE() can solve the race.

That looks like a different one where it complains about c->failcnt++. I=E2=80=
=99ll send a separate patch for that.=
