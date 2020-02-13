Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CBEC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241232168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJA3vGr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgBMNvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:51:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35460 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbgBMNvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:51:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id b17so6845264wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dXeXmbnt/wE2uV+BRjNgnqQCAx/h6dr+7sDohudsbhM=;
        b=BJA3vGr/iLlR+5TsGX3YRqQM0xa4p6xj+gH5ge3WJwBL2noMLtMbcJK1Y8AbsU4fxr
         jeep5ss6fGNmdy1bk0mm/jztKxPHBnWXi1mngeJJ1tQpjAwYSsYp8AyaNZ77/xcXSvHV
         p/hZeWbL4JwB1Ky0vJIY1+9PEGdrXqm9SzVDIi1pIbOJOPynXhMjdsZTrUVB2GWFasNQ
         WV4ETEruV2s3bmh3vFX6sHfoaVefaalFYl0HQfbxwVLsUEplbmOpoMNpSibmCnWVBtwq
         UJtaaheWIdXX8n2nwGwDQylAEAZf8Xr0U5yG0h+WUHjJ/D3iI9JwnD0SZgeRxXNuj5GZ
         t1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dXeXmbnt/wE2uV+BRjNgnqQCAx/h6dr+7sDohudsbhM=;
        b=Wc/4kH13ARxDuKyMZ9ivzQc6dex/AJE6q5Wy2WLHUBajcPXmMRPhpmtPfY6qSvuTpv
         eIDiP0NvIqzyNLIP+R4jp5ZMcHVVmjuZJDBMGN6SVT59cowe3NJrkkRyJwfPQm1tOLhb
         pxbMJWk3jThOGdI/2bmXUnhPYO8Un550IbxYAuIT1m6rdlMRwM3dukIf117/VMSzpvoF
         YR+ZDnGkPx9kGLkHZAOj7lD3ZCBDv4Y/rYIVcfrN4QYfjjz8sQcv/Ez5EGLQvMph++/E
         WKSY2Sq+Ji+VT6E3mrblUJuu50mJabvp0JqsBxmdFvEqw6Oz2ro6GWaUkg5tKXYuz9Qo
         5Cag==
X-Gm-Message-State: APjAAAWt1kMIROBpEramSOJ5LpvRyqFcLDaulSvFfCjxiiuOSAqqx7H1
        AnozcyX5+CS102IwhoWvGiE=
X-Google-Smtp-Source: APXvYqwR1iaGDp4GFWoCDS/WUIQc0XiJcUy2KWsuTzfnN95YSv2E+XsPesP3g28sspLRLVAp94YJDA==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr6288226wmb.114.1581601905326;
        Thu, 13 Feb 2020 05:51:45 -0800 (PST)
Received: from andrea (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id x14sm3108109wmj.42.2020.02.13.05.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:51:44 -0800 (PST)
Date:   Thu, 13 Feb 2020 14:51:38 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de,
        Stefan Asserhall load and store 
        <stefan.asserhall@xilinx.com>, Will Deacon <will@kernel.org>,
        paulmck@kernel.org
Subject: Re: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
Message-ID: <20200213135138.GA5843@andrea>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
 <20200212155500.GB14973@hirez.programming.kicks-ass.net>
 <4b46b33e-14ad-7097-f0db-2915ac772f15@xilinx.com>
 <20200213085849.GL14897@hirez.programming.kicks-ass.net>
 <20200213113432.GF69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200213113812.GG69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213113812.GG69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 13, 2020 at 07:38:12PM +0800, Boqun Feng wrote:
> (Forget to copy Andrea in the previous email)
> 
> Andrea, could you tell us more about how to use klitmus to generate test
> modules from litmus test?

The basic usage is described in "tools/memory-model/README", cf., in
particular, the section dedicated to klitmus7 and the "REQUIREMENTS"
section.  For example, given the test,

andrea@andrea:~$ cat atomicity.litmus
C atomicity

{
	atomic_t x = ATOMIC_INIT(0);
}

P0(atomic_t *x)
{
	int r0;

	r0 = atomic_fetch_inc_relaxed(x);
}

P1(atomic_t *x)
{
	atomic_set(x, 2);
}

exists (0:r0=0 /\ x=1)

You should be able to do:

$ mkdir mymodules
$ klitmus7 -o mymodules atomicity.litmus
$ cd mymodules ; make
[...]

$ sudo sh run.sh
Thu 13 Feb 2020 02:21:52 PM CET
Compilation command: klitmus7 -o mymodules atomicity.litmus
OPT=
uname -r=5.3.0-29-generic

Test atomicity Allowed
Histogram (2 states)
1963399 :>0:r0=0; x=2;
2036601 :>0:r0=2; x=3;
No

Witnesses
Positive: 0, Negative: 4000000
Condition exists (0:r0=0 /\ x=1) is NOT validated
Hash=11bd2c90c4ca7a8acd9ca728a3d61d5f
Observation atomicity Never 0 4000000
Time atomicity 0.15

Thu 13 Feb 2020 02:21:52 PM CET

Where the "Positive: 0 Negative: 4000000" indicates that, during four
million trials, the state specified in the test's "exists" clause was
not reached/observed (as expected).

More information are available at:

  http://diy.inria.fr/doc/litmus.html#klitmus

Thanks,
  Andrea
