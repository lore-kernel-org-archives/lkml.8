Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC0BC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB38824653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKk50HHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgBZUuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:50:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35792 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgBZUuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:50:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id 7so250981pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 12:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YwKojmAOHjMYhRzqI+8svwd4Ox2CAbO+FF61xJvemgY=;
        b=MKk50HHoXVCMgZYBxRagQTGsgRzHL61BkAaUPq+uoLiXKiTwTPnvFC4nB5P1mAxAMY
         I33Gr/tzBzEgOHD/k4QUxbonRDxPLxk76vG/UnP50LnNk7vT++5t1itCTsB/lyJU0W8E
         U1AFcHgI5RtIAyJmbkWojGM9AHdVd8ra8YpsKgWvOEDefyCtYXxYMspu8uO/E42DUV2L
         feQxMB9E9HNc9ujpNkoIkpTSixgUenW+GK6UAjzrWoylUNU6x42eNnJWvfNHJY74IWcw
         uVFVeBsv1kmgS0Qm2mSkHizIn/DNU9d33P4lpvMkMe3ZqUjLFtZsIBW5nH+kWv6FPymp
         xuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YwKojmAOHjMYhRzqI+8svwd4Ox2CAbO+FF61xJvemgY=;
        b=fz+ZV7BCmqvlp5gTYRuuCbxu0DW5Ao6kuP3ygJ+jmfiRSklTMkE0QCL3bgS/4x8qcI
         tj47Opetcjbodedsac1aHeRLjj52x7KJSxG1kkybMXES+7n/U8sR45gMzjna3VYO1UB4
         +5D5EbS3A9Pv4xusEGNZh/qZ3wq+9DfBxaDHH4TQLd2B0u3jVG+7jE6j7He4vp7/2XAQ
         3AwNWOUV8hEiUC+OVl6r0BnEVpAmCCOcvjShwJkfuzYZ2eFVZVM1ikZa7z9e10fP4Pii
         p7jiAY11tOvcSd4DnZRm4oVsx9J6AeixzFWgOVXDrMf+yvq/A6gZ8vbpfvhSCMalbt8L
         pOdg==
X-Gm-Message-State: APjAAAWiE3sDi/HBi6p+pca7kkS/sOW19M6by3eAapVsAZtTc8oer+2l
        xqNYKeYk4utG2VGZyOaHqRs=
X-Google-Smtp-Source: APXvYqz7YYlzlZAc+DLfk4XGy87eJ1USKZqzAXcVz/F/6vXUAgZFK3JMEGl61qAV85KvVs6zx9TYLg==
X-Received: by 2002:a63:1e06:: with SMTP id e6mr688508pge.134.1582750199360;
        Wed, 26 Feb 2020 12:49:59 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:500::6:1683])
        by smtp.gmail.com with ESMTPSA id p24sm4087848pff.69.2020.02.26.12.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 12:49:58 -0800 (PST)
Date:   Wed, 26 Feb 2020 12:49:55 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        naveen.n.rao@linux.ibm.com, ardb@kernel.org,
        Luigi Rizzo <rizzo@iet.unipi.it>,
        Paolo Abeni <pabeni@redhat.com>, giuseppe.lettieri@unipi.it,
        Jesper Dangaard Brouer <hawk@kernel.org>, mingo@redhat.com,
        acme@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        peterz@infradead.org
Subject: Re: [PATCH v3 0/2] kstats: kernel metric collector
Message-ID: <20200226204954.vmhxd6d5utg63uet@ast-mbp>
References: <20200226135027.34538-1-lrizzo@google.com>
 <87ftexz93y.fsf@toke.dk>
 <CAMOZA0Lzf2r7rFvgBEWpf-B=wXvyED2CxfzuO7qUA_qVsNtL7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMOZA0Lzf2r7rFvgBEWpf-B=wXvyED2CxfzuO7qUA_qVsNtL7g@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:26:22AM -0800, Luigi Rizzo wrote:
>   Any pointers to this are welcome; Alexei mentioned fentry/fexit and
>   bpf trampolines, but I haven't found an example that lets me do something
>   equivalent to kretprobe (take a timestamp before and one after a function
>   without explicit instrumentation)

please see the link in my previous email.

> - I still see some huge differences in usability, and this is in my opinion
>   one very big difference between the two approaches. The systems where data
>   collection may be of interest are not necessarily accessible to developers
>   with the skills to write custom bpf code,

bpf code and tooling is already written. There are bcc and bpftrace scripts
that already do what you're proposing without adding any new code to the kernel.
These tools are trivial to use. Requires zero knowledge in bpf.
So please stop the fud.
