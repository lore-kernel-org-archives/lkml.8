Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31973C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02872207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imgY3sLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgBSBcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:32:25 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54664 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgBSBcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:32:25 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so1847597pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 17:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rdSydlYDtK82PfAE/bEAcB+kfEvpRvEP8E9yrLU0z7E=;
        b=imgY3sLUfltWo0uKMUQBGNhdEFtihnDlh/hiuUlxqLNz8vYHiDlDnj+e+gidVVu2nZ
         VZSp7MRfTJMt3gVOOQPNThYytwCIpELBiwQ6yO0O+OpD6w0po6QmPtM8VL+jlBgoNp8v
         l6DcPZ5s5eNlVu+lyZPmsk5861zFqQIBumRWIrqsqwQ+wiiN4JB1CCQXKrGNfMYzVGQV
         YPxnnkUI1jCbz29HkrQ2DXoyz2ex8aHpwDMhkUbcLKOjKIcaXS9VRTXYswqvCjaKQxVI
         joUQlcwDiYYpzMU6tKsyII5/clCAVukg8j+q/pF2+rGGUQoa5jtzDFFrKbYQtrEY6/5L
         GDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rdSydlYDtK82PfAE/bEAcB+kfEvpRvEP8E9yrLU0z7E=;
        b=rbW28cIgRCSdOju/orrgzFM6/ZGpwdczZaLc6p/rXEZFCF63CcLDhNeRFbxi22d+Os
         QK/l3jnN3mHJKXsb8fu/4BbXXHdPB2zeLVChmP8enRQgQbW/tK2WqjgtnLIg5RDTkEEi
         hcAVag2+u4FkHnnDdw4bqKsZqFvEltsFOvQEypDfbv8uzr32cSvQd4Snv5DvV+W8OeOy
         wtZZ3Q2KSwML8DrPhLfQwL+o5h8dgjfYRSc6egzLV9cgKgo8TAC7jdC9GAWea1dSmn6y
         eqVhNzGyr6SlkpYUcA4dVrGNyp4zohnvP1WZrbESJLrhrhRSVfAtQxc1fJYFoVWHEkb3
         xOCQ==
X-Gm-Message-State: APjAAAXPdivqTkDYAVAL1TVthgwV96wLzWA44SI9XMlTAuaQ1Zlthos6
        2Q/3Tb5p6eb3AlsFsVaAve6b1Q==
X-Google-Smtp-Source: APXvYqwRPdAovkAZ2/O+M1SD4LO2zEZxW8I4CbrxngxJWSZSm6qZj8cDHOKrj+q0EdheibyTjfvJhg==
X-Received: by 2002:a17:902:c509:: with SMTP id o9mr23229451plx.112.1582075944675;
        Tue, 18 Feb 2020 17:32:24 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([2400:8902::f03c:91ff:fe3f:ee42])
        by smtp.gmail.com with ESMTPSA id a17sm244743pfo.146.2020.02.18.17.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 17:32:23 -0800 (PST)
Date:   Wed, 19 Feb 2020 09:32:14 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v4 0/5] perf cs-etm: Fix synthesizing instruction samples
Message-ID: <20200219013214.GA8932@leoy-ThinkPad-X240s>
References: <20200213094204.2568-1-leo.yan@linaro.org>
 <20200218184934.GA11448@xps15>
 <20200218193011.GB5365@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218193011.GB5365@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu, Arnaldo,

On Tue, Feb 18, 2020 at 04:30:11PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > > Leo Yan (5):
> > >   perf cs-etm: Swap packets for instruction samples
> > >   perf cs-etm: Continuously record last branch
> > >   perf cs-etm: Correct synthesizing instruction samples
> > >   perf cs-etm: Optimize copying last branches
> > >   perf cs-etm: Fix unsigned variable comparison to zero
> > 
> > For all the patches in this set:
> > 
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> > Unless Arnaldo says otherwise, I suggest you send a new V5 with Mike's RB for
> > patch 3/5 and mine for all of them.  That way he doesn't have to edit the
> > patches when applying them.

Thanks for reviewing and suggestions.

> Yeah, that would make things easier for me, always appreciated.

Sure, will send out patch set V5.

Thanks,
Leo
