Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353BFC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0A42464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IMSgfzJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgCJOKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:10:15 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40902 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJOKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:10:15 -0400
Received: by mail-il1-f193.google.com with SMTP id g6so12103362ilc.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Dq64x4DjoKFCRaWP0RmVXxQ/yypMvRHHigI32DgfmA=;
        b=IMSgfzJYgymp5J//NAnPuXmv+ttIDEmyfzo3Bl/xD5bXo890r/Y+o2KMqeTHJlcpRr
         LHhWPmBfOOouLuWuT3Uj7HRvFT2ydIXCkZaFwsKzywxSWuEKNBetWQvDVoULEZEDm03p
         tRMUsriMnv8JkVwffZVVKi89BSYtpcGRODjq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Dq64x4DjoKFCRaWP0RmVXxQ/yypMvRHHigI32DgfmA=;
        b=ObiMkRQqb5cq77cKWG1fUJHaGE8Sr1r4kGJ2cmcbzKmP7rlNOztvc8PYIEpv1cgSgI
         FK123hCRtCRkQURdeL2MlWzeq8XsQgZDFwk+Y79HJcGwCTe0GoUOI11nLtNshr5AgOh7
         Fo8T9ZUCzH3dik86ruaXqya9/eitahEURTogY3ZiK4kEfsMgxSYC18N4hKwPzDGImV5V
         D1jUgsuiUIUrN4wJkmMSRK7DDdKJ418C0jw7J2FZhWZXfPKiAU55FFm3SwGMPCDqsgym
         iCSMZqS5bJ9VW5aVIgJtfugfmPCmk2wnF3CK35UeWeldtYG7mZLVOLVUHSbaU6g/QodU
         nHjw==
X-Gm-Message-State: ANhLgQ1fNT4BQGLwBpbUBytrxPJvuHBltmbHlp65dB0YVk5kIFbqUNtW
        dCRflkwR1QqdU0LoGYogiTZYwgOM9ogrjAMaBMLMrA==
X-Google-Smtp-Source: ADFU+vtA2bBrA3QBgj3ZymF37VCxe3Znyz4vcji09X2nGjZ9/L3vfB4trInJdMsBR57HttHenvzZDwFXg1DyS7Avj/4=
X-Received: by 2002:a92:aa87:: with SMTP id p7mr12249562ill.63.1583849414997;
 Tue, 10 Mar 2020 07:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-7-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-7-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 15:10:04 +0100
Message-ID: <CAJfpegvKRt6eaZHzs3e70y_c6j5q30jAir6k-hOWevWiQUOVKw@mail.gmail.com>
Subject: Re: [PATCH 06/20] virtiofs: Provide a helper function for virtqueue initialization
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
> This reduces code duplication and make it little easier to read code.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
