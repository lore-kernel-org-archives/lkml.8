Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F222DC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65E320873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Auk/J/am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgCJTb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:31:56 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:44044 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgCJTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:31:56 -0400
Received: by mail-il1-f195.google.com with SMTP id j69so13094765ila.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QsMHMToALTgigyVVitR0QGzkqjZRHN3wRK9R0WkFcg=;
        b=Auk/J/am7PnSkti7DnDeBTBkoI7EdkOeiXxOafA83iFtNlXEfJCh8HA0llJSykN0lU
         F3K3PX0+eGlrLpw9xVldfbGWlBeibwiL4+JP4oW3J6fT8IYoEUYX6QU+hSAzqc2x9YAS
         wcqf5w4LictNkY4z6rP056PjahcGRfLxvhsqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QsMHMToALTgigyVVitR0QGzkqjZRHN3wRK9R0WkFcg=;
        b=cRolXBGdu0GwbFKAvT/C8vt13x1L3gvGAQlhDoMb9CEwtFCj/wk8JRQDpqX0SefaSx
         V3NoF+SpO+fAeGN17iwofyikKpUJQESce3bH8wurECkI29PEMcd3qwBqmNnN3XGHczCd
         NBUZYErph3LZmtLPv+5Yyg9PUQG2GrgD0M0TpIdzjT6GDcqOSzYH8BscNr6BOVQnhTkc
         Ui7qN2gdM7/BF/bCqQD3hJxPlYd7+q0zUB6A9kmioeuTH0VH+GM9BiqIDH1/FnRek46e
         +berO8vBxn3OEaJ8WE+GU35iU4X7/rYXSR31yVJ1e+dVlqsOepIZI3fvIJGyh3RvDZtF
         raIA==
X-Gm-Message-State: ANhLgQ3bXmm5wnz0TSR0IjkXCJS/p5rA7IWdftT8n8GbolPobdI4bCM2
        gp/1h3rECwaYvm8MA7b3w4K8P+6ptezKsBgu9jvMfA==
X-Google-Smtp-Source: ADFU+vsFfd6CjN4MRb2Z8XflZdOXGt54+OVcpgTdjMhSBiJTAUfuWfnL1e0wV+iTRlceDUTwZKIzKC3VAbxB+0sXKGs=
X-Received: by 2002:a05:6e02:f43:: with SMTP id y3mr21752506ilj.174.1583868715742;
 Tue, 10 Mar 2020 12:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-12-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-12-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 20:31:44 +0100
Message-ID: <CAJfpegu5HMg2BnBsfSEWOv7K_0KjchntZ9q4oOvxzYLjOEBF3g@mail.gmail.com>
Subject: Re: [PATCH 11/20] fuse: implement FUSE_INIT map_alignment field
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
> The device communicates FUSE_SETUPMAPPING/FUSE_REMOVMAPPING alignment
> constraints via the FUST_INIT map_alignment field.  Parse this field and
> ensure our DAX mappings meet the alignment constraints.
>
> We don't actually align anything differently since our mappings are
> already 2MB aligned.  Just check the value when the connection is
> established.  If it becomes necessary to honor arbitrary alignments in
> the future we'll have to adjust how mappings are sized.
>
> The upshot of this commit is that we can be confident that mappings will
> work even when emulating x86 on Power and similar combinations where the
> host page sizes are different.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
