Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DF0C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA0D206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="iZLH4CfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgC0KTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:19:41 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:41915 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgC0KTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:19:40 -0400
Received: by mail-qk1-f173.google.com with SMTP id q188so10176342qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=bdNljni0qGfsEsOjwWI52DzmcTz0dDp50+ihOjqpjX0=;
        b=iZLH4CfWYW4cjqrXxp8hEXnciNngJ41CUmtDM46s1G8iLlpgwhFhPuhzn0OKbYGNyJ
         UGC1Cau/q2B/nftm+byUQYU0u0cchFev0vLGr5uAr3C/EQWg9NodE14zhXNhcDGBywvA
         ZkKf+4BeRxRAr1naEEHlSMu4DqYYO8fuk++LjVdW2mFMM/P/FH5/A1tHhn4kun9cl1S9
         uaCJAnzjkm+41xPi1aDWg/RQDJVcl5A8TpSxIHVXjXSnmwf5dwxZKNwEVmmonwgfZlMj
         Tlf5ASjwjGevoG7fD2coXYA6wyMti67P9S9eRoFw2GwPVEp1FkDjUgGOY3P60vRa84mB
         8w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=bdNljni0qGfsEsOjwWI52DzmcTz0dDp50+ihOjqpjX0=;
        b=a3sHcXhTT5QrDcw/vC+5z8tppNIV/c3K760QFn5i4urgN/cnmUpyGeaIRSInwT9nTx
         C+CfcGEi+mz/hdjfsOnH6bcJKqQwXRxHOPWINfGOqVuFgNLhxArIZXr2DVeQ7nxdsPrP
         4KIZlOcirJ2jMHwYuEGKMiri1OaqsEOyzQVKwwnBZjnTVcRYXM0PIecufTe02auPYnza
         G9TLfODu/+6vzflmWK4LF3E8674GKuguzZKq/gSfig8wbs+SvtMCwDGBOGrTivmkamPz
         E9SbTzkMrvKvkEUPfM6npVavhUN+IfAXfzZ1W9kjNkhIT/vdLFWCtL+1sFT4mZn4qJAL
         pUmw==
X-Gm-Message-State: ANhLgQ0xfeLHVEi3TCU4A68DM9rrdRC3aXQVktkBnUoSkrFqCelB6DKV
        YxyjRQNWe53q+gSIGUWJLVWTSw==
X-Google-Smtp-Source: ADFU+vvbVg85P2Bvd+Adoz9kGHO7VQHW1wW4dWoGvBjjBK2nxq8lOhcDZ5inchpi2rrTC+0rJktKpg==
X-Received: by 2002:a37:cc1:: with SMTP id 184mr13416103qkm.430.1585304379199;
        Fri, 27 Mar 2020 03:19:39 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l45sm3639875qtb.8.2020.03.27.03.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 03:19:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] locking/percpu-rwsem: fix a task_struct refcount
Date:   Fri, 27 Mar 2020 06:19:37 -0400
Message-Id: <BB30C711-B54C-4D61-8BEE-A55F410C4178@lca.pw>
References: <20200327093754.GS20713@hirez.programming.kicks-ass.net>
Cc:     mingo@redhat.com, will@kernel.org, dbueso@suse.de,
        juri.lelli@redhat.com, longman@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200327093754.GS20713@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 27, 2020, at 5:37 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> If the trylock fails, someone else got the lock and we remain on the
> waitqueue. It seems like a very bad idea to put the task while it
> remains on the waitqueue, no?

Interesting, I thought this was more straightforward to see, but I may be wr=
ong as always. At the beginning of percpu_rwsem_wake_function() it calls get=
_task_struct(), but if the trylock failed, it will remain in the waitqueue. H=
owever, it will run percpu_rwsem_wake_function() again with get_task_struct(=
) to increase the refcount. Can you enlighten me where it will call put_task=
_struct() in waitqueue or elsewhere to balance the refcount in this case?=
