Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEA8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4142071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593635545;
	bh=Qu1PVZWZQB1pW5uORGG9JkdLLWLwrioSV8gFiogltGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EYDcbP+Z43QXgIcbUFlYeZubb2upeYObVgFByBPaC0f1pFw87zWplDDBVM7VEJlwW
	 2MJ0iTLjJsW39ZAB0L+lNbWrLsnoc69kitk8jzQEcq5oH/xMJbJVlSOgYOYmxa2e6E
	 T095d/r5LWOKnN3kKlwXzc/uJ4E+aN/CPhyNXGNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgGAUcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGAUcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:32:23 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D5FC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 13:32:22 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m26so14481732lfo.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 13:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQTuuRnTRD5guY+N3kjgnPLHXT6P3qZiYHrrKJ47r1w=;
        b=M5E2TfLcC3cfW8OMyrKhXxxtIvY0Y104cXmmv3Q4raTCa6ajB/XOROYaclyuBwWh+A
         QwyVYKRQgeqALuvdcW7sv0dw33dOl/5F5gCyZFcJBfQqk4HuU7lj0CC2aelEfwTDdC0Y
         4kjCbqfpjXn7jho9KN1KvD2s7uo+DH0VG6r6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQTuuRnTRD5guY+N3kjgnPLHXT6P3qZiYHrrKJ47r1w=;
        b=Y+YKMPt/XgPI+KAyaiiU7dQgIP8GVZLBt195B8BeMLqva41m82EwjeuEioFQv6jRDS
         qBRd3kK5NVOD9pS1vQuYwW+q62r55UK0D/OalIUqUAG67kX5wqGn7+zbgB9ZovNI7NPP
         /M8xI6edEU4ia361JbPFnYbIQvYb34hxRlZnVyrfap+MlOF0WwFOQQpSSL1NGSckWqZF
         FrQbbtZg+wENn7x3eGkbLA+qGcQ1VF6Sea7+uTu/ofIVnfcwwJmZGOKjsH26RDcQgoXM
         JnCs1a/Ai/KQUs2kWd01+NWLCfY1fHibWojvBKn/LmKB5MLChbkEtn9CcTBEIHVtUHvF
         Z2Ig==
X-Gm-Message-State: AOAM5301iG7J7xDoxtziJdkbfUX/3ZfFhVqNVvW5sd35DWQEUgkmDPxH
        +YeftlFG3bvqq95ir9iE+WPpXbCmKi8=
X-Google-Smtp-Source: ABdhPJyOYnk6uLMcLOASgxkqyM6qlRYozO2BuVhU56QjaGbC5WV2VEXuNqfhdaAjXMfHaak7mljgDw==
X-Received: by 2002:ac2:548a:: with SMTP id t10mr16396959lfk.142.1593635540816;
        Wed, 01 Jul 2020 13:32:20 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id f4sm2045002lfh.38.2020.07.01.13.32.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 13:32:19 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id u25so14524873lfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 13:32:19 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr16119813lfd.31.1593635539128;
 Wed, 01 Jul 2020 13:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200624161335.1810359-14-hch@lst.de> <20200701091943.GC3874@shao2-debian>
 <20200701121344.GA14149@lst.de>
In-Reply-To: <20200701121344.GA14149@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jul 2020 13:32:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYihRm0brAXPc0dFcsU2M+FA4VoOiwGGdVLC_sHT=M1g@mail.gmail.com>
Message-ID: <CAHk-=whYihRm0brAXPc0dFcsU2M+FA4VoOiwGGdVLC_sHT=M1g@mail.gmail.com>
Subject: Re: [fs] 140402bab8: stress-ng.splice.ops_per_sec -100.0% regression
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 5:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> FYI, this is because stress-nh tests splice using /dev/null.  Which
> happens to actually have the iter ops, but doesn't have explicit
> splice_read operation.

Heh. I guess a splice op for /dev/null should be fairly trivial to implement..

               Linus
