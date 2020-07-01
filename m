Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B6AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F348207D4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593645650;
	bh=JMCEhMGrZolS7Zo917Ex5jh02w1p5G8xc+SFAo0CiCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WvvGf4xDoiZP+WpM8ThNZKEHVu79OipEmBnmcyMIL84ewvazR1ze9VAAR71x14X23
	 cugyfejd9slTlDf1mZOIdgfhfQKPqVuFoWQc3qYr57Dk9obfLGpTd7QF8kAViYH2qZ
	 A9aPsBfcDKjPwjYsyqGIDang31xC4PW7HIgi9fig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGAXUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgGAXUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:20:48 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11BE72077D;
        Wed,  1 Jul 2020 23:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593645648;
        bh=JMCEhMGrZolS7Zo917Ex5jh02w1p5G8xc+SFAo0CiCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=llSZRexV93ejjGN0yvBxMOZxe8/+ToIrAV28yxaWFhBs/haZX8ChHmTFqBdgb8toI
         oIZLVOBchbqW/p8U9dVK/m7KSG87ILLqsXAC1Oh9PVqltWi07IdyxBWiHs/SXyJ/aW
         C2gCSzG92yVBiLBXV0XA3iLx5kDgRd2uE2bQUx7c=
Date:   Thu, 2 Jul 2020 01:20:46 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 01/10] timer: Prevent base->clk from moving backward
Message-ID: <20200701232045.GA17670@lenoir>
References: <20200701011030.14324-1-frederic@kernel.org>
 <20200701011030.14324-2-frederic@kernel.org>
 <20200701163504.GD9670@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701163504.GD9670@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 06:35:04PM +0200, Juri Lelli wrote:
> Guess you might be faster to understand what I'm missing. :-)

So, did you port only this patch or the whole set in order to
trigger this?

If it was the whole set, can you try this patch alone?

Thanks!
