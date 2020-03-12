Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0695C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93CF20735
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mINpcoIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbgCLAwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:52:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40438 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbgCLAwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:52:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id 19so4422507ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jviTemCQoG4loq3hQd+5FHbbiKg1cB/oX7b11ImYwKo=;
        b=mINpcoIK+4b3v9Rg+UsfGUJC+BnxdOWNswx8E/bmeQniVPwlqFle9Cbz3R0TeE2Xoz
         ikkp7rQ3idJh0Hw/ti+V+fRFIDmUdspWLDJ/c5NQDa96XE/5jLE+3W9nkDnArdOttYA5
         eEEIzoYQWlew0ZfkOwr2h885H0iA2BHHU9WChmvCMT9lE3sg1985gaZtTRNUiPRAPTN4
         gHhoTk+skODCQloG59p5R19zNB1UpPHzSEv3AuL0uDN4ZM0OEJtTmG/E3Std7qmGdlvE
         go23z1Mn6gwPqC3QzKer9BLg0n3rbPljZKFLa/yv/HtUgvJtj72NKB9iaYPaR7mhHrlH
         JO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jviTemCQoG4loq3hQd+5FHbbiKg1cB/oX7b11ImYwKo=;
        b=IttX/5NheLyxrvnaeeHUVUeTjPi0WICsse8bahmgON6o0dmGtcFEYRk7THPAYgT6xj
         /QIAkQSHDp2RaTwqLFijS9Hr4bzUm/C0L7s9dbR3FEY+ja3NkyGMyqYn4Yl3VZaHj5zb
         rc5XhFpzsy8qqUrRTXWhBBAXWMBij9GiDtWtK6hNjNmAZdbai89vfmUGM7Z+gnPUff2p
         /89LQyTeMrE1mihHpBAvwkIi4mKLvcesnmZO8gQ9lLYZk+fTQjerYmCF9IfowYSbSIyt
         XiTUTvPVsPiHLBGUFkwtYW4jD715Oa+I+f+V/yHmzDjZzpvD96UNNxLk1Jzv80YDeRz+
         BB5w==
X-Gm-Message-State: ANhLgQ3APN5LRkY794lw8ns9grxwGkJfGYR/sa4nIkYFIM7RidbucNJz
        gOqQhvJjvLNSCmdMN1QyLXC6ZQ==
X-Google-Smtp-Source: ADFU+vudFHHLZPTM3dDvkwAob92FTevQrfdVZCd8MEV9E5gGuhf82oH55hfavYodNV69o87Zu/DoOQ==
X-Received: by 2002:a2e:b792:: with SMTP id n18mr3698691ljo.268.1583974334223;
        Wed, 11 Mar 2020 17:52:14 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o17sm10043314lfd.89.2020.03.11.17.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 17:52:13 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 60559100B95; Thu, 12 Mar 2020 03:52:12 +0300 (+03)
Date:   Thu, 12 Mar 2020 03:52:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200312005212.kb5utehkw3jaxcfx@box>
References: <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com>
 <20200309183704.GA1573@bombadil.infradead.org>
 <CAJfu=UfPKZwqjGR5AdhFRo_je7X5q2=zpBSBQkrbh2KhYrOJiA@mail.gmail.com>
 <20200311005447.jkpsaghrpk3c4rwu@box>
 <20200311033552.GA3657254@rani.riverdale.lan>
 <20200311081607.3ahlk4msosj4qjsj@box>
 <20200311183240.GA3880414@rani.riverdale.lan>
 <20200311203246.GA3971914@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311203246.GA3971914@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 04:32:47PM -0400, Arvind Sankar wrote:
> On Wed, Mar 11, 2020 at 02:32:41PM -0400, Arvind Sankar wrote:
> > On Wed, Mar 11, 2020 at 11:16:07AM +0300, Kirill A. Shutemov wrote:
> > > On Tue, Mar 10, 2020 at 11:35:54PM -0400, Arvind Sankar wrote:
> > > > 
> > > > The rationale for MOVNTI instruction is supposed to be that it avoids
> > > > cache pollution. Aside from the bench that shows MOVNTI to be faster for
> > > > the move itself, shouldn't it have an additional benefit in not trashing
> > > > the CPU caches?
> > > > 
> > > > As string instructions improve, why wouldn't the same improvements be
> > > > applied to MOVNTI?
> > > 
> > > String instructions inherently more flexible. Implementation can choose
> > > caching strategy depending on the operation size (cx) and other factors.
> > > Like if operation is large enough and cache is full of dirty cache lines
> > > that expensive to free up, it can choose to bypass cache. MOVNTI is more
> > > strict on semantics and more opaque to CPU.
> > 
> > But with today's processors, wouldn't writing 1G via the string
> > operations empty out almost the whole cache? Or are there already
> > optimizations to prevent one thread from hogging the L3?
> 
> Also, currently the stringop is only done 4k at a time, so it would
> likely not trigger any future cache-bypassing optimizations in any case.

What I tried to say is that we need to be careful with this kind of
optimizations. We need to see a sizable improvement on something beyond
microbenchmark, ideally across multiple CPU microarchitectures.

-- 
 Kirill A. Shutemov
