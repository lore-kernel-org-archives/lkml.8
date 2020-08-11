Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102C5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7A420771
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Bv1Bl02L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgHKPGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgHKPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:06:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A1CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:06:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 2so11900740qkf.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kKnx53M5XbyLLCCwOSDObubCS6cU/NfvJWrtPaFaVlk=;
        b=Bv1Bl02Lx3IaqeN2DkPY+ruc6fzBfowKMA7iiIPJ+DiAJZsOy8szw6aoZ0TStGaHpZ
         xilghORcnZqO5cX19vjFxySoMjbUkRFXfaZzw58Vc+NvQYR05SwB7jf9SpoISlQ6iZy7
         dH1q403WO9OyWx0Z1nBbVbDc3Q4OihzLrYdrkNSOIzak0CHZwtUdc3Uh/25RvlQo/O1L
         MnHoRfiTJ8rffT0ZepO4EWKqT7C/MNOc+lJa95lHzm0yHnksRf2JKSHIcet0AEiAXEIi
         yMYJRK+Rm585q5ija7lhtB6mcKBWueW8BXrbPC5RnW9kvgoABAOO+Br1w5uKFRHA8t+S
         bVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kKnx53M5XbyLLCCwOSDObubCS6cU/NfvJWrtPaFaVlk=;
        b=pZRkNsMJ4HSFbfHzqRT19F+dsrxpGo1LwwTbNJ4b96a3IJRXjcZBhoV1dOdUKGOSG4
         PE/zxBKux8hKwM8X0oi/OwIybbGl+u1IC7EU3dysUl/Lgx9GVX2entzFxdjk2QiyYAnZ
         /IkceN7GRYW+TYrr8D89HK65W+nlVl7jHUcDANEfODi8xww/ExwOzvrX0G7lbmN0OWJq
         azzSy/UI9mjkYobTMXcSw7nf6soaImnN5GjL4Uv5w4V5PLXLRlQTP0wr7CKB5kxVI4n8
         JZZXYVIsQFEEuPutVVIqBx1h454y+cFGo6niuwD+vKW7W2pZeTj4WuIPZ6nrX1IDmkiB
         6rwg==
X-Gm-Message-State: AOAM532VJeogpnJqAe7vNSuydQSL+SZs6JUDlcp5P/zCI2j3X0AWwNS2
        UellSgFh0XPBpxrpbxwCIhvAFgd6/uU=
X-Google-Smtp-Source: ABdhPJyJvJGap5I6DiGS6pq3ZWpGuLvnm4JDu/uIeSUz8BOTqNkzo/600m7MHlYvaSL4nuuqzQKmlQ==
X-Received: by 2002:a37:a354:: with SMTP id m81mr1571997qke.277.1597158369961;
        Tue, 11 Aug 2020 08:06:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2dd0])
        by smtp.gmail.com with ESMTPSA id k48sm21761270qtk.44.2020.08.11.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 08:06:09 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:05:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] mm: memcg/percpu: per-memcg percpu memory
 statistics
Message-ID: <20200811150505.GA650506@cmpxchg.org>
References: <20200623184515.4132564-1-guro@fb.com>
 <20200623184515.4132564-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623184515.4132564-4-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:45:13AM -0700, Roman Gushchin wrote:
> Percpu memory can represent a noticeable chunk of the total memory
> consumption, especially on big machines with many CPUs.  Let's track
> percpu memory usage for each memcg and display it in memory.stat.
> 
> A percpu allocation is usually scattered over multiple pages (and nodes),
> and can be significantly smaller than a page.  So let's add a byte-sized
> counter on the memcg level: MEMCG_PERCPU_B.  Byte-sized vmstat infra
> created for slabs can be perfectly reused for percpu case.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Dennis Zhou <dennis@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
