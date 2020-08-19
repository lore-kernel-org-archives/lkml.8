Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F2CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E2120738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HfCIuaUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHSS1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgHSS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:26:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DF1C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:26:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id j13so1502555pjd.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fvIFX0if5musGR/AuULcq2bjqGRTVsjqU+8CFLDy+hw=;
        b=HfCIuaUTEFVRCg2xF4Xl2CLjgnUSrDLPxH/LNGSnFxEGH64THvX9qUz3m4bt8HSp5A
         5IOSlR76HwB4xah21PaZoxVCk/d5M2Fet5xlwBPpGNFA8wnWRG9OyQNkRg8KituxX3NV
         MTPc1JXnrxUn7fsZcRSXehWMmRr7FpBpWz7sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fvIFX0if5musGR/AuULcq2bjqGRTVsjqU+8CFLDy+hw=;
        b=O8y2KmGrPPHnSMzh4Bh3x+4hTr84DJ46lcnsDa8FzfRqjzfo/oeEa+elYwWqs5fwwz
         1/2wLm0JJti05y4xfp1UFpivq/f5wsjn0dkmPHXOhcM6VDS1wvA9LAyTs7pFCbNETf/p
         XCGcDmw4vuVLshxqnC+7d5RX3XV2au/TRDqZJ4dfM+m6pDzD7YYODyNHCChOf0L7Yr7r
         c7nG1rFWTASzR9/UekBaUDoltP09bN55FoBFUE24OIsi3bX4gL/9KnNTyQ1Ei84eJ2f/
         DdJK5X2034bdEpCmPl0yVKVc/kDU85csmTMbQ4hx/aDVIgXua9CiC5NkyQlRT/CuYuzP
         /73g==
X-Gm-Message-State: AOAM533zCv+hXABNn1dC0zjOe3oFaaU/lVk/euIfqxsSC6lQWhH4efPO
        1shIgYokMzzNBKSmSrlTuwroJA==
X-Google-Smtp-Source: ABdhPJwxgsz0D4aicIwYdouVEzk6AM/3p47+iWecIKeauBam4yUoUFDdg69JVb1+UpjSN7L/1wYAnQ==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr19250739plb.329.1597861612317;
        Wed, 19 Aug 2020 11:26:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z29sm29495220pfj.182.2020.08.19.11.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:26:49 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:26:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH RFC 00/12] Core-sched v6+: kernel protection and hotplug
 fixes
Message-ID: <202008191116.1A1F51186D@keescook>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815031908.1015049-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 11:18:56PM -0400, Joel Fernandes (Google) wrote:
> This series is continuation of main core-sched v6 series [1] and adds support

- Is this really "RFC"? Seeing multiple authors implies this is looking
  to get merged. :)

- Is this on top of the v6 core-sched series (or instead of)? (That
  series doesn't seem to be RFC any more either, IMO, if it's at v6.) If
  this replaces that series, isn't this v7? I don't see the v6
  core-sched series in -next anywhere?

- Whatever the case, please include the series version in the "[PATCH vN ...]"
  portion of the Subject, otherwise things like "b4" don't really know what's
  happening.

Sorry for the drive-by comments, but I was really confused trying to
understand how this fit together. :)

-- 
Kees Cook
