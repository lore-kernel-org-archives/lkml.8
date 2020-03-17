Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C8FC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E646205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgCQMvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:51:18 -0400
Received: from smtprelay0066.hostedemail.com ([216.40.44.66]:50722 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgCQMvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:51:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id ABC6718024A45;
        Tue, 17 Mar 2020 12:51:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: list89_453106e984b38
X-Filterd-Recvd-Size: 1573
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Mar 2020 12:51:15 +0000 (UTC)
Message-ID: <52f737a95e0e50d3f556f8ebf3677f99683ee70b.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Better regex for dma_buf|fence|resv
From:   Joe Perches <joe@perches.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Date:   Tue, 17 Mar 2020 05:49:27 -0700
In-Reply-To: <20200317071547.1008622-1-daniel.vetter@ffwll.ch>
References: <20200317071547.1008622-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-17 at 08:15 +0100, Daniel Vetter wrote:
> We're getting some random other stuff that we're not relly interested
> in, so match only word boundaries. Also avoid the capture group while
> at it.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -5025,7 +5025,7 @@ F:	include/linux/dma-buf*
>  F:	include/linux/reservation.h
>  F:	include/linux/*fence.h
>  F:	Documentation/driver-api/dma-buf.rst
> -K:	dma_(buf|fence|resv)
> +K:	'\bdma_(?:buf|fence|resv)\b'

You don't want the single quotes in the K: entry

K:	\bdma_(?:buf|fence|resv)\b

My mistake for adding them in the initial suggestion.


