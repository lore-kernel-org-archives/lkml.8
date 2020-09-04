Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE8C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 21:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A297C2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 21:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgIDVeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 17:34:12 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:39058 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727020AbgIDVeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 17:34:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 75B528384365;
        Fri,  4 Sep 2020 21:34:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brain20_590dcfc270b5
X-Filterd-Recvd-Size: 1527
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  4 Sep 2020 21:34:02 +0000 (UTC)
Message-ID: <f5e9bd00f94d4058e7fa214b4219d3e1978e8b55.camel@perches.com>
Subject: Re: [PATCH 08/29] dma-buf: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     kieran.bingham+renesas@ideasonboard.com,
        Jiri Kosina <trivial@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
In-Reply-To: <e6035e4b-9d4e-3c23-c140-4e9d6822496b@ideasonboard.com>
References: <cover.1598331148.git.joe@perches.com>
         <990bf6f33ccaf73ad56eb4bea8bd2c0db5e90a31.1598331148.git.joe@perches.com>
         <e6035e4b-9d4e-3c23-c140-4e9d6822496b@ideasonboard.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date:   Fri, 04 Sep 2020 14:33:52 -0700
MIME-Version: 1.0
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-04 at 12:42 +0100, Kieran Bingham wrote:
> I'm pleased to see this is treewide ;-)
> Definitely prefer this.

These are only the comma uses in if/do/while blocks that
would also need braces as separate statements.

There a multiple dozens more just with single statements
terminated by commas and not semicolons.

See:  https://lore.kernel.org/patchwork/patch/1291033/


