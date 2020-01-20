Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E6EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BEC2073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7TS/pxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATLG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:06:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49906 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726148AbgATLG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579518417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBr/Vebb3VXffLj0Is78F4eUTgwO3xgPG3+P62qQsx8=;
        b=B7TS/pxSE85KOZPnucMq7MiF8znZC5m023mFLV4+fbvRoGQ/U5uSj2KUvgb9MSDn5lj6P+
        GCXfb3RgmczfjNwcoQ4u75Bbcyx2G7G9QkO12CtrbxOx+rQCg181eCP6u+ETY20ddboSuj
        2CAHVn3ZGUBsaFCNIFVi97BzmCR/348=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-IUHroKxKOjCx9Vkd99DuxA-1; Mon, 20 Jan 2020 06:06:48 -0500
X-MC-Unique: IUHroKxKOjCx9Vkd99DuxA-1
Received: by mail-lj1-f199.google.com with SMTP id f19so7453292ljm.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 03:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GBr/Vebb3VXffLj0Is78F4eUTgwO3xgPG3+P62qQsx8=;
        b=quO/8wAERDLJAgKupd9G8qR+cy4Fk7xEcwXrvKnHkD8OOy6pHq4JRY66fpMeQoXjIz
         JnzkTCvOYVJRZRGIhNOP9CQx9rB8I1H2e83F8fQlfySIYPbFoWvYl/h6909WvAYNtQHO
         73yz4d5n47yMrkakXZjByoAhB6QlUhzi0knaserjBJssb3lTpHfQ4SSNPJCR9RNLSvB1
         +o5pR2lsMCyBngXv+LtCqNUGv0tBziQG1p3QX59VAAqX4Q9QQxf77lgCe+6B/Js/Rcz8
         eP0+zdC5voA77d0aXSTLFOv1hvd1Qadexed/A96JKfesIxTWPK6dNQxb1YxDjc78kVxK
         28PQ==
X-Gm-Message-State: APjAAAVQxsTuKpcHaGccYk9OZ8L6ki+BR995iUQvvJB4H/0nejc31b9N
        1WO4tNCgC+njIB2yZB7sPDDCpadzyvcc90JGD3D9kWmdEU5NVV5nYxHUt4Qk+z7XXElGV8YaUN/
        Xyl+BsG10T+BRqmh2r/kr0Of8
X-Received: by 2002:a2e:8e22:: with SMTP id r2mr12213810ljk.51.1579518406711;
        Mon, 20 Jan 2020 03:06:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRHGGNFbd5H0/cF1REV/7+jcnpPn0KrgS8p2w5aL+jlmOCDTBslDcW/9arMdp3KMXCx8EM9A==
X-Received: by 2002:a2e:8e22:: with SMTP id r2mr12213786ljk.51.1579518406456;
        Mon, 20 Jan 2020 03:06:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id p136sm16758946lfa.8.2020.01.20.03.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:06:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C1D8A1804D6; Mon, 20 Jan 2020 12:06:44 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next v4 09/10] selftests: Remove tools/lib/bpf from include path
In-Reply-To: <CAEf4Bzb9zUmhxTyYahJqySJzgfyB-zMEd+o4ybv=a8-t+iZS4w@mail.gmail.com>
References: <157926819690.1555735.10756593211671752826.stgit@toke.dk> <157926820677.1555735.5437255599683298212.stgit@toke.dk> <CAEf4Bzb9zUmhxTyYahJqySJzgfyB-zMEd+o4ybv=a8-t+iZS4w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 20 Jan 2020 12:06:44 +0100
Message-ID: <878sm2pet7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> I really-really didn't like this alternating dependency on directory
> or a set of file, depending on current state of those temporary
> directories. Then also this ugly check to avoid circular dependency.
> All that seemed wrong. So I played a bit with how to achieve the same
> differently, and here's what I came up with, which I like a bit
> better. What do you think?
>
> $(BPFOBJ): $(wildcard $(BPFDIR)/*.c $(BPFDIR)/*.h $(BPFDIR)/Makefile)          \
>            ../../../include/uapi/linux/bpf.h                                   \
>            | $(INCLUDE_DIR) $(BUILD_DIR)/libbpf
>         $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
>                     DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
>
> So, essentially, just make sure that we install local copies of
> headers whenever libbpf.a needs to be re-built.
> ../../../include/uapi/linux/bpf.h ensures we don't miss uapi header
> changes as well. Now anything that uses libbpf headers will need to
> depend on $(BPFOBJ) and will automatically get up-to-date local copies
> of headers.
>
> This seems much simpler. Please give it a try, thanks!

Yes, this is a good idea! It did actually occur to me that the $(BPFOBJ)
rule could just include the install_headers make arg, but only after I
sent out this latest version. Thank you for taking the time to work out
the details, I'll fold this in :)

-Toke

