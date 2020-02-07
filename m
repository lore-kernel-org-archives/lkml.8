Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A0AC35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAF92253D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="yuMv4j/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBGWyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:54:55 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38908 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgBGWyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:54:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id c24so678114qtp.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IbED31rDsq1pztcDA0AbIYB2zqHtiu3fIIwDDgr0ROY=;
        b=yuMv4j/SoDlOxhbmiBXl97vV364eVGy//UWz/P9YnSkF3WAVAjI/1GSibRYMISOOy9
         JfeHiTEkEC94dVrnFb8lyXpsNvmYm2pSbKYjpwsQi71hVfT0m4gkm/f57CQbdYj7c6Ee
         9wwkBfyL7fxUi0/bDy77SlN9uRFoVmm+a+TPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IbED31rDsq1pztcDA0AbIYB2zqHtiu3fIIwDDgr0ROY=;
        b=arQSRtTQMcG6EfPRXqyRTjOxt5BPAOkdi/NsyiV75ONKrXk4mbq1k/yNDq1/rPUfKQ
         YEswW0TCtlSS8W0vJFbnih7xKL7nO6zSRLIBxAqHKm22hVDn6XbP+DjScsB8R61x+Zvq
         uSsPjAUU6/HMoLodS/J09uI8z4DIYXIJXyFEoTXoPU07rjYq8BpbB2GfATs6lprpFlQv
         ml7jzJCN30lE7Wghi1A0E/aRuEcYJGtXiSWl0YZPPtm3hPn9r3TH320R0EZnxzRkcrn3
         B59v3kcGbd+7m9p1Y84tNXsRFMOJnlSYVCjEVpTQBD2lEFD+T/+UBk6K9mkOHAIYBLqa
         haLA==
X-Gm-Message-State: APjAAAWcfujI8AVA6vfmfBztOlI3QuAOwIAVMqJr1LVgNoNgsgSWLkVM
        NVUgmpVM9Uof46RvIOnUuUeQ5Ki6J7byH1dyIf29vA==
X-Google-Smtp-Source: APXvYqz3T9ck+K7ecgPhdSVBEcjxN+tZSd/KUHx0fsMq4IqkWsQsPPP9HuYzQzogsOK5ILgLGnnklHXRqJ0pJspXc/s=
X-Received: by 2002:ac8:187b:: with SMTP id n56mr630773qtk.173.1581116094258;
 Fri, 07 Feb 2020 14:54:54 -0800 (PST)
MIME-Version: 1.0
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 7 Feb 2020 14:54:43 -0800
Message-ID: <CABWYdi1eOUD1DHORJxTsWPMT3BcZhz++xP1pXhT=x4SgxtgQZA@mail.gmail.com>
Subject: Reclaim regression after 1c30844d2dfe
To:     linux-mm@kvack.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change from 5.5 times:

* https://github.com/torvalds/linux/commit/1c30844d2dfe

> mm: reclaim small amounts of memory when an external fragmentation event occurs

Introduced undesired effects in our environment.

* NUMA with 2 x CPU
* 128GB of RAM
* THP disabled
* Upgraded from 4.19 to 5.4

Before we saw free memory hover at around 1.4GB with no spikes. After
the upgrade we saw some machines decide that they need a lot more than
that, with frequent spikes above 10GB, often only on a single numa
node.

We can see kswapd quite active in balance_pgdat (it didn't look like
it slept at all):

$ ps uax | fgrep kswapd
root       1850 23.0  0.0      0     0 ?        R    Jan30 1902:24 [kswapd0]
root       1851  1.8  0.0      0     0 ?        S    Jan30 152:16 [kswapd1]

This in turn massively increased pressure on page cache, which did not
go well to services that depend on having a quick response from a
local cache backed by solid storage.

Here's how it looked like when I zeroed vm.watermark_boost_factor:

* https://imgur.com/a/6IZWicU

IO subsided from 100% busy in page cache population at 300MB/s on a
single SATA drive down to under 100MB/s.

This sort of regression doesn't seem like a good thing.
