Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF26C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EF122202
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587147403;
	bh=uFNjI2NTBZuu5HInd9mBICjFFSqgyNOTntNrA4CeJ9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FEYAcQwEKBbxwiSOHAZDtm6p3acyAboO59C8xgAQz3JFNlVbYoI5QmofROkDvjaws
	 Qrbd5cfU0YAn7brC9E4eZZ2khSUxQ+hWWHmqJZyEWL2SjDyCwDf3z3wl9vN5YDUImB
	 8Fd6NHnWSUOVxZVUzSmHvVhZ82mmbRyTsfljb/U0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgDQSQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730256AbgDQSQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:16:41 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2EEE22202;
        Fri, 17 Apr 2020 18:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587147400;
        bh=uFNjI2NTBZuu5HInd9mBICjFFSqgyNOTntNrA4CeJ9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KVwP9wt2tX56g8roK8GLXShPr8iTbHwOKAah+lAfxgcOCFnra2g7mBSG3/+JNsGvG
         WNvvLGbH+RW7ZviRL5HJ8is/1lbPVfVJfGipCfZQRETVo/SasWTYdzRw1Pima5bnBf
         YtbRgpMmtkYIKYguPVdfdpQgMZCQopRhVYBCxySw=
Received: by mail-qk1-f177.google.com with SMTP id y3so3403472qky.8;
        Fri, 17 Apr 2020 11:16:40 -0700 (PDT)
X-Gm-Message-State: AGi0PuZBOiO2v3YSbiwip1PSOMJ6Wol5JffvUnOmOjinheYGnqT5zqjz
        w1dop4hDZf/i11glNlBfRbbFHpQRgWx3x3+uKg==
X-Google-Smtp-Source: APiQypJtW2mvG5+Ex3UqXvZbs5wvXKHc10E3/tyFNH2CKDd4NqO1RLmorKwCUS5+pYi2la9j++2BRIk80oiLTHRuIVU=
X-Received: by 2002:a37:4a85:: with SMTP id x127mr4598821qka.152.1587147399791;
 Fri, 17 Apr 2020 11:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <c48a3baef99f3d74e7904498c4054221ec384b36.camel@suse.de> <20200416205838.161894-1-saravanak@google.com>
In-Reply-To: <20200416205838.161894-1-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 Apr 2020 13:16:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK9VmRomOnkVLQUOR9tHnh6phjjqXB=ERkjqhBw_wTVzg@mail.gmail.com>
Message-ID: <CAL_JsqK9VmRomOnkVLQUOR9tHnh6phjjqXB=ERkjqhBw_wTVzg@mail.gmail.com>
Subject: Re: [PATCH v1] of: property: Don't retry device_link_add() upon failure
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 3:58 PM Saravana Kannan <saravanak@google.com> wrote:
>
> When of_link_to_phandle() was implemented initially, there was no way to
> tell if device_link_add() was failing because the supplier device hasn't
> been parsed yet, hasn't been added yet, the links were creating a cycle,
> etc. Some of these were transient errors that'd go away at a later
> point.
>
> However, with the current set of improved checks, if device_link_add()
> fails, it'll only be for permanent errors like cycles or out-of-memory
> errors.

What improved checks? The series from Nicolas?

Is there a dependency between this and Nicolas' series?

Should this go to stable?


>
> Also, with the addition of DL_FLAG_SYNC_STATE_ONLY flag [1] to device
> links, all the valid dependency cycles due to "proxy" device links
> (needed for correctness of sync_state() device callback) will never fail
> device_link_add() due to cycles.
>
> So, continuing to retry failing device links (by returning -EAGAIN) is
> no longer useful. At worst, it prevents platforms from setting
> fw_devlink=on (or better) because it prevents proper boot up. So, let's
> not do that anymore.
>
> [1] - https://lore.kernel.org/lkml/20191028220027.251605-1-saravanak@google.com/
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 252e4f600155..ee1bc267f975 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1074,7 +1074,7 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
>                 return -EAGAIN;
>         }
>         if (!device_link_add(dev, sup_dev, dl_flags))
> -               ret = -EAGAIN;
> +               ret = -EINVAL;
>         put_device(sup_dev);
>         return ret;
>  }
> --
> 2.26.1.301.g55bc3eb7cb9-goog
>
