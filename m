Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AA5C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01F12072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQL04WvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgCWJ2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:28:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27736 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727669AbgCWJ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584955679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0eue0jrc67xfJnfJk9ICQ1xtxeUcbBK4TygDF+Ayn20=;
        b=MQL04WvNeM5m2QtCPGIjpFrJnnXPrTjxR3MWksat7OlNdS9nZ2UP3AOgGvC7FQWEzGXdrq
        yrxuey3KhJGuH4JJuU0rxMs6EXhdAGfn0o8hkO7z/DfB/2KQiNEgLlPZwRRm4VWhPGBQkv
        lVIFcts870zovjhRhBIls1KAtIINPu4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-PrClEjvfNwu1Wo8dCd4OeA-1; Mon, 23 Mar 2020 05:27:58 -0400
X-MC-Unique: PrClEjvfNwu1Wo8dCd4OeA-1
Received: by mail-wm1-f72.google.com with SMTP id v184so3309198wme.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 02:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0eue0jrc67xfJnfJk9ICQ1xtxeUcbBK4TygDF+Ayn20=;
        b=eW84g2UmHa9BSv1flQKm09HGv7olgqVdOGyFx9O2GKQ6C9WaE4d4OktMj99bgXKmuN
         9QDvJrXa8bBgwuq2Yvxy5tYiuYUYXaTjL8CPd7KIG5H29DSjhhdDsl+G1JjtGxkYeJQO
         uAVJpmGrRU+9/RI9jrhm1tn4bxsJsrla8Lv1L+R7ZBJ6EFq5/2Lk8PQ38FQEveoBuEyG
         4Mojj54M+RKdbbK+12F3Xtwa3+k/91gBo92sEnTtK+J6MH3hPfXJAayzE7q4JcA4fc44
         Cg1gKckI5EPnxpTeHC+gGFoeKPCH1pVYfL3KAVuxezi7v4t7NN9il7f0ZQliaMpBZEA1
         OdOQ==
X-Gm-Message-State: ANhLgQ2MdsShcuNSOIvs0ALM+OQvSm0ehFM2KQzAuZ7hNeexD/axISSR
        a6xowa4i+hhQRNcuByldX6K3d3OC/N4YLlZQTMai7T0mVkN8PWWOUYS8yBHxtFdKIUlruG6+nFT
        3ZqplKYF/0isLj4uf9ZJRa9ry
X-Received: by 2002:a1c:9658:: with SMTP id y85mr26269461wmd.63.1584955676994;
        Mon, 23 Mar 2020 02:27:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vun9jWmUPgL/rJK95Cry9OUaAEuL0bLGvpk0q05iiMD9MI+PPsMSsLdAGIhBJfiJtQ7oLokCw==
X-Received: by 2002:a1c:9658:: with SMTP id y85mr26269434wmd.63.1584955676758;
        Mon, 23 Mar 2020 02:27:56 -0700 (PDT)
Received: from localhost.localdomain ([151.29.194.179])
        by smtp.gmail.com with ESMTPSA id e1sm23474045wrx.90.2020.03.23.02.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 02:27:56 -0700 (PDT)
Date:   Mon, 23 Mar 2020 10:27:54 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: help needed in debugging missed wakeup(?)
Message-ID: <20200323092754.GD14300@localhost.localdomain>
References: <c74744cc78cab34f3be8b547b7ff3cd6769d299b.camel@pengutronix.de>
 <20200320140618.048714c9@gandalf.local.home>
 <d8f1b10028b57c5a62bcf3088489c0dbdd0dec5d.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8f1b10028b57c5a62bcf3088489c0dbdd0dec5d.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/03/20 20:04, Lucas Stach wrote:

[...]

> My hope was that someone would could guide me a little with an educated
> guess, to make those trace_printks more helpful. The lockup is hard to
> trigger and there's other unrelated system activity going on, even when
> the relevant user task is stuck, so randomly sprinkling debug
> statements will generate lots of output to filter down.

I'd start by enabling sched:sched_pi_setprio (or adding trace_printks
around there to confirm your suspicion). Once that is confirmed, I'd try
to look at update_curr_dl::throttle and verify if the misbehaving task
was indeed throttled at some point; it shouldn't be, because dl_boosted
flag should be set for it at this point (maybe check this condition as
well).

Best,

Juri

