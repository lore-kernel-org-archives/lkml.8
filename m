Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D44C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB0A20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yu55m6e0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgBNHsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:48:32 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38505 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgBNHsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:48:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so9638778ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDMP/iMlsFSKAhNbTsv4LG78iIuugxuS+5R4an07o3U=;
        b=Yu55m6e0R8WQA775FlnYEulghk58+/9qINdSt+j/Q+Jt27zfUuRaRilHgLlTv5qpKG
         BciFyd8ZzEnlEOPIdS08RksfxMkQDLIboUyXvIOl7CWM04WAdzp0S6QMA71Bo7G/Ed+i
         EdF+qQaXxZJogPcKGj9lMRPjS3LX3IEiWmrYkZCmrTnnaUdgGkJF93kei7Acs4M3rxQo
         oI7yqsURGPQEoXB2hHzYV6TVixhOk6VzKyzteAz73/r9KAhDsEctSiPIqKe3qOCr7G0r
         KU/oQ3lGywzxEncr0gzwkbLVZtL/zSXj3s+/Bc5YyTXsm7sRfm81g8LCaAd1GFdumUyj
         E9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDMP/iMlsFSKAhNbTsv4LG78iIuugxuS+5R4an07o3U=;
        b=C4GnycIcfjxxK0w7V9RWiFf8TfBCQxGFbt8QIWRJX6xeyi8Gdu57xbOtWX/s3NlbTL
         Knj7zcXlW9mCB2TTOlR4cH8K+eiQm7w070W6JFqmTMpppZj8bbinkQ1CFEq4TAMhOrE5
         /7nDHT/t1ECIWwilBfkGYEgzANcFuhlF67MHa4Z+pQHCRoVzNUxgMiqZhxtjmjPNczNp
         1e4pKqyzUAzBH2m6eqhlKf7KSq03Wq+WIClou6drGdywXKSKt4IujALCjG0/W1l3LXPA
         R5yvUkjkZIEM47FVjkxVJ2HGZlmMPd63JGe9B+NGflDERJzo1rBBEuAga50thAIV6xg3
         Q9jQ==
X-Gm-Message-State: APjAAAVpx6y4gMU+4uiqbICfiR9O9vy0IVewU1Gemrd/rQtYqaHMIcrR
        KhzHLaVaQoxu/SNDtrNgYbfUgv8mieca1Ggtji/gyQ==
X-Google-Smtp-Source: APXvYqwI9wj/WDlBwsOBWlQX9JRZ1Qt5hua3dZfzWGZEb9PZR0p6ZYwyMmrnme6SkDTraHb3Oza5TwWXwDNBBnX0/ks=
X-Received: by 2002:a2e:9596:: with SMTP id w22mr1156786ljh.21.1581666509696;
 Thu, 13 Feb 2020 23:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-5-vincent.guittot@linaro.org> <94eae44f-7608-936d-4fde-dcf93cfa6b9b@arm.com>
 <e997556f-8adc-2165-2e76-ce9b0229c977@arm.com>
In-Reply-To: <e997556f-8adc-2165-2e76-ce9b0229c977@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 14 Feb 2020 08:48:18 +0100
Message-ID: <CAKfTPtBEUJVxUa8k=-fKXKJwwj4VJv0CAh-2xG0j6Z5vG1xVjA@mail.gmail.com>
Subject: Re: [RFC 4/4] sched/fair: Take into runnable_avg to classify group
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 at 19:37, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 2/13/20 6:32 PM, Valentin Schneider wrote:
> >> @@ -7911,6 +7912,10 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
> >>      if (sgs->sum_nr_running < sgs->group_weight)
> >>              return true;
> >>
> >> +    if ((sgs->group_capacity * imbalance_pct) <
> >> +                    (sgs->group_runnable * 100))
> >> +            return false;
> >> +
> >
> > I haven't stared long enough at patch 2, but I'll ask anyway - with this new
> > condition, do we still need the next one (based on util)? AIUI
> > group_runnable is >= group_util, so if group_runnable is within the allowed
> > margin then group_util has to be as well.
> >
>
> Hmph, actually util_est breaks the runnable >= util assumption I think...

yes, that's 1 reason

and also the 2 conditions are a bit different as  the imbalance_pct is
not on the same side of the condition.

For util_avg, the tests is true when util_avg is still below but close
to capacity
For runnable_avg, the test is true  when runnable is significantly
above capacity

>
> >>      if ((sgs->group_capacity * 100) >
> >>                      (sgs->group_util * imbalance_pct))
> >>              return true;
