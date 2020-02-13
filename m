Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53327C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDFD2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgBMQBS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:01:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:56746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbgBMQBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:01:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 539D6B197;
        Thu, 13 Feb 2020 16:01:06 +0000 (UTC)
Date:   Thu, 13 Feb 2020 07:50:05 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com
Subject: Re: [PATCH -next 0/5] rbtree: optimize frequent tree walks
Message-ID: <20200213155005.devifejlo3jxjzxo@linux-p48b>
References: <20200207180305.11092-1-dave@stgolabs.net>
 <20200209174632.9c7b6ff20567853c05e5ee58@linux-foundation.org>
 <20200210155611.lfrddnolsyzktqne@linux-p48b>
 <20200210143546.4491d9715f1c4a0a1de999ca@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200210143546.4491d9715f1c4a0a1de999ca@linux-foundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020, Andrew Morton wrote:
>Measurable for microbenchmarks, I think?  But what benefit will a user
>see, running a workload that is cared about?

Well avoiding pointer chasing on large SMP systems has been shown to be
something we care about in the past. And yes my performance data comes
from an adhoc test scenario which only measures iteration latencies but
that doesn't mean there isn't value here.

Thanks,
Davidlohr
