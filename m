Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE39CC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1F820775
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTVlFx/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgCZUTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:19:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60968 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbgCZUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585253982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2H0aNl3zQWL1Oa8VAJWZD9TKx1tMioxrAbzpcBRLq4E=;
        b=TTVlFx/enu241fzND1oPRZxo5txT39o2wOEbzsyEj1yPo06pRpG8yqMrxRCu5nY7iZfY6A
        4tifb+0dHYS13MMUFSxdWvdPBJtCq6Wd61tDTmWs2v50nWNCIfqfhgmyNjHpGZdDHzPwbY
        u8r1J+sD/jdS83OJTMnEJUF6ZQf41lY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-nQLKUHPiPjOv1USmiv-dmw-1; Thu, 26 Mar 2020 16:19:40 -0400
X-MC-Unique: nQLKUHPiPjOv1USmiv-dmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19529800D50;
        Thu, 26 Mar 2020 20:19:39 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.33.36.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EF5360304;
        Thu, 26 Mar 2020 20:19:36 +0000 (UTC)
Date:   Thu, 26 Mar 2020 16:19:34 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Eric B Munson <emunson@akamai.com>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200326201934.GB4605@optiplex-lnx>
References: <20200323150259.GD23364@optiplex-lnx>
 <20200323151256.GP7524@dhcp22.suse.cz>
 <20200323154159.GF23364@optiplex-lnx>
 <20200323155111.GQ7524@dhcp22.suse.cz>
 <20200323155449.GG23364@optiplex-lnx>
 <20200324154218.GS19542@dhcp22.suse.cz>
 <20200324154910.GM23364@optiplex-lnx>
 <20200325174949.95d8a9de61c6a30a7e0f4582@linux-foundation.org>
 <20200326064909.GB27965@dhcp22.suse.cz>
 <20200326125809.64d92920bcd481cf15207855@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326125809.64d92920bcd481cf15207855@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 12:58:09PM -0700, Andrew Morton wrote:
> On Thu, 26 Mar 2020 07:49:09 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Wed 25-03-20 17:49:49, Andrew Morton wrote:
> > > On Tue, 24 Mar 2020 11:49:10 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> > > 
> > > > Thanks Michal!
> > > > 
> > > >  
> > > > Acked-by: Rafael Aquini <aquini@redhat.com>
> > > 
> > > I'll add
> > > Fixes: 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> > 
> > Wouldn't be this misleading? It would suggest that this commit is
> > somehow incorrect. I would consider b3b0d09c7a23 ("selftests: vm: add
> > tests for lock on fault") to be a better fit.
> 
> Yes, it's a bit misleading.
> 
> Or maybe not.  b3b0d09c7a23 was merged in 2015 and worked OK (afaik)
> until 9c4e6b1a7027f came along in 2020.  So arguably, 2020's
> 9c4e6b1a7027f was correct but incomplete, since it failed to repair the
> impact upon the test code.
> 
> I don't think that kernels prior to 2020's 9c4e6b1a7027f require this
> change(?), so we only need to backport this into 5.6.x, which is what

Only one note here: 9c4e6b1a7027f is from 2018, and went merged on 4.16,
AFAICS.

-- Rafael

