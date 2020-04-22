Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5811C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E88D2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKT9+XVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgDVWRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:17:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23920 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVWRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587593860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/cWGqNrwRUi86LXOam7nhjqgeV8uCuXewweugzrbGz8=;
        b=VKT9+XVYc3p2IjIFY1s1c8qHarMS59nnmMNV4aRkqJpOefuYTfuQSyzRTp2smvB3kf05Mi
        KwHoSACQ/szmhvWwW/233qfqLMJOstUyaBGC5nx/mkkjeyIqLa6QW/xwZsCGGIyXjfwAM+
        FDEv/LYiBFqtVCm7uJIYXIU7VL++2Ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-etYuuQxEORWvQuObNkoVTA-1; Wed, 22 Apr 2020 18:17:38 -0400
X-MC-Unique: etYuuQxEORWvQuObNkoVTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E500E8017FD;
        Wed, 22 Apr 2020 22:17:35 +0000 (UTC)
Received: from treble (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4010460C87;
        Wed, 22 Apr 2020 22:17:34 +0000 (UTC)
Date:   Wed, 22 Apr 2020 17:17:32 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, Peter Zijlstra <peterz@infradead.org>,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecomb@intel.com
Subject: Re: [PATCH 1/9] objtool: do not assume order of parent/child
 functions
Message-ID: <20200422221732.wmih73qrdh4fksog@treble>
References: <20200415210452.27436-1-kristen@linux.intel.com>
 <20200415210452.27436-2-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415210452.27436-2-kristen@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:04:43PM -0700, Kristen Carlson Accardi wrote:
> If a .cold function is examined prior to it's parent, the link
> to the parent/child function can be overwritten when the parent
> is examined. Only update pfunc and cfunc if they were previously
> nil to prevent this from happening.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Hi Kristen,

I grabbed this one and it will be merged into the -tip tree soon.
Thanks!

-- 
Josh

