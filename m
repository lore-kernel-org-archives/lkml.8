Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5A1C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAE220873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583866101;
	bh=UoXJdEEKzECIcCSHrxLeDArfTEy5XBQEHi5a5pGCDUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a3VNXmwYlIrq4rOPAeE7ARhxBvpORK1v2E2aotS/LVhVIRbVOGHfnGjraixhF3Ri6
	 SZ083H8zp5x+QwlcCYVGLp1WzdFzxenQ3amsMTNNoobfp6wVvBWgJiyUrd1I/fHQ7k
	 gp/OdVQ44hWW5JeRqk5yPuKFI08K+yL0T9OV3wQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgCJSsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:48:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35786 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCJSsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:48:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so17276989wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 11:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=faj4Gnv3ao1AYalzRRSD4ZhnRIS4F6sDhppOSlAm8cg=;
        b=S9TRnxeKkA43VAS0Qykppksx1pmQ7QLn1qgc2Y4KfwWEQnVYQw5B2ZyBfy3giegCVM
         6mj/TwtxgMHlMAmr1/SdywooC2TZN1RfB8kx9T1fl4ssYj9YuRcDr/+MNiY4qMOasATo
         OiyXAKLBlbbkdjihmvfor4bGEXzOZU86wCtuoYfDc8537Y5qREHTkdYm/40/31aT79Bm
         vpXsJrNu2IGttKYP/07vMtxu1uCQBXWa7rksl8DFFhGwgYwKQhI63Q6WYy3GzwlG9CRE
         DU0HWp+dKnLWhctkINkiuOM1g2zn9sLDlQv5bLKtq3IHRUj+64Tfwa8p6+cN4uouJ/3N
         ilBw==
X-Gm-Message-State: ANhLgQ2NdVrpLlKoqYZnABqhliCRqosKBA6CFxWxJrDMqrN4OUrjUI15
        0VQgAxHJ5RBypS/mveLlCxMTYlAV/I8=
X-Google-Smtp-Source: ADFU+vvvvXe3gYO63vIzXpyJejrK0vbmhPUZgnsZtDYuXrKXHRkybLQuppeHuZyOfjZbQ8Dub0Smcg==
X-Received: by 2002:adf:e906:: with SMTP id f6mr2623231wrm.108.1583866097007;
        Tue, 10 Mar 2020 11:48:17 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id w15sm2934119wrm.9.2020.03.10.11.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:48:16 -0700 (PDT)
Date:   Tue, 10 Mar 2020 19:48:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200310184814.GA8447@dhcp22.suse.cz>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 19:08:28, Jann Horn wrote:
> Hi!
> 
> >From looking at the source code, it looks to me as if using
> MADV_PAGEOUT on a CoW anonymous mapping will page out the page if
> possible, even if other processes still have the same page mapped. Is
> that correct?
> 
> If so, that's probably bad in environments where many processes (with
> different privileges) are forked from a single zygote process (like
> Android and Chrome), I think? If you accidentally call it on a CoW
> anonymous mapping with shared pages, you'll degrade the performance of
> other processes. And if an attacker does it intentionally, they could
> use that to aid with exploiting race conditions or weird
> microarchitectural stuff (e.g. the new https://lviattack.eu/lvi.pdf
> talks about "the assumption that attackers can provoke page faults or
> microcode assists for (arbitrary) load operations in the victim
> domain").
> 
> Should madvise_cold_or_pageout_pte_range() maybe refuse to operate on
> pages with mapcount>1, or something like that? Or does it already do
> that, and I just missed the check?

I have brought up side channel attacks earlier [1] but only in the
context of shared page cache pages. I didn't really consider shared
anonymous pages to be a real problem. I was under impression that CoW
pages shouldn't be a real problem because any security sensible
applications shouldn't allow untrusted code to be forked and CoW
anything really important. I believe we have made this assumption
in other places - IIRC on gup with FOLL_FORCE but I admit I have
very happily forgot most details.

[1] http://lkml.kernel.org/r/20190619132450.GQ2968@dhcp22.suse.cz

-- 
Michal Hocko
SUSE Labs
