Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7DFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853D92075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="rO39pjE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgGMLmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGMLmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:42:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 04:42:15 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p20so16631294ejd.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TvJxYzvOgzlC3BuPyn0KYnjcr7/OFk0QNHyHHZoEtGc=;
        b=rO39pjE0Wei+6nLZvaupuo2Ex4KuQD2qZ+3t6eBYQNcRJtvYdxAC8ONfkblcinlcJO
         CsVJ3UHvyqauDlk9iXmWwHEWUAv6UaIhcERBX4YfcmGPRVnAF+ubSh8IYXCZ3iIBZhvT
         yOhcnmyjlTvVR4JTTXRQsTb9HRlMgpn7BBmrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TvJxYzvOgzlC3BuPyn0KYnjcr7/OFk0QNHyHHZoEtGc=;
        b=FQS3NIFUwQtVo/S7YLBCH9ucc/D16JLfqhRDapjAP50dtJnWFQ4rEHoKtgQNb7JdQS
         RDOJ/1xOtZ7py32gEYK/bv5nafoxkw67q8+4MzAVUMSzjrVyuow/F1QXNy6OaX8cnSjZ
         6DBDVOZZZs6jOlytdVW86p0239x9spi4mBpxYNOY+pQYL6N9W6XpmhOMcwuNJHWJ5z1H
         UHfGFTWaodupem9AcuBpkZ591sSLlcbvK8wsiYoK1St9ECkNYBmO7KeZMFFY4jBKvRla
         d5T/NVMvl6QL1U6XkNQ2Mh5hW6ei7eoOjzn9E0To9bkzK6GjZzVOdQCcbF49fmyMTjeb
         v50A==
X-Gm-Message-State: AOAM533GkcF30mT8lgCRBzWG2twNdPdKU2h+96eBXylrZwyEjmbiurzC
        FHs4rzKFJDUpQivRkFp41oKuRw==
X-Google-Smtp-Source: ABdhPJzGgq6RGP3XIbwumibrODkGvKT1MpPv2MlO3N6NK25YXE3CCow3QCIXO8inZ0byPzPoTPrA+Q==
X-Received: by 2002:a17:906:c142:: with SMTP id dp2mr76749291ejc.541.1594640534092;
        Mon, 13 Jul 2020 04:42:14 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id bz14sm5377849ejc.88.2020.07.13.04.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:42:13 -0700 (PDT)
Date:   Mon, 13 Jul 2020 12:42:13 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 0/2] mm, memcg: reclaim harder before high throttling
Message-ID: <cover.1594640214.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:

- Reclaim only SWAP_CLUSTER_MAX pages on reclaim retries, and add
  comment explaining why. Thanks Johannes for the suggestion.
- Unify into series.

Chris Down (2):
  mm, memcg: reclaim more aggressively before high allocator throttling
  mm, memcg: unify reclaim retry limits with page allocator

 mm/memcontrol.c | 53 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 12 deletions(-)

-- 
2.27.0

