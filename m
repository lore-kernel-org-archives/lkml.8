Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6893CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3247C20721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="b9jsebrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgEUNtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgEUNtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:49:15 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9451C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:49:14 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id r3so3095135qve.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=J+C1gfkSjYLne9keDCP2UNyXwOjB62jHfW7cgQObU8s=;
        b=b9jsebrfPmlbjKXFmG0YOx9tS7DFt1dWq3yu9lj9Zy2a794TG5RNkoOBzQQgfxnVJ+
         R0+KYEXfPbFsFQeeOXsFN8KHLDqnxdnR/HCKIwNly9lM5VPwY5HvIBZvLQ0xN1fNwlYz
         jTIRWtXS5UjPp4yUzk/ZSEln0UaTVdNfrxpQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J+C1gfkSjYLne9keDCP2UNyXwOjB62jHfW7cgQObU8s=;
        b=F9P9zNm9B00d7Fns+3LoDQikR/fZZNf5Ojx2HqCTaN1orfJ/pDsgnVi8wIIsbQ9cr5
         LpGVGEVsUzy45lIXG3gwBp1SdQsUjnCB9wT6sgAlqxIeeAbAwI9NPb2Zf1IiReeRCx+h
         8NOUa4qITjI1Ih6UvYEKGNjidEtb6gzTdCtuYcHVWJZPF8YQMsA7nvLaGJo2/IxJyOQs
         t3sflL3WdTHTMsAVsVTv3r9y4nN1nmFf/Thal/9LvDofU5v2ftD7ONMgJYv0IW1fLNLQ
         ltL6Qwko4p1bIZn9k21cT7Nz7fYh0ACz8eTnsKTqYtOgcONAvPsV2xT9l7EEoFqnpvjt
         VGqw==
X-Gm-Message-State: AOAM533oPtvAgrCyh7AZXwSG83D2ZSw/VNhM2YKwnN4C0NDVoHZvQop6
        bY4wl8nnUnMt3rDm2bodsZTd8g==
X-Google-Smtp-Source: ABdhPJy/BZJ+Um73LfAOvwd50rtJIWV9Gq956NWaJ0Sn3QXJpPu3N2TuR1EbzOsmXc23Jv8+Wzq0aQ==
X-Received: by 2002:ad4:57cb:: with SMTP id y11mr9944990qvx.26.1590068954041;
        Thu, 21 May 2020 06:49:14 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d140sm4287727qkc.22.2020.05.21.06.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 06:49:13 -0700 (PDT)
Date:   Thu, 21 May 2020 09:49:13 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pjt@google.com" <pjt@google.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        vpillai <vpillai@digitalocean.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kerrnel@google.com" <kerrnel@google.com>,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling
 interface(Internet mail)
Message-ID: <20200521134913.GB140701@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org>
 <71B72E96-CD6E-43C3-B22B-ADE0EC78C550@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71B72E96-CD6E-43C3-B22B-ADE0EC78C550@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 04:09:50AM +0000, benbjiang(蒋彪) wrote:
> 
> 
> > On May 21, 2020, at 6:26 AM, Joel Fernandes (Google) <joel@joelfernandes.org> wrote:
> > 
> > Add a per-thread core scheduling interface which allows a thread to tag
> > itself and enable core scheduling. Based on discussion at OSPM with
> > maintainers, we propose a prctl(2) interface accepting values of 0 or 1.
> > 1 - enable core scheduling for the task.
> > 0 - disable core scheduling for the task.
> > 
> > Special cases:
> > (1)
> > The core-scheduling patchset contains a CGroup interface as well. In
> > order for us to respect users of that interface, we avoid overriding the
> > tag if a task was CGroup-tagged because the task becomes inconsistent
> > with the CGroup tag. Instead return -EBUSY.
> > 
> > (2)
> > If a task is prctl-tagged, allow the CGroup interface to override
> > the task's tag.
> > 
> > ChromeOS will use core-scheduling to securely enable hyperthreading.
> > This cuts down the keypress latency in Google docs from 150ms to 50ms
> > while improving the camera streaming frame rate by ~3%.
> Hi,
> Are the performance improvements compared to the hyperthreading disabled scenario or not?
> Could you help to explain how the keypress latency improvement comes with core-scheduling?

Hi Jiang,

The keypress end-to-end latency metric we have is calculated from when the
keypress is registered in hardware to when a character is drawn on the
scereen. This involves several parties including the GPU and browser
processes which are all running in the same trust domain and benefit from
parallelism through hyperthreading.

thanks,

 - Joel

