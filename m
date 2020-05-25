Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 02:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397702076C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 02:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="a7DtJGwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbgEYCZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 22:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388110AbgEYCZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 22:25:54 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9642EC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 19:25:53 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q8so15912252iow.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 19:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sExaUQG+IPyncAhsVw5lguZ0tU5GKQsX5eYb5m1nJfc=;
        b=a7DtJGwDeRXIAvsQzFAlpmcS0vnsn60H7HaxhJCV61CkGZ7U8QrghWMLxRQ91v2xIT
         KemEV/6bFVb6MAO/j00VYeSPOwL4XwCrfhCQaqU/LEz/zTLQO1JoqOEdj8UhjIsZlhoq
         Sq74/QlFJ1PLHFIQmW+xwzO5PcWIdP9VJnbfttTt2dS3Tz3e6E1AH20sChQpsDWHoW1z
         mCXTwhXPkTq0ViMyrwHK8diWJoAP68ZaLbCDN44lC1aSicREKkA9nLTCX751CVB/qAo3
         nJhWWuNDtD4saJFzUgTXYZPP3yrw5zXA/4Ocj4CrgXwhYNFAiJ9Iyb12gQ4/eE048lQf
         xV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sExaUQG+IPyncAhsVw5lguZ0tU5GKQsX5eYb5m1nJfc=;
        b=Y2PL0Z2BFJT0gVF9/qyjOWbhDnhewoy3QNweMyqsJ6K0eyfMrWROKffqBvYiikPMZ0
         woKqPW9ZlweyC13tJWUJeWD7FCtq4p1Cph3Kz1XqDNeJVfyIqObDxkuCiO+IIoynWT0M
         ZH9N8PLUY62SciO1oyEHJsG2622mlgVxf604lvi55NdO6OYN6sNh73zvwEpumxfK+er6
         6QVzw46cnKGBuM/qwi6vKiqf+c2pAR+kZyTcofn4cDP3bZmYQgnDZDfJ+DDVZMV0fkFz
         Vvqbd+3zNTn3uLruOPBTKhEacWdag9OC/fq7t5xWok9qdYCSOim0oLfNwpv7KHPkDJ1+
         CMBA==
X-Gm-Message-State: AOAM530y8SXzqY2TBBCI0TMglr1uC0DfCqZ5B/hIB4lAZtdzNiuO5zet
        B53jdq2gyEiWiZNJVcj/EoHrzaHVgRHq8DGlynE/xQ==
X-Google-Smtp-Source: ABdhPJyzFxKYBRcaKZBDLtOOfeO+pbYT4UVYMR7Y2gxiNj+OgIjC2XGmEH3ZF6Xds/oCJO06ZO4D/W4Sa/uR6dK7peY=
X-Received: by 2002:a5e:df49:: with SMTP id g9mr8286037ioq.153.1590373552754;
 Sun, 24 May 2020 19:25:52 -0700 (PDT)
MIME-Version: 1.0
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Sun, 24 May 2020 22:25:17 -0400
Message-ID: <CABV8kRxoxt3dWyAOoVjkzBTxXnJ4AQ7M0Efx=FJ8DSOj70dd9g@mail.gmail.com>
Subject: mm: Behavior of process_vm_* with short local buffers
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <khuey@pernos.co>,
        "Robert O'Callahan" <roc@pernos.co>,
        Valentin Churavy <vchuravy@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm in the process of trying to port a debugging tool (http://rr-project.org/)
from x86 to various other architectures. This tool relies on noting every
change that was made to the memory of the process being debugged.
As such, it has a battery of tests for corner cases of copyin/out and it
is one of these that I saw behaving strangely when ported to non-x86
architectures. This particular test was testing the behavior of
process_vm_readv (and writev, but for simplicity, let's assume readv here)
with short local buffers.

On x86 if the buffer is short and the following page is unmapped,
the syscall will fill the remainder of the page, and
then return however many bytes it actually wrote. However, on other
architectures (I mostly looked at arm64, though the same applies
elsewhere), the behavior can be quite different.
In general, the behavior depends strongly on factors like how close to
the start of the copy region the page break occurs, how many bytes
were supposed to be left after the page break and the total size of
the region to be copied. In various situations, I'm seeing:

- Writes that end many bytes before the page break
- Bytes being modified beyond what the syscall result would indicate
happened.
- Combinations thereof

I can work around this in my port, but I thought it might be valuable
to ask where the line is between "architecture-defined behavior" and
a bug that should be reported to the appropriate architecture
maintainers and eventually fixed. For example, I think it would be
nice if the syscall result actually did match the actual number of
bytes written in all cases.

I've written a small program [1] that sets up this situation for various
parameter values and prints the results. I have access to arm64,
powerpc and x86, so I included results for those architectures,
but I suspect other architectures have similar issues. The
program should be easy to run to get your own results for
a different architecture.

[1] https://gist.github.com/Keno/b247bca85219c4e3bdde9f7d7ff36c77

Thanks, Keno
