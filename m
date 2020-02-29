Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6504C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F352087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TYpFojaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgB2Uop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 15:44:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33531 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgB2Uop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 15:44:45 -0500
Received: by mail-ot1-f67.google.com with SMTP id w6so6004914otk.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 12:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqrrnhnAhDxDR8DToJ03L+juASOs6Wy8PQ3rH1ycKSY=;
        b=TYpFojaFQdUqaHBll6wgyaBq0JuxhRQyFCiHl2aCihv5uMBc1KFDLDDeMczLWyt8tD
         qnLbcLplw+2WoNzbCgJnxTLzJUgibDfZbhT9vNbt0/enEuXTff8alC+u6o+URMJGyNJ6
         ou1NISRDvkqJtex7bh+3kcVgLSIao7pALFZD+un2PFXr3PJS3k+VeI1R+qVg2jI4wJXw
         L5hTOFFVEbsKWNM3uV0YKQ+t9u+eM/SZ1W/MR2NG+K24z72IjJI5pZ4CTLDqOY2K4PT1
         nii7SoL/cAdaHD/p50gusTVN3y7GcODdwr9wZ2TLWb8bhxiKX9kOGosaY8MhItMZJRCE
         nAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqrrnhnAhDxDR8DToJ03L+juASOs6Wy8PQ3rH1ycKSY=;
        b=gc7QIra1gEZWNtP0lJ+H7Atvd7sWSj/7X52k9KHLxMXK+FRLoCpVktRbjHxLoQA7fC
         Umfe2duIuzZrpNE09qPejC2cJ9z1YBk2O4+FKQd/PwubRBP4Vsms7C6TiAqygivdGQ3H
         eXznVmoD80fDWtMdlFWzlgX1M/kiF/mPfZ2fVuzq/zVEaEPUJqfJ0UYOpL2l8kPU/0wP
         F84VCey4Ajp7tYOBGvrR8PPmZkSBx+1caXi8tVLHxaWO15thqcjkyCLkYwl2wHbXIDt7
         mxwqDx+gUzDWIyGO5pMcbYLGtCEo54qVLVo2u5nvgTBU5B1ptVWxW5cqt9rRkirGywyR
         XWig==
X-Gm-Message-State: APjAAAUVQ4C10CTfZbNFPg3yxJQm9/o+YApv9yMJ7PqnH8IeHweEBu7s
        2IIP58x5ed8Fe3sYLpdQGC/Cusr/57+4FVJJSvktbiKI
X-Google-Smtp-Source: APXvYqwuD7hXgqDuHa7bNKr2aGN5ZsRtxcfrMKKpE5k3aRoSjSLBCzEO28z30FjlnmPqDSMCgEWPc3EsieveZxFwGeE=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr7849308otq.126.1583009084306;
 Sat, 29 Feb 2020 12:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20200221182503.28317-1-logang@deltatee.com> <20200221182503.28317-3-logang@deltatee.com>
In-Reply-To: <20200221182503.28317-3-logang@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 29 Feb 2020 12:44:29 -0800
Message-ID: <CAPcyv4hLvciwxSnsQRye9SuB-sy9fm+_6CwZSuHifkmbWQs-+g@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm/memory_hotplug: Rename mhp_restrictions to mhp_params
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:25 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> The mhp_restrictions struct really doesn't specify anything resembling
> a restriction anymore so rename it to be mhp_params as it is a list
> of extended parameters.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Tests ok, and looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
