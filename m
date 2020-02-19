Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CD7C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF3B24673
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjFV7Bpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgBSR5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:57:21 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35637 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:57:21 -0500
Received: by mail-qv1-f68.google.com with SMTP id u10so594264qvi.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ewush9FZQ99JcnNrTcfn2jc4jttJEoZmIN55Ep+JY/c=;
        b=bjFV7BpzBl5/r4KME15BBl/2n+bVTDAncv8sTanHwXAM8jDiGn/sFGDHoK6HtisdkL
         hBnbnQnh9GPF92plI9SY6ltsPWh+4ecUrxf/a//fgPunmKz4CIeskkwjCmOjxVCnBOVk
         eYjw5+AT3sZlpNUSE6Kwwb9AKTI1KZKGx8DU2C67fDVqB4CveQ9/QdbFUbNVwxyFf9Iy
         5SZWkAvun+q3J+jTOP0hTZve6gN6GSXX72J82h7qXfY/6IBTiyV/2LZqoLf+BBFaDsLB
         paB4v5o3XjYsKCBDsVTDib+fS/s90xKawepYrF5to/wv5GiygPwT4JTfKCN7KDw1t66s
         87Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ewush9FZQ99JcnNrTcfn2jc4jttJEoZmIN55Ep+JY/c=;
        b=bKTGemcOwnpChfE5xOXghNnKP+iDVmJaoYmneyb+e4NUBi4ra0pFfWI04/NkDqWslp
         BtBbDgk8+HZfVfFW0ByZvll+NjzlQzVV1VLpokxgRjC7F/yi/BWHevQuxkcnOc5MSNDC
         hG/TTh2mFnXJ9eggMedThIM/FWJPrtbiS6JYkFLiz+ZmgFkdyCzYi7oV7Y5LNunHYxBL
         0zYIr7h03thLNpWcQRlOXwXomhcF65Y2RYEI5DpCPK0hJ0z2GNme36956i+0iuWeS2jL
         ZU+F403TlDZh48xgNf9uU1WPzCrnhQK88ocGFlJVVrLMh4MkoRhfvTXXCrtUPGJI/puz
         jf1g==
X-Gm-Message-State: APjAAAXcSer78XJyK2e9I+3cUbd5cjck7huWv+KhrZOxS1xWcWEXKQ2T
        Ov+Sk0O6ApgbaQHZ1th9MU6eKQSp
X-Google-Smtp-Source: APXvYqy1JFOM36lrk50My1kNeEuMpeOOKtOfPz3NY31uc/Bc9jAPvLQxFdsCW9q/8YaUVArqgLYdwg==
X-Received: by 2002:a05:6214:133:: with SMTP id w19mr5288728qvs.6.1582135039509;
        Wed, 19 Feb 2020 09:57:19 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o21sm196817qki.56.2020.02.19.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 09:57:19 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 19 Feb 2020 12:57:17 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <20200219175717.GA1892094@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200205162921.GA318609@rani.riverdale.lan>
 <20200218180353.GA930230@rani.riverdale.lan>
 <20200219120938.GB30966@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219120938.GB30966@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:09:38PM +0100, Borislav Petkov wrote:
> 
> You keep pinging. Why? Is it a showstopper or what is the urgency here?
> 
> This is shaving off some 100 - 200 KiB from the final bzImage, AFAICT. Or
> is there something more broken this is fixing?
> 

There isn't any particular urgency (at least until fg-kaslr patches try
to make it 64MiB bigger), but it's unclear how long to wait before
sending a reminder -- Documentation/process suggests that comments
should be received in a week or so, pinging after 4 and 6 weeks seemed
reasonable. If x86 has a longer queue, might be worth documenting that
somewhere?
