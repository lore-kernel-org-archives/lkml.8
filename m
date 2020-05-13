Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5D3C2D0FE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598BE20575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SszF5JPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbgEMKGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388621AbgEMKGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:06:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA44C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:06:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f134so13732463wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zU0nB1Ip8ux85FhZzaXr4w0z8K5MqsOQGnZo4jaAbog=;
        b=SszF5JPW3fDKq2WXZ39nc9lt5EoRcBFOKEf7uZel3MJNBA0J7xDYyepZ0GB8YN2VoX
         FyQ3Hp7xbElnfZvb8GtdVWbJQPOtnErTX233RRP744Q6VTMBlG5q+eucT4uCUWIVMPj4
         zFa9/+WUYlcsh/gG1hOn36HQj6yk2mZCB48BqGFRztVd07biYqlPpAnxXb8dZpJCiToO
         VfemMFAHmSwm4hoUFOxJZj2mDlBuZ9fUAqgFkFsiXIolgtHnzH0A8/jBI0hhedCfa1/f
         H7CvfWcHTM+6t7cekF9kiPFDTq0eoRIuN0VsDfnsJRdF0WSZkZhmcAMUgr/0ndRe5Jrp
         eRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zU0nB1Ip8ux85FhZzaXr4w0z8K5MqsOQGnZo4jaAbog=;
        b=BIboFLdbWos6mYQ/dXtI2iwvsZDo2aoI6jlmybBqInZCUUjkTkMV4ItvRsRjf90d5r
         zeBdm5HQ/BopFVcRlaQmUgiHjwwhHa620lxMvWKHOVZKx+TAYrPZ7hyxahlK8XPWnSOX
         x85+d4DedIG5y+oBsab4fRVteaUTcA8w49Sr+cD+kp5+qNPtV+K/5Wz+CKZjFR0zB1v9
         407xdJdQd9MAARRabJxk66I3ul31SgU+O9alCV2aD7NWqSkdQHmf5yFt8wrgV7dOmvxm
         CTPJbRqt2bcN0LoGNGIfKlk7CXzxt95LfCoMnELRb8dYptEjMNlhlwYgmtHPGLBtrBgA
         Dyew==
X-Gm-Message-State: AGi0PuYEwU4JHv+1HILXwsDZGdZtE7lHQpSdmPIsBVbYYYJZaHmuplBL
        CIyYjfKgtendfFXBKsh6e1gX+Q==
X-Google-Smtp-Source: APiQypK2RUITynpf031+51+fINLm92xUpyiGpfNAzJn9+fcZDpMYpGn6iHsaty4IHIxjBH6P5sq3fA==
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr12590358wmj.173.1589364375719;
        Wed, 13 May 2020 03:06:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id l13sm10335380wrm.55.2020.05.13.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 03:06:15 -0700 (PDT)
Date:   Wed, 13 May 2020 11:06:11 +0100
From:   Quentin Perret <qperret@google.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200513100611.GA168476@google.com>
References: <20200512092102.GA16151@google.com>
 <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
 <20200512135813.GA101124@google.com>
 <CAJZ5v0hN708uvurZ-3oo90qUJFw3=Eg0OmtTaOKXQgNPXhCkFg@mail.gmail.com>
 <20200512151120.GB101124@google.com>
 <CAJZ5v0inoge=nWQtv-rU_ReQUMZA5w-PZXuSpHHj1UHn-S7aSA@mail.gmail.com>
 <20200512162630.GC101124@google.com>
 <CAJZ5v0ges4=e2HkHpVk4E1yF1VsBm9H5noqMz-MxX9DK_kt6Xg@mail.gmail.com>
 <20200513094117.GB225140@google.com>
 <20200513100213.GA868852@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513100213.GA868852@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 May 2020 at 12:02:13 (+0200), Greg KH wrote:
> It's not significant at all, just always build it in, no one will notice
> it, it's just a page or two.  Serial port drivers are way bigger :)

Alright, I give up :)

When partners will complain (and I think they will) I'll point them here
and say we tried ;)

Cheers,
Quentin
