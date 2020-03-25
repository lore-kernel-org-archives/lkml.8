Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA09C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318D820722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPqCGbGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCYJLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:11:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55414 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgCYJL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585127488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpkY/0lY7hpHmA05svGpFbUDqP2D/nkfiH+o4beESdM=;
        b=iPqCGbGyGMaLBvKL05CcmsJA1SPBGA3IUv8xpeNGF+sSjVDMmAgIg5G/PEAaOI1Kw9aRWy
        QyKYZYycZypB7Zb2BW4cdYcZDsTacZR/RAcrlY1kFcR9Y+E57dG2phMy0nvQh12sdjV5Aj
        bbXnR1zvsUAyVH3evs6WznzEB/8Cpsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-yFDH14ZWOBmUqrL7kRzgMA-1; Wed, 25 Mar 2020 05:11:24 -0400
X-MC-Unique: yFDH14ZWOBmUqrL7kRzgMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51F9A801F7B;
        Wed, 25 Mar 2020 09:11:23 +0000 (UTC)
Received: from new-host-5 (unknown [10.40.194.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9EDF5C241;
        Wed, 25 Mar 2020 09:11:20 +0000 (UTC)
Message-ID: <e1733a5fd6f6bbeeae82c0cbc62c17675818bb6c.camel@redhat.com>
Subject: Re: [PATCH v2 3/3] driver core: Skip unnecessary work when device
 doesn't have sync_state()
From:   Davide Caratti <dcaratti@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vladimir Benes <vbenes@redhat.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200325074428.GA3014101@kroah.com>
References: <20200221080510.197337-1-saravanak@google.com>
         <20200221080510.197337-4-saravanak@google.com>
         <f22b7cd6fb6256f56e908e021f4fe389f3a6ee07.camel@redhat.com>
         <20200325074428.GA3014101@kroah.com>
Organization: red hat
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 25 Mar 2020 10:11:19 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-25 at 08:44 +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 24, 2020 at 09:03:28PM +0100, Davide Caratti wrote:
> > On Fri, 2020-02-21 at 00:05 -0800, Saravana Kannan wrote:
> > > A bunch of busy work is done for devices that don't have sync_state()
> > > support. Stop doing the busy work.
> > > 
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/base/core.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > 
> > hello Greg,
> > 
> > this patch and patch 2/3 of the same series proved to fix systematic
> > crashes (NULL pointer dereference in device_links_flush_sync_list() while
> > loading mac80211_hwsim.ko, see [1]) on Fedora 31, that are triggered by
> > NetworkManager-ci [2]. May I ask to queue these two patches for the next
> > 5.5 stable?
> 
> What are the git commit ids of these patches in Linus's tree that you
> want backported?

right, I should have mentioned them also here: 

ac338acf514e "(driver core: Add dev_has_sync_state())" <-- patch 2/3 
77036165d8bc "(driver core: Skip unnecessary work when device doesn't have sync_state())" <-- patch 3/3

like Saravana mentioned, the problem is probably introduced by patch
1/3 of the series, 

77036165d8bc "(driver core: Skip unnecessary work when device doesn't have sync_state())"

that's already in stable 5.5.

thanks!
-- 
davide


