Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D0A20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592919792;
	bh=g6tRclVhtSAW5qi8EewP5Y8pul/IVob3dqrhPrm4VBY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=cgt/yGTBU9ycPrSdVqBaFN95iPCKP68aSbY7vzA2hiFVi9GhtuTTNXQ94AnUMJgsm
	 bs48HHLygZVw/k3U1ofidH7v/Wp9dj8+OyO8bqIKSRxkx/D8ww0qd8Ut5IKhdHvtUD
	 TAWHUE0+eGpAltibmBYk3tkz2/gjuV2WQr4m6kWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbgFWNnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732629AbgFWNnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:43:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391BF2070E;
        Tue, 23 Jun 2020 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592919789;
        bh=g6tRclVhtSAW5qi8EewP5Y8pul/IVob3dqrhPrm4VBY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qcAuHWsDyGTkatCEmevMuVi9SvNOqHcICBUvMOANCoEUsupKwv/jFgfmcn5XwzurA
         G803DE95LTHZxb2lY9lXcVsDOStklRdWseO7wE/h+KEz5A0mGBeK7O14jVXIZC6JzG
         juIiXlkOSfkTvkppE/39/qST8cRxQp1WjwAbxiSE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1E5CE352265E; Tue, 23 Jun 2020 06:43:09 -0700 (PDT)
Date:   Tue, 23 Jun 2020 06:43:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH kcsan 0/10] KCSAN updates for v5.9
Message-ID: <20200623134309.GB9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200623004310.GA26995@paulmck-ThinkPad-P72>
 <CANpmjNOV=rGaDmvU+neSe8Pyz-Jezm6c45LS0-DJHADNU9H_QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOV=rGaDmvU+neSe8Pyz-Jezm6c45LS0-DJHADNU9H_QA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:31:15AM +0200, Marco Elver wrote:
> On Tue, 23 Jun 2020 at 02:43, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Hello!
> >
> > This series provides KCSAN updates:
> >
> > 1.      Annotate a data race in vm_area_dup(), courtesy of Qian Cai.
> >
> > 2.      x86/mm/pat: Mark an intentional data race, courtesy of Qian Cai.
> >
> > 3.      Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init_rcu().
> >
> > 4.      Add test suite, courtesy of Marco Elver.
> >
> > 5.      locking/osq_lock: Annotate a data race in osq_lock.
> >
> > 6.      Prefer '__no_kcsan inline' in test, courtesy of Marco Elver.
> >
> > 7.      Silence -Wmissing-prototypes warning with W=1, courtesy of Qian Cai.
> >
> > 8.      Rename test.c to selftest.c, courtesy of Marco Elver.
> >
> > 9.      Remove existing special atomic rules, courtesy of Marco Elver.
> >
> > 10.     Add jiffies test to test suite, courtesy of Marco Elver.
> 
> Do we want GCC support back for 5.9?
> 
>    https://lkml.kernel.org/r/20200618093118.247375-1-elver@google.com
> 
> I was hoping it could go into 5.9, because it makes a big difference
> in terms of usability as it provides more compiler choice. The only
> significant change for GCC support is the addition of the checking of
> (CC_IS_GCC && (....)).

Very good, I will rebase the following into the KCSAN branch for v5.9:

	3e490e3 kcsan: Re-add GCC as a supported compiler
	03296de kcsan: Simplify compiler flags
	d831090 kcsan: Disable branch tracing in core runtime

Please let me know if any other adjustments are needed.

							Thanx, Paul
