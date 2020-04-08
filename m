Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2ECC2BB54
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824D7206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDHAWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:22:48 -0400
Received: from gentwo.org ([3.19.106.255]:48778 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgDHAWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:22:48 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 2956F3F948; Wed,  8 Apr 2020 00:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 2868F3F946;
        Wed,  8 Apr 2020 00:22:47 +0000 (UTC)
Date:   Wed, 8 Apr 2020 00:22:47 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Qiujun Huang <hqjagain@gmail.com>
cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, slab_common: Fix a typo in comment
 "eariler"->"earlier"
In-Reply-To: <20200405160544.1246-1-hqjagain@gmail.com>
Message-ID: <alpine.DEB.2.21.2004080022100.3215@www.lameter.com>
References: <20200405160544.1246-1-hqjagain@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020, Qiujun Huang wrote:

> There is a typo in comment, fix it.
> s/eariler/earlier/


Acked-by: Christoph Lameter <cl@linux.com>
