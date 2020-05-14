Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7E7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1E520675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589471472;
	bh=64eVHHRV2z/AWFVnyBrc+rm3gagzzsXme65pxjF7a3w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=wPMg2gwhk58bKWYNqfB8WqLy4A0DLMuD7QiDUObIOzVasSTCOH0x+qSP0kgrCHsxK
	 WRQE2bX4cUdAit5jSIwBM9GAJAuSyHAWAXo4sWsLzE2nXAGqGXFseQUKcpma94horp
	 PQV6T2yeDmWOEw/cKcRJgfp/vWMQT4PrgbiGdO00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgENPvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgENPvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:51:11 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395702065F;
        Thu, 14 May 2020 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589471471;
        bh=64eVHHRV2z/AWFVnyBrc+rm3gagzzsXme65pxjF7a3w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VrB8Gl0gwU8rXRcLQ2LV8L1Z2l7qOCBGLc12r7now3I8kzq52WyY5LZ6u2VIXaO4M
         Hxyt3tunqsItrbKw/Hy5S9gLoeKKRxyJ5sWbSXuQr5fY0KmrRo0ZUjlAq010COlv54
         oU3KK6IPnUGYD9vL087x5czmNxrD/1s55Wc5qRlI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2930135229C5; Thu, 14 May 2020 08:51:11 -0700 (PDT)
Date:   Thu, 14 May 2020 08:51:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 10/10] rcu: Nocb (de)activate through sysfs
Message-ID: <20200514155111.GO2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-11-frederic@kernel.org>
 <20200513184229.GX2869@paulmck-ThinkPad-P72>
 <20200513232312.GD18303@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513232312.GD18303@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:23:13AM +0200, Frederic Weisbecker wrote:
> On Wed, May 13, 2020 at 11:42:29AM -0700, Paul E. McKenney wrote:
> > On Wed, May 13, 2020 at 06:47:14PM +0200, Frederic Weisbecker wrote:
> > > Not for merge.
> > > 
> > > Make nocb toggable for a given CPU using:
> > > 	/sys/devices/system/cpu/cpu*/hotplug/nocb
> > > 
> > > This is only intended for those who want to test this patchset. The real
> > > interfaces will be cpuset/isolation and rcutorture.
> > 
> > Makes sense!
> > 
> > Speaking of rcutorture, what level of testing has this series undergone?
> 
> None yet, that first set was to shape up the design. But next
> iteration should see rcutorture coverage.

Fair enough!  I am sure that rcutorture will be ready when you are.
Hey, it always has been ready for me!  ;-)

							Thanx, Paul
