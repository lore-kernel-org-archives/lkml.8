Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDE9C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36393206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9/heIwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgD1USF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:18:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57310 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726284AbgD1USF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588105084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pNaTRGOowlvoNRIeEmlZ9mTD2eu8RhnnExgOmaoGzV0=;
        b=I9/heIwrDdX3/DqMXNnmwIFMjwO1q+oE/wmxP8OPBDnSmbnpKqgUDxV7vskIITfogFxz+r
        DMDYPWGr6AKT//mVaC0RLzxO/sMD7JFfoQiQyN9bPSHWhFeZk86twGFJApuZqhA+jD+WeQ
        MRYKBruw9Sk+B3dQb5LYyglETImYKkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-PMu2hFzMMxWbx51mksD7FQ-1; Tue, 28 Apr 2020 16:18:02 -0400
X-MC-Unique: PMu2hFzMMxWbx51mksD7FQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44E768015CE;
        Tue, 28 Apr 2020 20:18:01 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61B4660D60;
        Tue, 28 Apr 2020 20:18:00 +0000 (UTC)
Date:   Tue, 28 Apr 2020 15:17:58 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH v2 00/14] objtool vs retpoline
Message-ID: <20200428201758.zwi5pfj7bpuvjwnw@treble>
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428191101.886208539@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:11:01PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> Based on Alexandre's patches, here's a few that go on top of tip/objtool/core.
> 
> With these patches on objtool can completely understand retpolines and RSB
> stuffing, which means it can emit valid ORC unwind information for them, which
> in turn means we can now unwind through a retpoline.
> 
> New since last time:
> 
>  - 1-3, alternatives vs ORC unwind
>  - 7-9: implement some suggestions from Julien
>  - addressed feedback

For patches 2-14:

  Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Instead of patch 1, maybe you could grab Julien's patch to drop the
useless warning; and also grab the alt_group numbering and the
"orig->alt_group = true" bits from Alexandre's patch.

-- 
Josh

