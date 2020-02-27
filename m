Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1DBC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CE3222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582797544;
	bh=06Vr4fb9S78h9bNlh0lKeEo/QOWCjp42tLzTIj4gp6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g9gQyq6lYRFNYrX5F0b1mZFbTJH0XAMvanIStEwsVSENTTWUhQgDcim+rO5mM4i8a
	 3n705o1yuAFA503vN4i4Xc+9DXxqvE/+F3AhI/xVnNkqjcHAcCIaxa+hr+eKtrYDmY
	 n9h49SFAqcSTNtA69TNxOtg2yxjP34XwP+rGyMR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgB0J7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:59:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46207 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgB0J7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:59:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id j7so2451309wrp.13;
        Thu, 27 Feb 2020 01:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VQ5cODCZxfkuaY7C2X27hLMvpBk5ErfD2dcMR1H0vUQ=;
        b=JJU0oNnazQsJt2bms+AMLR/OzVoAGmRebYNrmf2enIBVhIyVEh8UKPSPvU1QAB1yxw
         ISl9/mGH+qEazp4gKqF5/ZIsIvfbLfhqWyW9IzJZrliSNHkAv1WkrFSQVlArErG3ujm5
         uSt0nk0gRc3EWkoWcy3un2IhRZAkCe3rLZKX6J3C8S/Y35XzHuTrfEj3dx3ZfrTx3idv
         dmKwIhW9+K3luWrlcViyVjptuR+jLjX2YMXxgrdCBf/odKqoA211p962V9/O0k6aXU2T
         KGT/0l/9B9x8Q2SIybxCyHmGV1+yt4/4pO4qtdM23qcbA/sJezmG+DowwYNdU/f0llPU
         /eTg==
X-Gm-Message-State: APjAAAUvp7Ny8+kJ3XiSPxzoPWYMJDHeXcDiOrA+dRcU00q302rVCra7
        wy1n0fgGGnMX3xiFGdNyfxE=
X-Google-Smtp-Source: APXvYqyIHDqVdj4EvcgNGGEOqLGP0YnWFvgtDohXEArkdrFlu3228O8uGCdziWphEpOylyvx14xPRQ==
X-Received: by 2002:adf:ed84:: with SMTP id c4mr3890509wro.24.1582797540999;
        Thu, 27 Feb 2020 01:59:00 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a198sm7226849wme.12.2020.02.27.01.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 01:58:59 -0800 (PST)
Date:   Thu, 27 Feb 2020 10:58:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200227095859.GA3771@dhcp22.suse.cz>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <CALvZod7fya+o8mO+qo=FXjk3WgNje=2P=sxM5StgdBoGNeXRMg@mail.gmail.com>
 <20200226222642.GB30206@cmpxchg.org>
 <2be6ac8d-e290-0a85-5cfa-084968a7fe36@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2be6ac8d-e290-0a85-5cfa-084968a7fe36@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-02-20 16:12:23, Yang Shi wrote:
[...]
> Actually I'm wondering if we really need account CPU cycles used by
> background reclaimer or not. For our usecase (this may be not general), the
> purpose of background reclaimer is to avoid latency sensitive workloads get
> into direct relcaim (avoid the stall from direct relcaim). In fact it just
> "steal" CPU cycles from lower priority or best-effort workloads to guarantee
> latency sensitive workloads behave well. If the "stolen" CPU cycles are
> accounted, it means the latency sensitive workloads would get throttled from
> somewhere else later, i.e. by CPU share.

I believe we need to because that work is not for free and so you are
essentially stealing those CPUs cycles from everybody else outside of
your throttled cgroup.
-- 
Michal Hocko
SUSE Labs
