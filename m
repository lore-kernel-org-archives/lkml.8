Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414B4C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 04:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1437C21835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 04:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORc9oamB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgAWEpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 23:45:19 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35605 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgAWEpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 23:45:18 -0500
Received: by mail-qt1-f194.google.com with SMTP id e12so1543458qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 20:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rnHpCGV92LpDcYVnnbgJoWD9Pug4o0aRSlq+bN0P9tQ=;
        b=ORc9oamBp1MGZWgtVkzbSf0XuJt+suUOyMpgwDLUFJv4w5O4TRQKcbfXqHUqv8Rrb3
         jpHxGXbEXzjv03PHkIyyornYUO8n4zDPTrYMr0Qs7HPXyvOPnlicmMZNlLG0YPSoj+cn
         nOD7kUQeGbQ0LDM4NmQKX2kPHta8QexYMF58PgKFnJgEcvx8qbslCgHZxLjkIcku8rj6
         q8EIf3/GiU+1iDhjs5DzAyHxzJuzh0fZvTy2gbA0PKOCdo+9Xsk/i1T1s+jRMcB8xhds
         bQgZ/5Wmr14J+64ockJpj+DO7Wa8U109onx02U2lE6W+OEuVwqunoZT1Dwq4uRyP/Dlf
         3HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rnHpCGV92LpDcYVnnbgJoWD9Pug4o0aRSlq+bN0P9tQ=;
        b=Pw3WyZRf1s59hb2wJ5J9YAXVBPMoqRepQNZOVEMT9ifudu4G5XiDbw5qwlP7kXJL60
         poLl/IUpxOWZSvffxG3Hu3Ku2UEf7cBXBj4JIJEO3KBvNHpGyWcHIGadysW/cgb5LkNx
         89pB3xOs9omQ+7gXXnEGJgZW2Q8RWvHNpGcEFgV/d5QGH7ySxFq2AHPDJIZGlWNPi/fZ
         S9GFyLbfOFVuNcGBnEvWLaq8Iq3x+DuwZA7qXxRiQmlkTxqa1DD+Y19giy77QafdIMoq
         YIqP3YwAPmCTv4Ih3k7R5cpBmnMFXGSqakXfAlXyKVZTxe+0oixOftrrDwuTJe9jvc8n
         DOfg==
X-Gm-Message-State: APjAAAVmv4UA4uNgelM/mTNHHXTh0YDu+kTREikn3x/cPQ+Ts2y53P26
        6o8aU2kyQz0HMtdIUeUBTa0=
X-Google-Smtp-Source: APXvYqxNcUwH//oHzxkyRnWgyRfkUcdOBycZX/mcqQeVrzwklUAX4zbpE7mmLO3TP1W2SFLgIVy4DA==
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr14535239qtu.2.1579754717689;
        Wed, 22 Jan 2020 20:45:17 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s11sm382232qkg.99.2020.01.22.20.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 20:45:17 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 22 Jan 2020 23:45:15 -0500
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v13] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200123044514.GA2453000@rani.riverdale.lan>
References: <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
 <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 07:53:59PM -0800, Luck, Tony wrote:
>  
> +	split_lock_ac=
> +			[X86] Enable split lock detection

More bike-shedding: I actually don't get Sean's suggestion to rename
this to split_lock_ac [1]. If split lock detection is able to trigger
some other form of fault/trap we just change the implementation to cope,
we would not want to change the command line argument that enables it,
so split_lock_detect is more informative?

And if the concern is the earlier one [2], then surely everything should
be renamed sld -> slac?

[1] https://lore.kernel.org/lkml/20200114055521.GI14928@linux.intel.com/
[2] https://lore.kernel.org/lkml/20191122184457.GA31235@linux.intel.com/
