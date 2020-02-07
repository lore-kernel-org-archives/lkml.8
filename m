Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F72C35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6B6214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mFqfTxH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBGCAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:00:30 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44592 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgBGCAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 21:00:25 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so492094oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 18:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3CzpWEhjGrNTft9efyOK3iDvmIkcWco/Hi4kp5Xn6c=;
        b=mFqfTxH17DKWGmlyN+WKWh3LGx9K2vV7Uu6I6markT+umMWzauzf+aSs/chFlQuWyL
         WjOWy3sp4tBmrfTD+lYBZD4Ptv4uVSLZ8jk7cvuJWPhifk6ocGYh6BDyQmcoQsJwoETy
         sJsgG04MmnecAng2izL09mlcdFaRFyDcNZFML0VALpeCMK/Yn9cqpJuDjeVLOTShIiIw
         dHHgAlAaOgJRqgPUWjT4UoBlrZJ1CQIz6i+Y7n8Y1neWZsVe2ZwVbrmkyIrFGiPL6zbA
         CBmgoVEV6ohxtoeuxJzbcQk6AmoqWEIY26fmJr5y07j79rcYKQz5zkPrXY066zYXynlN
         s2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3CzpWEhjGrNTft9efyOK3iDvmIkcWco/Hi4kp5Xn6c=;
        b=c4lEqoG7djY4tmt3hDYJ5IyEzlcUnQRNLtYpsQPcF1c8h+ZgDU9+EDsudSQFyazUj7
         nRI714BZ4Lfc0K4kKwv7+gIqXMaI2e9jCk10O06DAI16cCFRMSqwjmcqIiC3jDac9F0c
         mNdyh8fc5GRdeHJvuu97T8hX5xFQYevEKxHNtEpbX+bzxs5exEnbAcZPDpIb3kOuj/lS
         LZaoAjHtCGkyH8rLPGxGA6KMUdb9O6xANAOnG2ULM/34BIPRkwvKsmrdKuIcO2IS7wUW
         0i5LI1THl5VanleL9k32ShdLF57EJaAputJ3RjwYH5Cv2olttFJ6m3BUWIbn5fipiMc7
         G/wg==
X-Gm-Message-State: APjAAAVDU/+O46QU6402GqP5LFKyM1ENocZf+whnJrPGmcGDV13MTWK7
        H7AQuFv1y+pANtdGkuCIOUz1FQGiCL0M9Kfi3arv3g==
X-Google-Smtp-Source: APXvYqzDAxly+x9xhSwzVeIqYYmAXLncXK+51lPngBmnh8tEaAPHsBxMPHY2clTJyT6lZmY1MH3Y9rUK9ynOq3OURAA=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr517359oia.73.1581040824822;
 Thu, 06 Feb 2020 18:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20200206231629.14151-1-richardw.yang@linux.intel.com> <20200206231629.14151-2-richardw.yang@linux.intel.com>
In-Reply-To: <20200206231629.14151-2-richardw.yang@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 6 Feb 2020 18:00:13 -0800
Message-ID: <CAPcyv4h9C+QLO0VVn2W97p2sYxP2LocCyxYF+Gzy3tM=DYxH4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/sparsemem: adjust memmap only for SPARSEMEM_VMEMMAP
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> Only when SPARSEMEM_VMEMMAP is set, memmap returned from
> section_activate() points to sub-section page struct. Otherwise, memmap
> already points to the whole section page struct.
>
> This means only for SPARSEMEM_VMEMMAP, we need to adjust memmap for
> sub-section case.
>
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/sparse.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 586d85662978..b5da121bdd6e 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -886,7 +886,8 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>         section_mark_present(ms);
>
>         /* Align memmap to section boundary in the subsection case */
> -       if (section_nr_to_pfn(section_nr) != start_pfn)
> +       if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
> +               section_nr_to_pfn(section_nr) != start_pfn)

Aren't we assured that start_pfn is always section aligned in the
SPARSEMEM case? That's the role of check_pfn_span(). Does the change
have a runtime impact or is this just theoretical?
