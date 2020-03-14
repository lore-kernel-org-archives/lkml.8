Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A10C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 02:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6852074B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 02:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="g9JMyT4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgCNCx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 22:53:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42542 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgCNCx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 22:53:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id e11so16279891qkg.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 19:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VjewnPoybngaF4j18VnhCQc7gYXnlRqQi/8Wl5U+iwo=;
        b=g9JMyT4PiSLSvNJpHuJ5MXlTSG/WY3jolLdY3Sgd25rvahuuI/j9rhi3e6v6Va6t6A
         l4lyEO+ukUQlMgOi72cY//D86xgikI2H24CESLHu/x2rsB/LYNDR0EYBqNDeHSBwriAQ
         jC0a0iJLYK47e/JdcP8DWckuKWMGFBALx/DMnIzouaSguDwiAB5Y72CtpKEfdUqV+j2Z
         hHcKYW/dsPZfPxc1elBZ6Db39jiRLnUbCIwjsHzV+xYi0Dcnblb9eedPMBB/aLyEIn59
         RELtohPopw7cPdNIV4Vh4958BEpeY58aqsxKiVeN7OlpV5wK85Kewc0jBd3/EF3Sp9lL
         ak1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VjewnPoybngaF4j18VnhCQc7gYXnlRqQi/8Wl5U+iwo=;
        b=ZcSriRWNZ11PyOTgh83/V6jn965NBhjtALD8y534KbdCi0+00nIMt+51GUXfZvmn6A
         QoSjzkxrNvfiy9nD7X+341kq3mG8BL5RsyBOwDGfVwfAeAl0NvRbmViKE2yMxLPZ19xd
         EWKlwnYuvNfiN4hOP9nkAjRVu8hxPKodfZMgvX/zXy+OwaA6nJLXErI0uyMXvN72/UJL
         yGmobJbirAadakqJVRw3oBDbwmlWk1pXtXcIKn1C1DkzS29P61hRBCBrUj/EU7rO6WoS
         QyQRn+0E0SMydIeMy1bgkF2KeUOZ3DqwEOYpuo3zCpDU0sUC8MiDLmzxziv07rxxz1f7
         nWwA==
X-Gm-Message-State: ANhLgQ3TQuT6KFe1jtxTH9nY5zLWFREE5x4GmrfnfLmsZLfGgSd2EB//
        BLsO1YM8KwHcbDmfieXcpBhZIRhjDcFGOw==
X-Google-Smtp-Source: ADFU+vs3ZiNS3xWCJ8wqwdpppicJcs+38sNDzK9L2A+remzr12ThqIGsChR4VSJQGLhA1g0Y2SxkgQ==
X-Received: by 2002:ae9:e306:: with SMTP id v6mr16616977qkf.2.1584154406183;
        Fri, 13 Mar 2020 19:53:26 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m1sm9516956qtm.22.2020.03.13.19.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 19:53:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] timer: silenct a lockdep splat with debugobjects
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200313212620.GA2452@worktop.programming.kicks-ass.net>
Date:   Fri, 13 Mar 2020 22:53:24 -0400
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        rostedt@goodmis.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <47A499D0-D1F5-4B72-A99D-6FBC8E3DD8AD@lca.pw>
References: <20200313154221.1566-1-cai@lca.pw>
 <20200313180811.GD12521@hirez.programming.kicks-ass.net>
 <4FFD109D-EAC1-486F-8548-AA1F5E024120@lca.pw>
 <20200313201314.GE5086@worktop.programming.kicks-ass.net>
 <D3115315-12A9-43A9-9209-09553CF2C71C@lca.pw>
 <20200313212620.GA2452@worktop.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 13, 2020, at 5:26 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Fri, Mar 13, 2020 at 05:00:41PM -0400, Qian Cai wrote:
>>> On Mar 13, 2020, at 4:13 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
>>>=20
>>> Or, fix that random crud to do the wakeup outside of the lock.
>>=20
>> That is likely to be difficult until we can find a creative way to =
not =E2=80=9Cuglifying" the
>> random code by dropping locks in the middle etc just because of =
debugojects.
>=20
> =
https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=3Dra=
ndom/fast
>=20
> Doesn't look difficult at all.

Great. I cherry-picked the first two patches,

random: Consolidate entropy batches for u32 and u64
random: Remove batched entropy locking

which solved the issue here as well.

Andy, may I ask what your plan to post those?=
