Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B67EC2D0E6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5355220719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZI2byf2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCYU3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:29:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44659 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYU3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:29:16 -0400
Received: by mail-io1-f65.google.com with SMTP id v3so3669608iot.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PU8MusG8hezkzW5+KO/6eKPDv5BwIZAo7r3U1MyX75U=;
        b=ZI2byf2rDJAZbfLYIXaAtMe63t/0GZoKwJ4cK63V8WQp6VV2H/N8jjA3QPBc5D27gM
         kcc5YHnX7hmE9y5h4ERM1pqI8/u7ax3SGdAaz2nzqYK8MIeWO/F5R6sImG+aYjVIjGIe
         +mJupj1LoVmeoww+WGM9cKjT9YyWnxsVR2gjuo1doh6veivh3sR6gjhHvYV6DyZZY7J/
         6znmOWw1IZ9IKbczFzX4/NakSIY0YPwWONtukKHn45S/NknmbZ6ORd0r2/OoSfxdwlIo
         +YjNScxCFwoqud/dYZSZiUw66GNobXRASbg8+3OMXxCUD0MHhXmZC1/XDf+frjMWzZtC
         61bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PU8MusG8hezkzW5+KO/6eKPDv5BwIZAo7r3U1MyX75U=;
        b=skuS7ncCiVpsU7ttl0tV/C+zCv6yHk0qp0zX2MEnXv8BhJQGWdhOAfWiOIiZQpdr0t
         KWqXUpJvD613FlVNQtipFPjcWIn0X24hCpxv7JuIxhoVvzPoswO75FzVP0zAhhDn6O1U
         taHqQBMjXtqO5k9a5e27PJRVTNmJv9moSN0syroySAG5OgJbJIFh1dqX9c/9l8zRxFTR
         AZXUKc3ZrDBJteZiOWhb4nLTFzqHXdd2jfm6G1/25tydB9lEG/MDygqWwzGEt4DgFjLX
         zutV5bH6LyENf19TQmabJVrLsr6P2i0onZaUyxa1dNbBCVQml21q1McJ2h1EGt1OqZa7
         OYIw==
X-Gm-Message-State: ANhLgQ2v8tbyEuGutOvfP3fiHPJ2vU06D3I1zGxMtfQ2uIUwMrak9w2P
        QwtMuf/hlCKRnK4di/I2UoU7gGyiy7dpO2YsqOmO6tGRFLw=
X-Google-Smtp-Source: ADFU+vtmJqBnftLMH2+YVqFQ9mUmLnM8IJNNLIYZmzTFdCDzijDPUJnekA7kYFkGsSJAc9tM9X7A8KYbax34+wu6Me8=
X-Received: by 2002:a02:93c1:: with SMTP id z59mr4456806jah.11.1585168154776;
 Wed, 25 Mar 2020 13:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200325194317.526492-1-ross.philipson@oracle.com>
In-Reply-To: <20200325194317.526492-1-ross.philipson@oracle.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 25 Mar 2020 13:29:03 -0700
Message-ID: <CACdnJut56WuqO=uLff0qy1Jp=C6f_sRxLpRBsrzb6byBsFYdCg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel support
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:43 PM Ross Philipson
<ross.philipson@oracle.com> wrote:
> To enable the kernel to be launched by GETSEC or SKINIT, a stub must be
> built into the setup section of the compressed kernel to handle the
> specific state that the late launch process leaves the BSP. This is a
> lot like the EFI stub that is found in the same area. Also this stub
> must measure everything that is going to be used as early as possible.
> This stub code and subsequent code must also deal with the specific
> state that the late launch leaves the APs in.

How does this integrate with the EFI entry point? That's the expected
entry point on most modern x86. What's calling ExitBootServices() in
this flow, and does the secure launch have to occur after it? It'd be
a lot easier if you could still use the firmware's TPM code rather
than carrying yet another copy.
