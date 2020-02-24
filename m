Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A67C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2476820714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDdq/60h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgBXIaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:30:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41091 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbgBXIaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582533019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DPoMszNHUoXAHQiBb1rQHz8L7fumCgYwDlek9a1RB/I=;
        b=fDdq/60hWSIGzsRDi3/UBsuBjNclW+kz6cfNd+aWO6ML+ObkoDpKeVvGzPXgY85gwj3Q56
        wi/rccbQzaogWzLwhMcdEqpGcHCK6iQUsVjwwl3tfMYFJSRTsCxUpqmMoqA4tB24bCTTsn
        d+Lca7dOBE1YoOSPiHcChQRfqexIHo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-DhTbfAZKPwWkOyRQsHKyUA-1; Mon, 24 Feb 2020 03:30:15 -0500
X-MC-Unique: DhTbfAZKPwWkOyRQsHKyUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A922F13FD;
        Mon, 24 Feb 2020 08:30:13 +0000 (UTC)
Received: from krava (ovpn-205-68.brq.redhat.com [10.40.205.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00BA05C241;
        Mon, 24 Feb 2020 08:30:06 +0000 (UTC)
Date:   Mon, 24 Feb 2020 09:30:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 2/4] perf expr: Move expr lexer to flex
Message-ID: <20200224083003.GC16664@krava>
References: <20200221231935.735145-1-jolsa@kernel.org>
 <20200221231935.735145-3-jolsa@kernel.org>
 <20200222002312.GN160988@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222002312.GN160988@tassilo.jf.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 04:23:12PM -0800, Andi Kleen wrote:
> > +max		{ return MAX; }
> > +min		{ return MIN; }
> > +if		{ return IF; }
> > +else		{ return ELSE; }
> > +#smt_on		{ return SMT_ON; }
> > +{number}	{ return value(yyscanner, 10); }
> > +{symbol}	{ return str(yyscanner, ID); }
> > +"|"		{ return '|'; }
> > +"^"		{ return '^'; }
> > +"&"		{ return '&'; }
> > +"-"		{ return '-'; }
> > +"+"		{ return '+'; }
> > +"*"		{ return '*'; }
> > +"/"		{ return '/'; }
> > +"%"		{ return '%'; }
> > +"("		{ return '('; }
> > +")"		{ return ')'; }
> > +","		{ return ','; }
> 
> Didn't think there was a comma, but ok.

actually it's for the min/max functions arguments separation
I posted v2

jirka

> 
> Looks reasonable to me.
> 
> -Andi
> 

