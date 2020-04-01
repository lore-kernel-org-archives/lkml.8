Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFC4C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C9C20658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759050;
	bh=J50/8Jga7foZAd3CXj/MWq+svhVNBZqF1M3zE56+/qw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=2f1MpPwnPl/6YDoKNJfsExxbUfVqk40zRbx/6ijOjDqPphM49YY+WFIcRngHqzpKx
	 JALwh+qxJh3Mv72P5lUcC7LpGkesiHmXbtJ3r5H0rfLcmM5PGS05BCkjYy2y0XUC6s
	 wQAllPGL05CCczHW54GyIVTiGvgedh78AOs7Ol08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388973AbgDAQh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388810AbgDAQhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:37:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3641820658;
        Wed,  1 Apr 2020 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759045;
        bh=J50/8Jga7foZAd3CXj/MWq+svhVNBZqF1M3zE56+/qw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nCt9BQq+7XUhdDSUnZQFEh1QfuJ+E2EBXypeE6r2J1P1EotPIEoq8YmM9tZD2eHA2
         lz604s22w/9BIqQkBES5WPNUAhh35WJ6ZXVDmUJiBopadMQSzBMsqfIWZGWC8qrqVC
         lWdX1g6qcMV2MmOqq7O8fWdZ4OirvWUXfwAlzSXA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F39493522887; Wed,  1 Apr 2020 09:37:24 -0700 (PDT)
Date:   Wed, 1 Apr 2020 09:37:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Marco Elver <elver@google.com>, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, cai@lca.pw,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kcsan: Move kcsan_{disable,enable}_current() to
 kcsan-checks.h
Message-ID: <20200401163724.GA19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200331193233.15180-1-elver@google.com>
 <20200401084002.GB16446@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401084002.GB16446@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 09:40:02AM +0100, Will Deacon wrote:
> On Tue, Mar 31, 2020 at 09:32:32PM +0200, Marco Elver wrote:
> > Both affect access checks, and should therefore be in kcsan-checks.h.
> > This is in preparation to use these in compiler.h.
> > 
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/kcsan-checks.h | 16 ++++++++++++++++
> >  include/linux/kcsan.h        | 16 ----------------
> >  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> Acked-by: Will Deacon <will@kernel.org>

Applied both acks, thank you!

							Thanx, Paul
