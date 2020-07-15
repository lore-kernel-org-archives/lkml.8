Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95631C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D320206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594819218;
	bh=GSpr6UASAlStOTqKkZNRWIGI2XEGUU7o/VqNPRA9ZGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Je+qx+YNG/f/SiujJ7flZMvK45mnW7/YHjENHuWtlu9SU0TKCyfaMibe1rEQCdMeU
	 GJdYsN8l5uUjWZHhpHinhqAntNmsKbM108m1n7P+kUvX8w2Rw72pQdHbN2Awa0yuX9
	 qQUfIVSwDRd8MdXTlo5DbY/QB1rfUkutevwpOgvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbgGONUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbgGONUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:20:16 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B3F20578;
        Wed, 15 Jul 2020 13:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594819216;
        bh=GSpr6UASAlStOTqKkZNRWIGI2XEGUU7o/VqNPRA9ZGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TMzCsrREac3xi0lBCtQKKs5hLraFo47JH9tU4OQSUIP3qyOn17RhiZ3D2IB3cWgEK
         GGgwnW50CraCwBnJhIQZzI6u0G2bnnp3G+Pwbfk6gclH2qqF6ahzAzZdRgvu6U+31J
         JvLVbM72Nod4Dx4RJg7HtxESW/0XX59dQYmlKeK8=
Date:   Wed, 15 Jul 2020 15:20:14 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 1/9] timer: Move trigger_dyntick_cpu() to enqueue_timer()
Message-ID: <20200715132010.GB16227@lenoir>
References: <20200707013253.26770-1-frederic@kernel.org>
 <20200707013253.26770-2-frederic@kernel.org>
 <alpine.DEB.2.21.2007091312340.4020@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2007091312340.4020@somnus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 02:17:35PM +0200, Anna-Maria Behnsen wrote:
> Hi Frederic,
> 
> On Tue, 7 Jul 2020, Frederic Weisbecker wrote:
> 
> > Consolidate the code by calling trigger_dyntick_cpu() from
> > enqueue_timer() instead of calling it from all its callers.
> 
> Looks good, but maybe you could also update the comments in the code (see
> remarks below)?

Ok, fixing that, thanks!
