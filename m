Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63274C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30EE4207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIu5+DdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgE0ChS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 22:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0ChR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:37:17 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7921EC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 19:37:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k26so1096960wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 19:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fo26F0NoW7UXAZI20P+HiT0dZgkQVqLV8VIU39gdYLc=;
        b=RIu5+DdQ1VaplU0z7eJUcwrnEvkUPhv62+7muM9zNQ0E015+xMKbUgeS5ko57IQucf
         FITrEU2ZXrPskZADXu/RIjwEUK6gSMkm+SSt/pCSVymTBZgzxlQuUBcEm8EkXU788H5C
         MvSelDzU3ynksHlGQr25M+Px2uhaBkBfy93bR5mPlZteeXCrbZJhKjBVPOUQD2QPBUpk
         ZmvPUDQdD9kjHT3FPrCkd6Gl/XIN+ucasRiVdW0181Zs2kD1or00i92mghg5vGLu2TBr
         KPYM7bbLfbfx98KAPLVoxGLGJmNPJqhqAcuhi2/s66stfFP1bcvALS3r3ztmP/KwZspb
         xNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fo26F0NoW7UXAZI20P+HiT0dZgkQVqLV8VIU39gdYLc=;
        b=FByKMlpZrEAUTeEiVZBtpHBDuAVWwgJRmOyWGl5HtlGwOMQ313FFDA/mRRqZaNCjBD
         3n5FvQVOprnYS0B/no2EVWmzLelPvCrLYIltj9EdJZhnh8eqRLj3zZAX5b6w6hiBCTiL
         7Go1LiPyiL9A/oeen8Le3f/uAz0IKh1rIc0TtomJ4KZADouZT1EvLbya3J1xbZCg8Qzb
         VqOcyMBVwN1FUrIcvnreEyszVApxlkma694gjKCwsAchnf1HipMdg721Z5Emh6XQTbrN
         vsMfiDhoHogA/4Hux/vPC/9Vem8FqGs880Jzcvhq7qRnl2APq6z7AAt2jQE3uqNQr5J9
         V57w==
X-Gm-Message-State: AOAM530nmpShmykkD/YHh31veT+tgMrbkJIXWhlxVnrrdfO2ara8kjD/
        huH4wj3L531qBZ4Qkzi/xOKgci60jNog7AlqpP0=
X-Google-Smtp-Source: ABdhPJxiWYpNJ1X2X+ovzubaN1Go7qWUFw+e2JFGNhptHPYwQune5xOXrRVPc3f0RMGFE7d445SPUhdRgsE5HvwDzcg=
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr1902422wmg.162.1590547036270;
 Tue, 26 May 2020 19:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200527004955.19463-1-dongli.zhang@oracle.com>
In-Reply-To: <20200527004955.19463-1-dongli.zhang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 27 May 2020 10:37:05 +0800
Message-ID: <CACVXFVOoJfyZ=H0A4kjUwCxbF24YWEMenNuny3MtXr=-aLbXDA@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme-pci: avoid race between nvme_reap_pending_cqes()
 and nvme_poll()
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:57 AM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>
> There may be a race between nvme_reap_pending_cqes() and nvme_poll(), e.g.,
> when doing live reset while polling the nvme device.
>
>       CPU X                        CPU Y
>                                nvme_poll()
> nvme_dev_disable()
> -> nvme_stop_queues()
> -> nvme_suspend_io_queues()
> -> nvme_suspend_queue()
>                                -> spin_lock(&nvmeq->cq_poll_lock);
> -> nvme_reap_pending_cqes()
>    -> nvme_process_cq()        -> nvme_process_cq()
>
> In the above scenario, the nvme_process_cq() for the same queue may be
> running on both CPU X and CPU Y concurrently.
>
> It is much more easier to reproduce the issue when CONFIG_PREEMPT is
> enabled in kernel. When CONFIG_PREEMPT is disabled, it would take longer
> time for nvme_stop_queues()-->blk_mq_quiesce_queue() to wait for grace
> period.
>
> This patch protects nvme_process_cq() with nvmeq->cq_poll_lock in
> nvme_reap_pending_cqes().
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/nvme/host/pci.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3726dc780d15..cc46e250fcac 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1382,16 +1382,19 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
>
>  /*
>   * Called only on a device that has been disabled and after all other threads
> - * that can check this device's completion queues have synced. This is the
> - * last chance for the driver to see a natural completion before
> - * nvme_cancel_request() terminates all incomplete requests.
> + * that can check this device's completion queues have synced, except
> + * nvme_poll(). This is the last chance for the driver to see a natural
> + * completion before nvme_cancel_request() terminates all incomplete requests.
>   */
>  static void nvme_reap_pending_cqes(struct nvme_dev *dev)
>  {
>         int i;
>
> -       for (i = dev->ctrl.queue_count - 1; i > 0; i--)
> +       for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
> +               spin_lock(&dev->queues[i].cq_poll_lock);
>                 nvme_process_cq(&dev->queues[i]);
> +               spin_unlock(&dev->queues[i].cq_poll_lock);
> +       }
>  }

Looks a real race, and the fix is fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming Lei
