Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9537C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BAE207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aipeRjry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgAMLw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:52:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726277AbgAMLwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578916344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fAtNK55yDbPKiBZA6iN0qoeGlR4L/c8UwxpFGcssRLE=;
        b=aipeRjryfBMmGleaYvMbHJvX6rDx9O9kS3uaof9h7WUSBxk2Sug4DG1MCa+apXY+0HoKTN
        ggQhUylnEckjzmrAs45rB1edEcocRd4zwe64W10Ja0sZKbJ5xJESr61YNFuV8evG9uMDXc
        0pjcZx9hncH848iXqXH057ehEbfYfSU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-f4ukGw7qPliXvxk4auhKVg-1; Mon, 13 Jan 2020 06:52:21 -0500
X-MC-Unique: f4ukGw7qPliXvxk4auhKVg-1
Received: by mail-wr1-f72.google.com with SMTP id v17so4860169wrm.17
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 03:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fAtNK55yDbPKiBZA6iN0qoeGlR4L/c8UwxpFGcssRLE=;
        b=l6M+mI2L2yfOHfsY/u9oEZznR3RwwFg7R7lAqwjupb1V+iIcW+ZM45VfiOjwjyyUUo
         38ti/GmeOGlzsxv/MstNobnC4ICSO2MtTws7KOX6dN1k6vhilPAwS+HRCW4TCciBssZN
         8ZFSzj8fFql0K9aIEeOjvC9hV/Cr5x1n1stHnG/+wH9DSSBV9yahcG4dluai0bIr+Z/B
         wG3pjk1tf9RyMBp0a6PjMsVpEacVR6cySiaOIXqCytq7nvAWC3DUIsUZdiDYzY8OgUTM
         MuMRnKSYIohAF8C5sZpM5v7yMVK0xc0hFuTMFO3JffvgJptL6G2Li7XTHRL0uU3r90kf
         Eh9g==
X-Gm-Message-State: APjAAAVe3dXZl4CkLWm6h8fV3xCKLqX0MCmJfEFskD/PC+U9wwNtT0+e
        nsKFHCalbY6QuwCQJBFZTVn5ACe1rbSezBZF8LCBD7u51ca9dUwE6HnFqAqHrG7g12gfMyEiR07
        R5K59nnI6IzmyMXU2pgFA3n6R
X-Received: by 2002:a1c:7f4f:: with SMTP id a76mr20060479wmd.77.1578916340370;
        Mon, 13 Jan 2020 03:52:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZg2dccxP0IdOTlGnnmh5SXAppWHgMgGLJe1d7ybkkLljLcXiIb4/SCMEl9TwTbWQUxFL5bA==
X-Received: by 2002:a1c:7f4f:: with SMTP id a76mr20060454wmd.77.1578916340124;
        Mon, 13 Jan 2020 03:52:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:1475:5c37:e2e2:68ea? ([2001:b07:6468:f312:1475:5c37:e2e2:68ea])
        by smtp.gmail.com with ESMTPSA id u24sm14250566wml.10.2020.01.13.03.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 03:52:19 -0800 (PST)
Subject: Re: [PATCH RFC] sched/fair: Penalty the cfs task which executes
 mwait/hlt
To:     Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        KarimAllah <karahmed@amazon.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        christopher.s.hall@intel.com, hubert.chrzaniuk@intel.com,
        len.brown@intel.com, thomas.lendacky@amd.com, rjw@rjwysocki.net
References: <1578448201-28218-1-git-send-email-wanpengli@tencent.com>
 <20200108155040.GB2827@hirez.programming.kicks-ass.net>
 <00d884a7-d463-74b4-82cf-9deb0aa70971@redhat.com>
 <CANRm+Cx0LMK1b2mJiU7edCDoRfPfGLzY1Zqr5paBEPcWFFALhQ@mail.gmail.com>
 <20200113104314.GU2844@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee2b6da2-be8c-2540-29e9-ffbb9fdfd3fc@redhat.com>
Date:   Mon, 13 Jan 2020 12:52:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200113104314.GU2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/20 11:43, Peter Zijlstra wrote:
> So the very first thing we need to get sorted is that MPERF/TSC ratio
> thing. TurboStat does it, but has 'funny' hacks on like:
> 
>   b2b34dfe4d9a ("tools/power turbostat: KNL workaround for %Busy and Avg_MHz")
> 
> and I imagine that there's going to be more exceptions there. You're
> basically going to have to get both Intel and AMD to commit to this.
> 
> IFF we can get concensus on MPERF/TSC, then yes, that is a reasonable
> way to detect a VCPU being idle I suppose. I've added a bunch of people
> who seem to know about this.
> 
> Anyone, what will it take to get MPERF/TSC 'working' ?

Do we really need MPERF/TSC for this use case, or can we just track
APERF as well and do MPERF/APERF to compute the "non-idle" time?

Paolo

