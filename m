Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD82C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 22:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEBD20702
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 22:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdK74PlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgBVWCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 17:02:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26451 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbgBVWCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 17:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582408950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HfKky+nt4grpJG/P21ojgvgnBL6Ye5h1Ib5S8gPVVb0=;
        b=bdK74PlG1ZH9uWSLHCGpIT7EOnoH1S5OrSVWgUznbhfZgb3ZRjZYeDcLMa6DSvw67pSwGD
        STyDJzgeCCimTJabqKkeFeagqEUK+GLG2JVoYI+sxGOOvxGavj4qJM77KEoTwS41yEPAHY
        VJlkHu2RB3JHJ51w4uAij40KX4bHJXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-YCF0ZadWN8ay53fld5q7HQ-1; Sat, 22 Feb 2020 17:02:25 -0500
X-MC-Unique: YCF0ZadWN8ay53fld5q7HQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D1D98017CC;
        Sat, 22 Feb 2020 22:02:21 +0000 (UTC)
Received: from krava (ovpn-204-16.brq.redhat.com [10.40.204.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77BF69183B;
        Sat, 22 Feb 2020 22:02:18 +0000 (UTC)
Date:   Sat, 22 Feb 2020 23:02:15 +0100
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
Message-ID: <20200222220215.GA9575@krava>
References: <20200221231935.735145-1-jolsa@kernel.org>
 <20200221231935.735145-3-jolsa@kernel.org>
 <20200222002312.GN160988@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222002312.GN160988@tassilo.jf.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
> 
> Looks reasonable to me.

it still needs to replace/skip special chars,
I'll post fixed version next week

thanks,
jirka

