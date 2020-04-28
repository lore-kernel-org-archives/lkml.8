Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF2FC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FB6206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtNTHlqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgD1JyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:54:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53869 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726974AbgD1JyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588067645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JDcXgincut8WHXmgN9Oi3Xs1ZRKQ3KlFK8d41RjA30E=;
        b=PtNTHlqw6aQJNjDhCidAc65dd85frSb2xrYI3wIDy+3UJCfiGY6O15OXoRbZT9h/3VuvIL
        iUaGr5Rf4xweffU9IakiNahy9S93hJfJDc+ARxc+4k7qHjH6LMFUsiDlBYs2LBsSOFJEUA
        845MeP3GX7oC1E5S26f4rQ71YmIl5WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-y3OF7pCRNUS5WYVWLlV4iw-1; Tue, 28 Apr 2020 05:54:00 -0400
X-MC-Unique: y3OF7pCRNUS5WYVWLlV4iw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6313A107ACCA;
        Tue, 28 Apr 2020 09:53:59 +0000 (UTC)
Received: from krava (unknown [10.40.196.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 175A41002388;
        Tue, 28 Apr 2020 09:53:57 +0000 (UTC)
Date:   Tue, 28 Apr 2020 11:53:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steve MacLean <Steve.MacLean@microsoft.com>
Cc:     Francois Saint-Jacques <fsaintjacques@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v3] perf inject --jit: Remove //anon mmap
 events
Message-ID: <20200428095355.GF1476763@krava>
References: <CABNn7+pYPSfduacOATcKT1X_=qs70i7Bc8pELXDahY7BoB9_wQ@mail.gmail.com>
 <20191229155112.GA21785@krava>
 <CH2PR21MB1511DC522EBE2E19C8185FE8F7AF0@CH2PR21MB1511.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR21MB1511DC522EBE2E19C8185FE8F7AF0@CH2PR21MB1511.namprd21.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:03:58PM +0000, Steve MacLean wrote:
> > it's simple enough to revert in case there's any issue
> >
> > thanks,
> > jirka
> 
> Can we go ahead and merge this?
> 

I saw the explanation you posted:
  https://lore.kernel.org/lkml/CY4PR21MB0632B5EE447DA9B931CB114DF7740@CY4PR21MB0632.namprd21.prod.outlook.com/

could you please add it to the patch changelog and repost?

as I said I'm ok with the patch, Stephane?

jirka

