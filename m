Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D0EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6999C206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgIARPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:15:54 -0400
Received: from verein.lst.de ([213.95.11.211]:53778 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbgIAPOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:14:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D8B0A68B05; Tue,  1 Sep 2020 17:14:44 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:14:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/6] proc: allocate count + 1 for our read buffer
Message-ID: <20200901151444.GC30709@lst.de>
References: <20200813210411.905010-1-josef@toxicpanda.com> <20200813210411.905010-4-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813210411.905010-4-josef@toxicpanda.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 05:04:08PM -0400, Josef Bacik wrote:
> Al suggested that if we allocate enough space to add in the '\0'
> character at the end of our strings, we could just use scnprintf() in
> our ->proc_handler functions without having to be fancy about keeping
> track of space.  There are a lot of these handlers, so the follow ups
> will be separate, but start with allocating the extra byte to handle the
> null termination of strings.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
