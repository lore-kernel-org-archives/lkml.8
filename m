Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C81C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 21:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687772071C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 21:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KySX/5fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgEYV5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 17:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgEYV5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 17:57:44 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5292C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 14:57:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so21753661ejd.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ygv3hKYyxoJ21smt2XHpzFB98SdmJo0Fen2E4n/642g=;
        b=KySX/5fm4SJFwvAgGOspIoxqlcVsD8lHdgJBeJacNDvf2nP/MFMdap5rhjg0Fi61ni
         fOWd7mNg6qLY1wiyzKsYO3BlrwlazZafThOlmUkFfk6CTs1d5t/4rgxRLwYQiqgjy8XG
         N7GH1EvukmjjrCO5VV64cborcLjV1kc+Q3B1hyLCCubzR/gLpfoFC+zCfUeSAiy6LqXQ
         2sTLaGBWn3fUQyHfx92TEoZjbVOWieXoi1nWO28PXu5N1iBLJ4l9hI00lXoZlycVrsbe
         KaeegDrKNGGwuzBOIxt3JhLm/H+TADID+BzvqEec3/CsjTGaJAyNNBV+neOIj9CSw31+
         TrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ygv3hKYyxoJ21smt2XHpzFB98SdmJo0Fen2E4n/642g=;
        b=Dycuc9YWLAKbES80n7x4RW65C1k0RrFZZsOD3KvcFaWIp2fWmirZDvr2hZ0VhYkEtB
         DlxKX/H4tRmlPX7KxIXHf2yhmnWDSdVBOmOfltp4STF5sbSELyS4TOUN9S7JZZ46S2pj
         zjOCx6w3LVu7H1a//4faoQukLsmlGUg8D5OkVG6yCaheeSyVkr5fRoRROJzvM0ZY6sv2
         j2cdFUzYTjj/eJ9wLXideO6xNq2pI1wEtxoHWNWsmesPsDy50oJ4MnNllIqf21KrKlbW
         M2qP2+EArjmw6+inSEuh9dTrrgiAmTUGu8qp6J9OyQhFA5mLZo5bl93BkMfgRZzSG966
         NQew==
X-Gm-Message-State: AOAM53396JCuyWF5s97/y8JARddDezbAI9fChhIw19zXiqnJXAXEXXMZ
        z47DiJJFN64GOTu4olLzZd4=
X-Google-Smtp-Source: ABdhPJxp1QWOZSGqMKA63d1P3jdt/D3ESink84uGA13jjfugkF72wpq1H+4YWbv87IZXZ5f/OgZjMg==
X-Received: by 2002:a17:906:398:: with SMTP id b24mr21239585eja.44.1590443862471;
        Mon, 25 May 2020 14:57:42 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id fi9sm16043835ejb.5.2020.05.25.14.57.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 14:57:41 -0700 (PDT)
Date:   Mon, 25 May 2020 21:57:41 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: simplify get_count_order_long()
Message-ID: <20200525215741.zd3gry4yyqqplix6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200524123551.9469-1-richard.weiyang@gmail.com>
 <20200525091458.GK1634618@smile.fi.intel.com>
 <20200525144312.mbw2z3ydncyasvss@master>
 <20200525153216.GD1634618@smile.fi.intel.com>
 <20200525134110.5737dd603d5fa1230e2f7ece@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525134110.5737dd603d5fa1230e2f7ece@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 01:41:10PM -0700, Andrew Morton wrote:
>On Mon, 25 May 2020 18:32:16 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> On Mon, May 25, 2020 at 02:43:12PM +0000, Wei Yang wrote:
>> > On Mon, May 25, 2020 at 12:14:58PM +0300, Andy Shevchenko wrote:
>> > >On Sun, May 24, 2020 at 12:35:51PM +0000, Wei Yang wrote:
>> > >> These two cases could be unified into one.
>> > >
>> > >Care to provide a test case which supports your change?
>
>I hurt my brain convincing myself, so I got practical:
>
>
>int fls(unsigned int x)
>{
>	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
>}
>
>static int get_count_order(unsigned l)
>{
>	if (l == 0)
>		return -1;
>	else if (l & (l - 1UL))
>		return fls(l);
>	else
>		return fls(l) - 1;
>}										
>
>static int get_count_order2(unsigned long l)
>{
>	if (l == 0)
>		return -1;
>	return fls(--l);
>}
>
>main()
>{
>	unsigned i;
>
>	for (i = 1; i < 64; i++) {
>		printf("%d %d\n", get_count_order(i),
>			get_count_order2(i));
>	}
>}
>
>
>> > 
>> > Hmm.. where should I put the test? tools/testing/selftests/ ?
>> 
>> I guess into test_bitops.c [1]? I though it eventually should make kernel, but I don't see it.
>> 
>> Andrew, can you apply that or do you need Jesse to resend?
>> 
>
>Got it.

I see the patch just merged, so I suppose to add the above test code into that
one?

-- 
Wei Yang
Help you, Help me
