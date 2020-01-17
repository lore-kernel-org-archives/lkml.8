Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3FFC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608772082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Etpm59pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgAQOBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:01:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=02vkEi6lxtA4lK33CdPk2WH+RGmnoTDnMl1bMs6Ix1Q=; b=Etpm59ptObPl8hzigJ5gTmz4i
        N1k1IkhLmFxME0A420uBwmIflzr6GqaIIQmyBceL2+f+HwUYZCZ9l0OW5hnzkWc2fuYH+3noLxILV
        PrO1zKzaLvU8YcjLeRWatAvlIIkO/zGZmJ2SfZKGb2BB8zTTndZDCYZiKaiDwN1CwfQbY6DuoR4bP
        Cq6i4wBDhW5IgHYTB4dZ6AUF/0NbY7d7yiKjRwUSeBcplkKiGK6/d8cyxcDqfw6LJs/IiYI2AARZB
        3iywZx0NyV28zDaT6jJGXMfV7jhbrW2bnyUTIdenvKZKb501xgPQ7m9o3YmWliy+oug0ajwPVaLgN
        KU1nqfBPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isSC2-0008MG-2C; Fri, 17 Jan 2020 14:01:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66B1E300F4B;
        Fri, 17 Jan 2020 15:00:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 948602020D8FC; Fri, 17 Jan 2020 15:01:43 +0100 (CET)
Date:   Fri, 17 Jan 2020 15:01:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, nd@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Return EINVAL when precise_ip perf events are
 requested on Arm
Message-ID: <20200117140143.GD14879@hirez.programming.kicks-ass.net>
References: <20200115105855.13395-1-james.clark@arm.com>
 <20200115105855.13395-2-james.clark@arm.com>
 <20200117123920.GB8199@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117123920.GB8199@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 12:39:21PM +0000, Will Deacon wrote:

> Perhaps a better way would be to expose something under sysfs, a bit like
> the caps directory for the SPE PMU, which identifies the fields of the attr
> structure that the driver does not ignore. I think doing this as an Arm-PMU
> specific thing initially would be fine, but it would be even better to have
> something where a driver can tell perf core about the parts it responds to
> and have this stuff populated automatically. The current design makes it
> inevitable that PMU drivers will have issues like the one you point out in
> the cover letter.
> 
> Thoughts?

We have PERF_PMU_CAP_ flags we could extend to that purpose.
