Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E31AC2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519DC20578
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="xpk/TKfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgC3Qdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:33:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42591 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgC3Qdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:33:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id s13so3579282lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=64xNGWOH/ZDGzwgpRPVeMys0868mYdl2Y2UpYiO2VeA=;
        b=xpk/TKfu2fvkSGRqaK5kwOEP6qjzckNWckt4x1mXBB0pWjqEhgvqXvJ2uVAyH9TO5S
         dJksBXfhXnl+bEWLU0Fk1PmVoXMxOvsfLVxIjItHlO5vTbKTrDLc7C2KJtBn9qmlBjjY
         ZlQiGLR10Tfwalvxa4Y0GCtIbOKBgom7IkVQMQ9hZ6aKGZ2LHpxuex+QXX5EuE82Q7gJ
         8X42PLMQJJT+3bC5RUCJGVy6dzrrboeenPYJ0bQrwcCf4hLUTWvLVd4TEtj3pPy+BTqn
         sPHV03tNwuQ/MadTOlE11S6qXgfaWVazdn+2MXMUDYa1zrROk+6najCA4krGmoR2GAQ6
         6KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=64xNGWOH/ZDGzwgpRPVeMys0868mYdl2Y2UpYiO2VeA=;
        b=hAV8XyOx7vY25KH3WAHkT3U8JR0pLh+pWmw6zAa928THmYkjEZOAnGQniSq4fTpiGc
         IKS0bIQbZW80SB2RX28a3++rb3gXGm2vG/MsNqbsje5SvpLJE2vz8vWQ/OEuq1cHnGJ4
         AfEYy8j3Q5mYGIV8mlTfl9sl+SzTa+MjI6m/erllVP9EB4a4Itc2x3TI6XAbn7cbU07T
         N8+9x6QYTM40iqAuC6JQR9FF1zufBTtNWLZrIgwMt04PPnfIalGtrO1FekPzLN41SaE4
         4FIzgBor/CeiRDv4jxFLM3qats7lNrkislkS/zmlg6/SKDWdqfSkPuHKZJ73pkemUuxk
         4hVQ==
X-Gm-Message-State: AGi0PuZEM+5sARuWIsq9AbeM011f3BN7AbyolCI5AZOSo7dWX9JLOoNv
        Pep046V6fD/VCswjdC2r3jcN5A==
X-Google-Smtp-Source: APiQypJ8aBK8nLn1jIHmDRvFffyMyEM4SlGK1xj3ISIFSs/PrB3Dc5CBbG59+lOqNifr0sEV2CU8og==
X-Received: by 2002:ac2:5092:: with SMTP id f18mr8537227lfm.162.1585586012852;
        Mon, 30 Mar 2020 09:33:32 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b198sm7983672lfg.11.2020.03.30.09.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:33:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1138E101DCA; Mon, 30 Mar 2020 19:33:32 +0300 (+03)
Date:   Mon, 30 Mar 2020 19:33:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, walken@google.com,
        bp@suse.de, akpm@linux-foundation.org, srostedt@vmware.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH v3 2/2] mm: mmap: add trace point of vm_unmapped_area
Message-ID: <20200330163332.e67q7tqpyuhmpxqr@box>
References: <20200320055823.27089-1-jaewon31.kim@samsung.com>
 <CGME20200320055839epcas1p189100549687530619d8a19919e8b5de0@epcas1p1.samsung.com>
 <20200320055823.27089-3-jaewon31.kim@samsung.com>
 <20200329160858.GV22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329160858.GV22483@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 09:08:58AM -0700, Matthew Wilcox wrote:
> On Fri, Mar 20, 2020 at 02:58:23PM +0900, Jaewon Kim wrote:
> > +	TP_printk("addr=%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
> 
> Shouldn't addr be printed as 0x%lx?

%#lx should do the trick.

-- 
 Kirill A. Shutemov
