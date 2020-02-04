Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ED1C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 18:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CA52082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 18:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="v0LrEskK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgBDSza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 13:55:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46678 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgBDSza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 13:55:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id g195so19004749qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 10:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DKe72S+VluXSCZ29PD9XHCSnv/QjEL3zPcDFXshWPUw=;
        b=v0LrEskKg/nWdHwgB+hV5I+k4ySmZ3vRd+SrZeLqSjZEP3ZLka8vOr3He6SRg0nmoC
         GX1DivbnZexrz5+6z5YUUNkXgk9yre+qig4gt6TLHysClSG1BrQHNAw+7WLNzpy1dfJr
         aT66fFItBhHz6FaavZpGAJ7z1A+hHYeqC9SEUTYB9qum6DItbyCAUgdKdeAE8XRywO1m
         0iWnktP7vZFSdF3B6yP2J2WsWtDlG8shAqtllLn9YecG/y6cVsW1LD7mM0oLpWnDYJ6q
         L6qnCWjNSVunzkHct3KY/M9XqiuAeC6LBRXNcw/q2Xv5P0KmjqQbkxOmR+tMmhOPKTTg
         hEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DKe72S+VluXSCZ29PD9XHCSnv/QjEL3zPcDFXshWPUw=;
        b=Qde00fZRsv4qg2/McwXcDpZHz2Gpw/N93FwzuTNpbptSNn5G81vOMTgDzHc/GYHoNe
         L7Ee3w9AZeVmiOlo9H2bVEXuMWdsPjSB2CDn3EqH9/STPt5rpzBUYtnqopU4Tg3K8TGl
         KaMuOWMb/K2q7mRG+5qvdA1NHNC76u9ZmMKsUPjJeFk/0bYimSXYPd8Ysx6hawW7krb1
         oClxU0g+Jb4g+lmxuZxM0FaiUa/yd31YnjT+0i4XRSmTLZByfJ3rr8+unhqYGZh/56JP
         kD9htxHdrnDyb6E0btT1JKf+e1bS2iJN6NafNi82O9pHIdtAuSEdXwOovn3xyfSe77EZ
         vm7Q==
X-Gm-Message-State: APjAAAWzcntIF1VwOnOKCCYcIAA6PczVdVAvFtg/N+noKxXUwkFf+gJx
        ojmNmmYoPR4iKhCy8MlI0qyWrw==
X-Google-Smtp-Source: APXvYqyhg3j8wJ4RBlkvcmcr1AJfQnl19/ksJub8hstGC7Ig/HN5xzyrAj1yjXJYaKprlPJde7sBsA==
X-Received: by 2002:a05:620a:20d9:: with SMTP id f25mr3208051qka.375.1580842524610;
        Tue, 04 Feb 2020 10:55:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::bcd8])
        by smtp.gmail.com with ESMTPSA id q5sm11504592qkf.14.2020.02.04.10.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 10:55:24 -0800 (PST)
Date:   Tue, 4 Feb 2020 13:55:23 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] psi: Fix OOB write when writing 0 bytes to psi files
Message-ID: <20200204185523.GC9027@cmpxchg.org>
References: <20200203212216.7076-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203212216.7076-1-surenb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 01:22:16PM -0800, Suren Baghdasaryan wrote:
> Issuing write() with count parameter set to 0 on any file under
> /proc/pressure/ will cause an OOB write because of the access to
> buf[buf_size-1] when NUL-termination is performed. Fix this by checking
> for buf_size to be non-zero.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Suren.
