Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33029C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021C42071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BjIdZtvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgAXEVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 23:21:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34506 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbgAXEVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 23:21:37 -0500
Received: by mail-qk1-f194.google.com with SMTP id d10so882729qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 20:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Qq7FacF5xTUSGTg0s7TEeVM38rbm3n3Bf5N/b8BLGs4=;
        b=BjIdZtvSGt0iGJ2gHLmhXWfi74+Ve/1rj3yiUk1IJdxGyiQnj8yk9oFRz2N+eQ1OxE
         yTLV/mk0hbFKdSdw+vLO7F8cvyzEO/urcp76TQPFPCJ/le8aMiZyw8CY5CUuOyuqB2JM
         Z5pc0KSHEgn2+NnqgHbw/TUipqPsSq15JM5tszkUbHwio3R4S1ZQaAp1uu72CfIfP1Co
         Y2l1xStSvJILFjikGVOdsn9GXUsvIEGuWw4iOUl8qH66EBIs+T9M2fyMROj9Dj99pnRS
         PyJ628DWi9fpQqabdXAoIIS5k8oDkhEXADwCTZCQX/XcqhnIW8uH8YVARm1VSL36lzyE
         gwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Qq7FacF5xTUSGTg0s7TEeVM38rbm3n3Bf5N/b8BLGs4=;
        b=APTpAChm1sjcKyt2dBt9xhYUf2P/DEaqbhZ+Yrfc952bNMegAN4CFajkIBU8qQoaFD
         /JdlcOT00UivxGgTGSZ7ZirRswhznMSm3EkIaesUEQCSV5NCjp6TLn+HruIIVDPR5lQO
         CJD8bm+woUPh7+TnMAS1/As/5hL4DByOZ1gLjXr2C9akye9IGjtsgMjj3YPRe1RAy1J1
         +6HAxFbB+hdGnNBsZo6cyBm+dpMhSbVsKdIvj8OKc7q31LcgA77I/P01ORcXmip1tF/n
         wyDJp5d2Lv/KiqHM2ODQM5i2OL0n5Sbkc8hU7VejKcG+x3rR6NI3F1Xw26kFT61Cxb8Q
         oBsg==
X-Gm-Message-State: APjAAAUzRVQeAfuOOEjQ9Ivd1ePhrJjckhxy33T17EAKuEDIGxafymNE
        eWzpov090UpkC5IaTujvshvoaw==
X-Google-Smtp-Source: APXvYqxh27xeGjjhHmqAZfbtAVe354clbRfI9zM/dA1zQGEkhxU5l/6LUKzOnZuO3mfSzlu2szfAiQ==
X-Received: by 2002:a05:620a:166a:: with SMTP id d10mr840663qko.37.1579839697038;
        Thu, 23 Jan 2020 20:21:37 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q5sm2277936qkf.14.2020.01.23.20.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 20:21:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
Date:   Thu, 23 Jan 2020 23:21:35 -0500
Message-Id: <A72A7F42-A166-4403-B12C-32B2D7A662C4@lca.pw>
References: <20200121103506.GH14914@hirez.programming.kicks-ass.net>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200121103506.GH14914@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 21, 2020, at 5:35 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> Something like this; except you'll need to go audit archs to make sure
> they all call idle_task_exit() and/or put in comments on why they don't
> have to (perhaps their bringup switches them to &init_mm unconditionally
> and the switch_mm() is not required).

Damn, I am having a hard time to motivate myself to learn all about those tw=
o =E2=80=9Cdead=E2=80=9C arches from scratch. I suppose the first step we co=
uld put a dummy finish_cpu() for alpha and parisc if they don=E2=80=99t call=
 idle_task_exit() in the first place anyway, so if it is a bug there it is a=
nother issue that could be dealt with in a separate patch later?=
