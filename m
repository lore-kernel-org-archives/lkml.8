Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADB9C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 21:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522D62074D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 21:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuV31VFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgF1VuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 17:50:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32269 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726079AbgF1VuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 17:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593381009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xyy6krilidAIyy2G0nPehLucKPOTt/b1Z3aO2e2OOBs=;
        b=NuV31VFDQktg3xiBNbgIh/BBiSizcdLTQT0FRBNWdkNxEV0T5z1Dmqysyi6fhXhkV7kv23
        3EWx/PdbNoN4oRwInlApn/E/57PXChQN9DcmWU8V1FAtPtlPtny8ZpfHh/4aN6WzLA72MI
        NIcJlElR0SQqIfajYdnZWmOwnlaQVqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-klE4hJaJOfW5XarMNkihlA-1; Sun, 28 Jun 2020 17:50:05 -0400
X-MC-Unique: klE4hJaJOfW5XarMNkihlA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38396107ACCA;
        Sun, 28 Jun 2020 21:50:03 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1D5485D9DA;
        Sun, 28 Jun 2020 21:49:59 +0000 (UTC)
Date:   Sun, 28 Jun 2020 23:49:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 01/10] perf tools: Rename expr__add_id to expr__add_val
Message-ID: <20200628214959.GK2988321@krava>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626194720.2915044-2-jolsa@kernel.org>
 <CAP-5=fV-i+fNj1v_6v4gnaZNoT9XSR1AOJr3cau2R0+MjJemkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV-i+fNj1v_6v4gnaZNoT9XSR1AOJr3cau2R0+MjJemkQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:01:51PM -0700, Ian Rogers wrote:
> Firstly, thanks for this work!
> 
> On Fri, Jun 26, 2020 at 12:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Renaming expr__add_id to expr__add_val so we can use
> > expr__add_id to actually add just id in following changes.
> 
> Perhaps clear up in the commit message that add id won't add an id and
> a value, just the id. I don't mind long intention revealing function
> names, so expr__add_id_with_val may most fully convey this change.

ok, how about expr__add_id_val ?

jirka

