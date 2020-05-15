Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFEBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71CD52073E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9Hj/h33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgEOVE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:04:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44730 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbgEOVE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589576696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3caG0B1RGM0w2YEbxxrwWnjt85G7AlSJ61zuBN9U0lE=;
        b=T9Hj/h33x+hcV36RDRcl1F6Q3uRQUmHuWQSC2rJkGl47WPWm0zd4YOrDo9tCjf7jpE+d8w
        x1Yu7oknfSeeODx0JgYUoRzFDuvT3JOYPTHsFFm/n/ac+zxufrTKzFvgGrZyVsfD7qgV1v
        917w+jcMzlXL5NLdPtf0XfzrzAWQX9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-W0DOlcrlPGuDq6Uu0tbPDw-1; Fri, 15 May 2020 17:04:52 -0400
X-MC-Unique: W0DOlcrlPGuDq6Uu0tbPDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDC361005510;
        Fri, 15 May 2020 21:04:50 +0000 (UTC)
Received: from treble (ovpn-117-151.rdu2.redhat.com [10.10.117.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B98E5D9C9;
        Fri, 15 May 2020 21:04:50 +0000 (UTC)
Date:   Fri, 15 May 2020 16:04:48 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 5/5] objtool: Report missing support for subcommands
Message-ID: <20200515210448.jqseippuz52wx7ct@treble>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <38a0c7a1ec8d98238379a322866c0432befc259b.1588888003.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38a0c7a1ec8d98238379a322866c0432befc259b.1588888003.git.mhelsley@vmware.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:35:13AM -0700, Matt Helsley wrote:
> The check and orc-related subcommands for objtool are x86-specific.
> To make this clear to anyone using the tool return a non-zero exit
> code and indicate in the help and usage output which commands are
> (and are not) available.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>

I think I'd rather the simplest approach of just having the weak
functions print an error and return an error code.  At least for now I
don't think we need to go through the trouble of advertising whether
certain commands are available.  Technically they are available, they
just always fail :-)

And, people don't tend to use objtool directly anyway.

BTW, several of the patches didn't apply cleanly to tip/master, so
you'll probably need to rebase for v2.  There've been a lot of objtool
changes lately.  Peter's been busy...

-- 
Josh

