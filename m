Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE82FC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957B820674
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VUMeVtRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCJOND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:13:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41329 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCJOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:13:03 -0400
Received: by mail-io1-f66.google.com with SMTP id m25so12853977ioo.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYU1wxb/ge5DirIWwK28AnywpJQY3e/U9vYLjiccLeo=;
        b=VUMeVtRyDXOmmJAxS6+A2yYelERcpsMobnU+K+HXqAre31LWH5Ybg9m1IevwykOAC8
         LuhKNNqsEpPoC+7agcvG1rpEStM2V2YpmRpy+BjS+BXwOrIaMeNotiWCXzqWdLczA50g
         BSV6AlSgpI8eO6i/dsioSkintiC6wBXLVK/So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYU1wxb/ge5DirIWwK28AnywpJQY3e/U9vYLjiccLeo=;
        b=Oqgwkpg55si1Q6pPzfA8yNfrKElrXa3/u/bkEqz1iQ/5wTZxnaZtdg518jv4R29MUv
         zPyfBpKev0VshVMvtocmp1fjlv/GcI+nGzWgWuVBQ9LURFv1UIc/yqpWY/w3k1V1BeKD
         sNfgyAefJfYyKXvSXLi5eQfeG0tBPI3gAYAHo6rGBfdtgLYZMrMp7PZ8scuu6LOzC2os
         YFZqkrSyBxlww8Iptfi07k8MFcLRAQaI3KjgQsdO6ZcdGrzo6mPiweywo11geGWLvcw9
         i3o6tZ3rIrJlUTFm7BtA3MMAotY/CN+WihosN2oW7UKM76c9xxaHZZwW9EA/q7lEUxmF
         mSuw==
X-Gm-Message-State: ANhLgQ05PwdV7twJtQp9mZxsDHM1EV0r+zN1MjAQa+tI+FIkdT2jooPR
        xZv4ebQboINZvWjanpSmdiKRTp0YidF4Wk7G1B1fCQ==
X-Google-Smtp-Source: ADFU+vt4UJTT+vs/UI2ECs5CVHI9EXdfAc9QZZ6Sp885Ay5Ze3oaL6r9lcZCZ0eNm46t4uWRe96k4C0dQKTFbWt2E9E=
X-Received: by 2002:a5d:934d:: with SMTP id i13mr17966092ioo.154.1583849582112;
 Tue, 10 Mar 2020 07:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-8-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-8-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 15:12:51 +0100
Message-ID: <CAJfpeguxR2mR53BHEaSQUq2dN6mUVQHMVCoECrCX1F6x38M-0A@mail.gmail.com>
Subject: Re: [PATCH 07/20] fuse: Get rid of no_mount_options
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> This option was introduced so that for virtio_fs we don't show any mounts
> options fuse_show_options(). Because we don't offer any of these options
> to be controlled by mounter.
>
> Very soon we are planning to introduce option "dax" which mounter should
> be able to specify. And no_mount_options does not work anymore. What
> we need is a per mount option specific flag so that fileystem can
> specify which options to show.
>
> Add few such flags to control the behavior in more fine grained manner
> and get rid of no_mount_options.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
