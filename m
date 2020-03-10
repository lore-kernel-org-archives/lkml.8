Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACB9C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD85A21D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aK5PVE29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCJT37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:29:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45929 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgCJT3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:29:55 -0400
Received: by mail-io1-f65.google.com with SMTP id w9so14009228iob.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+5kKx2vjd+32qtXdrToSkdcaTFfCoL0XwTHvIf1Udg=;
        b=aK5PVE29ZcX0JiUctdQKR6J4V8Ui1eAIPqRanRd0A6P1wY0Olma3AwHhrD2PySTEY1
         kZXXW4WCwVRDmSdrzbH44gRLv2dG0A/Uo2FsE583gbPAcJns18ZxYKCVeIw3hoRvR9nW
         X63aa+sKmNAHbQ4QA3pDh67PTQqXiIq2fbgVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+5kKx2vjd+32qtXdrToSkdcaTFfCoL0XwTHvIf1Udg=;
        b=eobogGv9RlvHuXlJBfY/cTPgGRYlPNqs5FatbJZ66qwV0EkBPtnYc8o8hPuoqDIbxW
         92D+RWS/8Okxcss7SGgbWOLoooJwcuH1R3Ek4bTtfgK+CxQG72CYPhWXp2daTDAtCN4s
         qXVEa+ADEgpGDWKAQY4YebS2HFQqsl1IOthBQMML8pytusHNhJS8Zqc4yVldeqigyif4
         wlsS2QpG9ch2DALuvZsExj17hS5wxCBBw4lRpKgyDtJEa5G3Lv4XEyLUy5CpiZVIEmH3
         KygJ4CZXuLBYI4LZ5+1eHX3w54aIWZ5CwCUkbWKE9o4xXQg4EFNkvRPe6en2A6G25Scg
         fhJg==
X-Gm-Message-State: ANhLgQ0dHVShHm7b3Q91IYDBE6NNSRt9KEkS57cc8fY7uTwyx2AJJG2e
        4pe6NxTmc16m0BCzmL6cjTdcgDHjzkaDVL/7btzX9Q==
X-Google-Smtp-Source: ADFU+vtsHIE3juf6VloEHRQ+IFMzK3xP4NZGmqU4UP+Nis9eHwUR1TaPlSRS7pe1JGlIhD+fR0kBGJFzXYHNxz1Bts4=
X-Received: by 2002:a02:7a07:: with SMTP id a7mr12556058jac.77.1583868594718;
 Tue, 10 Mar 2020 12:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-11-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-11-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 20:29:43 +0100
Message-ID: <CAJfpegshzZB=e3npbY3h9VOLMwAgLtQ3PJSC8AupF_d3FW9few@mail.gmail.com>
Subject: Re: [PATCH 10/20] fuse,virtiofs: Keep a list of free dax memory ranges
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Divide the dax memory range into fixed size ranges (2MB for now) and put
> them in a list. This will track free ranges. Once an inode requires a
> free range, we will take one from here and put it in interval-tree
> of ranges assigned to inode.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
