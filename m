Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE8EC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B5624680
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELstMXLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCJMCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:02:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54802 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgCJMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:02:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id n8so1083533wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 05:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mfThv2Ldbu4yvtonAdZ7hsdZm1jzxZzXGDjXqQ8NU0M=;
        b=ELstMXLYQgBBWfgP4eHD0p/B56BEMC7lmxoHn0vkZq0WtxMw189/cbfUhUVPNZ6k8H
         SgCq7To1Wp4k7Fex5iYAIr5RivymO5G5DMXhA5VThVX6j6HZrzfSP5QqWUddLC+iLYg+
         pX7xBogJ6dCoPJmjHYYZ3YYyJ6fg/GpveGEBTD6Mc5LXY7O+j8z/Q9aKHF2YGlu9Hwdq
         iRs+ptEBCxlLpF6E17gNS5+lbDxiMJ+TjXvhfh6VxmL8wmqmuPRmsEeSsFD1lI26blRs
         we0FugT0DVs7TTGiQS7OyVCTuKBysSTUrN0GiKB08+IaOYVENbTgVI6UicSKxocBvu90
         7kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mfThv2Ldbu4yvtonAdZ7hsdZm1jzxZzXGDjXqQ8NU0M=;
        b=Ifp9aq45YjNeTP6/WmF8GCCmhfknJxIYViA1EIhaSmugOG4V2kHR1AlKVz3p9Sjt/q
         qwa1Bh3D7ophYAzffW6r0ODfKiEyDLfhzZVjssxHAQD7hwpURESNaxG+VYReNUodHaD1
         YLF2M8nN1GsK5J9ICVK7OG4Ar75U2hkZXVihfH5bLSUqzxsrtFM6b/j21k1Cr8vGMbnA
         yL7Kvetr0UFMb6mp+Ljik+NDDVfBPsuU0cvF7FblN3vBRa8mabmKe0UKDmh1epqfFgge
         fWt2u92bfGOJMrlk64VtFySazc5g+9cQwaK4TG8Ek1fTrUYIA9p5ol/wwsthvkIkHFxf
         8jtA==
X-Gm-Message-State: ANhLgQ331Rff9XgvCYd+pfXDsnZxSANIG4JZ83MBUnKOf0IZb4Keh9oW
        SshHUalBCWg8yw+YfBSUjzp+HA==
X-Google-Smtp-Source: ADFU+vsHcmUVwlqm4sIPILPaC+ui1eO/CnvHSQdEErD3WCvjmIq7Yi9CVOf29Ba2CBzxxYuFMoakMw==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr1942727wmk.104.1583841739989;
        Tue, 10 Mar 2020 05:02:19 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([92.118.13.13])
        by smtp.gmail.com with ESMTPSA id c5sm3745323wma.3.2020.03.10.05.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 05:02:17 -0700 (PDT)
Date:   Tue, 10 Mar 2020 20:01:54 +0800
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
Subject: Re: [PATCH v5 0/5] perf cs-etm: Fix synthesizing instruction samples
Message-ID: <20200310120154.GA11393@leoy-ThinkPad-X240s>
References: <20200219021811.20067-1-leo.yan@linaro.org>
 <20200310054305.GA21545@leoy-ThinkPad-X240s>
 <20200310114503.GA25299@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310114503.GA25299@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 08:45:03AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > Could you pick up this patch set?  I confirmed this patch set can
> > cleanly apply on top of the latest mainline kernel (5.6-rc5).
> > 
> > Or if you want me to resend this patch set, please feel free let me
> > know.  Thanks!
> 
> Thanks, all build tested on x86 and arm64 (with CORESIGHT=1, etc), applied.

Thank you, Arnaldo.

Leo
