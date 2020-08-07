Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41394C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248BC2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596763558;
	bh=mA/awtDZ4yMki7SF0GBozP3n+dALHx4VvvVdvvuQTg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KvG2ahMd7758UjQf16MNg0KPdXEgkaIBaRW1oRF88eKRDV3ipi87xpvKuX9IfRAmk
	 n1tlxoBwIz896NHwcST1jsjZmWMOLMB1jPxkNElOdSIv5hT+4ght8W+8rsGa9dS5l7
	 ULf4cLIdUDV585N04OtW+eaK65GVa1NaatQNUPBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHGBZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgHGBZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 21:25:56 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B832206B5;
        Fri,  7 Aug 2020 01:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596763556;
        bh=mA/awtDZ4yMki7SF0GBozP3n+dALHx4VvvVdvvuQTg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dYvoJcTEvXHqFP5FwYVm1gBTYqZu8kiddHmoWKhQgx1+Lw0OXOD7nABF/x8GMbg8t
         V7yB1BureSyuML7pk/LzSQO0CyOADWd7U7d2f0yIgK3YsTcHuGUPdEAdEX7YczjyyQ
         aE88OvCf1CNxX9ay7Qh29SuMK2kyvvETSZj41nQw=
Date:   Thu, 6 Aug 2020 18:25:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
Message-Id: <20200806182555.d7a7fc9853b5a239ffe9f846@linux-foundation.org>
In-Reply-To: <20200806233804.GB1217906@carbon.dhcp.thefacebook.com>
References: <20200714173920.3319063-1-guro@fb.com>
        <alpine.LSU.2.11.2007291902340.6363@eggly.anvils>
        <20200730162348.GA679955@carbon.dhcp.thefacebook.com>
        <alpine.LSU.2.11.2007302018350.2410@eggly.anvils>
        <20200801011821.GA859734@carbon.dhcp.thefacebook.com>
        <alpine.LSU.2.11.2007311915130.9716@eggly.anvils>
        <20200804004012.GA1049259@carbon.dhcp.thefacebook.com>
        <alpine.LSU.2.11.2008051913580.8184@eggly.anvils>
        <20200806233804.GB1217906@carbon.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 16:38:04 -0700 Roman Gushchin <guro@fb.com> wrote:

> it seems that Hugh and me haven't reached a consensus here.
> Can, you, please, not merge this patch into 5.9, so we would have
> more time to find a solution, acceptable for all?

No probs.  I already had a big red asterisk on it ;)
