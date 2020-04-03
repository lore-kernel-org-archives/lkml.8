Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3956CC2BA18
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D2620CC7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkM5y40/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404063AbgDCOzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:55:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33677 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404068AbgDCOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585925721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3R5aqOAa6cJV3ccGmaNvYRE09DuIFl70G2nLJBN8x94=;
        b=CkM5y40/zmn+d3qJ2YjJB2xuBfOT1S6fL8lTZqWFCEL63Db3BqWtFcT72GZOTPRav+VDm6
        IXPS0Wivj1WPJWkKq5TCHWXFYTK7wBK4oaNV4IcxETWA+xdKaRMzHn9eINgHC1/Cd3Iwqh
        jk12QuzSN6nLiW/vNI8fkS2xv0kRtX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-Kbxj0pLlMJePshtVQGBF3w-1; Fri, 03 Apr 2020 10:55:19 -0400
X-MC-Unique: Kbxj0pLlMJePshtVQGBF3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B94B0107ACCC;
        Fri,  3 Apr 2020 14:55:18 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F7685C1BE;
        Fri,  3 Apr 2020 14:55:17 +0000 (UTC)
Date:   Fri, 3 Apr 2020 09:55:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        raphael.gault@arm.com
Subject: Re: [PATCH v2 10/10] objtool: Support multiple stack_op per
 instruction
Message-ID: <20200403145515.ywubrfbg44a22orf@treble>
References: <20200327152847.15294-1-jthierry@redhat.com>
 <20200327152847.15294-11-jthierry@redhat.com>
 <20200402175426.77houvk46xhcxxmn@treble>
 <3b3f07b3-172b-0560-96c7-d9386e3cab23@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b3f07b3-172b-0560-96c7-d9386e3cab23@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:01:46AM +0100, Julien Thierry wrote:
> 
> 
> On 4/2/20 6:54 PM, Josh Poimboeuf wrote:
> > On Fri, Mar 27, 2020 at 03:28:47PM +0000, Julien Thierry wrote:
> > > @@ -127,6 +129,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
> > >   	if (insn.sib.nbytes)
> > >   		sib = insn.sib.bytes[0];
> > > +	op = calloc(1, sizeof(*op));
> > > +	if (!op)
> > > +		return -1;
> > > +
> > 
> > Why not malloc()?
> > 
> 
> It's just that previsously, stack_op was part of the instruction structure
> and was initialized to all 0 in decode_instructions(). Now that it's created
> here, I assumed it would be better to have the same thing here and
> initialized the new stack_op to all 0.
> 
> Do you prefer to have an explicit malloc() + memset()?

Maybe just add a comment that calloc() is equivalent to malloc() +
memset() zero, for us user-space neophytes :-)

-- 
Josh

