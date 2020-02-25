Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC14C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B39C21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODgl8aRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbgBYUg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:36:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47444 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731362AbgBYUgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582662983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=quzQOEA/eAGKSh5/jwUh6JGVB9Hvxfy9enYmNuoMU20=;
        b=ODgl8aRQ8XzO8cMFGkwdExaYXNw8245wdosA54l/ukPmQEg94vTaPhBov/QOdrkr8N44sI
        G++WVzbxCjYj83xzbvk4CMVL6yZSigWQgGiicX/ey/LhARQXiZGx+E5ZswlEyW7wI8oZrW
        DEpQUNx4BdeyB5E3v1Z8Nf/Dq2XKCpg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-TxDd-bwbM92ln7jnzxRO2A-1; Tue, 25 Feb 2020 15:36:18 -0500
X-MC-Unique: TxDd-bwbM92ln7jnzxRO2A-1
Received: by mail-wm1-f72.google.com with SMTP id f207so249429wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 12:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=quzQOEA/eAGKSh5/jwUh6JGVB9Hvxfy9enYmNuoMU20=;
        b=JYsxJAY5R0cnPmFCBhqZ4ZM6cWxHx88taea1NFcN/sVpu8CYUwhbe9DXBMyez6JMnM
         ohqDWbq2UMFqDF67TUMp7F/wOxYQLUjLyaewRMDCmYPElj1cIWME22GmFbx7OfBRQnqE
         4bnfXK9QyqRYjKorKpBeY2UyQ0vGUZnVSEDfBIeZsoOIMyWChhnbY1AS0X9Qu/b4jzjs
         7FGiLON0a58pafBnkc3iWfA0u5cWJqanvyVjYcRQpfCbuVF3h2qyfQ91SX9P6qEkhtlw
         Ka3iwJW0bUDd7uvVrz1hHmqJzFJKf/A2P7iwcqXetx+XL7zdBl40mwayIWl99BIjUD75
         sptw==
X-Gm-Message-State: APjAAAVHIcssRINg6W9ASwhtuux0rKwnvu5GUj0LJ/Zruxul03gvK7Ud
        BgysOhXEW2EIAw8nx8bLM6K1Voq2Zlf1NPDPmQW94bN6zoSw77BcjguAmgwvvd7zQfpeALoUPY9
        XiWl0+wJCzcU04zjJjZcY3qmp
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr1029110wmg.91.1582662976784;
        Tue, 25 Feb 2020 12:36:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqxu/rylI3K/PNqXcf42UxSsrOGt+qlaNjbW0WymdxSqP4d7i58TqzZS4KgivZdeXrA66wEgzw==
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr1029080wmg.91.1582662976504;
        Tue, 25 Feb 2020 12:36:16 -0800 (PST)
Received: from ?IPv6:2a02:8388:7c1:1280:a281:9dab:554b:2fdc? (2a02-8388-07c1-1280-a281-9dab-554b-2fdc.cable.dynamic.v6.surfer.at. [2a02:8388:7c1:1280:a281:9dab:554b:2fdc])
        by smtp.gmail.com with ESMTPSA id w8sm5613357wmm.0.2020.02.25.12.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 12:36:15 -0800 (PST)
Subject: Re: [RFC] perf script: add flamegraph.py script
To:     Jiri Olsa <jolsa@redhat.com>
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
References: <20200221175500.83774-1-agerstmayr@redhat.com>
 <20200225195418.GA160300@krava>
 <0582d729-0e07-b95d-7cad-8912514b8871@redhat.com>
 <20200225202056.GA160294@krava>
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
Message-ID: <cd44bf7a-6766-d42b-50d1-482d389fe488@redhat.com>
Date:   Tue, 25 Feb 2020 21:36:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225202056.GA160294@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.02.20 21:20, Jiri Olsa wrote:
> On Tue, Feb 25, 2020 at 09:03:19PM +0100, Andreas Gerstmayr wrote:
>> On 25.02.20 20:54, Jiri Olsa wrote:
>>> On Fri, Feb 21, 2020 at 06:55:01PM +0100, Andreas Gerstmayr wrote:
>>>> This script works in tandem with d3-flame-graph to generate flame graphs
>>>> from perf. It supports two output formats: JSON and HTML (the default).
>>>> The HTML format will look for a standalone d3-flame-graph template file in
>>>> /usr/share/d3-flame-graph/template.html and fill in the collected stacks.
>>>>
>>>> Usage:
>>>>
>>>>       perf script flamegraph -a -F 99 sleep 60
>>>>
>>>> Alternative usage:
>>>>
>>>>       perf record -a -g -F 99 sleep 60
>>>>       perf script report flamegraph
>>>
>>> nice, could this output the output file, like:
>>>
>>>        # perf script report flamegraph --output krava.html
>>>        dumping data to krava.html
> 
> I meant the actual line ^^^^, saying that it's writing to the file

Ah! Sorry, I misunderstood.
Yep, sure, I can add that.

I also have one other change lined up to reduce the JSON output, and I'm 
testing it with huge flamegraphs right now. Will send an update this week.


Cheers,
Andreas


> 
> thanks,
> jirka
> 
>>>
>>> or something in that sense
>>>
>>> other than that it looks good to me
>>
>> Yes, it's already implemented.
>>
>> $ perf script report flamegraph --output krava.html
>>
>> writes the output to krava.html
>>
>> $ perf script report flamegraph --help
>>
>> shows the supported arguments.
>>
>> The only gotcha is that you need to have a perf.data in the same directory
>> when calling this command, otherwise perf complains about a missing
>> perf.data and doesn't call the flamegraph.py script.
>>
>>
>> Cheers,
>> Andreas
>>
>>
>>>
>>> thanks,
>>> jirka
>>>
>>>
>>>>
>>>> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>> Cc: Jiri Olsa <jolsa@redhat.com>
>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>> ---
>>>>
>>>> I'm currently preparing packages for d3-flame-graph. For Fedora, the copr
>>>> at
>>>> https://copr.fedorainfracloud.org/coprs/agerstmayr/reviews/package/js-d3-flame-graph/
>>>> can be installed, or alternatively the prebuilt standalone d3-flame-graph
>>>> template can be downloaded from
>>>> https://raw.githubusercontent.com/andreasgerstmayr/specs/master/reviews/js-d3-flame-graph/template.html
>>>> and moved into /usr/share/d3-flame-graph/template.html
>>>>
>>>>    .../perf/scripts/python/bin/flamegraph-record |   2 +
>>>>    .../perf/scripts/python/bin/flamegraph-report |   3 +
>>>>    tools/perf/scripts/python/flamegraph.py       | 117 ++++++++++++++++++
>>>>    3 files changed, 122 insertions(+)
>>>>    create mode 100755 tools/perf/scripts/python/bin/flamegraph-record
>>>>    create mode 100755 tools/perf/scripts/python/bin/flamegraph-report
>>>>    create mode 100755 tools/perf/scripts/python/flamegraph.py
>>>>
>>>> diff --git a/tools/perf/scripts/python/bin/flamegraph-record b/tools/perf/scripts/python/bin/flamegraph-record
>>>> new file mode 100755
>>>> index 000000000000..725d66e71570
>>>> --- /dev/null
>>>> +++ b/tools/perf/scripts/python/bin/flamegraph-record
>>>> @@ -0,0 +1,2 @@
>>>> +#!/usr/bin/sh
>>>> +perf record -g "$@"
>>>> diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
>>>> new file mode 100755
>>>> index 000000000000..b1a79afd903b
>>>> --- /dev/null
>>>> +++ b/tools/perf/scripts/python/bin/flamegraph-report
>>>> @@ -0,0 +1,3 @@
>>>> +#!/usr/bin/sh
>>>> +# description: create flame graphs
>>>> +perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
>>>> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
>>>> new file mode 100755
>>>> index 000000000000..2e9139ef2c4a
>>>> --- /dev/null
>>>> +++ b/tools/perf/scripts/python/flamegraph.py
>>>> @@ -0,0 +1,117 @@
>>>> +# flamegraph.py - create flame graphs from perf samples
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +#
>>>> +# Usage:
>>>> +#
>>>> +#  perf record -a -g -F 99 sleep 60
>>>> +#  perf script report flamegraph
>>>> +#
>>>> +# Combined data collection and flamegraph generation:
>>>> +#
>>>> +#  perf script flamegraph -a -F 99 sleep 60
>>>> +#
>>>> +# Written by Andreas Gerstmayr <agerstmayr@redhat.com>
>>>> +# Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
>>>> +# Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.com>
>>>> +
>>>> +import sys
>>>> +import os
>>>> +import argparse
>>>> +import json
>>>> +
>>>> +
>>>> +class Node:
>>>> +    def __init__(self, name, libtype=""):
>>>> +        self.name = name
>>>> +        self.libtype = libtype
>>>> +        self.value = 0
>>>> +        self.children = []
>>>> +
>>>> +
>>>> +class FlameGraphCLI:
>>>> +    def __init__(self, args):
>>>> +        self.args = args
>>>> +        self.stack = Node("root")
>>>> +
>>>> +        if self.args.format == "html" and \
>>>> +                not os.path.isfile(self.args.template):
>>>> +            print(f"Flame Graph template '{self.args.template}' does not " +
>>>> +                  f"exist. Please install the d3-flame-graph package, " +
>>>> +                  f"specify an existing flame graph template " +
>>>> +                  f"(--template PATH) or another output format " +
>>>> +                  f"(--format FORMAT).", file=sys.stderr)
>>>> +            sys.exit(1)
>>>> +
>>>> +    def find_or_create_node(self, node, name, dso):
>>>> +        libtype = "kernel" if dso == "[kernel.kallsyms]" else ""
>>>> +        if name is None:
>>>> +            name = "[unknown]"
>>>> +
>>>> +        for child in node.children:
>>>> +            if child.name == name and child.libtype == libtype:
>>>> +                return child
>>>> +
>>>> +        child = Node(name, libtype)
>>>> +        node.children.append(child)
>>>> +        return child
>>>> +
>>>> +    def process_event(self, event):
>>>> +        node = self.find_or_create_node(self.stack, event["comm"], None)
>>>> +        if "callchain" in event:
>>>> +            for entry in reversed(event['callchain']):
>>>> +                node = self.find_or_create_node(
>>>> +                    node, entry.get("sym", {}).get("name"), event.get("dso"))
>>>> +        else:
>>>> +            node = self.find_or_create_node(
>>>> +                node, entry.get("symbol"), event.get("dso"))
>>>> +        node.value += 1
>>>> +
>>>> +    def trace_end(self):
>>>> +        def encoder(x): return x.__dict__
>>>> +        json_str = json.dumps(self.stack, default=encoder,
>>>> +                              indent=self.args.indent)
>>>> +
>>>> +        if self.args.format == "html":
>>>> +            try:
>>>> +                with open(self.args.template) as f:
>>>> +                    output_str = f.read().replace("/** @flamegraph_params **/",
>>>> +                                                  json_str)
>>>> +            except IOError as e:
>>>> +                print(f"Error reading template file: {e}", file=sys.stderr)
>>>> +                sys.exit(1)
>>>> +            output_fn = self.args.output or "flamegraph.html"
>>>> +        else:
>>>> +            output_str = json_str
>>>> +            output_fn = self.args.output or "stacks.json"
>>>> +
>>>> +        if output_fn == "-":
>>>> +            sys.stdout.write(output_str)
>>>> +        else:
>>>> +            try:
>>>> +                with open(output_fn, "w") as out:
>>>> +                    out.write(output_str)
>>>> +            except IOError as e:
>>>> +                print(f"Error writing output file: {e}", file=sys.stderr)
>>>> +                sys.exit(1)
>>>> +
>>>> +
>>>> +if __name__ == "__main__":
>>>> +    parser = argparse.ArgumentParser(description="Create flame graphs.")
>>>> +    parser.add_argument("-F", "--format",
>>>> +                        default="html", choices=["json", "html"],
>>>> +                        help="output file format")
>>>> +    parser.add_argument("-o", "--output",
>>>> +                        help="output file name")
>>>> +    parser.add_argument("--indent",
>>>> +                        type=int, help="JSON indentation")
>>>> +    parser.add_argument("--template",
>>>> +                        default="/usr/share/d3-flame-graph/template.html",
>>>> +                        help="path to flamegraph HTML template")
>>>> +    parser.add_argument("-i", "--input",
>>>> +                        help=argparse.SUPPRESS)
>>>> +
>>>> +    args = parser.parse_args()
>>>> +    cli = FlameGraphCLI(args)
>>>> +
>>>> +    process_event = cli.process_event
>>>> +    trace_end = cli.trace_end
>>>> -- 
>>>> 2.24.1
>>>>
>>>
>>
> 

