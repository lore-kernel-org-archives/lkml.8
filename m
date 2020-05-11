Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2087CC54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 05:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3F82192A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 05:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdDOkdm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgEKFVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 01:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725817AbgEKFVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 01:21:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B585C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 22:21:46 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so4243411pfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 22:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z99sLoNJtvUPb5Oimy7/Ab89RPlq4LmhubC3XgJRemk=;
        b=QdDOkdm3armA+UkqeDUI8uWIroEDHSaYNvrr4VtGNWVIFrFo/etGIyX800wKwlfa5q
         oGjtaEa0g2f4LawzX3D+qPqLg1IT+hmn+jz4LE4ATT6ZAvc+h4ODPMqZubBSVObx0qh+
         rktIuB5m9Nub3X6gvdpdt/o4LOqI/u8bZRjIcqmN0xAdzuDMPbplG9KswC+J2ZvFf918
         qRna5DApJzMlYqIQhVouVzxQ4RRgIUWfhk4Znz6rxvMTxshnPe9vImq8WYGoTka2skes
         UbrF889Y3uzhYGyxsovIbXR1ux0uVe+odeHMapgON28crbNfVN3BVpKAtQGIGKS8fvgd
         ZEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z99sLoNJtvUPb5Oimy7/Ab89RPlq4LmhubC3XgJRemk=;
        b=kVhFeAlAhdjzQiupM6i72NMtDbPJdnzNHjKdVifu9ynnNYmYEWT3wQnsbOylW82WlL
         r09aXCRCl3jO2Ts8Dk1bzyEgy7x4nNxLWUG/w2zpo+3NVzEhgyClDdMtuW2AZA0AKn9L
         6PrBSrx9Wsfxo0l5iqxaWw8uRHIt1uJ7f+en6AJ4dnUfMpNBH9etlne7oioW8FY18pZu
         7Fi5ddtWPccKErzm51BUhjWbCpzlXFbTXKti51GPMY1oFNeXXuUW2a0o1tt1KYzY8KLk
         OlCxMrsxMw8TA6vMocCyKVyGHYxwaKxJbkiM8xgYxK/YDNDGs8/1ox6dXP0t58h3hWD9
         Br/A==
X-Gm-Message-State: AOAM533uA0kPQ6fO8J2iORbsxQBxFEv67afeS6le0dhRDdS+s/Wk5a7Z
        NWo7susPhOKFBA82tfH13zUuHw==
X-Google-Smtp-Source: ABdhPJy5If8k0d87yf9zR6j4eLkbVal8JbArOgQGRcuw/Z5nthLe/i9OHHVLXY1wFyTehEaMPXJ/yw==
X-Received: by 2002:a63:4cc:: with SMTP id 195mr627586pge.294.1589174506092;
        Sun, 10 May 2020 22:21:46 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id w11sm7976422pfq.100.2020.05.10.22.21.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 May 2020 22:21:45 -0700 (PDT)
Date:   Mon, 11 May 2020 10:51:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, rafael@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200511052142.s2zjxuv44dqx3ta2@vireshk-i7>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com>
 <20200508112609.GA5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508112609.GA5298@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-05-20, 13:26, Peter Zijlstra wrote:
> At the very least there's that interactive governor that's really
> popular with Android. But IIRC there's a whole scala of home-brew
> governors and tweaks out there.

I removed interactive governor from Android long time back :)

-- 
viresh
