Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1698CC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC24208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnWnfFl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgEHSXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:23:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55779 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgEHSXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588962209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=myo8Tk8TgNvVtlGSwYNrPjsKmagFJfTNCigTo/58By4=;
        b=hnWnfFl6Iofwt/CLoj0DqW0ZdfyQLUL+z4sIYpURjEhoXMxtZxcJWRLoMMwkadV38Xujmj
        IqZCVnVlxKecyni56OVLwxWBfLs+5zBgXpAuXWkZSpVzVrkLA/5xr/XnT+hSQW9fZQotts
        DzAboyW7EMGeukage18R2MLUYNRZZSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-5zrj16gVMhmfL_UvzKa_wg-1; Fri, 08 May 2020 14:23:27 -0400
X-MC-Unique: 5zrj16gVMhmfL_UvzKa_wg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBDC0107ACF9;
        Fri,  8 May 2020 18:23:25 +0000 (UTC)
Received: from x2.localnet (ovpn-113-49.phx2.redhat.com [10.3.113.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57FFA6AD1B;
        Fri,  8 May 2020 18:23:18 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, omosnace@redhat.com, fw@strlen.de,
        twoerner@redhat.com, Eric Paris <eparis@parisplace.org>,
        ebiederm@xmission.com, tgraf@infradead.org
Subject: Re: [PATCH ghak25 v4 3/3] audit: add subj creds to NETFILTER_CFG record to cover async unregister
Date:   Fri, 08 May 2020 14:23:17 -0400
Message-ID: <1894903.vQEQaK82eK@x2>
Organization: Red Hat
In-Reply-To: <20200506224233.najv6ltb5gzcicqb@madcap2.tricolour.ca>
References: <cover.1587500467.git.rgb@redhat.com> <3250272.v6NOfJhyum@x2> <20200506224233.najv6ltb5gzcicqb@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 6, 2020 6:42:33 PM EDT Richard Guy Briggs wrote:
> > > > We can't be adding deleting fields based on how its triggered. If
> > > > they are unset, that is fine. The main issue is they have to behave
> > > > the same.
> > > 
> > > I don't think the intent was to have fields swing in and out depending
> > > on trigger.  The idea is to potentially permanently not include them in
> > > this record type only.  The justification is that where they aren't
> > > needed for the kernel trigger situation it made sense to delete them
> > > because if it is a user context event it will be accompanied by a
> > > syscall record that already has that information and there would be no
> > > sense in duplicating it.
> > 
> > We should not be adding syscall records to anything that does not result
> > from a syscall rule triggering the event. Its very wasteful. More
> > wasteful than just adding the necessary fields.
> 
> So what you are saying is you want all the fields that are being
> proposed to be added to this record?

Yes.

> If the records are all from one event, they all should all have the same
> timestamp/serial number so that the records are kept together and not
> mistaken for multiple events.

But NETFILTER_CFG is a simple event known to have only 1 record.

> One reason for having information in seperate records is to be able to
> filter them either in kernel or in userspace if you don't need certain
> records.

We can't filter out SYSCALL.

-Steve


