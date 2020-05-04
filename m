Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF14C47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53ACE206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NmBQj+/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgEDUA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgEDUA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:00:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECC6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:00:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a2so15064154ejx.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCWAep3g/S7kYu55ffGrHwoUe1KKlRiY8jCjhGfRTrA=;
        b=NmBQj+/dOtZLHa1FZ/2Vzi4YdEQY+QcB0DmpdxrMU459Sw0tCwj7iWQg2lC/mfKMQo
         dSSpVaAfTFuTN4w4Eai+oqe+5uDxQIoUNns7XrcRNTs/B50mpJU6WzoinSyQ1VYqKOrQ
         kSPXMsX92FgyWRUrGuDmNqGzMsdXKBNgP+jFKbFboCcRBMdApPmOxSECYQPkrnXTcvBc
         hiyMwyNKBTfD9rPPLjFTiN0YFn5g4lt2SscNid+KjRttkh4Lc/4EImyuh1ttpjC2lAce
         w+CNLVINNgTu9ZIGKY6fFT+Dws752yxb7SSVP2ZusvW25VnFJdoeahk56vdknUYDKrwT
         IsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCWAep3g/S7kYu55ffGrHwoUe1KKlRiY8jCjhGfRTrA=;
        b=GRXpOofPu2nBcIgIdaDxb15ZwR8JS2XwyCFirnakJwGlruT4I1HfBS5JLYUcmX9kIQ
         ke1+PbZJH7otMKK+yLZ8RDdrFTiMZmD0KBc2w9AE+Y3daMgCETEA/mBn9H+2Q6TIN49E
         QsNHPsxOh8RdBbOyjdZr4FNdT9BTWXT6GYiigvyDqLMP0/7eZHnei6g1oYtb9w3J5Q+n
         E4oMX3Xczl8p6SXcfh5b59H4zivP9dTT2KHC7n4jMXPXp9m+jhK737QKvkNIx2VFz7qh
         dnaQzg2vACdcRLY84jGseK065kYBoP0HcSL6rcNw0huey/youR/0dhfzOEAVuZ3MXzU7
         /LeQ==
X-Gm-Message-State: AGi0PuaEhafATcBzPooT/9b0L1h2kPfWtngMH5gNkIrHZ+0Oh2iX5G93
        WxmgovI/cSZkVsj50VVR54nOWW1byBOQWBVciXbebw==
X-Google-Smtp-Source: APiQypIKdYLJL6Vtdfg8m2Hm7jVII0Q6HbqUBjDODDYpBrQYl4VmtkkDWkeWyy+1cDzz0nt2P+dHZ/Xwf1pT9FocxQc=
X-Received: by 2002:a17:906:ce4b:: with SMTP id se11mr17199903ejb.178.1588622454437;
 Mon, 04 May 2020 13:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <20200502143555.543636-4-pasha.tatashin@soleen.com> <202005041229.D410FE0B1@keescook>
In-Reply-To: <202005041229.D410FE0B1@keescook>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 4 May 2020 16:00:18 -0400
Message-ID: <CA+CK2bB1=gwaDCcYLLi56oQFS6hdc8wzG-s14rz4q7PDCnLycg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] ramoops: add dump_all optional field to ramoops DT node
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 3:29 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, May 02, 2020 at 10:35:55AM -0400, Pavel Tatashin wrote:
> > Currently, it is possible to dump kmesges for panic, or oops.
> > With dump_all it is possible to dump messages for kmesg_dump events,
> > for example reboot, halt, shutdown, kexec.
>
> Please just collapse this into patch #2.

Will do it.

Thank you,
Pasha
