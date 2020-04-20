Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCFCC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58DC20A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDTIq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:46:59 -0400
Received: from verein.lst.de ([213.95.11.211]:39427 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTIq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:46:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A83B68C4E; Mon, 20 Apr 2020 10:46:56 +0200 (CEST)
Date:   Mon, 20 Apr 2020 10:46:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hide __pte2cachemode_tbl and __cachemode2pte_tbl
Message-ID: <20200420084656.GA1229@lst.de>
References: <20200408152745.1565832-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408152745.1565832-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:27:41PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series avoids pointlessly exposing the cachemode to pte bit
> translation tables to modules.

Any comments?
