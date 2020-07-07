Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE8BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171EF2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Av2GKPOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgGGRbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:31:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42773 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728036AbgGGRbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594143090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1JNKnughHzmUSO0b3oMDeWVqYEtKjsfc7Nl0FoZm4g=;
        b=Av2GKPOUsYl4xUaDvedTVCFhJEfF20zG1cU/qIG945pPSsbvpnFl7Gk9AmERnmkhEnrkFJ
        zv+CIhpRjZv+cXF4WzOZms/9t1+YT3wAghlPVjiG0oZy+SjkgW4tH7fahRXmR3S45bAN8U
        6i2Tf4yehBGIfRk6J2mBKxQmoOtRdHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-baVp8dsoOtGV4FgC05JZvA-1; Tue, 07 Jul 2020 13:31:28 -0400
X-MC-Unique: baVp8dsoOtGV4FgC05JZvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2C531B18BCB;
        Tue,  7 Jul 2020 17:31:27 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-172.phx2.redhat.com [10.3.114.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 829C6797E9;
        Tue,  7 Jul 2020 17:31:27 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 45A191202DC; Tue,  7 Jul 2020 13:31:26 -0400 (EDT)
Date:   Tue, 7 Jul 2020 13:31:26 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4 35/65] nfsd: clients dont need to break their own
 delegations
Message-ID: <20200707173126.GE171624@pick.fieldses.org>
References: <20200707145752.417212219@linuxfoundation.org>
 <20200707145754.171869800@linuxfoundation.org>
 <20200707153122.GA171624@pick.fieldses.org>
 <20200707172051.GT2722994@sasha-vm>
 <20200707172930.GU2722994@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707172930.GU2722994@sasha-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:29:30PM -0400, Sasha Levin wrote:
> On Tue, Jul 07, 2020 at 01:20:51PM -0400, Sasha Levin wrote:
> > On Tue, Jul 07, 2020 at 11:31:22AM -0400, J. Bruce Fields wrote:
> > > NACK.
> > > 
> > > (How did this one even end up headed for stable?  It wasn't cc'd to
> > 
> > It came in when I was looking at the later nfs patches in this series
> > and figured it is a fix on its own.
> > 
> > > stable, it's not a bugfix, and it's not a small patch.)
> > 
> > If its not a bugfix, why did it go in -rc4 rather than waiting for the
> > merge window?

They went in during the merge window, unless I'm very confused.

> Sorry, my bad, I failed at shuffling patches around. I'll drop these.

OK, thanks.

--b.

