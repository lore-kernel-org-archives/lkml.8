Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427D2C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B412072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOlrK8Fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406773AbgDNHjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:39:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46870 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406729AbgDNHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586849969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5yqJxRspOj9S6no1ZxF07oulR1nz7Ec102GncjE1E9s=;
        b=LOlrK8FzggLV68f6bDjRqkU77J6RL4chSq0VTpl3/JRxzcZmcTOtniqo4KpasrEf4SJlpx
        qXJdshf7ghfPtboWJf3an7jUV6qgykO69q6KP4rAqmghxkvxqTyafLto4XzYeoT3l9KEwt
        r9eZozjE1luI9l127sdfF/rSRwzEzZA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-_DRnBVCANVmo6rhZKJrlSg-1; Tue, 14 Apr 2020 03:39:27 -0400
X-MC-Unique: _DRnBVCANVmo6rhZKJrlSg-1
Received: by mail-wm1-f70.google.com with SMTP id h22so2339435wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5yqJxRspOj9S6no1ZxF07oulR1nz7Ec102GncjE1E9s=;
        b=ApehqE6GjiAATszRyqGUfQUTFFcQx8Je1nOfou3VERkWe7N9MTPZlNEWPwl5Fac8cQ
         041D1zTb2fetkO2WCa/gHrSQmFhJq+CdgfP0ySThx+VgEe9Utbe401sGXFWWCMzh5LDB
         rzPgcSibRjdt5CKWAUTC7/gcX0B2mMStQ9yCx1+VikzoViysKjftAGDIxFaZYUimxjT7
         /mRtmqy/7gHoxZ9bQjDXFDhFWjR+U+nCoImHHQEgVRO8Ok3jSvhRYnsCOWW2PQhgBBsR
         BOjISVCCi1ixda5/fzQ+j9H+tAL2bzqOuQz1iyCk2i1EHep6pZgHmvIGuEGWCQv1syCW
         6Ndg==
X-Gm-Message-State: AGi0PuZGkC6FCt1C7Qh2tADIeeeujr70a9Bcty+cnwmBZ+Fpk44VFeyc
        x6PmvObENF/cIZV8ISdVKlWAflDlKwSAFaHfNzrtCaetJjSw3gfb/+VXdCH9BNXV2dOhLvyJC5f
        81fuIBeMI1zubEP8j2yjLsH3Z
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr21740152wmh.120.1586849965387;
        Tue, 14 Apr 2020 00:39:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypKTpaW99V7jZERhp1jeSfECY0h+upnLUS9UlDxk1Bfw9jdEkyIOGPw6XQauSAlmpctUVJi/sA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr21740135wmh.120.1586849965155;
        Tue, 14 Apr 2020 00:39:25 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id m1sm12710562wro.64.2020.04.14.00.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 00:39:24 -0700 (PDT)
Subject: Re: [RFC][PATCH 03/36] objtool: Enable compilation of objtool for all
 architectures
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>
References: <cover.1586468801.git.mhelsley@vmware.com>
 <a96d42818c7e8f2a8bd2e151b8c220193f4ae986.1586468801.git.mhelsley@vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <e8a52162-dd38-6092-7217-cc5c088abadc@redhat.com>
Date:   Tue, 14 Apr 2020 08:39:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a96d42818c7e8f2a8bd2e151b8c220193f4ae986.1586468801.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 4/10/20 8:35 PM, Matt Helsley wrote:
> objtool currently only compiles for x86 architectures. This is
> fine as it presently does not support tooling for other
> architectures. However, we would like to be able to convert other
> kernel tools to run as objtool sub commands because they too
> process ELF object files. This will allow us to convert tools
> such as recordmcount to use objtool's ELF code.
> 
> Since much of recordmcount's ELF code is copy-paste code to/from
> a variety of other kernel tools (look at modpost for example) this
> means that if we can convert recordmcount we can convert more.
> 
> We define a "missing" architecture which contains weak definitions
> for tools that do not exist on all architectures. In this case the
> "check" and "orc" tools do not exist on all architectures.
> 
> To test building for other architectures ($arch below):
> 
> 	cd tools/objtool/arch
> 	ln -s missing $arch
> 	make O=build-$arch ARCH=$arch tools/objtool
> 
> This uses the weak, no-op definitions of the "check" and "orc"
> commands for the newly-supported architecture. Presently these
> exit with 127 to indicate that the subcommands are missing.
> Subsequent patches can then be made to determine if the weak
> definitions are used and explicitly report a missing command,
> and even to list which subcommands are supported (perhaps if
> no subcommand is specified it can list the supported subcommands).
> 
> objtool is not currently wired in to KConfig to be built for other
> architectures because it's not needed for those architectures and
> there are no commands it supports other than those for x86.
> 
> This commit allows us to demonstrate the pattern of adding
> architecture support and isolates moving the various files from
> adding support for more objtool subcommands.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> ---
>   tools/objtool/Build                     |  4 ---
>   tools/objtool/arch/missing/Build        |  3 ++
>   tools/objtool/arch/missing/check.c      | 14 +++++++++
>   tools/objtool/arch/missing/orc_dump.c   | 11 +++++++
>   tools/objtool/arch/missing/orc_gen.c    | 16 ++++++++++
>   tools/objtool/arch/x86/Build            |  4 +++
>   tools/objtool/{ => arch/x86}/arch.h     | 42 ++++++++++++++++++++++++-
>   tools/objtool/{ => arch/x86}/cfi.h      |  0
>   tools/objtool/{ => arch/x86}/check.c    | 11 ++++---
>   tools/objtool/arch/x86/decode.c         |  2 +-
>   tools/objtool/{ => arch/x86}/orc_dump.c |  5 +--
>   tools/objtool/{ => arch/x86}/orc_gen.c  |  9 ++++--
>   tools/objtool/{ => arch/x86}/special.c  |  4 +--
>   tools/objtool/{ => arch/x86}/special.h  |  2 +-
>   tools/objtool/builtin-orc.c             |  2 +-
>   tools/objtool/check.h                   | 37 ----------------------
>   tools/objtool/objtool.h                 |  2 +-
>   tools/objtool/orc.h                     |  2 --
>   18 files changed, 110 insertions(+), 60 deletions(-)
>   create mode 100644 tools/objtool/arch/missing/Build
>   create mode 100644 tools/objtool/arch/missing/check.c
>   create mode 100644 tools/objtool/arch/missing/orc_dump.c
>   create mode 100644 tools/objtool/arch/missing/orc_gen.c
>   rename tools/objtool/{ => arch/x86}/arch.h (59%)
>   rename tools/objtool/{ => arch/x86}/cfi.h (100%)
>   rename tools/objtool/{ => arch/x86}/check.c (99%)
>   rename tools/objtool/{ => arch/x86}/orc_dump.c (98%)
>   rename tools/objtool/{ => arch/x86}/orc_gen.c (96%)
>   rename tools/objtool/{ => arch/x86}/special.c (98%)
>   rename tools/objtool/{ => arch/x86}/special.h (95%)
> 

My concern with this it that most of the structures and code in arch.h 
and check.c can/should be reused across architectures. So, when 
providing support for a new architecutre, the first thing that will be 
needed is to move those back under tools/objtool whithout disturbing the 
arches that don't yet provide support for "check" subcommand.

So, if it is decided that recordmcount should be an objtool subcommand, 
the code itself should probably stay under tools/objtool and then have 
different compilation configurations for objtool depending on the 
architecture (e.g. HAVE_OBJTOOL_CHECK, HAVE_OBJTOOL_ORC) or something of 
the sort.

Cheers,

-- 
Julien Thierry

