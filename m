Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBA4C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3552084D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="qW1fjVFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgDXPjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgDXPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:39:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876D6C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:39:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u127so11305448wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YSBMPH2SiMvyXNhOgsqYroFNDKcMckrugusrbaG1UMY=;
        b=qW1fjVFBbdDldpxEkq1v3UYceJOVKO4e8h+dx18ZHmwBfMeB7tDoIKXT7CJdyE6tFn
         H2yCZ4sCMX16NUANvxE0uJHz4pKUS/QbjFbDAEZg3ZprYH0q4/IYUjEB2EQ1KXRXn28U
         ksRB59kvydHXpIiesXIeQWF19ASwHyX5SA+7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YSBMPH2SiMvyXNhOgsqYroFNDKcMckrugusrbaG1UMY=;
        b=EooL9UwUbB/p22Y9nHeBi/OSwqEGlBV9XPdQ4JGv5Qk5VGSDWJBX62a+cbOobLcGGu
         wFnoh166RmOtDWWGSVEA8d9YiQR0KPnxNWbtorbzR6vuxZweHHuDoilqKKdSt3a4VrkS
         LC1IJpxSHs1snI0sh7jQP024/vaxl6bjWlXfIjl8LOafQZyljC3sCy1VwqmevTTvpc7b
         4jTrmE3/j7H/fadoCSSN7fYg7nAs/rKcnvcDYNtK9vf3jJfrUe5f6eYm+DXfUMNx8/d3
         ZCpO/N6Yjm/8SmTduOTQG6018b7PfjxAtx5Kn78BLci0fvH+MVWg3nJl9x9Qi/UOezxX
         tSlQ==
X-Gm-Message-State: AGi0PuYKvYtDogJNaG94uHPtdX1Iezd2IwKLo3BNrDyfJabIvFXod08y
        s7TlMg/uXscr92gRgCgGjNPRag==
X-Google-Smtp-Source: APiQypKKdDuBIK3RAel7TfdUZEJ9nb6qCSCu/AD3mzsQfBGssktdzJVcFdOgmONYb+33+dUh2wfrJg==
X-Received: by 2002:a7b:c213:: with SMTP id x19mr10552650wmi.53.1587742740012;
        Fri, 24 Apr 2020 08:39:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id f7sm8614173wrt.10.2020.04.24.08.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 08:38:59 -0700 (PDT)
Date:   Fri, 24 Apr 2020 16:38:59 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: PSI poll() support for unprivileged users
Message-ID: <20200424153859.GA1481119@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suren,

I noticed that one restriction of the PSI poll() interface is that currently 
only root can set up new triggers. Talking to Johannes, it seems the reason for 
this was that you end up with a realtime kernel thread for every cgroup where a 
trigger is set, and this could be used by unprivileged users to sap resources.

I'm building a userspace daemon for desktop users which notifies based on 
pressure events, and it's particularly janky to ask people to run such a 
notifier as root: the notification mechanism is usually tied to the user's 
display server auth, and the surrounding environment is generally pretty 
important to maintain. In addition to this, just in general this doesn't feel 
like the kind of feature that by its nature needs to be restricted to root -- 
it seems reasonable that there would be unprivileged users which want to use 
this, and that not using RT threads would be acceptable in that scenario.

Have you considered making the per-cgroup RT threads optional? If the 
processing isn't done in the FIFO kthread for unprivileged users, I think it 
should be safe to allow them to write to pressure files (perhaps with some 
additional limits or restrictions on things like the interval, as needed).

Thanks!

Chris
