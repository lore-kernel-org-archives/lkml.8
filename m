Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9A6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C68920757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nuy+VIQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389874AbgDBR2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:28:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52054 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389166AbgDBR2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585848483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AMQfLxvugCOFU77orNDzP9NMFKIQjlgZ0oIuQQ+c+oc=;
        b=Nuy+VIQe1ABsq8MLJZGPhjCkJ4atT5yjAB6aPDySSObZZSRKYJ22A5z245ScJ5TWvFNcQM
        fwL1UvV7gkeshgHFL1m4Rxh7ujDGUzdta8OWyCFPd+nLQU9BHZoBRZAjkDEr3vZdAAvaRl
        oIOl5ChResYBuThowd1ycFIexRagIUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-n999QUpTNZeUqoeUoAWTRw-1; Thu, 02 Apr 2020 13:27:59 -0400
X-MC-Unique: n999QUpTNZeUqoeUoAWTRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A301107ACC9;
        Thu,  2 Apr 2020 17:27:58 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E40B5E02B;
        Thu,  2 Apr 2020 17:27:57 +0000 (UTC)
Date:   Thu, 2 Apr 2020 12:27:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: Re: [PATCH 3/7] objtool: Add support for intra-function calls
Message-ID: <20200402172755.eejb5g7z5oadj5pj@treble>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-4-alexandre.chartre@oracle.com>
 <db508586-258a-0616-d649-e76e95df9611@redhat.com>
 <20200402154919.2c6shw4hfreagchg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200402154919.2c6shw4hfreagchg@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:49:19AM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 02, 2020 at 01:53:49PM +0100, Julien Thierry wrote:
> > Hi Alexandre,
> > 
> > I ran into the limitation of intra-function call for the arm64 support but
> > didn't take the time to make a clean patch to support them properly.
> 
> Can you give an example of where arm64 uses intra-function calls?  It
> sounds sketchy to me :-)  Is it really needed/useful?

BTW, I have a vague memory of discussing this before, so I apologize if
I'm repeating myself ;-)

-- 
Josh

