Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD43C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D17206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0MyEES3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgFBP20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:28:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47970 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgFBP2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591111703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nR21UYc7T3iWpidCymNIbNxJAG4n7BvaujGaGmhQHhk=;
        b=W0MyEES3BDRrAq7t+ezk7kBa6nSCQSGSSN4rRcUjII11WWjZ4yGi+DwsWuUW/0Xp0OzFOu
        et9YD++CdJ+coicsG4cNb3fK9ixrn16UW0USiCp/jMsP4tKDMdJBmCoLE+yCUSM3mgGN3D
        DcIYyGzINjbrHhd/Cfl64oKCYO4tffc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-nG0o-nLyO5C6qydt-t2NRg-1; Tue, 02 Jun 2020 11:28:12 -0400
X-MC-Unique: nG0o-nLyO5C6qydt-t2NRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F397461;
        Tue,  2 Jun 2020 15:28:10 +0000 (UTC)
Received: from krava (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4CDDC6062D;
        Tue,  2 Jun 2020 15:28:07 +0000 (UTC)
Date:   Tue, 2 Jun 2020 17:28:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv3] perf stat: Ensure group is defined on top of the same
 cpu mask
Message-ID: <20200602152806.GD1169993@krava>
References: <20200531162206.911168-1-jolsa@kernel.org>
 <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
 <20200601082027.GF881900@krava>
 <CAP-5=fWLp8qyVjwVuQCTEoz=SY5FFtEEZyH5=L-5cAEeN4_5uw@mail.gmail.com>
 <20200602101736.GE1112120@krava>
 <20200602134256.GO31795@kernel.org>
 <20200602140508.GA1169993@krava>
 <20200602150352.GS31795@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602150352.GS31795@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 12:03:52PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > right, it disables 'grouping', events are scheduled/counted individualy
> 
> Ok, I applied this already, we can fix this in the next cycle.
> 
> > this way we will not hit the issue when looking for group_fd FD
> > and there's not any, because of different cpu maps
> 
> > > If I do:
> 
> > >   [root@seventh ~]# perf stat -e '{power/energy-cores/,power/energy-ram/},{instructions,cycles}' -a sleep 2
> 
> > >    Performance counter stats for 'system wide':
> 
> > >                 1.73 Joules power/energy-cores/
> > >                 0.92 Joules power/energy-ram/
> > >           12,191,658        instructions              #    0.67  insn per cycles/
> > >           18,275,233        cycles
> 
> > >          2.001272492 seconds time elapsed
> 
> > >   [root@seventh ~]#
> > >
> > > It works, grouped. One observation, shouldn't we somehow show in the
> > > output that the first two were indeed grouped, ditto for the second two?
> 
> > yea, we don't display groups in output.. also there's no number
> > for the group, it's still separate events numbers in output
> > grouping is only used when creating events
> 
> perhaps if we just add a blank line to separate groups? I.e. the above
> would be:
> 
> [root@seventh ~]# perf stat -e '{power/energy-cores/,power/energy-ram/},{instructions,cycles}' -a sleep 2
> 
>  Performance counter stats for 'system wide':
> 
>               1.73 Joules power/energy-cores/
>               0.92 Joules power/energy-ram/
> 
>         12,191,658        instructions              #    0.67  insn per cycle
>         18,275,233        cycles
> 
>        2.001272492 seconds time elapsed

maybe it could be separated by new line and we could put note in the comment:

  Performance counter stats for 'system wide':
 
               1.73 Joules power/energy-cores/
               0.92 Joules power/energy-ram/         # groupped
 
         12,191,658        instructions              #    0.67  insn per cycle
         18,275,233        cycles
 
        2.001272492 seconds time elapsed
 

for events that already have defined comment, it'd be on the next line, like:

  Performance counter stats for 'system wide':
 
               1.73 Joules power/energy-cores/
               0.92 Joules power/energy-ram/         # XXXXX
                                                     # groupped
 
         12,191,658        instructions              #    0.67  insn per cycle
         18,275,233        cycles
 
        2.001272492 seconds time elapsed
 

jirka

