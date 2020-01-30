Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AFDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B6120661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgA3S3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:29:04 -0500
Received: from gentwo.org ([3.19.106.255]:40996 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729845AbgA3S3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:29:03 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 5A4FE3FFFB; Thu, 30 Jan 2020 18:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 595523E94E;
        Thu, 30 Jan 2020 18:29:03 +0000 (UTC)
Date:   Thu, 30 Jan 2020 18:29:03 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Qian Cai <cai@lca.pw>
cc:     akpm@linux-foundation.org, dennis@kernel.org, tj@kernel.org,
        elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/util: annotate an intentional data race
In-Reply-To: <20200130145649.1240-1-cai@lca.pw>
Message-ID: <alpine.DEB.2.21.2001301828360.9861@www.lameter.com>
References: <20200130145649.1240-1-cai@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020, Qian Cai wrote
> "vm_committed_as.count" could be accessed concurrently as reported by
> KCSAN,

Acked-by: Christoph Lameter <cl@linux.com>
