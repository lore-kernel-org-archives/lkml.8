Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3EBC2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBECA2137B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585847797;
	bh=dsVfNTn/hVDA6Xzuu7xcrFWaWU7RKkU7JOKRN7mol7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xp6klingjaOlGXovlQ8WS+T++DUqcsUpr2+dwJsRWQJ6QtmxU6cJk2mUnybTGppXH
	 QJFsi9HXB9DuYL5V3C4IKCaX3h9mi8QTzi2DVk+SE+xI6kmf2nWrKzKAJVeyk5wwCo
	 lLQdKJkYMScC/YX0RD/tdjZr3hPcfUWuFzuSMe+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbgDBRQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:16:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44789 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbgDBRQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:16:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id m17so5125305wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wSJgn6y+TnPhKVbxYRczrw0YlPLaTZQeeEt5dFsH/O0=;
        b=hh6qzSOKCf/UZMT0ETCvcb28mj+Du8ZnPD/baZXs0lUklIIsqDty7xap86ohuo1BPM
         owRyQNj24IBcEEovPYF0lBiRuGM7c2VhEDMp+H4G2+kwbHj/wT5w1jhbBOefItQuQkKy
         uFvx7LqEXoRSYdS9Uvqm1jvrBysCL2jI7uakuElM4Q149lnz2MVasTRRG0L1rYoBNCfm
         FiF3zdZ+jpv6OsQzI0IGDsUBJamp7AYcuU8niHqcVYVZapo2vCiPrJrV1yOADYnGuxDK
         zVcSlkxe4/hBujj+YSzPJPxWVOFNJmB9r2SZVgMLALFn37PNqI5WwgHSNnM5z9qYyWH1
         c3EQ==
X-Gm-Message-State: AGi0Pubcx4ilWejcpTVabZI3XLwVnv6BNt7BRtGEnzxqo9/LgdDKHVY/
        kgnfjjcp+r14H9d0QNAvj6U=
X-Google-Smtp-Source: APiQypIWtH7Pfnug8iU1zL15G60DAQmAUS0fYXs9+ehtubvusYTQQj++dv8yoYgYp85u4+rIix2yIw==
X-Received: by 2002:a5d:4f08:: with SMTP id c8mr4636754wru.27.1585847794165;
        Thu, 02 Apr 2020 10:16:34 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id k3sm8396362wrw.61.2020.04.02.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 10:16:33 -0700 (PDT)
Date:   Thu, 2 Apr 2020 19:16:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 2/2] mm: initialize deferred pages with interrupts
 enabled
Message-ID: <20200402171631.GU22681@dhcp22.suse.cz>
References: <20200401225723.14164-1-pasha.tatashin@soleen.com>
 <20200401225723.14164-3-pasha.tatashin@soleen.com>
 <bd3db378-f5d5-0058-0a42-4ed6033439a8@redhat.com>
 <20200402074732.GJ22681@dhcp22.suse.cz>
 <CA+CK2bAFsTJT2zU=+OyHj_-=zTKbw6mLHzrc2VEoGjPQpfhppQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAFsTJT2zU=+OyHj_-=zTKbw6mLHzrc2VEoGjPQpfhppQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-04-20 11:13:49, Pavel Tatashin wrote:
> > > I do wonder if this change is strictly required in this patch (IOW, if
> > > we could keep calling touch_nmi_watchdog() also without holding a spinlock)
> >
> > Exactly. I would go with your patch on top.
> >
> > > Anyhow, it's the right thing to do.
> 
> Michal,
> 
> The reason I changed it here is because in the original patch that
> this patch fixes we changed cond_sched() to touch_nmi_watchdog():
> $ git show 3a2d7fa8a3d5 | grep -E '(nmi|sched)'
> - cond_resched();
> + touch_nmi_watchdog();
> - cond_resched();
> + touch_nmi_watchdog();
> 
> So, should I move it to a separate patch or is it OK to keep it here?

Having in a separate patch would be better IMO. If for nothing else, the
RCU stall would be easier to see.
-- 
Michal Hocko
SUSE Labs
