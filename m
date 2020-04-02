Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F840C2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE062063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XZ84V2Sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389562AbgDBPuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:50:12 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:42111 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbgDBPuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:50:12 -0400
Received: by mail-ed1-f45.google.com with SMTP id cw6so4768867edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWiLEOoB9oK39HFnZLy9XnHKYhWh1Ssr8OhqfbIqh4k=;
        b=XZ84V2SdmNStKb0uvifsP+3Vnv6KxRR09jB+fdBNVPmqKoJdPmL/ao8W67lgTiGJ0v
         YRmeGHXN2vGZm9id/mSrFE9UjVfr9qcUIUsDGUp5W+XyHRu1VjlDMEZq+EDmdCMlTR2K
         r8XQNq1HR3WbbyAN2RXx20ENHJtkhTlHnVaVdExP3hBWEdnIt4y7SiwW6CEAXyccOEXs
         oPz1AMyXiG2R99jG4dZd1IoUsd2wQBnuXbpgigQKc2dc+Xo0yECuwQlVIAC2rheQuCKi
         PFbeOZ6xe+Qb3EXGD4ikV3xPLhkCZHumplPKNEKXHhsStjmehPAu229WBGJP4akuyRmc
         gMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWiLEOoB9oK39HFnZLy9XnHKYhWh1Ssr8OhqfbIqh4k=;
        b=eqpkayfOXAEeU7F5vCoY8xaq6PcFavQFEPh5v4u+yCUvpb7VD9TZkmt0XDFD7nfoy5
         etSVb03NWebTHoDEkPu34KueK6O5bi+lm0cs8IHdC8Ybj3BrJvhULmc6jdiqaw5ainw7
         /hGOo1G1Ia+f5Qag04sUtbbkObmopXkq1y2cvx1wfOm6YSRAfbn6XVvYCHP9CZwH74Ei
         4bq620JefQrm9X7NVd5VzTIrr7i+egnuKJ+At8TokXYAzjgkZSfnIE5RFRHQOlzSapps
         ZEqRpnBQbxnDQGzg042T6dtq7k+I5zsgD4NlUYxpi7K4lZ3ivFFdIjcKatHt5rQ4soOY
         GWZQ==
X-Gm-Message-State: AGi0PubYeieqHWpZepF5YluA8GGVwSfxF/ElWlpOoY1FeehHAGZfxEVI
        Mg4SdE/SpvPzUZ2DPv2hjP2MZeN3L3ukoujtKX6SXg==
X-Google-Smtp-Source: APiQypIyLw8BJpyCQnBxfXvaW2AVBrt8fIMhpgGxCm+e32hu2TFoMcW3XaF51k3UAsagEGJCgD6CU5KzKrjBw+fak8o=
X-Received: by 2002:a50:b966:: with SMTP id m93mr3549543ede.346.1585842609563;
 Thu, 02 Apr 2020 08:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200401225723.14164-1-pasha.tatashin@soleen.com>
 <20200401225723.14164-3-pasha.tatashin@soleen.com> <875bcca7-7a95-d98f-ff0c-7eab224e6033@redhat.com>
In-Reply-To: <875bcca7-7a95-d98f-ff0c-7eab224e6033@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 Apr 2020 11:49:58 -0400
Message-ID: <CA+CK2bA6HWG1bjRuRiHGCFQsWJ1aXQ=qQzJ07_iDGhMGUrLmkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: initialize deferred pages with interrupts enabled
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you please add my details about the use of cond_resched() fixing
> detection of RCU stalls?
>
> https://lore.kernel.org/linux-mm/20200401104156.11564-2-david@redhat.com/
>
> In the meantime, I'll give these two patches a churn. Thanks

Hi David,

I will add your RCU details in the next revision.

Thank you,
Pasha
