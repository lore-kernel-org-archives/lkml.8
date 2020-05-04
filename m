Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C545BC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 02:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A529C2071C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 02:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWG7ZdI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgEDCvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 22:51:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56545 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgEDCvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 22:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588560705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3LaCbVlWjbzCuD40XLJY0jfLFr8/yA0ea/zELNcIVD4=;
        b=DWG7ZdI9Ijl+g/SQovrlveEjbLiXut6kdtiDaGIX7uAK+c/4wow8M0OK8goo8qglRSgZF+
        4bS6ssDcwDjXMLdHrrV4+hxc1fyrs6ozYMUWxVj6J8IOYtmcMUN5UJ463EAhTnhnngfGtZ
        C/LXlrS9TLcMnqsZl340/mo8sBGAuAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-hfu3dCytO1GZC_r4ZmLjXA-1; Sun, 03 May 2020 22:51:43 -0400
X-MC-Unique: hfu3dCytO1GZC_r4ZmLjXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D72141895A2A;
        Mon,  4 May 2020 02:51:41 +0000 (UTC)
Received: from t490s (ovpn-112-64.phx2.redhat.com [10.3.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B74521001B30;
        Mon,  4 May 2020 02:51:40 +0000 (UTC)
Date:   Sun, 3 May 2020 22:51:38 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org
Subject: Re: [PATCH] mm: slub: add panic_on_error to the debug facilities
Message-ID: <20200504025138.GB18463@t490s>
References: <20200501211540.71216-1-aquini@redhat.com>
 <alpine.DEB.2.22.394.2005022313490.1519@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2005022313490.1519@www.lameter.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 11:16:30PM +0000, Christopher Lameter wrote:
> On Fri, 1 May 2020, Rafael Aquini wrote:
> 
> > Sometimes it is desirable to override SLUB's debug facilities
> > default behavior upon stumbling on a cache or object error
> > and just stop the execution in order to grab a coredump, at
> > the error-spotting time, instead of trying to fix the issue
> > and report in an attempt to keep the system rolling.
> 
> The stopping of execution on an error is the default behavior. Usually
> you get some OOPS somewhere when data is corrupted and that causes a core
> dump.
> 
> SLUB can fix the issue and continue if enabled by specifying special
> options on boot. That is *not* the default.
>
It is the default behavior when slub_debug is turned on, which is what
this patch is trying to override, when needed. We've been seeing the
need for such feature as, most often than not, by letting the system
running to crash somewhere else after hitting occurrences reported by 
slub_debug ends up clobbering clues to the original issue.

-- Rafael

