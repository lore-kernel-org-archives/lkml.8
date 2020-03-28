Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77858C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 13:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7AE20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 13:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="VC1e5z6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC1N4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 09:56:30 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44519 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1N43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 09:56:29 -0400
Received: by mail-yb1-f195.google.com with SMTP id 11so6224086ybj.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ONdMAPyiB0FQN9RfNXQDWPw1B2SNFTDlbdPq+oteUP0=;
        b=VC1e5z6odylqRXJ01LB/715zOmiuRw6n94RE+SFPg+ccDnVRWqdVq+IU3uxFNtOl69
         uQmXJrW85p/GN7cX3/y/9sEdlMFPGgdJAZY/A8cUINEopka2hUcQSRHHFqpVdITaPKH4
         0Gag/Fm3S7BYiMXl4z8awVZx2ohJB8jyaILnuLZy3rbncNhc/Z1U9yIfqWg18SmOecrT
         NEB8KlC60vhC7cokGw6TtDlXR1nTJKHYUzk0poxHkP8fhfqhiJFMefgY04eqoiRiwSkq
         CuvI5skXFIfWW86MsVmtOXkNcFYU/trSirOjFy+kyPhn78YDhTG4igc87sVuiZ2GT5eZ
         FSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ONdMAPyiB0FQN9RfNXQDWPw1B2SNFTDlbdPq+oteUP0=;
        b=kfzsqYcULHEuW3TpP9Mk/aUlOXjS87XiLqvQBnCWPBce4VdEJRBPEqMf2AuKwKrpkM
         AM0Py34K3DZntHrJyeKuqaAXAZTRALxWeTtCc8OKoGqfbYgfFkaQnKOgCokU0JEutlK6
         rKkAzE42LQqJAM4OHBLyT7RLLF5YnuXt0mEyWU/JCuCquRTi1XCe92qrWs7unrKo4qTB
         BQSLJHKpWORypFX+EaeZyc+Q0ovOKMmiwYaqsq/SSH5ldbgAJJ/x5xeljBiPrGHDQzln
         76vz9bhlCyD6Srgsao3nE5+tEjKbsIlbU5p4Lzx5km4J6/GP5HMwcV0I4l1a5GEkyAqg
         PK6g==
X-Gm-Message-State: ANhLgQ0PpZygdrJ7ij2rVw+9LruPvSegUVRmqtHwpVTpJ+4xIjwEZUk9
        /2GmqAk5uhmYFDVYdVN3LymDla4zd5XDDfRk3AxUlg==
X-Google-Smtp-Source: ADFU+vuRXCOQPyauFIJmv2m9SNnbV6hifB8BojlvTqloHfynOqJyE74a8eLVpc3XwnUnkij3d0BA0Bc1VMQYMk40TKM=
X-Received: by 2002:a25:3701:: with SMTP id e1mr6170514yba.196.1585403788766;
 Sat, 28 Mar 2020 06:56:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:1941:0:0:0:0:0 with HTTP; Sat, 28 Mar 2020 06:56:28
 -0700 (PDT)
X-Originating-IP: [24.53.240.163]
In-Reply-To: <20200328082601.GA7658@infradead.org>
References: <20200328050909.30639-1-nbowler@draconx.ca> <20200328050909.30639-2-nbowler@draconx.ca>
 <20200328082601.GA7658@infradead.org>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Sat, 28 Mar 2020 09:56:28 -0400
Message-ID: <CADyTPEyDbV9WiOc9SOFvzPX9ccd7mhGG_Fj8QNmxGEY9UgkiRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nvme: Fix compat NVME_IOCTL_SUBMIT_IO numbering
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2020, Christoph Hellwig <hch@infradead.org> wrote:
> On Sat, Mar 28, 2020 at 01:09:08AM -0400, Nick Bowler wrote:
>> When __u64 has 64-bit alignment, the nvme_user_io structure has trailing
>> padding.  This causes problems in the compat case with 32-bit userspace
>> that has less strict alignment because the size of the structure differs.
>>
>> Since the NVME_IOCTL_SUBMIT_IO macro encodes the structure size itself,
>> the result is that this ioctl does not work at all in such a scenario:
>>
>>   # nvme read /dev/nvme0n1 -z 512
>>   submit-io: Inappropriate ioctl for device
>>
>> But by the same token, this makes it easy to handle both cases and
>> since the structures differ only in unused trailing padding bytes
>> we can simply not read those bytes.
>>
>> Signed-off-by: Nick Bowler <nbowler@draconx.ca>
>
> I think we already have a similar patch titled
> "nvme: Add compat_ioctl handler for NVME_IOCTL_SUBMIT_IO" in
> linux-next, with the difference of actually implementing the
> .compat_ioctl entry point.

OK, I found that one and it looks to solve the same problem.

I'm not sure about copying the nonexistent trailing padding from 32-bit
userspace but that may not be a problem in practice.

So feel free to drop this patch.

Thanks,
  Nick
