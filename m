Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C21DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9ABE20760
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwrb8q1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgGFLuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFLuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:50:12 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F11AC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 04:50:12 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p7so17009069qvl.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJPS9i68AMwe08ob266SMGfaNOxK2LzyyRESTVDvAq8=;
        b=gwrb8q1fpMTbIIY+b98bPBgNhHC9YXFytB4yndrISbMQrXTdynTfT3rTtMJrliss9x
         erJD+p3yZxRqXXvy6ytWhvzyRPXafkIQ1DgcxO7PNK7Jdpc69H7TWhU/j11tArTdwfGo
         aXF6HcW5XBkKo0Zf0o9W8iSnrTGiSyrphmjbPmec/KIfQgEhg5i+KtkhCSHxs6XOawqI
         PRp4Gr9thqc+rEYeLoWK4Bu/pGXceBTFR/y0eLu/dsRBjPuOqkE0lEE+4/IhK10q6g5P
         JGVi/SSTbRtWI9eAeRX+yBvyCldrbTU2z8giLdxKHyYKTa+zplEHvc1kkX9CbJn1f3mN
         ZxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJPS9i68AMwe08ob266SMGfaNOxK2LzyyRESTVDvAq8=;
        b=cgaivGvs5aBQHiNKoUin4cnl2rH2VKamibyqKEsgKJZInaDmfDkpPB4EKRUTHiRht8
         KynBdFQnEsOCwKw3wJftfpRH+r6jZlZ8LgSRYDm7fDuPXJ+KtBYUx786OByrhXhUeOy4
         +dj+UKWJ9jumcY5iSOv18h5hkzggYv4WosJxHHSKRmrQb9ls1wH1xux/kOCwI6wDDFIR
         iOBrn2F25t5g33GIQtg8iN/q3twJEjqbUILBmIgV0qExCDMOzFCpOAroWY8FiFWaQ1La
         u0xmSX/NKESpvEPY6ZROYdycKq6Gr5UIDyU8kyr2AhCGUgwWg0O3iltDVENpmYAcjya2
         IlCQ==
X-Gm-Message-State: AOAM533ds4kRhzm0ZywxzJAWIGkHLO/fXFpL3RodcMY8+HWM2v0wILjy
        U2U9SnDt3/9/xpc2wVswvK0zF18YTbR/B5Yk+VU=
X-Google-Smtp-Source: ABdhPJwzhKnIeBJyg6Hdvrq0O2HRc6A2LQH4oD4siELH9amza/RljlZvEd4qxDGulKPGQ9WRBSHHijY40XERUUjP8r8=
X-Received: by 2002:a0c:e78b:: with SMTP id x11mr41855150qvn.103.1594036211296;
 Mon, 06 Jul 2020 04:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200706025921.53683-1-songmuchun@bytedance.com>
In-Reply-To: <20200706025921.53683-1-songmuchun@bytedance.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Mon, 6 Jul 2020 14:49:55 +0300
Message-ID: <CAOJsxLEgRvkganmNNmeBsHdgHTgJ5tbK=b8Pnrc4LB3tvTzbMA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/page_alloc: skip setting nodemask when we are in interrupt
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 5:59 AM Muchun Song <songmuchun@bytedance.com> wrote:
> When we are in the interrupt context, it is irrelevant to the
> current task context. If we use current task's mems_allowed, we
> can fair to alloc pages in the fast path and fall back to slow
> path memory allocation when the current node(which is the current
> task mems_allowed) does not have enough memory to allocate. In
> this case, it slows down the memory allocation speed of interrupt
> context. So we can skip setting the nodemask to allow any node
> to allocate memory, so that fast path allocation can success.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Pekka Enberg <penberg@kernel.org>
