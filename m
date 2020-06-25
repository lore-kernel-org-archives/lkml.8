Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64C3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7780F20768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="md6JeSeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391273AbgFYVwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391257AbgFYVwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:52:54 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191F7C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:52:54 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id i4so7710775iov.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4efuZftxKK9o65+Vk5rpjA4LyQPX0eWU9Rf6LChVf/Y=;
        b=md6JeSeb07oZ9fTzIeWhZZy9dr3WU5gVL/D7ojnrBrDiKN0M3XFjNfmACdRiaighYd
         Cj+ILx7vcu0NpsJeWCFagvMgJtpxnxP093KNjXFhtMuaj/SYznb4pPgYoGeZGfBndrDH
         ELICbQsqhCQOwuW9w8mLw1O+7cHOM53vXnWCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4efuZftxKK9o65+Vk5rpjA4LyQPX0eWU9Rf6LChVf/Y=;
        b=VpCJCS7K18ORSmThLqhqgJcHdaEFQJhJi+3yFwEhPpV5ejK5OOUu0Yxo17Hb/pjZgW
         HOt+nepO5Cm20ak3r3pwCL6aUxt8hklQINQxH9QDHYo+EIs7Y3AnsgAtk+PcW6dTxK9q
         mDSiYVi7AiwjBCl58XMSKXEm6z/BbC/5Gbz8UuxLd9Ztwor/p4wx7aNiK9QMNdEiQ35K
         ZmVnEzKDOdziK5z46Qj4ACaa8+gcXH/CaoTQArk9pcCesXOo6UqahzF5dNu2vaLkj0R7
         4f/TMT3B2pI8Xjff5knsAFPCNXEduRKO2JjmkNkp/43qYYfiUAVwlMERs5k2QEacTNG0
         IKrQ==
X-Gm-Message-State: AOAM531cMCkIEO3p3DqLq3nlWPShMoWIjk9+QLr1ZXlC4K/ko+5NNPQm
        Unr/1vodi+G2CYtBDnuakrGwnVYXmxe2WAy7KnGIuw==
X-Google-Smtp-Source: ABdhPJzDnqY+KrnyZxEUF6ZAsrr4PJZRiL+HNtKEt/yk9IpvplAdeMwy/BIXgr75KXcB7dvMFujEchzrzsxrIqzhX78=
X-Received: by 2002:a02:cc49:: with SMTP id i9mr239068jaq.52.1593121973487;
 Thu, 25 Jun 2020 14:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200625170300.224906-1-enric.balletbo@collabora.com>
In-Reply-To: <20200625170300.224906-1-enric.balletbo@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 25 Jun 2020 14:52:42 -0700
Message-ID: <CAPUE2utidaoe+pw5o3w0yL3mZYMm0GKCEijWHTVH3if2PvXhcQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_rpmsg: Document missing struct parameters
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

On Thu, Jun 25, 2020 at 10:03 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Kerneldoc expects all kernel structure member to be documented.
>
> Fixes the following W=1 level warnings:
>
>   cros_ec_rpmsg.c:49: warning: Function parameter or member 'ept' not described in 'cros_ec_rpmsg'
>   cros_ec_rpmsg.c:49: warning: Function parameter or member 'has_pending_host_event' not described in 'cros_ec_rpmsg'
>   cros_ec_rpmsg.c:49: warning: Function parameter or member 'probe_done' not described in 'cros_ec_rpmsg'
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/platform/chrome/cros_ec_rpmsg.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> index ff08c3d12873a..ad0a30afd7423 100644
> --- a/drivers/platform/chrome/cros_ec_rpmsg.c
> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> @@ -38,6 +38,9 @@ struct cros_ec_rpmsg_response {
>   * @rpdev:     rpmsg device we are connected to
>   * @xfer_ack:  completion for host command transfer.
>   * @host_event_work:   Work struct for pending host event.
> + * @ept: The rpmsg endpoint of this channel.
> + * @has_pending_host_event: Boolean used to check if there is a pending event.
> + * @probe_done: Flag to indicate that probe is done.
>   */
>  struct cros_ec_rpmsg {
>         struct rpmsg_device *rpdev;
> --
> 2.27.0
>
