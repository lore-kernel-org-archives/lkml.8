Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1A5C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668152071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDX0cwBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgHaSbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgHaSbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598898707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RxJLlZuQTfe0nzxxsZvFwjkSWTHqtnjzt8kLm8TmuCk=;
        b=WDX0cwBQCI8wAmWP8j7BEqB/sz8s5TI3QQGf6YTP0EprCalJoL4KLkyWKV2lvvWDI2D3sn
        R2FzNpODhhzED5O8WWsHVyZbx3FTJwHJycv+zl5i8UjFoerZZjWz+jVek5A0Aep4FgkcQN
        OmKopjGz1iiNXFKZ5698XAeX2vnzrgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-9T-JruPWPqiJYtb7vtNn6A-1; Mon, 31 Aug 2020 14:31:45 -0400
X-MC-Unique: 9T-JruPWPqiJYtb7vtNn6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E43FB1084C81;
        Mon, 31 Aug 2020 18:31:43 +0000 (UTC)
Received: from treble (ovpn-114-37.rdu2.redhat.com [10.10.114.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AFEB7A41A;
        Mon, 31 Aug 2020 18:31:42 +0000 (UTC)
Date:   Mon, 31 Aug 2020 13:31:40 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v2 8/9] frame: Make unwind hints definitions available to
 other architectures
Message-ID: <20200831183140.xxadcua3ggldbo6q@treble>
References: <20200730094652.28297-1-jthierry@redhat.com>
 <20200730094652.28297-9-jthierry@redhat.com>
 <20200730145613.lbsexjcqwj67ktmb@treble>
 <12615fa7-8ba9-1daa-f648-644bf16110f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12615fa7-8ba9-1daa-f648-644bf16110f2@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 01:12:04PM +0100, Julien Thierry wrote:
> 
> 
> On 7/30/20 3:56 PM, Josh Poimboeuf wrote:
> > On Thu, Jul 30, 2020 at 10:46:51AM +0100, Julien Thierry wrote:
> > > Unwind hints are useful to provide objtool with information about stack
> > > states in non-standard functions/code.
> > > While the type of information being provided might be very arch
> > > specific, the mechanism to provide the information can be useful for
> > > other architectures.
> > > 
> > > Move the relevant unwint hint definitions for all architectures to
> > > see.
> > 
> > The scope of include/linux/frame.h has been creeping, it's no longer
> > just about frame pointers.  Maybe we should rename it to objtool.h.
> > 
> 
> I missed this comment until now, sorry.
> 
> The name "objtool.h" might conflict with tools/objtool/objtool.h. What about
> "objtool_utils.h" or "objtool_defs.h" ?

There shouldn't be a conflict: objtool doesn't include kernel headers
directly; and even if it did need a copy (in tools/include/linux), it
would be referenced as <linux/objtool.h> instead of "objtool.h".

-- 
Josh

