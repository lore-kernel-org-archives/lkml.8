Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE9AC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9F8206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ju/gItcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgIKMKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgIKMIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599826119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVg8NZb3XREmzVribQHfAuVjodAq3CHk37cp1IALDMM=;
        b=Ju/gItcHTw51TT2+CxXIhgnLBUtBg6kK44LKS2UpsCsY39saK8659+sNPFIMxrppuB9zGH
        Wf9umbMMmOIjcHRl47nIaKsGfJaj7mPiQp3YdBF+I4fL4/szYYCLLd9RpAq99rZOx1DzjG
        /h/KXJ3GXMIv/l2Gp2PEk1SgDJoJEjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-UxymmEKUNsKZHYa3d4mO6A-1; Fri, 11 Sep 2020 08:08:38 -0400
X-MC-Unique: UxymmEKUNsKZHYa3d4mO6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE6E910082F9;
        Fri, 11 Sep 2020 12:08:36 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B52B7E8F1;
        Fri, 11 Sep 2020 12:08:36 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 08193181A050;
        Fri, 11 Sep 2020 12:08:36 +0000 (UTC)
Date:   Fri, 11 Sep 2020 08:08:35 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Craig <Daniel.Craig@csiro.au>,
        Nicolas Courtel <courtel@cena.fr>
Message-ID: <942693093.16771250.1599826115915.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200911115816.GB3717176@kroah.com>
References: <20200623195316.864547658@linuxfoundation.org> <20200623195323.968867013@linuxfoundation.org> <20200910194319.GA131386@eldamar.local> <20200911115816.GB3717176@kroah.com>
Subject: Re: [PATCH 4.19 142/206] gfs2: fix use-after-free on transaction
 ail lists
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.23, 10.4.195.2]
Thread-Topic: gfs2: fix use-after-free on transaction ail lists
Thread-Index: 7tAZ6eQVWu/XBrrfQ/Ia5mWO+IMFDw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> On Thu, Sep 10, 2020 at 09:43:19PM +0200, Salvatore Bonaccorso wrote:
> > Hi,
> > 
> > On Tue, Jun 23, 2020 at 09:57:50PM +0200, Greg Kroah-Hartman wrote:
> > > From: Bob Peterson <rpeterso@redhat.com>
> > > 
> > > [ Upstream commit 83d060ca8d90fa1e3feac227f995c013100862d3 ]
> > > 
> > > Before this patch, transactions could be merged into the system
> > > transaction by function gfs2_merge_trans(), but the transaction ail
> > > lists were never merged. Because the ail flushing mechanism can run
> > > separately, bd elements can be attached to the transaction's buffer
> > > list during the transaction (trans_add_meta, etc) but quickly moved
> > > to its ail lists. Later, in function gfs2_trans_end, the transaction
> > > can be freed (by gfs2_trans_end) while it still has bd elements
> > > queued to its ail lists, which can cause it to either lose track of
> > > the bd elements altogether (memory leak) or worse, reference the bd
> > > elements after the parent transaction has been freed.
> > > 
> > > Although I've not seen any serious consequences, the problem becomes
> > > apparent with the previous patch's addition of:
> > > 
> > > 	gfs2_assert_warn(sdp, list_empty(&tr->tr_ail1_list));
> > > 
> > > to function gfs2_trans_free().
> > > 
> > > This patch adds logic into gfs2_merge_trans() to move the merged
> > > transaction's ail lists to the sdp transaction. This prevents the
> > > use-after-free. To do this properly, we need to hold the ail lock,
> > > so we pass sdp into the function instead of the transaction itself.
> > > 
> > > Signed-off-by: Bob Peterson <rpeterso@redhat.com>
> > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
(snip)
> > 
> > In Debian two user confirmed issues on writing on a GFS2 partition
> > with this commit applied. The initial Debian report is at
> > https://bugs.debian.org/968567 and Daniel Craig reported it into
> > Bugzilla at https://bugzilla.kernel.org/show_bug.cgi?id=209217 .
> > 
> > Writing to a gfs2 filesystem fails and results in a soft lookup of the
> > machine for kernels with that commit applied. I cannot reporduce the
> > issue myself due not having a respective setup available, but Daniel
> > described a minimal serieos of steps to reproduce the issue.
> > 
> > This might affect as well other stable series where this commit was
> > applied, as there was a similar report for someone running 5.4.58 in
> > https://www.redhat.com/archives/linux-cluster/2020-August/msg00000.html
> 
> Can you report this to the gfs2 developers?
> 
> thanks,
> 
> greg k-h

Hi Greg,

No need. The patch came from the gfs2 developers. I think he just wants
it added to a stable release.

Regards,

Bob Peterson
GFS2 File System

