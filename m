Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057EAC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0782246B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FOSXg/gD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgB1VbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:31:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40357 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgB1VbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:31:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id a36so3957390otb.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 13:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E57qmAYxRULljTteoL9BnNM233t9xRFNSPdb4qSFmz4=;
        b=FOSXg/gDLnMTvsFKrROzrWHQkymULqZ4VWWSzkxbCpGWafrvoL1DbhvWHkNA1awmFJ
         mqZ4yc3Xu7lUtGU0lnzzTMrQrhjDoBb0aAi0O834VNv0Xx2wr1FRPluT436M+3L6Uu3P
         OeEfO9GHrkLM+a5+P9XzccUiCN5lVGpuO1RMFe6qheaZSXTBuWXwalcRrw3HRO/r9ITu
         dbpQvHayrSz63xS3XZJvxFAo9ni5zPDlHcVTL49HtS1LUdDaUyRpVgHEgZqSQiaYscIw
         1HyAUUJ1ehUcyfKMFiPZLd4BrozyOvRYXTSs34KN1qjk4Mke8taeKrGC90q2MJWKZrKw
         q4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E57qmAYxRULljTteoL9BnNM233t9xRFNSPdb4qSFmz4=;
        b=Zb+uazLkzXX/GiuEEta9OrrVU0HUWnh2lA/kwBQrmg9nXuMH3QwuLnY3H1KZo2ddGI
         6algNKGG2T++gx9hT2dKuKvHjoHhbHxwZkVvuRriiCUrTis/G9j/UnNAmGOPSOAQovq4
         EWZYmamkx39PCWWk8Rgxl1QlgodwL8cbh0EsJAub0JIMGRRSp76bf88p/SYDDAdEsgFI
         PLfJjulyz6G7o2RMed5Zg8a4z34vy/v3GlPhH5gPugZ+8tbRQTw8b12mWGHo3MDPq9b2
         yViOX50Qt7cGYTPZ/itFI0Tfg5pUTqItdlmRQJmVYEhuMsEJKyamedP4n/s9th177dTv
         G0IA==
X-Gm-Message-State: APjAAAW3YVzV93PcsyJZz6ZfpQBkyvtvvJKaTC9L/65swWJdLnmHs/AF
        BOBa9ZtD5TIaJNNkmw4Qo0ro6bueO3wBSRTAdMVTqw==
X-Google-Smtp-Source: APXvYqw3lx5wUMOoXp5Dz6+9E6dRQ6P4Q87wBR0C2ISCuvp93d5At8nQ1nTZ6ODRu1fC1blNWg8tMcQbt7eE8AgCHRU=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr4607004otl.71.1582925476085;
 Fri, 28 Feb 2020 13:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20200221182503.28317-1-logang@deltatee.com> <20200221182503.28317-2-logang@deltatee.com>
In-Reply-To: <20200221182503.28317-2-logang@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Feb 2020 13:31:05 -0800
Message-ID: <CAPcyv4gFiCBN_Bz5eZrWXV0PEaWhwdHDkgEW7e5z0xZkp6a83w@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] mm/memory_hotplug: Drop the flags field from
 struct mhp_restrictions
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
> This variable is not used anywhere and should therefore be removed
> from the structure.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
