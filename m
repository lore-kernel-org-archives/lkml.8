Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9B3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8227D2077D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594635124;
	bh=8vkQxgop8AnI5kG91NxLuPtN9u1EWVhC68mM6Di0TH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gFoyVYPZgn0qQ187eldvrBRxpl/tHsA3koC22+0vcc4sQV3KOetSR1K/QOPovx6Ly
	 xXIthq6RzBT53UHEdIKTPYkHlL51SV+etGletOYBcxwFMxEYMqBD2zmc48O6pH3LsQ
	 Zidp/a7iQBpZGNI4whJKU9lzskbGMQKl3Vs3ZOj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgGMKMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgGMKMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:12:02 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D50720758;
        Mon, 13 Jul 2020 10:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594635122;
        bh=8vkQxgop8AnI5kG91NxLuPtN9u1EWVhC68mM6Di0TH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0Xdv6OcGf0Q+AdkK8+2lSCTHVNL8t+YmPNh/2v+Hls5kQpjq0brLZ69ycsbk4Drp
         Ao1jSnh6NoLfKrOTT9ghtW0aYikN5Gm5ujAtCTlMydclEOSREd3/uLY7jZ9M127Xpe
         AvUWvQ+YRhs6onfRHFwlBrpo978cHliv6CRewUCc=
Date:   Mon, 13 Jul 2020 11:11:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        sboyd@codeaurora.org, john.stultz@linaro.org
Subject: Re: [PATCH 0/5] arm64: perf: Proper cap_user_time* support
Message-ID: <20200713101156.GA2328@willie-the-truck>
References: <20200512124058.833263033@infradead.org>
 <20200713060800.GA15400@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713060800.GA15400@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Mon, Jul 13, 2020 at 02:08:00PM +0800, Leo Yan wrote:
> On Tue, May 12, 2020 at 02:40:58PM +0200, Peter Zijlstra wrote:
> > Prompted by Leo's patches, here a series that corrects the arm64 perf cap_user_time situation.
> 
> I checked the latest mainline kernel code base, found this patch set
> are missed to merge into it.
> 
> Could you confirm if this is missed or any other reasons to hold on it?

I was assuming you were going to pick them up, fix up the issues found
by you and kbuild robot and then post a full series after testing.

Will
