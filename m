Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C392C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99A92078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUlyA9C1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgFOQLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:11:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30877 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729949AbgFOQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592237506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s3Y9+xXDyttebs3/fVIigjv1aP9MsZuTcGKyOjbOlrk=;
        b=RUlyA9C1yldMWgNtIwDeFLL/ywlWYyEUuz5T7NXXQKJ2EQy2p3f9siYTgXxAcqm4l51chG
        jmoxDb23K626sUkr6tkAo7RsZtBZlXGj6kZET4EqdHOYIPRwj5AGYhV67ANutZ3S5TQPRt
        HQKiJ5T7WjaPsrl/B7N7hg5jF3NQgwU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-dTb3WIONMtuKgZwd7-NMdg-1; Mon, 15 Jun 2020 12:11:43 -0400
X-MC-Unique: dTb3WIONMtuKgZwd7-NMdg-1
Received: by mail-qv1-f72.google.com with SMTP id ba13so13402708qvb.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3Y9+xXDyttebs3/fVIigjv1aP9MsZuTcGKyOjbOlrk=;
        b=XUCCFahAMfay3AMvEShDXWSA3zC6vg/e6ovgYfgFaOk3gYC0KQ0t8gukbZB9L6Giz3
         Iy/aRmJVvn7VuSgBx0gAVyjOHPrRiC7XC8Mi/wXmqVgsqNx/K8zsrAaYWn0C1v5uejLT
         KZ8rjbz4N7M60pty6OlriAGX5Kx+CK6mc0LLEq0z5GNjUgyjIN4nAxA0/zR2tRHc1RJO
         MHwjNNgP/mlzOjXbDCNOivPkDUjgODmUJvgKYWrTK+TrrObK94BXlAR29gqxPHmIEAgQ
         4Wx0GQAS8SuwlbIsMl3+v6XDaFL+Hoix9vUVGnEAv5VN//5veUsb/1XoWOnPSsnbcFWN
         qAIw==
X-Gm-Message-State: AOAM532X4O+H9xC5eya2VAse1eUQTBVUmD9H0PF3np30P5X8vqcVo48C
        XO06XQvNdUdPZL7xqo/Lfj8xYeftg41V+QGq6/y39wwizriO8lH1sr7avDRvRV5SoHQY/AxgX9c
        y9Yx3v7BkMCvt6vtlkWwqtU3Bl7epjiz9PCsBFiKr
X-Received: by 2002:ac8:312e:: with SMTP id g43mr16444501qtb.308.1592237502358;
        Mon, 15 Jun 2020 09:11:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJf2dKPK+iYSVWjob0YFgJrsLx4Y6zwMor0rx3TpwaUzXHN6d9uezxdspNtpgbkwdstqV1JKgXVMQuYTR4Z48=
X-Received: by 2002:ac8:312e:: with SMTP id g43mr16444416qtb.308.1592237501400;
 Mon, 15 Jun 2020 09:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-6-mst@redhat.com>
In-Reply-To: <20200611113404.17810-6-mst@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 15 Jun 2020 18:11:05 +0200
Message-ID: <CAJaqyWeEdydJu6=Mxptgi0doiCBVS9pF9pg39FMcy1-8jN9G9Q@mail.gmail.com>
Subject: Re: [PATCH RFC v8 05/11] vhost: format-independent API for used buffers
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 1:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Add a new API that doesn't assume used ring, heads, etc.
> For now, we keep the old APIs around to make it easier
> to convert drivers.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/vhost.c | 73 +++++++++++++++++++++++++++++++++++++------
>  drivers/vhost/vhost.h | 17 +++++++++-
>  2 files changed, 79 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c38605b01080..03e6bca02288 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2335,13 +2335,12 @@ static void unfetch_descs(struct vhost_virtqueue *vq)
>   * number of output then some number of input descriptors, it's actually two
>   * iovecs, but we pack them into one and note how many of each there were.
>   *
> - * This function returns the descriptor number found, or vq->num (which is
> - * never a valid descriptor number) if none was found.  A negative code is
> - * returned on error. */
> -int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> -                     struct iovec iov[], unsigned int iov_size,
> -                     unsigned int *out_num, unsigned int *in_num,
> -                     struct vhost_log *log, unsigned int *log_num)
> + * This function returns a value > 0 if a descriptor was found, or 0 if none were found.
> + * A negative code is returned on error. */
> +int vhost_get_avail_buf(struct vhost_virtqueue *vq, struct vhost_buf *buf,
> +                       struct iovec iov[], unsigned int iov_size,
> +                       unsigned int *out_num, unsigned int *in_num,
> +                       struct vhost_log *log, unsigned int *log_num)
>  {
>         int ret = fetch_descs(vq);
>         int i;
> @@ -2354,6 +2353,8 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>         *out_num = *in_num = 0;
>         if (unlikely(log))
>                 *log_num = 0;
> +       buf->in_len = buf->out_len = 0;
> +       buf->descs = 0;
>
>         for (i = vq->first_desc; i < vq->ndescs; ++i) {
>                 unsigned iov_count = *in_num + *out_num;
> @@ -2383,6 +2384,7 @@ int (struct vhost_virtqueue *vq,
>                         /* If this is an input descriptor,
>                          * increment that count. */
>                         *in_num += ret;
> +                       buf->in_len += desc->len;
>                         if (unlikely(log && ret)) {
>                                 log[*log_num].addr = desc->addr;
>                                 log[*log_num].len = desc->len;
> @@ -2398,9 +2400,11 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>                                 goto err;
>                         }
>                         *out_num += ret;
> +                       buf->out_len += desc->len;
>                 }
>
> -               ret = desc->id;
> +               buf->id = desc->id;
> +               ++buf->descs;
>
>                 if (!(desc->flags & VRING_DESC_F_NEXT))
>                         break;
> @@ -2408,12 +2412,41 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>
>         vq->first_desc = i + 1;
>
> -       return ret;
> +       return 1;
>
>  err:
>         unfetch_descs(vq);
>
> -       return ret ? ret : vq->num;
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(vhost_get_avail_buf);
> +
> +/* Reverse the effect of vhost_get_avail_buf. Useful for error handling. */
> +void vhost_discard_avail_bufs(struct vhost_virtqueue *vq,
> +                             struct vhost_buf *buf, unsigned count)
> +{
> +       vhost_discard_vq_desc(vq, count);
> +}
> +EXPORT_SYMBOL_GPL(vhost_discard_avail_bufs);
> +
> +/* This function returns the descriptor number found, or vq->num (which is
> + * never a valid descriptor number) if none was found.  A negative code is
> + * returned on error. */
> +int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> +                     struct iovec iov[], unsigned int iov_size,
> +                     unsigned int *out_num, unsigned int *in_num,
> +                     struct vhost_log *log, unsigned int *log_num)
> +{
> +       struct vhost_buf buf;
> +       int ret = vhost_get_avail_buf(vq, &buf,
> +                                     iov, iov_size, out_num, in_num,
> +                                     log, log_num);
> +
> +       if (likely(ret > 0))
> +               return buf->id;

This should be buf.id, isn't it?

> +       if (likely(!ret))
> +               return vq->num;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
>
> @@ -2507,6 +2540,26 @@ int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
>  }
>  EXPORT_SYMBOL_GPL(vhost_add_used);
>
> +int vhost_put_used_buf(struct vhost_virtqueue *vq, struct vhost_buf *buf)
> +{
> +       return vhost_add_used(vq, buf->id, buf->in_len);
> +}
> +EXPORT_SYMBOL_GPL(vhost_put_used_buf);
> +
> +int vhost_put_used_n_bufs(struct vhost_virtqueue *vq,
> +                         struct vhost_buf *bufs, unsigned count)
> +{
> +       unsigned i;
> +
> +       for (i = 0; i < count; ++i) {
> +               vq->heads[i].id = cpu_to_vhost32(vq, bufs[i].id);
> +               vq->heads[i].len = cpu_to_vhost32(vq, bufs[i].in_len);
> +       }
> +
> +       return vhost_add_used_n(vq, vq->heads, count);
> +}
> +EXPORT_SYMBOL_GPL(vhost_put_used_n_bufs);
> +
>  static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  {
>         __u16 old, new;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index fed36af5c444..28eea0155efb 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -67,6 +67,13 @@ struct vhost_desc {
>         u16 id;
>  };
>
> +struct vhost_buf {
> +       u32 out_len;
> +       u32 in_len;
> +       u16 descs;
> +       u16 id;
> +};
> +
>  /* The virtqueue structure describes a queue attached to a device. */
>  struct vhost_virtqueue {
>         struct vhost_dev *dev;
> @@ -195,7 +202,12 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
>                       unsigned int *out_num, unsigned int *in_num,
>                       struct vhost_log *log, unsigned int *log_num);
>  void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
> -
> +int vhost_get_avail_buf(struct vhost_virtqueue *, struct vhost_buf *buf,
> +                       struct iovec iov[], unsigned int iov_count,
> +                       unsigned int *out_num, unsigned int *in_num,
> +                       struct vhost_log *log, unsigned int *log_num);
> +void vhost_discard_avail_bufs(struct vhost_virtqueue *,
> +                             struct vhost_buf *, unsigned count);
>  int vhost_vq_init_access(struct vhost_virtqueue *);
>  int vhost_add_used(struct vhost_virtqueue *, unsigned int head, int len);
>  int vhost_add_used_n(struct vhost_virtqueue *, struct vring_used_elem *heads,
> @@ -204,6 +216,9 @@ void vhost_add_used_and_signal(struct vhost_dev *, struct vhost_virtqueue *,
>                                unsigned int id, int len);
>  void vhost_add_used_and_signal_n(struct vhost_dev *, struct vhost_virtqueue *,
>                                struct vring_used_elem *heads, unsigned count);
> +int vhost_put_used_buf(struct vhost_virtqueue *, struct vhost_buf *buf);
> +int vhost_put_used_n_bufs(struct vhost_virtqueue *,
> +                         struct vhost_buf *bufs, unsigned count);
>  void vhost_signal(struct vhost_dev *, struct vhost_virtqueue *);
>  void vhost_disable_notify(struct vhost_dev *, struct vhost_virtqueue *);
>  bool vhost_vq_avail_empty(struct vhost_dev *, struct vhost_virtqueue *);
> --
> MST
>

