Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F94C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724F2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgPW57tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgCKGZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:25:15 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52396 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgCKGZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:25:15 -0400
Received: by mail-pj1-f65.google.com with SMTP id f15so454349pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bt1O8uM5G8pXH1MHWG9pCoJ7EMImXZ7wY9eLxbsFLdA=;
        b=LgPW57tzWWWdp9KgQ0hpT4ZMxdE4CE+5156yW06y5G9NTk8fi4QDfdxtQc38KQTxws
         +pdsUZ+euQv91pReXuvQheDBUPIY8y09YfuEh8UBcqwPN4Vlmey9i0P9BWMwRYS8xyPF
         BEX6ZgDvG2KolqPQB0MKqK22ho6OelCf7WccHLduOeiJyF5rWt5F9KHQC8HwwiRG2f5X
         ZV0Bd2QZ5l8cxJX6C6Svu7mzCbJLs1iVpr78RtAogCcium+Lz0HKKoGHXOFVBSvItQPr
         xo0k7jRJlC2Nme1PS/2BHqxn9gvzmUmFnYUd02b351r+kp53hpfMWgrxoWIPlXa46/YR
         3ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bt1O8uM5G8pXH1MHWG9pCoJ7EMImXZ7wY9eLxbsFLdA=;
        b=VaJTSKGi87ONabVK9ep/EmLEkZm8aTNiG/+GpemJTmVOIioXcM2FMamQhc4c6nYv/W
         ev+k555BqxCsHslp8isH4ijmfGPvtxvCZLladGX/fkT810B9M94vr+sHQf9SY/W+9ugO
         V3K1pcr+DJnB0kwlJoXl7QTL6Bs8xmIfqA9HEKLHr0BjvUINKnhgnBIpyvVeQS1gN8oy
         BpUMdMxTqlYwp2s7rLPIwJc9VYRbfP/DOayXOzowskT61Fc+uKyaetQ/5trjBxd4au8R
         iCHsX9/i6SE3mf5kbmixPMdsTm+J8s0T4fTsTFIgJikSSV6Snv7dGsO+vNLrRGst8QIH
         PPMg==
X-Gm-Message-State: ANhLgQ3BROwJpYJbchAiyXd+9L/zwmlzsGJcJUc+cradjhbZxIi4j7aP
        Og7vj0GyZMwrkGSuw1hDDsU=
X-Google-Smtp-Source: ADFU+vtO8orUpxL98tMF8My0R6rxQboeMUoUFL+xJhiu1WuQLqkbtm3AENqM+1gJVVS9BbO139yngg==
X-Received: by 2002:a17:90a:c301:: with SMTP id g1mr1767437pjt.173.1583907912392;
        Tue, 10 Mar 2020 23:25:12 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id 199sm53153692pfv.81.2020.03.10.23.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 23:25:11 -0700 (PDT)
Date:   Wed, 11 Mar 2020 15:25:09 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, adobriyan@gmail.com,
        akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
Subject: Re: [RFC PATCH 1/3] proc/meminfo: introduce extra meminfo
Message-ID: <20200311062509.GB83589@google.com>
References: <20200311034441.23243-1-jaewon31.kim@samsung.com>
 <CGME20200311034454epcas1p184680d40f89d37eec7f934074c4a9fcf@epcas1p1.samsung.com>
 <20200311034441.23243-2-jaewon31.kim@samsung.com>
 <20200311061836.GA83589@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311061836.GA83589@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/11 15:18), Sergey Senozhatsky wrote:
> On (20/03/11 12:44), Jaewon Kim wrote:
> [..]
> > +#define NAME_SIZE      15
> > +#define NAME_BUF_SIZE  (NAME_SIZE + 2) /* ':' and '\0' */
> > +
> > +struct extra_meminfo {
> > +	struct list_head list;
> > +	atomic_long_t *val;
> > +	int shift_for_page;
> > +	char name[NAME_BUF_SIZE];
> > +	char name_pad[NAME_BUF_SIZE];
> > +};
> > +
> > +int register_extra_meminfo(atomic_long_t *val, int shift, const char *name)
> > +{
> > +	struct extra_meminfo *meminfo, *memtemp;
> > +	int len;
> > +	int error = 0;
> > +
> > +	meminfo = kzalloc(sizeof(*meminfo), GFP_KERNEL);
> > +	if (!meminfo) {
> > +		error = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	meminfo->val = val;
> > +	meminfo->shift_for_page = shift;
> > +	strncpy(meminfo->name, name, NAME_SIZE);
> > +	len = strlen(meminfo->name);
> > +	meminfo->name[len] = ':';
> > +	strncpy(meminfo->name_pad, meminfo->name, NAME_BUF_SIZE);
> 
> What happens if there is no NULL byte among the first NAME_SIZE bytes
> of passed `name'?

Ah. The buffer size is NAME_BUF_SIZE, so should be fine.

	-ss
