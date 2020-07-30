Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4CEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9862070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ow95l7Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgG3OPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:15:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727072AbgG3OPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596118534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mC9bnvLUmM2DBjf+quSal6Se9a1/PYo8DVnoJYZcaTc=;
        b=Ow95l7Hy33WpUuimm99Ud9CJFBgQD0BACnv886Nqeva1yiKdxYL8qujGa2RgrIt6zIJADE
        dDESO9mihKk12v9ZjT1D1IcxF2K+MelbN7uKUo2tpSE0JSEKxCh7hCjYiQnHMn1pgD06ea
        LieU59CIrmnQ2YWvuSiZvhkOy9WaQSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-2bvH98rxNImIqjoAgJcl4A-1; Thu, 30 Jul 2020 10:15:32 -0400
X-MC-Unique: 2bvH98rxNImIqjoAgJcl4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66FFA100944F;
        Thu, 30 Jul 2020 14:15:31 +0000 (UTC)
Received: from treble (ovpn-119-23.rdu2.redhat.com [10.10.119.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0E2610246F2;
        Thu, 30 Jul 2020 14:15:28 +0000 (UTC)
Date:   Thu, 30 Jul 2020 09:15:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH v3 2/4] objtool: Move orc outside of check
Message-ID: <20200730141526.lr33zv4ffa3rdygp@treble>
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-3-jthierry@redhat.com>
 <20200730095759.GH2655@hirez.programming.kicks-ass.net>
 <dfe69c8f-db70-8366-5601-2592409ce7a0@redhat.com>
 <20200730132237.GM2655@hirez.programming.kicks-ass.net>
 <3af41a3b-a4b9-8120-3ac0-c9ce13770628@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3af41a3b-a4b9-8120-3ac0-c9ce13770628@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 02:29:20PM +0100, Julien Thierry wrote:
> 
> 
> On 7/30/20 2:22 PM, peterz@infradead.org wrote:
> > On Thu, Jul 30, 2020 at 01:40:42PM +0100, Julien Thierry wrote:
> > > 
> > > 
> > > On 7/30/20 10:57 AM, peterz@infradead.org wrote:
> > > > On Thu, Jul 30, 2020 at 10:41:41AM +0100, Julien Thierry wrote:
> > > > > +		if (file->elf->changed)
> > > > > +			return elf_write(file->elf);
> > > > > +		else
> > > > > +			return 0;
> > > > >    	}
> > > > 
> > > > I think we can do without that else :-)
> > > > 
> > > 
> > > I did wonder and was not 100% confident about it, but the orc gen will
> > > always change the file, correct?
> > 
> > Not if it already has orc, iirc.
> > 
> > But what I was trying to say is that:
> > 
> > 	if (file->elf->changed)
> > 		return elf_write(file->elf)
> > 
> > 	return 0;
> > 
> > is identical code and, IMO, easier to read.
> > 
> 
> Much easier yes, I'll change it.

But I think file->elf->changed can be assumed at this point anyway, so
it could just be an unconditional

	return elf_write(file->elf);

-- 
Josh

