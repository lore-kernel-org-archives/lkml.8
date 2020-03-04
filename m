Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16B5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39CD20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nAZKkTLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbgCDLVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:21:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37334 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgCDLVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:21:00 -0500
Received: by mail-qk1-f196.google.com with SMTP id m9so1162552qke.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 03:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=0ndoGe5qwdHblj18NHAxI4x/qQzvTwAx0af3Gh2K+1s=;
        b=nAZKkTLEGDV6MeTXcfkjdC0zbxsF4m5MwH/M7EsMwd9L5jZ5EYp+iXB/e/O5U6uPQc
         Ump1A1RpxFY5yiaMFXOmKrgcpMcupstJLmzxFVc+RtLJq9Rc0pZvsnQbqu+0wgGt01BU
         ATvcY2ClY+ON1cLirxeFu9h2lfxVnhRJMbWQpyGOMA7vyKv4opDzGwTAIjrTl3jxOdCB
         e4mKTIG2Zvl6aNrnSVvUP39wXnGgquSgxZ8g6dV1wTcO5mIrGrLFIM6rO9FBIl5tjmEM
         XEkT7YqKvIdjw3YqaqUJ8u7YkR6vu/06lgFZdydtvh+S+xH45dkqrQwv8v+wc1U6rXiQ
         dHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=0ndoGe5qwdHblj18NHAxI4x/qQzvTwAx0af3Gh2K+1s=;
        b=a5HwTHpEHILcArvIpo3cCXmrFDB312Rxh30qVo9aUL5sJlX2fEt1Wqnp/l74f3+X8V
         OCkyknIcB7kfmXDyUh8jjJO4FpZyUsZS20Gw0xs05DzVfxfVvmxRAW+Yzv0TWUv9c7od
         CCS957uhsr1JBswbjHaP+P2SH3s9jFNa8NcZcOAmw2VrhWlQ5y4U94X5dBaqQGSGj8I+
         mMBQqcy85+CqOWUgtAf1NIduMjslJbP8ZxCB0XLvyU0ZFyTp2xxuK1fyYyvPAWkXdxKx
         D9dMNXaq2P0NoNjc1qB98Oq+bA8CF3hLHvR7qD4EhoQl2m4K4hkK460GUiHP+IO8zfDI
         mQhw==
X-Gm-Message-State: ANhLgQ0zNE2mhnyBbW47gHmLcEoQUAUc8dK63KkZOeb/hbtkLAPVpGD8
        b9NHClTs/TlAQGiZKubiIADSSA==
X-Google-Smtp-Source: ADFU+vvMorp98iGu9Owbik8CzHg/oCpBTVmeuY8+h8VEnKeawUtFUM5CvUjIxAKSnHQ1nHEHC2uR6A==
X-Received: by 2002:a37:4351:: with SMTP id q78mr2360200qka.409.1583320859128;
        Wed, 04 Mar 2020 03:20:59 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p77sm11244265qke.18.2020.03.04.03.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 03:20:58 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] tick/sched: fix data races at tick_do_timer_cpu
Date:   Wed, 4 Mar 2020 06:20:56 -0500
Message-Id: <1C65422C-FFA4-4651-893B-300FAF9C49DE@lca.pw>
References: <87tv34laqq.fsf@nanos.tec.linutronix.de>
Cc:     fweisbec@gmail.com, mingo@kernel.org, elver@google.com,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <87tv34laqq.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2020, at 4:39 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> They are reported, but are they actually a real problem?
>=20
> This completely lacks analysis why these 8 places need the
> READ/WRITE_ONCE() treatment at all and if so why the other 14 places
> accessing tick_do_timer_cpu are safe without it.
>=20
> I definitely appreciate the work done with KCSAN, but just making the
> tool shut up does not cut it.

Looks at tick_sched_do_timer(), for example,

if (unlikely(tick_do_timer_cpu =3D=3D TICK_DO_TIMER_NONE)) {
#ifdef CONFIG_NO_HZ_FULL
		WARN_ON(tick_nohz_full_running);
#endif
		tick_do_timer_cpu =3D cpu;
	}
#endif

/* Check, if the jiffies need an update */
if (tick_do_timer_cpu =3D=3D cpu)
	tick_do_update_jiffies64(now);

Could we rule out all compilers and archs will not optimize it if !CONFIG_NO=
_HZ_FULL to,

if (unlikely(tick_do_timer_cpu =3D=3D TICK_DO_TIMER_NONE) || tick_do_timer_c=
pu =3D=3D cpu)
         tick_do_update_jiffies64(now);

So it could save a branch or/and realized that tick_do_timer_cpu is not used=
 later in this cpu, so it could discard the store?

I am not all that familiar with all other 14 places if it is possible to hap=
pen concurrently as well, so I took a pragmatic approach that for now only d=
eal with the places that KCSAN confirmed, and then look forward for an incre=
mental approach if there are more places needs treatments later once confirm=
ed.=
