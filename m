Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B88FC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C619A2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kvsm+3Yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgCST1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:27:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53023 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbgCST1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584646024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFMdMW6Y0NTb1UiLeQfhS+IknCZrq0Eca3UovxCSJQw=;
        b=Kvsm+3YhC/fyED7oLSVQm5zODj1FAry9rUdHjqhZf5rCOb/1NNJz92Of2pEG+m1yQszDyL
        2RPDvpRRm/e494h5GWwcsJ3tZWId45FabjMMbaM5+P3D9mRdQdsVaV6eBMVu0qixc77Brh
        1lNg18kWNwThl3vCEXe1sFa/Uc2qChU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-iUNoR811N_G_WbmuXuK0bA-1; Thu, 19 Mar 2020 15:27:02 -0400
X-MC-Unique: iUNoR811N_G_WbmuXuK0bA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2DEF1005514;
        Thu, 19 Mar 2020 19:27:00 +0000 (UTC)
Received: from krava (unknown [10.40.194.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D7355D9CA;
        Thu, 19 Mar 2020 19:26:57 +0000 (UTC)
Date:   Thu, 19 Mar 2020 20:26:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Unify a bit the build directory output
Message-ID: <20200319192653.GA1200613@krava>
References: <20200318204522.1200981-1-jolsa@kernel.org>
 <20200319182514.GC14841@kernel.org>
 <20200319185750.GE14841@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319185750.GE14841@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 03:57:50PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 19, 2020 at 03:25:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Mar 18, 2020 at 09:45:22PM +0100, Jiri Olsa escreveu:
> > > Removing the extra 'SUBDIR' line from clean and doc build
> > > output. Because it's annoying.. ;-)
> > > 
> > > Before:
> > >   $ make clean
> > >   ...
> > >   SUBDIR   Documentation
> > >   CLEAN    Documentation
> > > 
> > > After:
> > >   $ make clean
> > >   ...
> > >   CLEAN    Documentation
> > 
> > Thanks, applied to perf/core.
> 
> Hey, since you're annoyed, how about sending a patch to ditch this one:
> 
> make[3]: Nothing to be done for '/tmp/build/perf/plugins/libtraceevent-dynamic-list'.
> 
> ? ;-)

I'll add it to my 'when annoyed todo list' .. which is getting
more and more attention in this lock down time ;-)

jirka

