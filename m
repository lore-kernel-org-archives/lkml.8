Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD1DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 00:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D792071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 00:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8L3Jyz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgEZASF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 20:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgEZASE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 20:18:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA68C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 17:18:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so466776pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 17:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sgmk8Rx6GsFz+nunlwuNBUy97Y+yWoceMW4ZfumqYDE=;
        b=N8L3Jyz2AfKBc/zg6WI2PBaEFBdMF/DTnCmydgqGvjgxCTQP8Hzd+oKBoLhL5Qwr+P
         Bo/3zyWn2hV4gdEbrKqPHjVsMdE4EQJNiWLm3FxUpdswyFcWMRrvajd6P6KN4x525d7h
         qpt69BpO8S9UB7fqnva6VgqPXHw0jvQmTo5sj35wkNwl7OkCM9OQ2Jov8fexd7nzEeAl
         cEV1hh/IXTedWpvSl+f4KbxJvagbNScbLmN6AjYL0x+ja+myDza4pTfVG6ZUz/B5T2Zq
         koMhkjS95MjHXOyNR7w91gTjAAzQYNglj7zI1nLyoXHoRz9QInI/4ma+9rwhxLTIJ2ku
         XwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sgmk8Rx6GsFz+nunlwuNBUy97Y+yWoceMW4ZfumqYDE=;
        b=CnkTf29YhkDNcpgryAzOXaNduA9mTw/uA7NW/N4pOP0H+AQFVRmV2+Poi16yDBcGn7
         WN1m+s1N17Dp6DMFAh0Ah5TmFC9ILQrGcJv1ZESTtIx9CcF/GF9MM7UcFEvFOKH+tL8B
         gwW2yj1T7NwqJSjL6w0W4rMzbZ8CIJGKQEpTcNFr13etY7CoK0qOaUvMR7cdwc4rdFOL
         ab+bGyS4jpLca/daA++vaAFDS3IfCV2lG8t1239XRXE6tx/z6zT+wT6I8GDJnXC+V2uL
         rEH/+V5QLR/7h5594KYdtzdFix4FWoiIqqyP9haAPNXOVxTBTsB02cT2EXkD4GX+HenE
         H8pA==
X-Gm-Message-State: AOAM531R218iKGckUzDOYqRTJGJ9guWd+eVvh1oj6UZ9Lzpuesa8Ywg0
        Blo4s9Vg2umcz/lpPZnsIAnS3bVK2cg=
X-Google-Smtp-Source: ABdhPJz5Fe1j3KtwugTmqy8XMIQPl0IOUAyO8xKSIydGEW/ZC3dZZMgc2OgYqVwLj0GUVnPimAvrOw==
X-Received: by 2002:a17:90b:23d4:: with SMTP id md20mr24582982pjb.164.1590452281672;
        Mon, 25 May 2020 17:18:01 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q44sm14096772pja.29.2020.05.25.17.18.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 17:18:00 -0700 (PDT)
Date:   Tue, 26 May 2020 00:17:58 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] perf: ftrace enhancement
Message-ID: <20200526001757.7bj3x4f65j43ityk@mail.google.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200520203128.GN32678@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520203128.GN32678@kernel.org>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 05:31:28PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, May 10, 2020 at 11:06:09PM +0800, Changbin Du escreveu:
> > The perf has basic kernel ftrace support but lack support of most tracing
> > options. This serias is target to enhance the perf ftrace functionality so
> > that we can make full use of kernel ftrace with only perf.
> 
> Quite a lot! Going thru it now.
> 
> - Arnaldo
>  
Hi Arnaldo, thanks for your detailed review. Sorry for slow response since I am
just getting busy with my own affairs. I'll do the changes acoording
to your comments one by one as soon as possilbe.

[snip..]
-- 
Cheers,
Changbin Du
