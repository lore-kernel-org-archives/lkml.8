Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07048C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F8C208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgFQQXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:23:05 -0400
Received: from gentwo.org ([3.19.106.255]:38672 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgFQQXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:23:05 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id D2E483E9DB; Wed, 17 Jun 2020 16:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id D10583E9D1;
        Wed, 17 Jun 2020 16:23:04 +0000 (UTC)
Date:   Wed, 17 Jun 2020 16:23:04 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     William Kucharski <william.kucharski@oracle.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: ksize() should silently accept a NULL pointer
In-Reply-To: <20200616225409.4670-1-william.kucharski@oracle.com>
Message-ID: <alpine.DEB.2.22.394.2006171621140.1574@www.lameter.com>
References: <20200616225409.4670-1-william.kucharski@oracle.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020, William Kucharski wrote:

> Other mm routines such as kfree() and kzfree() silently do the right
> thing if passed a NULL pointer, so ksize() should do the same.

Ok so the size of an no object pointer is zero? Ignoring the freeing
of a nonexisting object makes sense. But determining it size?
