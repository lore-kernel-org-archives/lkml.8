Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8B0C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D17E2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgGPQA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:00:26 -0400
Received: from verein.lst.de ([213.95.11.211]:35238 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbgGPQAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:00:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8A01E68BEB; Thu, 16 Jul 2020 18:00:22 +0200 (CEST)
Date:   Thu, 16 Jul 2020 18:00:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: decruft the early init / initrd / initramfs code v2
Message-ID: <20200716160022.GA29393@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <CAHk-=wgxV9We+nVcJtQu2DHco+HSeja-WqVdA-KUcB=nyUYuoQ@mail.gmail.com> <20200715065140.GA22060@lst.de> <4b38a63b-af09-608c-c4fa-b9e484ebe6bc@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b38a63b-af09-608c-c4fa-b9e484ebe6bc@cloud.ionos.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 05:57:12PM +0200, Guoqing Jiang wrote:
> On 7/15/20 8:51 AM, Christoph Hellwig wrote:
>> On Tue, Jul 14, 2020 at 12:34:45PM -0700, Linus Torvalds wrote:
> I just cloned the tree, seems there is compile issue that you need to 
> resolve.

Fixed and force pushed.
