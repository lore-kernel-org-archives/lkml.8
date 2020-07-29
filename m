Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3438FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34BE20829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyohM68r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgG2OQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:16:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54083 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726724AbgG2OQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596032173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+kWxxzVDXpfhBG6NZI6e/XAKHu4RLpk6Vec2IpRy1o=;
        b=dyohM68rP+jWbWnvvaJxxyEk4ClKeHbgFKiG0t+lpya3rNUGqDYbECxSDt5RhgkRZ5xK8v
        g9SDdrAgccgDvhlGjMzCrCkqB1EqYG5TWfv3pILwXTyj4dmdx+9AJ8zeY1u6Bkmg2fxPJm
        1DS5CXP5U/wd6g4uPqsmotm+Tweqlxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-T0g2FcyGP7eT56ycpL13Zg-1; Wed, 29 Jul 2020 10:16:09 -0400
X-MC-Unique: T0g2FcyGP7eT56ycpL13Zg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9059F106B242;
        Wed, 29 Jul 2020 14:16:08 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67B6A5C5B7;
        Wed, 29 Jul 2020 14:16:08 +0000 (UTC)
Date:   Wed, 29 Jul 2020 10:16:07 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Donnelly <John.P.donnelly@oracle.com>, stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (resend) [PATCH [linux-4.14.y]] dm cache: submit writethrough
 writes in parallel to origin and cache
Message-ID: <20200729141607.GA7215@redhat.com>
References: <37c5a615-655d-c106-afd0-54e03f3c0eef@oracle.com>
 <20200727150014.GA27472@redhat.com>
 <20200729115119.GB2674635@kroah.com>
 <20200729115557.GA2799681@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729115557.GA2799681@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29 2020 at  7:55am -0400,
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Jul 29, 2020 at 01:51:19PM +0200, Greg KH wrote:
> > On Mon, Jul 27, 2020 at 11:00:14AM -0400, Mike Snitzer wrote:
> > > This mail needs to be saent to stable@vger.kernel.org (now cc'd).
> > > 
> > > Greg et al: please backport 2df3bae9a6543e90042291707b8db0cbfbae9ee9
> > 
> > Now backported, thanks.
> 
> Nope, it broke the build, I need something that actually works :)
> 

OK, I'll defer to John Donnelly to get back with you (and rest of
stable@).  He is more invested due to SUSE also having this issue.  I
can put focus to it if John cannot sort this out.

Mike

