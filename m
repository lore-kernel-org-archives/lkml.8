Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F33C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAA720781
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="EOqCghog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCTLrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:47:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45051 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgCTLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:47:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id j188so416679lfj.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M2TXgqwUodKIYzZQJAh9II3qf8XBdi90z3brsAgVKrM=;
        b=EOqCghogEmGJ1fsAFS0IHYdEmNQzGmBdIKU7jeXqBFhTiR8LxaFQ+MDWLVgLshqjzJ
         9OeqePbgK4sWKU7KOBt7auRlj28cHFFQtDC6XsiTMbAHMJmZbnr+Neuik7VeKx4OfGvI
         ZK5UMK2IikgllUw17HLgo6N/9nyEd92UfQFjdECjbsm/XroryWTYiRwKpK61AhiH1AWn
         IOpozrLzcemPCfHaDNd9ubTDsN746O9i9Tl3y9OmQAVvc8Lveg3cPfk++YOWEpDp/7tY
         y2uqzMfnBxkeHJjxFc20DS3l5iW8n+jLgmGamBDOhai/PbP20em6JUFxLeAS+8Gbotb4
         vkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2TXgqwUodKIYzZQJAh9II3qf8XBdi90z3brsAgVKrM=;
        b=a28mCBs3TTC928kEh4eodQjD5vyLb0HOteu8KI74wRF3olhECLfMPMEWEhF3mOUIDt
         jkYxMDTmfU4a75KHNUx2a+0Iz9ZzZCyLC68f5LzE1PAbFGjAJSOWQwwpxraKRAevR9x7
         P0/K2bm9q/l7yFAnMCLB2yPXEjyWkrqdKHH0CUkn3jMSH595qq/s5cs1fjRvlSpSmrhs
         24BqhjKX1aQc3qOrjzgoYZRUWyd7maJrBNVx32gJlEDEdxYyDRpCR4knd9TboHpA9L5m
         aGZvBMEzBTYClvnP4NogrE5f2ryn67NHbFfUuNLF1J3SOcC6YW+BWvM8RvsBFChlqXa+
         2NDw==
X-Gm-Message-State: ANhLgQ3iJBKzCzz4LNR2g783h1iPdiAfK4Sod3GjdFgxKLh2I3gjweZa
        lsuRoGHCWXhS6ARyGONgsbined4JTrIR/g==
X-Google-Smtp-Source: ADFU+vv2hj54FnbwzFhCeK1QseTOS3XEPe8XbkB7Ucp0Rt2uShXeQvecyNxv0o40/OLXqhrVGw9gCw==
X-Received: by 2002:ac2:5c5d:: with SMTP id s29mr787973lfp.129.1584704859333;
        Fri, 20 Mar 2020 04:47:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b23sm3315212lff.64.2020.03.20.04.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 04:47:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 09E221020EE; Fri, 20 Mar 2020 14:47:42 +0300 (+03)
Date:   Fri, 20 Mar 2020 14:47:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] x86/mm: Make pud_present() check _PAGE_PROTNONE and
 _PAGE_PSE as well
Message-ID: <20200320114741.c62iolt2yzltnscf@box>
References: <1584507679-11976-1-git-send-email-anshuman.khandual@arm.com>
 <c03165c8-6d44-49c2-2dad-a85759200718@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c03165c8-6d44-49c2-2dad-a85759200718@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 08:53:16AM +0530, Anshuman Khandual wrote:
> 
> 
> On 03/18/2020 10:31 AM, Anshuman Khandual wrote:
> > pud_present() should also check _PAGE_PROTNONE and _PAGE_PSE bits like in
> > case pmd_present(). This makes a PUD entry test positive for pud_present()
> > after getting invalidated with pud_mknotpresent(), hence standardizing the
> > semantics with PMD helpers.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: x86@kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > Even though pud_mknotpresent() is not used any where currently, there is
> > a discrepancy between PMD and PUD.
> > 
> > WARN_ON(!pud_present(pud_mknotpresent(pud_mkhuge(pud)))) -> Fail
> > WARN_ON(!pmd_present(pmd_mknotpresent(pmd_mkhuge(pmd)))) -> Pass
> > 
> > Though pud_mknotpresent() currently clears _PAGE_PROTNONE, pud_present()
> > does not check it. This change fixes both inconsistencies.
> > 
> > This has been build and boot tested on x86.
> 
> Adding Kirill and Dan.
> 
> +Cc: Kirill A. Shutemov <kirill@shutemov.name>
> +Cc: Dan Williams <dan.j.williams@intel.com>

Or we can just drop the pud_mknotpresent(). There's no users AFAICS and
only x86 provides it.

-- 
 Kirill A. Shutemov
