Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52361C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F1D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OhbAghdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgCJTuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:50:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37600 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgCJTuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:50:01 -0400
Received: by mail-io1-f67.google.com with SMTP id k4so14082742ior.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3QS0e8RcKFN7/huSeBCCDwuVM9JqD+PwQz/25LYZ7s=;
        b=OhbAghdNUJbciPVHuH7moOlqqCFrFRE9cU5y6G8bZaazds/cVCLgdwVJGN8cktdJeV
         PcCU4iK+sDFS7sQ0uFJKeBvYtAZY/fdaWTYPriu+UWlAjLMThNuq340tP6KkBerdfuKh
         y3T0QJitw2eIkqR+syI0QC6SM1+A3omTiS8nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3QS0e8RcKFN7/huSeBCCDwuVM9JqD+PwQz/25LYZ7s=;
        b=AC2ixpEQL7RD8uYFQW+5yrcdnoqcTdaAaHpj/xQH3aXzwRMpQc/Mj+TZemmZD/wId9
         lHy71xB8FzWvXSy/MR7XrEo5vMVsOLcC8z/sL9NOH/BfpP0tEwzTAJCyUUInvLfS+u4W
         m8E1LP2Apjz7f6FQzUcSDw+22MASIvBQ6EcBvDeYNzPPhqMk168oz5XLjFEWQQ9+3oEC
         QTRvml2Q/rGFaNvEWR6GYRjrA7+Wfo8mowtNMGgRU4+NU1Q2yabmltZE4CzpDzO6YuUt
         ovA8E961Eh9seAPM+39765QQqh1bxKOMLhBCLzqSH9N95r7u9SnH1JQLzLlY8PqJWeNI
         pvjw==
X-Gm-Message-State: ANhLgQ2lFW21JX1oMly5Xjz5CjrB11xhAdK9GB7VyI67MrsHVSlzuMLc
        qPgb2i33QqV58NMgwzlUTSyI7IPnwijf3/FH1GPUqA==
X-Google-Smtp-Source: ADFU+vst15KzgX+tYyB+mxwdb3zdIiBvf9oRWln6x3JODjSTwfwW2FTFg8mFRjfOJtT7xvjklxE++Xz8fUEBp6Pgo14=
X-Received: by 2002:a02:a813:: with SMTP id f19mr19907887jaj.35.1583869800367;
 Tue, 10 Mar 2020 12:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-13-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-13-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 20:49:49 +0100
Message-ID: <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com>
Subject: Re: [PATCH 12/20] fuse: Introduce setupmapping/removemapping commands
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
> Introduce two new fuse commands to setup/remove memory mappings. This
> will be used to setup/tear down file mapping in dax window.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> ---
>  include/uapi/linux/fuse.h | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 5b85819e045f..62633555d547 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -894,4 +894,41 @@ struct fuse_copy_file_range_in {
>         uint64_t        flags;
>  };
>
> +#define FUSE_SETUPMAPPING_ENTRIES 8
> +#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> +struct fuse_setupmapping_in {
> +       /* An already open handle */
> +       uint64_t        fh;
> +       /* Offset into the file to start the mapping */
> +       uint64_t        foffset;
> +       /* Length of mapping required */
> +       uint64_t        len;
> +       /* Flags, FUSE_SETUPMAPPING_FLAG_* */
> +       uint64_t        flags;
> +       /* Offset in Memory Window */
> +       uint64_t        moffset;
> +};
> +
> +struct fuse_setupmapping_out {
> +       /* Offsets into the cache of mappings */
> +       uint64_t        coffset[FUSE_SETUPMAPPING_ENTRIES];
> +        /* Lengths of each mapping */
> +        uint64_t       len[FUSE_SETUPMAPPING_ENTRIES];
> +};

fuse_setupmapping_out together with FUSE_SETUPMAPPING_ENTRIES seem to be unused.

Thanks,
Miklos
