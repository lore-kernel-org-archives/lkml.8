Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD03C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744582073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="O+9wu3Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEQJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:09:32 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40971 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEQJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:09:32 -0500
Received: by mail-qv1-f66.google.com with SMTP id s15so2644042qvn.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YFJQskCNWVXuMbTVUr/PuWgn4wVuFnn3nZZ9fMSzuBk=;
        b=O+9wu3BfAMHUjSBZqShEq7hMfSVcLTfHQH3cPXWeDLhMdWns+lMT2fjlIuVY1xcidZ
         r4aOTQjLqDmz1oGNL0DlWKypSa0m3yZsnU98baSb735BbZLpwMdBa8ezdluL9EQhAfjQ
         WrqEGLIjEEzTA76rzJUhPVQYxwdyqC/HlQ5i15gGol/dcdcCgy5ZTMSn9xCotqoHeL/z
         LVSdPNoJnFMfy2TqYVXGDzx2e2K2xAWeZ4P34/1bZNcK28XlUjpfu0FAZ5QWJBKKgIRG
         8xBuG8dS2XEPA3p/3jNDBn8jVaTwqUBnDUKjRsG9drVZQl30An7O+5aTkA+ooVkatlL1
         ceLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YFJQskCNWVXuMbTVUr/PuWgn4wVuFnn3nZZ9fMSzuBk=;
        b=NZeWkJucBIsKYSARrelzg64xcyDjd4doa7clPU/zDTzU8N62bI8f4ZvGjchBeodzMS
         m3BRkFpXXW/qGTsZxqcJE42wg+K1zcR1BP8fFHJn4Bul6pKO+GvMo89Gb5+yyGdIyA3x
         N2Knp6olZZMWKUDRgWK2SdnDt8WnB9KxbtJSzjgpj02Hwv32NXMcona+VcTs9fX6bKL2
         DXvuGMGg+DsHwnmCG++Aaj9QuKwoiG1gYdnYge0ee+zOtsucxb9uZB6sigoNiwCKuSmI
         295+XDi1pRWEWEQaE/ovZBOF235kt/RHmpnJ0Va/UkkG1TJdjORqtV9Mma2vHcCzLhZs
         N4Yw==
X-Gm-Message-State: ANhLgQ2eSWxMb3zxWKSWNv3cloPU5q18A5zKXz0V2b7F8jEBT57+2o6p
        mKhQkAsbbGQJdBA1K8DrxaU45A==
X-Google-Smtp-Source: ADFU+vtZefeykjoi6XK4ZnTYc/+LRGud/nqzFl3SaKgi4mOWBmWqaGlmlg6yNMVJUNRNWWa06BMDeQ==
X-Received: by 2002:ad4:510f:: with SMTP id g15mr7140943qvp.105.1583424571027;
        Thu, 05 Mar 2020 08:09:31 -0800 (PST)
Received: from localhost (pool-96-232-200-60.nycmny.fios.verizon.net. [96.232.200.60])
        by smtp.gmail.com with ESMTPSA id j1sm13031066qtd.66.2020.03.05.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 08:09:30 -0800 (PST)
Date:   Thu, 5 Mar 2020 11:09:29 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Make mem_cgroup_id_get_many dependent on MMU and
 MEMCG_SWAP
Message-ID: <20200305160929.GA1166@cmpxchg.org>
References: <20200304142348.48167-1-vincenzo.frascino@arm.com>
 <20200304165336.GO16139@dhcp22.suse.cz>
 <8c489836-b824-184e-7cfe-25e55ab73000@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c489836-b824-184e-7cfe-25e55ab73000@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 09:49:23AM +0000, Vincenzo Frascino wrote:
> Hi Michal,
> 
> On 3/4/20 4:53 PM, Michal Hocko wrote:
> > On Wed 04-03-20 14:23:48, Vincenzo Frascino wrote:
> >> mem_cgroup_id_get_many() is currently used only when MMU or MEMCG_SWAP
> >> configuration options are enabled. Having them disabled triggers the
> >> following warning at compile time:
> >>
> >> linux/mm/memcontrol.c:4797:13: warning: ‘mem_cgroup_id_get_many’ defined
> >> but not used [-Wunused-function]
> >>  static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned
> >>  int n)
> >>
> >> Make mem_cgroup_id_get_many() dependent on MMU and MEMCG_SWAP to address
> >> the issue.
> > 
> > A similar patch has been proposed recently
> > http://lkml.kernel.org/r/87fthjh2ib.wl-kuninori.morimoto.gx@renesas.com.
> > The conclusion was that the warning is not really worth adding code.
> > 
> 
> Thank you for pointing this out, I was not aware of it. I understand that you
> are against "#ifdeffery" in this case, but isn't it the case of adding at least
> __maybe_unused? This would prevent people from reporting it over and over again
> and you to have to push them back :) Let me know what do you think, in case I am
> happy to change my patch accordingly.

I would ack a patch that adds __maybe_unused.

This is a tiny function. If we keep it around a few releases after
removing the last user, it costs us absolutely nothing. Eventually
somebody will notice and send a patch to remove it. No big deal.

There is, however, real cost in keeping bogus warnings around and
telling people to ignore them. It's actively lowering the
signal-to-noise ratio and normalizing warnings to developers. That's
the kind of thing that will actually hide problems in the kernel.

We know that the function can be unused in certain scenarios. It's
silly to let the compiler continue to warn about it. That's exactly
what __maybe_unused is for, so let's use it here.
