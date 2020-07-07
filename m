Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C3EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F47206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594123586;
	bh=KxgfClRFzGLf98/Yqu+Qe5gZQnfvtwnqVejlfIOAkjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=smSl99VErB+P4hwDQb6cNhTJVoehV/oyYbqQfcim8U8XXMERXFNdH2pRLcrM2QYT6
	 YZ5RldniGlFOqL/UZtcqt6a+dP6XJ+nIJAjw81kKfCL2ogy/oRgLS1Gkk+QdKyCJdm
	 PNvWBXBHUIHEuLMKJx4CoFoVKEPPHsGoFhCpbPmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGGMG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:06:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45001 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGMGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:06:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id b6so44850642wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4wU011wHSnWuBlHf2T56JsZw7TsOaUVP+MGeL9UXru4=;
        b=DTtETGPO6OAljirHWkJwk255j8riYZZowzArTTsxtZ/Ay980al4YuYorqd2/WvJVO3
         maSAQ/hPQrTDKGhc6/8SqKFSJfMyA1HkqB88WaYSepK2mFeu+rRnGCI021B+wr7GgknJ
         b1YRJOBvyZE3SJPB8oCOaJGiNnZelahx3W8FAW/OClXqmxpZYkcXFQjrgTmAcKHNg18L
         DVgMBTftvqFDi0pxY7z736ckuaG3RgZUxdk6TVg5343fEx/TvwCAia+qth2e06y/ecba
         sFmYG/fXlniOtdMRVt8VyyouhvFBxw94HL41vzlGwar0VHR59LQUMspqN8e8IZHiSJd2
         Xl1w==
X-Gm-Message-State: AOAM532sHnIS5mt4kByTnBmjVh2lOSrcq5U4Zk9TVwlPuuJKqFkFUQl1
        f9sZO4EIvNIURzT5Ld76wmJqjRfA
X-Google-Smtp-Source: ABdhPJyOPID0b4MJHIKKkNKsXwgnltSadf5kAcW0ldbS5sUjQj7VgNJjuvH1p99u9tTBvKWUo5XsyQ==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr52821643wrq.184.1594123582099;
        Tue, 07 Jul 2020 05:06:22 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id n14sm722767wro.81.2020.07.07.05.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 05:06:21 -0700 (PDT)
Date:   Tue, 7 Jul 2020 14:06:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200707120619.GO5913@dhcp22.suse.cz>
References: <AF8CFC10-7655-4664-974D-3632793B0710@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AF8CFC10-7655-4664-974D-3632793B0710@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 07:43:48, Qian Cai wrote:
> 
> 
> > On Jul 7, 2020, at 6:28 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Would you have any examples? Because I find this highly unlikely.
> > OVERCOMMIT_NEVER only works when virtual memory is not largerly
> > overcommited wrt to real memory demand. And that tends to be more of
> > an exception rather than a rule. "Modern" userspace (whatever that
> > means) tends to be really hungry with virtual memory which is only used
> > very sparsely.
> > 
> > I would argue that either somebody is running an "OVERCOMMIT_NEVER"
> > friendly SW and this is a permanent setting or this is not used at all.
> > At least this is my experience.
> > 
> > So I strongly suspect that LTP test failure is not something we should
> > really lose sleep over. It would be nice to find a way to flush existing
> > batches but I would rather see a real workload that would suffer from
> > this imprecision.
> 
> I hear you many times that you really don’t care about those use
> cases unless you hear exactly people are using in your world.
> 
> For example, when you said LTP oom tests are totally artificial last
> time and how less you care about if they are failing, and I could only
> enjoy their efficiencies to find many issues like race conditions
> and bad error accumulation handling etc that your “real world use
> cases” are going to take ages or no way to flag them.

Yes, they are effective at hitting corner cases and that is fine. I
am not dismissing their usefulness. I have tried to explain that many
times but let me try again. Seeing a corner case and think about a
potential fix is one thing. On the other hand it is not really ideal to
treat such a failure a hard regression and consider otherwise useful
functionality/improvement to be reverted without a proper cost benefit
analysis. Sure having corner cases is not really nice but really, look
at this example again. Overcommit setting is a global thing, it is hard
to change it during runtime nilly willy. Because that might have really
detrimental side effects on all workloads running. So it is quite
reasonable to expect that this is either early after the boot or when
the system is in quiescent state when almost nothing but very core
services are running and likelihood that the mode of operation changes.

> There are just too many valid use cases in this wild world. The
> difference is that I admit that I don’t know or even aware all the
> use cases, and I don’t believe you do as well.

Me neither and I am not claiming that. All I am saying is that a real
risk of a regression is reasonably low that I wouldn't lose sleep over
that. It is perfectly fine to address this pro-actively if the fix is
reasonably maintainable. I was mostly reacting to your pushing for a
revert solely based on LTP results.

LTP is a very useful tool to raise awareness of potential problems but
you shouldn't really follow those results just blindly.

> If a patchset broke the existing behaviors that written exactly in
> the spec, it is then someone has to prove its innocent. For example,
> if nobody is going to rely on something like this now and future, and
> then fix the spec and explain exactly nobody should be rely upon.

I am all for clarifications in the documentation.

-- 
Michal Hocko
SUSE Labs
