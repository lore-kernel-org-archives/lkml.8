Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3550C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621432176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ms6J+MZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbgBYUVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:21:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56397 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731565AbgBYUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582662071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WSvCqIPOAqpqMoWBgMDqztjHggXWGM6sCOu+ZfnsnV4=;
        b=Ms6J+MZwAND+3rkOfptdDQvogT8NJ7ARcKU61esZSKN/Qs1B/4gcuu5I6Bh/xiqrk+qkr8
        JmGcYfkZr8Uwz0IWYXatwSah3yiWKgFWW3Q25hyxX6LHY6wUhc/PNFBBge8zVcHeCeai7q
        4HrtV8On/qHL8k5WlFxg1hgushysQ24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-NpjRbR7cP2y4ixHLj7tXbw-1; Tue, 25 Feb 2020 15:21:07 -0500
X-MC-Unique: NpjRbR7cP2y4ixHLj7tXbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4FB51005513;
        Tue, 25 Feb 2020 20:21:05 +0000 (UTC)
Received: from krava (ovpn-205-170.brq.redhat.com [10.40.205.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AF521001B2C;
        Tue, 25 Feb 2020 20:20:59 +0000 (UTC)
Date:   Tue, 25 Feb 2020 21:20:56 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kabbott@redhat.com,
        skozina@redhat.com, mpetlan@redhat.com, nathans@redhat.com,
        mgoodwin@redhat.com, linux-perf-users@vger.kernel.org,
        bgregg@netflix.com, mspier@netflix.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] perf script: add flamegraph.py script
Message-ID: <20200225202056.GA160294@krava>
References: <20200221175500.83774-1-agerstmayr@redhat.com>
 <20200225195418.GA160300@krava>
 <0582d729-0e07-b95d-7cad-8912514b8871@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0582d729-0e07-b95d-7cad-8912514b8871@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 09:03:19PM +0100, Andreas Gerstmayr wrote:
> On 25.02.20 20:54, Jiri Olsa wrote:
> > On Fri, Feb 21, 2020 at 06:55:01PM +0100, Andreas Gerstmayr wrote:
> > > This script works in tandem with d3-flame-graph to generate flame graphs
> > > from perf. It supports two output formats: JSON and HTML (the default).
> > > The HTML format will look for a standalone d3-flame-graph template file in
> > > /usr/share/d3-flame-graph/template.html and fill in the collected stacks.
> > > 
> > > Usage:
> > > 
> > >      perf script flamegraph -a -F 99 sleep 60
> > > 
> > > Alternative usage:
> > > 
> > >      perf record -a -g -F 99 sleep 60
> > >      perf script report flamegraph
> > 
> > nice, could this output the output file, like:
> > 
> >       # perf script report flamegraph --output krava.html
> >       dumping data to krava.html

I meant the actual line ^^^^, saying that it's writing to the file

thanks,
jirka

> > 
> > or something in that sense
> > 
> > other than that it looks good to me
> 
> Yes, it's already implemented.
> 
> $ perf script report flamegraph --output krava.html
> 
> writes the output to krava.html
> 
> $ perf script report flamegraph --help
> 
> shows the supported arguments.
> 
> The only gotcha is that you need to have a perf.data in the same directory
> when calling this command, otherwise perf complains about a missing
> perf.data and doesn't call the flamegraph.py script.
> 
> 
> Cheers,
> Andreas
> 
> 
> > 
> > thanks,
> > jirka
> > 
> > 
> > > 
> > > Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > > 
> > > I'm currently preparing packages for d3-flame-graph. For Fedora, the copr
> > > at
> > > https://copr.fedorainfracloud.org/coprs/agerstmayr/reviews/package/js-d3-flame-graph/
> > > can be installed, or alternatively the prebuilt standalone d3-flame-graph
> > > template can be downloaded from
> > > https://raw.githubusercontent.com/andreasgerstmayr/specs/master/reviews/js-d3-flame-graph/template.html
> > > and moved into /usr/share/d3-flame-graph/template.html
> > > 
> > >   .../perf/scripts/python/bin/flamegraph-record |   2 +
> > >   .../perf/scripts/python/bin/flamegraph-report |   3 +
> > >   tools/perf/scripts/python/flamegraph.py       | 117 ++++++++++++++++++
> > >   3 files changed, 122 insertions(+)
> > >   create mode 100755 tools/perf/scripts/python/bin/flamegraph-record
> > >   create mode 100755 tools/perf/scripts/python/bin/flamegraph-report
> > >   create mode 100755 tools/perf/scripts/python/flamegraph.py
> > > 
> > > diff --git a/tools/perf/scripts/python/bin/flamegraph-record b/tools/perf/scripts/python/bin/flamegraph-record
> > > new file mode 100755
> > > index 000000000000..725d66e71570
> > > --- /dev/null
> > > +++ b/tools/perf/scripts/python/bin/flamegraph-record
> > > @@ -0,0 +1,2 @@
> > > +#!/usr/bin/sh
> > > +perf record -g "$@"
> > > diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
> > > new file mode 100755
> > > index 000000000000..b1a79afd903b
> > > --- /dev/null
> > > +++ b/tools/perf/scripts/python/bin/flamegraph-report
> > > @@ -0,0 +1,3 @@
> > > +#!/usr/bin/sh
> > > +# description: create flame graphs
> > > +perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
> > > diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> > > new file mode 100755
> > > index 000000000000..2e9139ef2c4a
> > > --- /dev/null
> > > +++ b/tools/perf/scripts/python/flamegraph.py
> > > @@ -0,0 +1,117 @@
> > > +# flamegraph.py - create flame graphs from perf samples
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# Usage:
> > > +#
> > > +#  perf record -a -g -F 99 sleep 60
> > > +#  perf script report flamegraph
> > > +#
> > > +# Combined data collection and flamegraph generation:
> > > +#
> > > +#  perf script flamegraph -a -F 99 sleep 60
> > > +#
> > > +# Written by Andreas Gerstmayr <agerstmayr@redhat.com>
> > > +# Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
> > > +# Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.com>
> > > +
> > > +import sys
> > > +import os
> > > +import argparse
> > > +import json
> > > +
> > > +
> > > +class Node:
> > > +    def __init__(self, name, libtype=""):
> > > +        self.name = name
> > > +        self.libtype = libtype
> > > +        self.value = 0
> > > +        self.children = []
> > > +
> > > +
> > > +class FlameGraphCLI:
> > > +    def __init__(self, args):
> > > +        self.args = args
> > > +        self.stack = Node("root")
> > > +
> > > +        if self.args.format == "html" and \
> > > +                not os.path.isfile(self.args.template):
> > > +            print(f"Flame Graph template '{self.args.template}' does not " +
> > > +                  f"exist. Please install the d3-flame-graph package, " +
> > > +                  f"specify an existing flame graph template " +
> > > +                  f"(--template PATH) or another output format " +
> > > +                  f"(--format FORMAT).", file=sys.stderr)
> > > +            sys.exit(1)
> > > +
> > > +    def find_or_create_node(self, node, name, dso):
> > > +        libtype = "kernel" if dso == "[kernel.kallsyms]" else ""
> > > +        if name is None:
> > > +            name = "[unknown]"
> > > +
> > > +        for child in node.children:
> > > +            if child.name == name and child.libtype == libtype:
> > > +                return child
> > > +
> > > +        child = Node(name, libtype)
> > > +        node.children.append(child)
> > > +        return child
> > > +
> > > +    def process_event(self, event):
> > > +        node = self.find_or_create_node(self.stack, event["comm"], None)
> > > +        if "callchain" in event:
> > > +            for entry in reversed(event['callchain']):
> > > +                node = self.find_or_create_node(
> > > +                    node, entry.get("sym", {}).get("name"), event.get("dso"))
> > > +        else:
> > > +            node = self.find_or_create_node(
> > > +                node, entry.get("symbol"), event.get("dso"))
> > > +        node.value += 1
> > > +
> > > +    def trace_end(self):
> > > +        def encoder(x): return x.__dict__
> > > +        json_str = json.dumps(self.stack, default=encoder,
> > > +                              indent=self.args.indent)
> > > +
> > > +        if self.args.format == "html":
> > > +            try:
> > > +                with open(self.args.template) as f:
> > > +                    output_str = f.read().replace("/** @flamegraph_params **/",
> > > +                                                  json_str)
> > > +            except IOError as e:
> > > +                print(f"Error reading template file: {e}", file=sys.stderr)
> > > +                sys.exit(1)
> > > +            output_fn = self.args.output or "flamegraph.html"
> > > +        else:
> > > +            output_str = json_str
> > > +            output_fn = self.args.output or "stacks.json"
> > > +
> > > +        if output_fn == "-":
> > > +            sys.stdout.write(output_str)
> > > +        else:
> > > +            try:
> > > +                with open(output_fn, "w") as out:
> > > +                    out.write(output_str)
> > > +            except IOError as e:
> > > +                print(f"Error writing output file: {e}", file=sys.stderr)
> > > +                sys.exit(1)
> > > +
> > > +
> > > +if __name__ == "__main__":
> > > +    parser = argparse.ArgumentParser(description="Create flame graphs.")
> > > +    parser.add_argument("-F", "--format",
> > > +                        default="html", choices=["json", "html"],
> > > +                        help="output file format")
> > > +    parser.add_argument("-o", "--output",
> > > +                        help="output file name")
> > > +    parser.add_argument("--indent",
> > > +                        type=int, help="JSON indentation")
> > > +    parser.add_argument("--template",
> > > +                        default="/usr/share/d3-flame-graph/template.html",
> > > +                        help="path to flamegraph HTML template")
> > > +    parser.add_argument("-i", "--input",
> > > +                        help=argparse.SUPPRESS)
> > > +
> > > +    args = parser.parse_args()
> > > +    cli = FlameGraphCLI(args)
> > > +
> > > +    process_event = cli.process_event
> > > +    trace_end = cli.trace_end
> > > -- 
> > > 2.24.1
> > > 
> > 
> 

