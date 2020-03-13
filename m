Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B34C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D1B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcDu4u3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCMQpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:45:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgCMQpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584117948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2NGcze98cXWYCmagpEsgCSEsYGqJZVyFshEV55Z7Gjs=;
        b=XcDu4u3kepWmiOLSEpbzHbnaYcI9eB1At0FVgm6211A3oW0J0HJOEVYYrKU596gaWnaDvm
        PguZovZCDRl+e9iC1tfSyrjTqZwDT0/XcsPwvO/AoFZwGkwbunne7YhKq43yBZH/CBy8b4
        fp3nYI+QWGuEjVfAd4g7+EiX76OOL14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-CzQAHedQM_2jEHV0CsdCFg-1; Fri, 13 Mar 2020 12:45:42 -0400
X-MC-Unique: CzQAHedQM_2jEHV0CsdCFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61380101FC68;
        Fri, 13 Mar 2020 16:45:40 +0000 (UTC)
Received: from x2.localnet (ovpn-117-60.phx2.redhat.com [10.3.117.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1C565C1BB;
        Fri, 13 Mar 2020 16:45:30 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, linux-audit@redhat.com,
        nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling the audit daemon
Date:   Fri, 13 Mar 2020 12:45:29 -0400
Message-ID: <2588582.z15pWOfGEt@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhS9DtxJ4gvOfMRnzoo6ccGJVKL+uZYe6qqH+SPqD8r01Q@mail.gmail.com>
References: <cover.1577736799.git.rgb@redhat.com> <20200312202733.7kli64zsnqc4mrd2@madcap2.tricolour.ca> <CAHC9VhS9DtxJ4gvOfMRnzoo6ccGJVKL+uZYe6qqH+SPqD8r01Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 13, 2020 12:42:15 PM EDT Paul Moore wrote:
> > I think more and more, that more complete isolation is being done,
> > taking advantage of each type of namespace as they become available, but
> > I know a nuber of them didn't find it important yet to use IPC, PID or
> > user namespaces which would be the only namespaces I can think of that
> > would provide that isolation.
> > 
> > It isn't entirely clear to me which side you fall on this issue, Paul.
> 
> That's mostly because I was hoping for some clarification in the
> discussion, especially the relevant certification requirements, but it
> looks like there is still plenty of room for interpretation there (as
> usual).  I'd much rather us arrive at decisions based on requirements
> and not gut feelings, which is where I think we are at right now.

Certification rquirements are that we need the identity of anyone attempting 
to modify the audit configuration including shutting it down.

-Steve


