Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AB6C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4158620722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBUJfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:35:09 -0500
Received: from foss.arm.com ([217.140.110.172]:35068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgBUJfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:35:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFD2931B;
        Fri, 21 Feb 2020 01:35:08 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 167323F68F;
        Fri, 21 Feb 2020 01:35:07 -0800 (PST)
Date:   Fri, 21 Feb 2020 09:35:05 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] torture: Replace cpu_up/down with
 device_online/offline
Message-ID: <20200221093505.wcg3e47iojxefa3p@e107158-lin.cambridge.arm.com>
References: <20191125112754.25223-1-qais.yousef@arm.com>
 <20191125112754.25223-13-qais.yousef@arm.com>
 <20191127214725.GG2889@paulmck-ThinkPad-P72>
 <20191128165611.7lmjaszjl4gbo7u2@e107158-lin.cambridge.arm.com>
 <20191128170025.ii3vqbj4jpcyghut@e107158-lin.cambridge.arm.com>
 <20191128210246.GJ2889@paulmck-ThinkPad-P72>
 <20191129091344.hf5demtjytv5dw5q@e107158-lin.cambridge.arm.com>
 <20191129203856.GN2889@paulmck-ThinkPad-P72>
 <20200220153159.mzpagvbwptxlehvd@e107158-lin.cambridge.arm.com>
 <20200221002616.GB2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221002616.GB2935@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/20 16:26, Paul E. McKenney wrote:
> > I'm taking that as reviewed-by, which I'll add to v3. Please shout if you still
> > need to have a look further.
> > 
> > Once this is taken I'll add the suggested API!
> 
> OK, I will bite...
> 
> Why not right now?

Sigh. Good question. Probably I'm just being lame; it just felt the series is a
bit fragile spanning that many archs and was wary introducing some extra
changes on top will make it even harder to get merged soon.

Let me go and do it. You're probably right and it shouldn't really create a big
ripple on the series.

Thanks!

--
Qais Yousef
