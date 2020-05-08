Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF5DC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 03:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC89E20746
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 03:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEHDSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 23:18:23 -0400
Received: from gentwo.org ([3.19.106.255]:33638 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbgEHDSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 23:18:22 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 0FD923FEDA; Fri,  8 May 2020 03:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 0D3633FED9;
        Fri,  8 May 2020 03:18:22 +0000 (UTC)
Date:   Fri, 8 May 2020 03:18:22 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] slub: limit count of partial slabs scanned to gather
 statistics
In-Reply-To: <20200504125656.e3d04b350c807aba8a2a7271@linux-foundation.org>
Message-ID: <alpine.DEB.2.22.394.2005080315290.56560@www.lameter.com>
References: <158860845968.33385.4165926113074799048.stgit@buzz> <20200504125656.e3d04b350c807aba8a2a7271@linux-foundation.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020, Andrew Morton wrote:

> But I guess it's better than nothing at all, unless there are
> alternative ideas?

I its highly unsusual to have such large partial lists. In a typical case
allocations whould reduce the size of the lists. 1000s? That is scary.

Are there inodes or dentries by chance?

The defrag stuff that I had been trying to do for a long time would solve
that issue but then objects would need to be made movable....

