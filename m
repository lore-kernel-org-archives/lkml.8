Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A862C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 284C420578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJ/qXXVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388769AbgDNOBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:01:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41714 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388719AbgDNOBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586872884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTcSJ4CEM5FZZK0mZvNwbCxZtyIONlR6rWwt1itPdho=;
        b=QJ/qXXVL4Dyv3UPEaUNEfhYVO7bNHuwK8DBeNJtATmZFYpdC701ZIfnr2t/lKG5FmFzkf3
        mdBlRQq2AZi8DDeJQIlcTfp3es3/l/1iQCfj1HD5v7sXJtPiBH/M5pX5sNO5Dz9KE/d/tx
        1wWRfsgx2kna2AGEPaN5fBs5nBgx2zk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-TDXbBOUvPMmAHTqgAOUFjQ-1; Tue, 14 Apr 2020 10:01:22 -0400
X-MC-Unique: TDXbBOUvPMmAHTqgAOUFjQ-1
Received: by mail-wr1-f69.google.com with SMTP id m5so5611370wru.15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bTcSJ4CEM5FZZK0mZvNwbCxZtyIONlR6rWwt1itPdho=;
        b=KjxjAK/cFWgtHiAB+o3F4Jl5bwNuq92Mnguqtyh2dkpVN3Lhm36uJPNtfxWIkKvZbZ
         ij6AIepQVEvbnVhiKV07W7QFpJLa7jVJPn0xxxaknjFSjLY2B/IfCIeXapof4Yauuk1R
         RT0OBAacAC3ZUmrT1jWgy8pZkkmMRQmfcYTgLDkJRxPyCn1L8UqYeXU2pbDWTUom7SRB
         1sc/kxf8ajJzxCiqGIDNMoGfR0AiGmqxvNLT6tPTaJg2bqY1kek+KjlCf/G4yLEOh4ff
         92l2/IRbptvJkUy+T5mXLkEBOiHJ9CRW/8X6dukJjPHTG2PD6tY0k4e431ITngB1b9Mp
         TgCQ==
X-Gm-Message-State: AGi0PuaRN8wwaVP3/YBrfD8GRvv2E+uyeRibSAo8x9UeK2rASV9CSIsv
        zni047B73x5pgkbiyK8/7Y+4yQgbR6P/6VEaBFVc78L1sj1/FqL2ctwYorDIzhG2cflfKYbkzBF
        Rv0cCoFjn2ElaKcFx5oSlOIBc
X-Received: by 2002:adf:8149:: with SMTP id 67mr24763150wrm.60.1586872881243;
        Tue, 14 Apr 2020 07:01:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypKnd+C4ZBXSnJavuTzZ4e+LrjBf7wiVQx7FcIAJZE5cNrvKm1lD7gJ7LVl6nG0eIXFpeE6BUQ==
X-Received: by 2002:adf:8149:: with SMTP id 67mr24763118wrm.60.1586872881003;
        Tue, 14 Apr 2020 07:01:21 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id b11sm19265200wrq.26.2020.04.14.07.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 07:01:20 -0700 (PDT)
Subject: Re: [RFC][PATCH 03/36] objtool: Enable compilation of objtool for all
 architectures
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Miroslav Benes <mbenes@suse.cz>
References: <cover.1586468801.git.mhelsley@vmware.com>
 <a96d42818c7e8f2a8bd2e151b8c220193f4ae986.1586468801.git.mhelsley@vmware.com>
 <e8a52162-dd38-6092-7217-cc5c088abadc@redhat.com>
 <20200414094121.73f5c82a@gandalf.local.home>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <59db4518-2450-e6a3-5a69-e65b86c39489@redhat.com>
Date:   Tue, 14 Apr 2020 15:01:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414094121.73f5c82a@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/20 2:41 PM, Steven Rostedt wrote:
> On Tue, 14 Apr 2020 08:39:23 +0100
> Julien Thierry <jthierry@redhat.com> wrote:
> 
>> My concern with this it that most of the structures and code in arch.h
>> and check.c can/should be reused across architectures. So, when
>> providing support for a new architecutre, the first thing that will be
>> needed is to move those back under tools/objtool whithout disturbing the
>> arches that don't yet provide support for "check" subcommand.
> 
> Are all the enums and structs in arch.h non-arch specific?

While some definitions are very x86 specific (in particular PUSH/POP 
related definition), most other other things have similar concept in 
other architectures.

And the "non-generic" definition here do not necessarily interfere with 
other architectures. E.g. if the instruction decoder never produces 
INSN_PUSH or INSN_POP, the corresponding branches in the validation code 
will simply not be taken.

> 
> Or would they need to be split?
> 

So far, for the arm64 work, I've left all those definitions where they 
are. In the future, some cleanup could encourage to split for some "arch 
specific" and "non-arch specific" instruction/stack-ops types, but this 
is not a hard requirement for introducing new architechtures. And I'd 
rather encourage to have complex arch specific instructions be divided 
into several simpler instructions (e.g. PUSH is just sub stack pointer + 
memory access) that could be reused for other architectures, as long as 
that is possible of course.


>>
>> So, if it is decided that recordmcount should be an objtool subcommand,
>> the code itself should probably stay under tools/objtool and then have
>> different compilation configurations for objtool depending on the
>> architecture (e.g. HAVE_OBJTOOL_CHECK, HAVE_OBJTOOL_ORC) or something of
>> the sort.
> 
> That could work.
> 
> -- Steve
> 

-- 
Julien Thierry

