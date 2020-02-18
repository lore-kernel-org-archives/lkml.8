Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38C2C34045
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865B224658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgBRQYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:24:55 -0500
Received: from gentwo.org ([3.19.106.255]:41648 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgBRQYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:24:55 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id A45B33E998; Tue, 18 Feb 2020 16:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id A246B3E997;
        Tue, 18 Feb 2020 16:24:54 +0000 (UTC)
Date:   Tue, 18 Feb 2020 16:24:54 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     "Tobin C. Harding" <tobin@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tools: vm: slabinfo: Add numa information for
 objects
In-Reply-To: <20200217084828.9092-3-tobin@kernel.org>
Message-ID: <alpine.DEB.2.21.2002181623150.20682@www.lameter.com>
References: <20200217084828.9092-1-tobin@kernel.org> <20200217084828.9092-3-tobin@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020, Tobin C. Harding wrote:

> Add a field to the slabinfo struct for the NUMA information and
> output it during a NUMA report as is done for `slabs` and `partial`.

How will this look? Note that there are boxes now with potentially huge
NUMA nodes (AMD Rome can already do 32 with an optimal BIOS layout for
minimal latency).

Maybe make it optional with a --numa switch or so?

