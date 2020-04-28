Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3D1C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8EF208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFKbfGdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgD1Rrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:47:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35964 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728448AbgD1Rrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588096055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kOFPHV7djE4yN9kYV8UD0gGJJiH5LnVp4DiGRU8Fo5A=;
        b=gFKbfGdCh1Z64PKvgJSvefSb6pGFuAt0tytp7bmRRVBy+Fj1GfLdTzGZjonAwA8zeq4Yyl
        IAtScYrvTkAuzvK5yyWBzI3ihbLmckt44nRxLeBqnyQBBnxWLNPJsDViSIwYw+AWHethzB
        SGkGDWKgYx4jm5SeGgAiDogQWrfDQwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-mgItoDWaM8OIFHsVd-tPRw-1; Tue, 28 Apr 2020 13:47:33 -0400
X-MC-Unique: mgItoDWaM8OIFHsVd-tPRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD4221008549;
        Tue, 28 Apr 2020 17:47:31 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D664579A9;
        Tue, 28 Apr 2020 17:47:31 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 3264D169; Tue, 28 Apr 2020 14:47:27 -0300 (BRT)
Date:   Tue, 28 Apr 2020 14:47:27 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zou Wei <zou_wei@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] tools lib traceevent: Remove unneeded semicolon
Message-ID: <20200428174727.GB2711@redhat.com>
References: <1588065121-71236-1-git-send-email-zou_wei@huawei.com>
 <20200428091915.7bead67f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428091915.7bead67f@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 28, 2020 at 09:19:15AM -0400, Steven Rostedt escreveu:
> On Tue, 28 Apr 2020 17:12:01 +0800
> Zou Wei <zou_wei@huawei.com> wrote:
> 
> > Fixes coccicheck warning:
> > 
> >  tools/lib/traceevent/kbuffer-parse.c:441:2-3: Unneeded semicolon
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zou Wei <zou_wei@huawei.com>
> > ---
> >  tools/lib/traceevent/kbuffer-parse.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/lib/traceevent/kbuffer-parse.c b/tools/lib/traceevent/kbuffer-parse.c
> > index b887e74..27f3b07 100644
> > --- a/tools/lib/traceevent/kbuffer-parse.c
> > +++ b/tools/lib/traceevent/kbuffer-parse.c
> > @@ -438,7 +438,7 @@ void *kbuffer_translate_data(int swap, void *data, unsigned int *size)
> >  	case KBUFFER_TYPE_TIME_EXTEND:
> >  	case KBUFFER_TYPE_TIME_STAMP:
> >  		return NULL;
> > -	};
> > +	}
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Arnaldo, can you take this?

Sure, applied.
 
> Thanks!
> 
> -- Steve
> 
> >  
> >  	*size = length;
> >  

