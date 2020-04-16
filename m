Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0248AC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F4D2222D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="fcE8vIY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgDPWMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727907AbgDPWMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:12:43 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77729C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 15:12:41 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id f8so72210lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sZgj1ZrAXOwHlYXwg4Ycg+watpXpPbWmk7DvmzwiL7Q=;
        b=fcE8vIY8L6o7x6PldEOOEQPNtQTjivyAw3L2B4x4MzMl9Tg2VzAG3xdaKSISAHU6va
         wPR0onErB0FkjoXPoFyUMxrVZO4+ZHvqVxQIBHyM/8KiymM0OsM96Tos6mcZUEAPqMj2
         GgPbDLhcZmqiCUlTN34qY9K7TZKZGd7NXEZ3QY1ZsJ7xbhPkPPYrvcmNia8gJqhjhHQw
         Q0mtrkIJwfLN0MiinnIMkRREvaiKFQ5OiZhU5eoq8ztZeFqkxvlMFCnDeoIyrCuEB7Vo
         LNFLwL7vJYoFmaElmf5XXx0XEI5Qs26St3CA8r4t7+W8NidsFOcbIiFme2IMlLnLe77W
         S1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sZgj1ZrAXOwHlYXwg4Ycg+watpXpPbWmk7DvmzwiL7Q=;
        b=s6xnMiMURc8HZp3RIeTq7MElv8qiXUFdkleebcQM2Luh6eAIstdrMwWFeEwAOSclu2
         vYFisIIweExVlaeHThJRP/TeteEqbBB43zsMkF1cpfIqfhiq/jzXo+M1r5/zmdtazIzj
         RT7nUkWVCcy4e/UiFT6NOpl/Xc1q9E5byo86RP49Qo9f0GDEsbZyYeHRVFr5xCl0KIUO
         qlYKsvlV/ddtkYEvSYrJiksUgU5x6CxBDhxJktIGSFfwjcTE1gAdiEls1uOxI+YJLfxw
         hYj+W/AeA3CUTPW787K70vHogZLBsoIBcpd1ZoKycvYIFJB6SeiJ1Pi/5ImpB6KL5lWL
         0Ubg==
X-Gm-Message-State: AGi0Pub4Tq/Q/ynsd71nMcGncm7xrQ/O0B6oRY1eJx8rtC1fIj64r46E
        huRDENJ2Jfxq2LqXaaKUR1m1Bw==
X-Google-Smtp-Source: APiQypJupD5xGPoTaxQXKBQ5fQv+cLHXCuBt2Nbg5dUyDPftkhL/VpApq64jbgk26cIddcN8vWWpYg==
X-Received: by 2002:a19:550a:: with SMTP id n10mr7367lfe.143.1587075159959;
        Thu, 16 Apr 2020 15:12:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b9sm19480499lfp.27.2020.04.16.15.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 15:12:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D52C3102EA9; Fri, 17 Apr 2020 01:12:38 +0300 (+03)
Date:   Fri, 17 Apr 2020 01:12:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] x86/mm/pat: Restore large pages after fragmentation
Message-ID: <20200416221238.qrkaajbe3m6ca2h2@box>
References: <20200416213229.19174-1-kirill.shutemov@linux.intel.com>
 <bf3e6e77-b812-992c-9916-76f19ae5c94a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf3e6e77-b812-992c-9916-76f19ae5c94a@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 03:03:12PM -0700, Dave Hansen wrote:
> On 4/16/20 2:32 PM, Kirill A. Shutemov wrote:
> > With current code it's one way road: kernel tries to avoid splitting
> > large pages, but it doesn't restore them back even if page attributes
> > got compatible again.
> 
> Looks pretty sane to me, and sounds like something we've needed for a
> long time.
> 
> I'd having doubts in my ability to find nasty corner cases in this code,
> though.  Could you rig up some tests to poke at this thing further?  Maybe:
> 
> Record what the direct map looks like (even from userspace).  Then,
> allocate some memory, including odd-sized and aligned ranges.  Try to do
> things >4M like the hugetlbfs code does.  Make the allocation (or a
> piece of it) not-present (or whatever), which usually fractures some
> large pages.  Then put it back the way it was.  All the large pages
> should come back.
> 
> If it survives that for an hour or two, it should be pretty good to go.
>  Basically, fuzz it.

We already have it in kernel: CONFIG_CPA_DEBUG. It messes up with the
mapping every 30 seconds. It is pretty good for the change too. It
produces a lot of 2M/1G pages to be restored. I run it over night in my
setup and it survives.

-- 
 Kirill A. Shutemov
