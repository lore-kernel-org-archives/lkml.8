Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E65BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AAB2065D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvxpVJOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgGIHCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:02:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36822 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726119AbgGIHCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594278140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMuHz4H6sEXXwc4TNQj/Hzfv3G/LgH2/WltR2CJoHps=;
        b=gvxpVJOh9nZKOJVKg14mmyopTG9tzMdCbYsTWjohh/1u37PFD/FYhuWe64cs2as+GapOs/
        MtIs9AE6L3rE7VnI/x19zaEOT+nvpZtLlCgrEJLA9PE2HihB5xX9jBkA6irmfXd+zP88PU
        ozxZX44m0J0UE7kPVbbIGGIsQ5DtBmc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-p6Pm6oq3MOis8rygMSTs0Q-1; Thu, 09 Jul 2020 03:02:18 -0400
X-MC-Unique: p6Pm6oq3MOis8rygMSTs0Q-1
Received: by mail-wm1-f72.google.com with SMTP id c124so1574383wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 00:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qMuHz4H6sEXXwc4TNQj/Hzfv3G/LgH2/WltR2CJoHps=;
        b=rSQCyPF/EyhNte2/yuPSPPA4DKy+y4ZqHl0C6oysWQ4Vv4fv3Pi1fluGOlpUgszLyC
         otCelNwRIKeTi8xo/b82WKPrwaYFu/7GilBxBjgwMrWbTf2x3JItt7slsaLoc6Ba9ghM
         7HDtFjW8xtr1SRsLJ2o3JrjWPyMBC/38U4j62WKvgpKap+dUL2Yu19WMopkA6iKXzI6u
         FB75kxEmrIWQ4ZK7Vr+f/utZCaNJNudGOiwt+c8e07qMU3BeSaMFZfQqEkfmM42oUZEj
         KgJvHlBK+RVTkPiDspZJfB1GWldJLxuXmARdOY0GCdU85DPMJAxGW+XBPC9Mm8RS40On
         vN/w==
X-Gm-Message-State: AOAM533mtngiKH9XEPM0Tdb1D7m2O5QT2/7jUN7MFiLuo1qK2wwe4MYA
        DvcCqmfwmnkEVM1iJZ1RodeN934PiQR6IgsvZKWVZQO4egTaU8Ki4SGE9ea/4XWEQWMn385Pt+p
        8lAL1Hg7b3Z+19bcnoBm8+a36
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr1177780wma.24.1594278137357;
        Thu, 09 Jul 2020 00:02:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUxz0KqcQsiX3G5AABvotPIknUgi4kxw+IC0wQcKK7Xw0nfqlQO295J1F5r9nMV5vexoTP5g==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr1177752wma.24.1594278137066;
        Thu, 09 Jul 2020 00:02:17 -0700 (PDT)
Received: from localhost.localdomain ([151.29.94.4])
        by smtp.gmail.com with ESMTPSA id 63sm4254931wra.86.2020.07.09.00.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 00:02:16 -0700 (PDT)
Date:   Thu, 9 Jul 2020 09:02:14 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/9] timer: Reduce timers softirq v2
Message-ID: <20200709070214.GD26135@localhost.localdomain>
References: <20200707013253.26770-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707013253.26770-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/07/20 03:32, Frederic Weisbecker wrote:
> Hi,
> 
> No huge change here, just addressed reviews and fixed warnings:
> 
> * Reposted patch 1 separately with appropriate "Fixes:" tag and stable Cc'ed:
>   https://lore.kernel.org/lkml/20200703010657.2302-1-frederic@kernel.org/
> 
> * Fix missing initialization of next_expiry in 4/9 (thanks Juri)
> 
> * Dropped "timer: Simplify LVL_START() and calc_index()" and added comments
>   to explain current layout instead in 2/9 (thanks Thomas)
> 
> * Rewrote changelog of 9/9 (Thanks Thomas)
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	timers/softirq-v2
> 
> HEAD: 5545d80b7b9bd69ede1c17fda194ac6620e7063f
> 
> Thanks,
> 	Frederic
> ---

Testing of this set looks good (even with RT). Feel free to add

Tested-by: Juri Lelli <juri.lelli@redhat.com>

to all the patches and to the patch you posted separately (old 01).

Thanks!

Juri

