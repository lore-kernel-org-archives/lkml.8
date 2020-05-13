Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80817C47079
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C50C24955
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgEMGEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:04:01 -0400
Received: from verein.lst.de ([213.95.11.211]:44347 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgEMGEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:04:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 79DD868CEC; Wed, 13 May 2020 08:03:58 +0200 (CEST)
Date:   Wed, 13 May 2020 08:03:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: add a CMSG_USER_DATA macro
Message-ID: <20200513060357.GA23760@lst.de>
References: <20200511115913.1420836-1-hch@lst.de> <20200511115913.1420836-2-hch@lst.de> <f754c4ac-db7d-6688-5582-2a5f476b0f08@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f754c4ac-db7d-6688-5582-2a5f476b0f08@cogentembedded.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:28:08AM +0300, Sergei Shtylyov wrote:
>    Perhaps it's time to add missing spaces consistently, not just one that 
> you added?

That is all fixed up in the next patch.
