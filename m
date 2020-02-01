Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1168C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 17:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7252205F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 17:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="g0I5kOKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgBAReS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 12:34:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35503 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgBAReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 12:34:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id b18so10663476oie.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 09:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtlBGnOFdYatlABMmvX9Zn+TYTRXCztfhZYZ1Bz9w4U=;
        b=g0I5kOKxbvaIHoz9zzo8+TvveUAbR9LvXjkSIK9y9JEVS47kBiSJ1EyNJB4o1BRmii
         CvN63G1tQmqv0VVWKjeMITEWMK+GuXhhPLB0W7gY1V7O480ajxmJs60vGlwwqqscoZiU
         WnXN8o0/DlOss4B0Cgb+N7WBWoylZTHzhBXzJLT671I2qXqrL/+Ma+2z1qkX3SN4g56X
         ol8UpuFzah3PN49ABHPtj/QbML8z/NdOCZWOR/dHazQfTL277Ib9WdMhxCTVSvQZvBuR
         8at5WtKcymXUXEaX8DOGadlPCCtcbZT5dTTEh0SamIUltO8pPyIEHVjvhnu5dD+8Vws8
         AxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtlBGnOFdYatlABMmvX9Zn+TYTRXCztfhZYZ1Bz9w4U=;
        b=GexVc7tcy89ZRiMMifRJoKBnkwbeGFMOvE2sC3tqd1nyCo4QXQgp0OGMqcI+yV5ow+
         7Hn1vORwjwGjob5mqCxc7T+E27ZrNYjP4N5PeDJQZ2zgqGSVgbhTuq037pnZLBqTaQwC
         ONdVNRaxosj1GEMZhyPmxcRcqh5gXf1RUJGubi81cE61IXAIdi9ah/4kHhdUV923tbL6
         FQdx27mL/GUXwfRij+HPIcGx6M+V6eITFFctNRriqf5wlwly1GP5lJrDISs1IpOEho2d
         evcHB3E1aFYBN48cAs0VNN+4ttIiGAAo6rq61QexJlqFDhB+lMBRXnWJZj94NKmL9Gz7
         SqPg==
X-Gm-Message-State: APjAAAVORycDKd23a868i3uh2AwJ18LDQ/MYO/Ywe4aKvlLSAtqQiSMN
        NJrpFyU768MHdQOLpOw5o8YKtd5v40+fbMOGNFmV6S2S
X-Google-Smtp-Source: APXvYqwb5iv1ePTk/w/ExyS59Gep0ry7jVLVOw430odoGAVzf892BRwIV2FslFjJZkDioXv+xZpvSF/r4FdlRncJMSA=
X-Received: by 2002:a54:4791:: with SMTP id o17mr9472411oic.70.1580578456766;
 Sat, 01 Feb 2020 09:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20200201170933.924-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200201170933.924-1-lukas.bulwahn@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 1 Feb 2020 09:34:05 -0800
Message-ID: <CAPcyv4iP9AMrkNk-sabqCmS0bZkBcO5gx2tsv5kM0tFxjv_YTA@mail.gmail.com>
Subject: Re: [PATCH RFC] MAINTAINERS: clarify maintenance of nvdimm testing tool
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 1, 2020 at 9:09 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The git history shows that the files under ./tools/testing/nvdimm are
> being developed and maintained by the LIBNVDIMM maintainers.
>
> This was identified with a small script that finds all files only
> belonging to "THE REST" according to the current MAINTAINERS file, and I
> acted upon its output.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> This is a RFC patch based on what I could see as an outsider to nvdimm.
> Dan, please pick this patch if it reflects the real responsibilities.
>
> applies cleanly on current master and next-20200131

Looks good, thanks, applied.
