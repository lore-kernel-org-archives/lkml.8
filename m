Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C00CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE845221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxpb2Uk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgIKI6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKI6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:58:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749FDC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:58:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so6158568pgd.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c8nz9oNcqS43/JX3gIjCU/zwWUctvs6c1e4wLHvLc2Y=;
        b=Hxpb2Uk3qvJAd3R0XfksSYNI8kdRCaccIUM/VdyS2lkhsMLXtOLRME8qLbuhPRhV7y
         roW/F/u6PTATgscybfZNaRVTOG7YlC66Fa2gylGkaElmNTELAQA87zHgP5W9HZmKY4kG
         sia/LM9pLookkv7sYkraeIi7fFQ31KlFVIrzmLg16dlNSOTcCroYiyskRO/yjHZnbv7R
         z29Bg+AdyZGixBqgba5i6ttcQyhAXy54KqdYGJvzHFHmbQG1tVEBDx1raDCT21FKjprb
         oYqWHsZEzqTjowkA1WkprF/4s4fiLyDEWd2fPD25icFROAkqHGvBCStRHrKWg1xqH6M8
         2OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8nz9oNcqS43/JX3gIjCU/zwWUctvs6c1e4wLHvLc2Y=;
        b=BHcE1gOj9duu/mQHJjjy4htPCLjkO6XFE/nyFJ+F3VNs0XjeuMscXor7hagevkSS24
         0qgP1w5aRFtgaeUeLEsCMwm/irioG3+fJ87ErTurgUhdzOeGZ2aeln0irvawArvXhyg8
         IQWfuJMZEmQTfXlHONP6Dwjf2Qd6Vup6fX5sURhgqYyu5Ge4o/ViHNhqKEZOPHCApphP
         7hMDA6FFdkUIiz925j4KMeOY3dYsjuTpJ8KkkyID4CEAue9jqOvijHR1yuhPS1iaBa+S
         OsILFt/6IrWBYHjgNtvBKj+4GgKf6L8AFr2epX+7Yl1KG65vMmh/sXv+Eui55bsYMX1c
         MBLA==
X-Gm-Message-State: AOAM530oGKKOv7m1r/zPDCBkTtQ8DAMk46Ozwy8+uZzZlIHwDnd5OKno
        n6JJG677uRCUfxTQknLRqmk=
X-Google-Smtp-Source: ABdhPJyoeITgOIN4JjrXohV3LFRjO6CAR/hsMueYMeKLzKIO6N7sKT5jESAJGrqk4eb/udlvx7W2CA==
X-Received: by 2002:a62:8286:0:b029:13c:1611:6588 with SMTP id w128-20020a6282860000b029013c16116588mr1176188pfd.5.1599814725003;
        Fri, 11 Sep 2020 01:58:45 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id u10sm1600580pfn.122.2020.09.11.01.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 01:58:44 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:58:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     yezengruan <yezengruan@huawei.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        will@kernel.org, joelaf@google.com, linux-kernel@vger.kernel.org,
        suleiman@google.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be
 preempted
Message-ID: <20200911085841.GB562@jagdpanzerIV.localdomain>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain>
 <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
 <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies for the slow reply.

On (20/08/17 13:25), Marc Zyngier wrote:
>
> It really isn't the same thing at all. You are exposing PV spinlocks,
> while Sergey exposes preemption to vcpus.
>

Correct, we see vcpu preemption as a "fundamental" feature, with
consequences that affect scheduling, which is a core feature :)

Marc, is there anything in particular that you dislike about this RFC
patch set? Joel has some ideas, which we may discuss offline if that
works for you.

	-ss
