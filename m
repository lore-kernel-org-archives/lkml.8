Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77D1C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC802078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XQbewNZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgH1O1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgH1O1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:27:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC6BC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:27:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j25so1761421ejk.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gl0n7d6uzVJsvRESdz9U6Q5zoOE/mArKZEtiHXlxl+A=;
        b=XQbewNZ6vbVoEOX8gsi1Rc4oDnVeju8D129HRlTSxUJHzvsLy8S4x4ttUv/Q1UbD7a
         RvH7dXTmrZ/ZsiQSdTzwNPUfqx9vmGPSqZ3jM1W1LFFJhJpo1s7/hzIpe/U20goTwNkm
         M/hx0L+ugVWf90stUZL9nRhUG59hiac/rQbow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gl0n7d6uzVJsvRESdz9U6Q5zoOE/mArKZEtiHXlxl+A=;
        b=AZih2TeOxWdbR+YZMIAf8ObaEL0mLQvu1xJJWA8M0InwMw9NbL2OghDcb8bW7Q/lIG
         +wfz4En7FG03AVavy6zW1waxqYj3sSXz2KCmoIkYNR6RTjZWHAQAnGNY8YKtHYejWBW6
         9rb9PQUP5x1RD9uf3sp6kQ0z0vzcCRN/CG8V0do9pPEpKRqoxJZKYcCSVLTqGjkQ9RFN
         sQdnAwPhVEagw9SLCvKwEvVregEecx4WgFu39Uft08Y64h7qd3N8L5yocRmpKjmS8Yk5
         ttzmW8P2JcqHa+Lw0bs7cmI0LZzmLikS5iZ8O2bIeS6ZV0j6Yvu1kBEZv/u2iEjm/QDV
         j8fw==
X-Gm-Message-State: AOAM530m5yaiFoo61oY/1sV/sJ957NfFKPqCBpJrBO0fRRMOU0zxzIPE
        /bKXczuRXxivVvqb32EBTnn96vZLLmpvevYG8kcEoQ==
X-Google-Smtp-Source: ABdhPJx/XumYJzNHjGferUrsD62R+WOS937oWA5dXyt/UPWotd7gXol3fLS1WId9GCqY81zy1C7DxVDsLeoyTNi+yYA=
X-Received: by 2002:a17:906:ca55:: with SMTP id jx21mr2095017ejb.110.1598624827171;
 Fri, 28 Aug 2020 07:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200819221956.845195-1-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 28 Aug 2020 16:26:55 +0200
Message-ID: <CAJfpegv5ro-nJTsbx7DMu6=CDXnQ=dzXBRYEKxKc6Bx+Bxmobw@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] virtiofs: Add DAX support
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 12:21 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi All,
>
> This is V3 of patches. I had posted version v2 version here.

Pushed to:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#dax

Fixed a couple of minor issues, and added two patches:

1. move dax specific code from fuse core to a separate source file

2. move dax specific data, as well as allowing dax to be configured out

I think it would be cleaner to fold these back into the original
series, but for now I'm just asking for comments and testing.

Thanks,
Miklos
