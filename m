Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E54C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23362051A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xy60esaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgAURuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:50:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50702 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728186AbgAURuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579629007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ae5Z+En0sqtjb39dBwdtiY6FkcMFIgmXM3FcN+xtsjE=;
        b=Xy60esaQvChiTQVbz1eOkL9QNyn5Qwa96n/F1QNqOn3YdobEO/GpxcUeiMk3qDGr/iO7nO
        MpXAmBKDoDo6XLvavCnNZLFsaRLufJSIXW/nX/D2DFSboNCoL0Fz46GlKTDUPbfPVazcWZ
        BUD5gRUnpXe/Q994luOX91LbEB5putw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-ozcYZBHiPnaFXzkGo2UiIg-1; Tue, 21 Jan 2020 12:50:06 -0500
X-MC-Unique: ozcYZBHiPnaFXzkGo2UiIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDD5C18B5FA2;
        Tue, 21 Jan 2020 17:50:04 +0000 (UTC)
Received: from treble (ovpn-122-154.rdu2.redhat.com [10.10.122.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FA1E8BE2F;
        Tue, 21 Jan 2020 17:50:03 +0000 (UTC)
Date:   Tue, 21 Jan 2020 11:50:01 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
Message-ID: <20200121175001.5jltrjuxrjklq5o2@treble>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200120150711.GD14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200120150711.GD14897@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 04:07:11PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 09, 2020 at 04:02:03PM +0000, Julien Thierry wrote:
> > In the mean time, any feedback on the current state is appreciated.
> > 
> > * Patches 1 to 18 adapts the current objtool code to make it easier to
> >   support new architectures.
> 
> In the interrest of moving things along; I've looked through these
> and 1-14,16 look good to me, 17,18 hurt my brain.
> 
> Josh, what say you?

Agreed.

Julien, thanks a lot for splitting these up nicely.  If you post 1-14
(updated based on the recent comments), we can look at merging those
sooner.

15-18 also hurt my brain -- probably a symptom of the existing fragile
mess -- so I'll need to spend more time staring at them.

-- 
Josh

