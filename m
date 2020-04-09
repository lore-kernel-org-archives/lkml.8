Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485DBC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED0920757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="tzNrLp6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDISAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:00:19 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40166 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDISAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:00:19 -0400
Received: by mail-pj1-f67.google.com with SMTP id kx8so1576771pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=zmgHj370LBNKV1cbwyo1caCm3JQLWtu1rtTInvPHiUM=;
        b=tzNrLp6SmTl4zuvoJWbv/IhrraqC8y+wpruozs/0zZ2WxqUK+8LU0L9I4hzVj2ua9U
         KY4iUimjpe58mMHQ5aLQgiS86vHoYVT/MPfC/f04JDPoelZ7dXayZ2gxrJoZJFqWqlAW
         tyC5H1xGmGRb3Es0DTFD6S73K5nQgskuaNMbgkZqBFc2BUEe7mEjWpXrG4IMCVehJ+K9
         mV7IN/uS5qiJOsvVoX7uMjJXer1hGe247YoLfdMK4bapF4kUSj1XtqPwbXfUvPZqUfTw
         +FmtN9UGx2prFh+/QoNprDQvyAWYCBn4UgnDGGocPkf5wCqL2lbyaPVsgzPfXKK0MFtg
         Wb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=zmgHj370LBNKV1cbwyo1caCm3JQLWtu1rtTInvPHiUM=;
        b=J16K7xEL5grLcZjP29oqytTr4vE3s4r+OLnT3A7oubopN8ATtsk2x57UKMzorMIUxO
         QVMC0hEgB5m1+j/CfXFswbnzaC8LepiTiXjr6ZjhQGlXCLiKc7e4JEYBQKIXEw905wTa
         6WQIXKXucU+azzQNpPJfRNYphPBYFMLc6klfCaGePHqwL+CeCnKZQ9GBw1RZ4WH4A/2t
         UNESGR5GqKZEH2UMafZU447lrNaAuMrk/TnLcnU6XwJqV4ybXCMaK2Ozl2QdVQWO06ma
         dCxCFzCm1TZfSEVV1GYLPwTEFQkCa9cPSdYP4hX9zpWnmy7sx4TTQmLvu7aS2CcFNtRA
         nJog==
X-Gm-Message-State: AGi0PuYSioTgjm3CUmKJZ+s9p8+04Q6z7mdnu77Sm2WZdFV4p/126Fc2
        Q9sK7HUqKzfejzA68Hs5yjW2vQ==
X-Google-Smtp-Source: APiQypIyuBEG4mydIIZ8UiVlFa6tJQNZqilN3DYnHlSeONtErGyrPOPpHqhOZbnewz+YO15faSZe2w==
X-Received: by 2002:a17:902:ff14:: with SMTP id f20mr731344plj.206.1586455218768;
        Thu, 09 Apr 2020 11:00:18 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:d3f:18b:ffcb:12f6? ([2601:646:c200:1ef2:d3f:18b:ffcb:12f6])
        by smtp.gmail.com with ESMTPSA id c3sm2461610pfa.160.2020.04.09.11.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 11:00:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 04/13] task_isolation: userspace hard isolation from kernel
Date:   Thu, 9 Apr 2020 11:00:16 -0700
Message-Id: <915489BC-B2C9-4D47-A205-FC597FC68B98@amacapital.net>
References: <58995f108f1af4d59aa8ccd412cdff92711a9990.camel@marvell.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Prasun Kapoor <pkapoor@marvell.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
In-Reply-To: <58995f108f1af4d59aa8ccd412cdff92711a9990.camel@marvell.com>
To:     Alex Belits <abelits@marvell.com>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 9, 2020, at 8:21 AM, Alex Belits <abelits@marvell.com> wrote:
>=20
> =EF=BB=BFThe existing nohz_full mode is designed as a "soft" isolation mod=
e
> that makes tradeoffs to minimize userspace interruptions while
> still attempting to avoid overheads in the kernel entry/exit path,
> to provide 100% kernel semantics, etc.
>=20
> However, some applications require a "hard" commitment from the
> kernel to avoid interruptions, in particular userspace device driver
> style applications, such as high-speed networking code.
>=20
> This change introduces a framework to allow applications
> to elect to have the "hard" semantics as needed, specifying
> prctl(PR_TASK_ISOLATION, PR_TASK_ISOLATION_ENABLE) to do so.
>=20
> The kernel must be built with the new TASK_ISOLATION Kconfig flag
> to enable this mode, and the kernel booted with an appropriate
> "isolcpus=3Dnohz,domain,CPULIST" boot argument to enable
> nohz_full and isolcpus. The "task_isolation" state is then indicated
> by setting a new task struct field, task_isolation_flag, to the
> value passed by prctl(), and also setting a TIF_TASK_ISOLATION
> bit in the thread_info flags. When the kernel is returning to
> userspace from the prctl() call and sees TIF_TASK_ISOLATION set,
> it calls the new task_isolation_start() routine to arrange for
> the task to avoid being interrupted in the future.
>=20
> With interrupts disabled, task_isolation_start() ensures that kernel
> subsystems that might cause a future interrupt are quiesced. If it
> doesn't succeed, it adjusts the syscall return value to indicate that
> fact, and userspace can retry as desired. In addition to stopping
> the scheduler tick, the code takes any actions that might avoid
> a future interrupt to the core, such as a worker thread being
> scheduled that could be quiesced now (e.g. the vmstat worker)
> or a future IPI to the core to clean up some state that could be
> cleaned up now (e.g. the mm lru per-cpu cache).
>=20
> Once the task has returned to userspace after issuing the prctl(),
> if it enters the kernel again via system call, page fault, or any
> other exception or irq, the kernel will kill it with SIGKILL.

I could easily imagine myself using task isolation, but not with the SIGKILL=
 semantics. SIGKILL causes data loss. Please at least let users choose what s=
ignal to send.=
