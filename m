Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6AEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FC321775
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="jWhtjW8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgCBOhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:37:53 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43473 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCBOhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:37:53 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so11718002ioo.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 06:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fmChl07tCnnnsdQkbYOcsmPILzyShLh33qBmgjXyxkA=;
        b=jWhtjW8byNV5i6zYn7TLRszuxZRXo+KsJDCRQNqMJxy4mxFW6SnjBqFPbllWCdiz1Z
         vSZtoEf4aWL9hhjLep45IC4+bNTaq9pt5eKC+7nuCeFX4LdBjvaVVZYOKBto5dDPmc+T
         ApyO6v+VFuYhFl9pSTY5dcurg8VNvxgwjDPcQQzBC3ydlusa+PlxEggxirhemmvaspww
         fJvqe0xyjFt8IX75KsbYqUodLnB1+D7tUCfuLt7iLqbBoM1gvEDYAArmW/dIVo6votI7
         onnLTrXtd0ivQoMl0j1nvFrpMKbS4PY52CbGZ5FhNEgTkJ5KFzYSyzINWwRgMG06rjZi
         mncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmChl07tCnnnsdQkbYOcsmPILzyShLh33qBmgjXyxkA=;
        b=FMQWFsw8DpLHUoD/HaTj8Nh7HEuda/ChIM+UTEWvJVQW79a3dgaiwhm+A8Kl3eAYKo
         +Tcwllk5sfF5BKIN0nUcH/gTpWbY4Y9auNPCjEvLHwJziHlTEQTRT/jAGQL+EuzLH8+E
         tzgy14hX2xiOEaqqFws4bAbJlvsvYtfTidJpYUQoADh+HLQwt8z0r9WFp2Ul7bhYuWTY
         HOp3nxpta97f9hCtC1SE/cVKaViXmTuQks0LG3SgCpGFSmmCJ50zIeRwTDEh6kGKYS/d
         Km3TG/DEXeXjFNnjHGzKsUHG0tZP71bvEojqTdxakI60xVQW4XLAAjNwPbPVoXtdwHMg
         92lg==
X-Gm-Message-State: APjAAAWurZxIKwdcZ5K9lshn3a2tHrbKV0gsFKwmvMH2XK++nUM8uK5/
        I9Ccsw4t4g0Mg5tguzsK4WFrFQ6Dedc+jChJK+tytg==
X-Google-Smtp-Source: APXvYqwpTrVreRlhOJstucnPx7hIH1xJIKArYs7wGfkg+h8SN/KzbOrQMY8TYI6vLJO0hKUh/OE4DxkfB83yk2X5bx4=
X-Received: by 2002:a6b:5a06:: with SMTP id o6mr12550360iob.54.1583159871960;
 Mon, 02 Mar 2020 06:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-2-jinpuwang@gmail.com>
 <8131773d-cf6e-9c1d-faad-a250f7135432@acm.org>
In-Reply-To: <8131773d-cf6e-9c1d-faad-a250f7135432@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 15:37:41 +0100
Message-ID: <CAMGffEn5tPDCsGZNMO9wZE6RGJ+VKM4mTp4ynjW13CKrv+Fh3Q@mail.gmail.com>
Subject: Re: [PATCH v9 01/25] sysfs: export sysfs_remove_file_self()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 1, 2020 at 1:24 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:46, Jack Wang wrote:
> > Function is going to be used in transport over RDMA module
> > in subsequent patches, so export it to GPL modules.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Thanks Bart!
