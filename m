Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938D7C35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB9124650
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582600538;
	bh=4/738ROLcMk6EwkI0GXh9S9IDhGAtYOzpN5m2pdwMa8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GPakBc7RW5H7+Ut3BpdhEMBh7rq9XVOXN/d2EVw5R2yI1k6NkdAbyGFgZYMo3/DxS
	 o1JM7cWj4V3SKCredUSdLDkRjz7xuX/YMHHyliJfINFRe2U0Fdb5HkZx8DjGSX2y82
	 PNsQm3DqIndx1/g74wx8yCboWiO1fd7SkcT9BEuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgBYDPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 22:15:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37444 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBYDPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 22:15:35 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so8495296lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 19:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5iO+nfOzfSwxO6ToL6xARGMrYF2zRJGQAu030DOWTo=;
        b=P6H/YKWKyDVsql7YMRodJEnjF4ZNaNn5Pk68Y7ZSMh+oX50E9/cBWKJ+0YfbeZGqvq
         wnsLwom/z89O9knX0O4dSodyQyI4C4JoP17iZecB4gxQt+0FP9nBfB5hduHcyDmJTSlx
         xBEO8Fj+XkTYXxuEaJY7w9EL5Wu0GPbiNcpU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5iO+nfOzfSwxO6ToL6xARGMrYF2zRJGQAu030DOWTo=;
        b=tj9at0WklyzgAOpH/8wVvM6PglYwVPybQWVdH5UAo0XJBqmNybIu62j43FG4Dur8Cl
         dgbl1iTbXtWpmDLWS11U6gPmr+o2f19UXDqE6MMx+zoVc3n2aFKSfaC7GQzOo+0B/82T
         adPkmpR/DX+ReAyuZz537t+2XdlG31vZX1qc2IoE8kCZGZQnRUdP4KsI1ZWHMWpgYAwC
         /sim3IyFiPCLXSMW7ur9KNJHUvBNit3bQlVFvT1PhvSYnXk0BxCO1hADEj/aqZi/i2dw
         zRm1cuHoBfgJ69+VYxwJ07VOq9TTrCsfcI3PooQQOpMrapu8wWHAZqsxR7aP3BtynmRz
         1IMg==
X-Gm-Message-State: APjAAAWZsIrFSqiPzjmdL3yTiJkj02e9dV6mjw4PDADMPiNBDo2cLD9l
        Qm1UE0/g+4dBenQsO3viUI8cE7DW+f4=
X-Google-Smtp-Source: APXvYqwTDJm6Gt+cUPcAxho0at2OL9N4i5hOIRiGCtZj8buEO6ujd1gZG6bLjROW5M3GYP7s3igi2A==
X-Received: by 2002:a19:5e41:: with SMTP id z1mr29153056lfi.101.1582600533197;
        Mon, 24 Feb 2020 19:15:33 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id n132sm1903733lfd.81.2020.02.24.19.15.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 19:15:32 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id w1so12383268ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 19:15:31 -0800 (PST)
X-Received: by 2002:a2e:909a:: with SMTP id l26mr30710614ljg.209.1582600531273;
 Mon, 24 Feb 2020 19:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20200221080325.GA67807@shbuild999.sh.intel.com>
 <20200221132048.GE652992@krava> <20200223141147.GA53531@shbuild999.sh.intel.com>
 <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
 <20200224003301.GA5061@shbuild999.sh.intel.com> <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
 <20200224021915.GC5061@shbuild999.sh.intel.com> <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
 <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
 <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com> <20200225025748.GB63065@shbuild999.sh.intel.com>
In-Reply-To: <20200225025748.GB63065@shbuild999.sh.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Feb 2020 19:15:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wisa2xZHaCV=kh3seU-1kFDTjyWW9Ak3w5HH8nDvv7Snw@mail.gmail.com>
Message-ID: <CAHk-=wisa2xZHaCV=kh3seU-1kFDTjyWW9Ak3w5HH8nDvv7Snw@mail.gmail.com>
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, "Huang, Ying" <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 6:57 PM Feng Tang <feng.tang@intel.com> wrote:
>
> Thanks for the optimization patch for signal!
>
> It makes a big difference, that the performance score is tripled!
> bump from original 17000 to 54000. Also the gap between 5.0-rc6 and
> 5.0-rc6+Jiri's patch is reduced to around 2%.

Ok, so what I think is happening is that the exact same issue still
exists, but now with less contention it's not quite as noticeable.

Can you find some Intel CPU hardware person who could spend a moment
on that odd 32-byte sub-block issue?

Considering that this effect apparently doesn't happen on any other
platform you've tested, and this Cascade Lake platform is the newly
released current Intel server platform, I think it's worth looking at.

That microbenchmark is not important on its own, but the odd timing
behaviour it has would be good to have explained.

And while the signal sending microbenchmark is not likely to be very
relevant to much anything else, I guess I'll apply the patch. Even if
it's just a microbenchmark, it's not like we haven't used those before
to pinpoint some very specific behavior. We used lmbench (and whatever
that odd page cache benchmark was) to do some fairly fundamental
optimizations back in the days.

If you fix the details on all the microbenchmarks you find, eventually
you probably do well on real loads too..

           Linus
