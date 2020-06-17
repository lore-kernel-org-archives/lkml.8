Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607C2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB10206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxCU71un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgFQHQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgFQHQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:16:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26E7C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 00:16:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p20so1121699ejd.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 00:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rxDV988DUu6HasBuCrxRn743kfCSD3gv/yZvtfCKovM=;
        b=VxCU71un4aaKfNH4wCTasrqnObw3DWCwMyY6Mn+nIzH9G22WrmAVRuzuWuYJ294bZD
         y2RLv8q3UtX4Z7s/HY45Eje6ZVx11COTdiBDuUB8u0zJDzawKsvLIMUpDe3pstuVqVXm
         iwnkJAT1QAzIBscIv45SmtiAgQa9b2b4PxACy07g1OwXg1+Aircpk0dEeSMCpyVQG5ZK
         7IDsX02uIWO2JJ/N8CwhnHJ4IUkJtO6eaxi/4V6PhdtvOKN+HEPjJg2P3Cx2RU+F9H7C
         1496JSpeMUT5vpOK462lfMqR22yFbQwwcWOYCiE2jkyjU0TtPGdf5UbBHE1Y4vcneV/+
         wy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rxDV988DUu6HasBuCrxRn743kfCSD3gv/yZvtfCKovM=;
        b=AC0fc3nC0rXji9eET+3tRdKffsO1u+jvoFMobPBcerUSu0U6aYUYhjgCPhMR9I41pd
         QneiqJ3Y/k/7p2X3D6ck+2ItwPOWzsKR3qldTQcCiYOv+KtfYt2X7csw/yNyUHmDwjzh
         Xd/x5nsvZFnEsLzjF/jbwIK7urFatIgpy5U0idfN5gOJ4ovL4kbtj+W0kIwSML85v/ct
         HJyMM/ic/4uJBL/tUVN+7A0hglGMAMsbLpIOf0OLYmh9BlzhTuBfexKf/Hyg0VElohsS
         oYoX+h3Q0I7jYbvAl6X7+DO064T8NQEy9GCGwg299kesNNMCVQ8I0zVYkCtZbDY2fg2s
         nlmw==
X-Gm-Message-State: AOAM531kZ7VnqQtZF01IbUUhDLWtJJJe8IeVIRuCAu0g6V8bmP3tK3Ym
        VoAzqoEge/3HMGqiYcJ3Ew==
X-Google-Smtp-Source: ABdhPJzaVPgu8fYtfIMhL0e2TUHP5DPa1nY0Me8cE9nbOHUcaOIoNWB9DnWdDnYN7WsF4uE5Y78+sw==
X-Received: by 2002:a17:906:4dc2:: with SMTP id f2mr6543648ejw.402.1592378178682;
        Wed, 17 Jun 2020 00:16:18 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.15])
        by smtp.gmail.com with ESMTPSA id bg21sm12689111ejb.90.2020.06.17.00.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 00:16:18 -0700 (PDT)
Date:   Wed, 17 Jun 2020 10:16:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     liao.pingfang@zte.com.cn
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, slab: Use kmem_cache_zalloc() instead of
 kmem_cache_alloc() with flag GFP_ZERO.
Message-ID: <20200617071616.GA4001@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
>  {
> -	return kmem_cache_alloc(k, flags | __GFP_ZERO);
> +	return kmem_cache_zalloc(k, flags);
>  }

That's a good one.
