Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD55AC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE05024680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFkZivHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgBZPA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:00:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28496 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727078AbgBZPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582729254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XEQXtA92WxEoyYVbPjA9RQHILAt7XDfCFPviC5NGtgE=;
        b=CFkZivHSsHlsIcB7gII0Jbr0m8dLTjN0o8b5RcoPbamHf3yiC3NU4cANvcv0rz3GH1Hadv
        qUVDAA0zcK7x8jQN6UOEtIGLhXnUTOGsMk3hc+ls0JZvahpgXOrSmAMOVSakoKb/MytmTj
        PynM9AkAFyVAg6xgLVy/DRHhfCLOAKs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-YYj90b9yPDCd6RT60cmDAA-1; Wed, 26 Feb 2020 10:00:52 -0500
X-MC-Unique: YYj90b9yPDCd6RT60cmDAA-1
Received: by mail-wm1-f69.google.com with SMTP id n17so760660wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XEQXtA92WxEoyYVbPjA9RQHILAt7XDfCFPviC5NGtgE=;
        b=KvU6RAiym2NFQpI8fpG051SReBi/YW7kgq9XTP0FqjF+UQNM6hbp2m8At7m/po+bDi
         7Q986i6qULOUk6jVoLUd0yoss5F0Ixg7wqjfGtSDW91vF8WApWWVQ48SmKpvIUmrAbgC
         J7KW/sFYYDTzBkHI4WTCy2FGJQnI2RYDbfHGpuGrNuDjMOIoDa9NDjwUlaNbSjmD+v+p
         fny1eIengDr5L0afb7mLmtYGh+yYGmAOswFmLsm1Ps5N6DXhW9bwf2eIxDg4ZCD69Jdv
         d4ElAZUxH6U5fmdA0tsqfiIDjjCBcXNYotVsdBDGQTtAo5DIxrAQ76x/b0n5fHMr5GOQ
         b3NQ==
X-Gm-Message-State: APjAAAWZi3BDwjvOfPRGsp90DI0E/S3XxF7/g8D1YysDWeHpiST0wXCc
        R8zgH1aG3AvUzJKF1kB2FePnL6qE3dPWgFYuDA/erp2rtFAjz2Yld8AjtaR9J0Yh9+kamBfKJ42
        /F2gHEKxJMPQj+G4jzz6gfFRk
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr6009904wmg.34.1582729251468;
        Wed, 26 Feb 2020 07:00:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZJyq+T6M+C5aDD/qf2sTbnPq9hAnwBKqfalQuDoDtsoS99uVrPXleCjhiwjWh3hyPEEv7Cg==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr6009871wmg.34.1582729251234;
        Wed, 26 Feb 2020 07:00:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x10sm3320837wrv.60.2020.02.26.07.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:00:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BBFCD180362; Wed, 26 Feb 2020 16:00:49 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Luigi Rizzo <lrizzo@google.com>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, naveen.n.rao@linux.ibm.com,
        ardb@kernel.org, rizzo@iet.unipi.it, pabeni@redhat.com,
        giuseppe.lettieri@unipi.it, hawk@kernel.org, mingo@redhat.com,
        acme@kernel.org, rostedt@goodmis.org, peterz@infradead.org
Cc:     Luigi Rizzo <lrizzo@google.com>
Subject: Re: [PATCH v3 0/2] kstats: kernel metric collector
In-Reply-To: <20200226135027.34538-1-lrizzo@google.com>
References: <20200226135027.34538-1-lrizzo@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 26 Feb 2020 16:00:49 +0100
Message-ID: <87ftexz93y.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Rizzo <lrizzo@google.com> writes:

> This patchset introduces a small library to collect per-cpu samples and
> accumulate distributions to be exported through debugfs.
>
> This v3 series addresses some initial comments (mostly style fixes in the
> code) and revises commit logs.

Could you please add a proper changelog spanning all versions of the
patch as you iterate?

As for the idea itself; picking up this argument you made on v1:

> The tracepoint/kprobe/kretprobe solution is much more expensive --
> from my measurements, the hooks that invoke the various handlers take
> ~250ns with hot cache, 1500+ns with cold cache, and tracing an empty
> function this way reports 90ns with hot cache, 500ns with cold cache.

I think it would be good if you could include an equivalent BPF-based
implementation of your instrumentation example so people can (a) see the
difference for themselves and get a better idea of how the approaches
differ in a concrete case and (b) quantify the difference in performance
between the two implementations.

-Toke

