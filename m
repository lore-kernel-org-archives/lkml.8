Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B93C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0846420772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="2EGajLxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgFBNdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBNdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:33:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2FBC061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 06:33:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a25so12628438ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UXOP6EeQeN7QnSWXWe4xWPi5EI/vGhngXSWL67O93vc=;
        b=2EGajLxxJM6gikQYPuS1mnKu5hp46+IVBEa9BwEc3owfe/BwQA7s9KI6hUKhvXWmSt
         iMTb3bx5tEj8Sg6M7mXe5jzbS8EczhnXojEdy5kqCDqyc08i+3JK6eu5RtkCnIjm3CyY
         bI4QHBWOVI7IQ5r9m0fg4tfoYV4jyp815xZStlLvA/SPqmTHBLzf1jYYzdTl/TDY+YKZ
         tQCVWR94HSbuE4z6qpl2vcGt6s4WI7kuo1H6tSS1vr1WOEbPHcyxvV1/7QcLvUVCP2FK
         xWa+SP7Rx1sAG/Sv1pXG9062JgPV+wc117DRdA0jPIqWflhSnelmPeh3mtb45eP9BUB3
         /lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UXOP6EeQeN7QnSWXWe4xWPi5EI/vGhngXSWL67O93vc=;
        b=FvMi7rsmAnWFrY0tl2aJbDKAEjH7dfAuDmrGfXH5ZHOLqH1qLbnxHLntf3dFbBwtG0
         VwpPVUkN8Nz8Mrco8ukj0+k/cDI6P7gnZqZdMg19W4GoVXETjGfhoxKxyiSZHDbgTMtA
         H0u4KUlMCGcrZ2HrXJJQ2h9PHSZGVC3lUoY0wg2c3eYcTjYQEhSOcY1MfzY8NUFBFoDc
         OzQZdPyqq9lI5k4sMqTqZWtQ7hLd2w3Lga5uoEvtx2n1KJ0qCyre8CiGDSvDW3Qq6RyM
         qrOeeTmE0xHjT4yZq0KXenGAkck7vsqSg1if/BmAsIp9YmGG8F6IhjScUjUxd3ktcb39
         m1KQ==
X-Gm-Message-State: AOAM530kYHw/lzNAqvHmDCAbHREZuHHZ8WmEk34CbJBUHYHaXkdFweIP
        a2cSX0ZMbWozYL7Ul4pCsF7iEQ==
X-Google-Smtp-Source: ABdhPJwUKdYFxoN2BZU6Td7Fn5skrnUDC3bo7r1I44uRR7y3Vo9hSYxz7kedhP7e5lIggogsjLYjGw==
X-Received: by 2002:a2e:9859:: with SMTP id e25mr3590593ljj.243.1591104784267;
        Tue, 02 Jun 2020 06:33:04 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y17sm696697lfa.77.2020.06.02.06.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 06:33:03 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 226B4102780; Tue,  2 Jun 2020 16:33:09 +0300 (+03)
Date:   Tue, 2 Jun 2020 16:33:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC 06/16] KVM: Use GUP instead of copy_from/to_user() to
 access guest memory
Message-ID: <20200602133309.xyet6tndjadwafnb@box>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
 <20200522125214.31348-7-kirill.shutemov@linux.intel.com>
 <87a71w832c.fsf@vitty.brq.redhat.com>
 <20200525151755.yzbmemtrii455s6k@box>
 <a5acc4c8-2ee6-9e5d-c0a5-2a6f7c54c059@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5acc4c8-2ee6-9e5d-c0a5-2a6f7c54c059@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 06:35:22PM +0200, Paolo Bonzini wrote:
> On 25/05/20 17:17, Kirill A. Shutemov wrote:
> >> Personally, I would've just added 'struct kvm' pointer to 'struct
> >> kvm_memory_slot' to be able to extract 'mem_protected' info when
> >> needed. This will make the patch much smaller.
> > Okay, can do.
> > 
> > Other thing I tried is to have per-slot flag to indicate that it's
> > protected. But Sean pointed that it's all-or-nothing feature and having
> > the flag in the slot would be misleading.
> > 
> 
> Perhaps it would be misleading, but it's an optimization.  Saving a
> pointer dereference can be worth it, also because there are some places
> where we just pass around a memslot and we don't have the struct kvm*.

Vitaly proposed to add struct kvm pointer into memslot. Do you object
against it?

-- 
 Kirill A. Shutemov
