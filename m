Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD6720812
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GgeT2KTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFKHVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgFKHVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:21:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E904BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:21:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o15so5355814ejm.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qo3jKj2TlYH3YqUl34KzJeMJH4fTcTcBHRWbQNMVHbQ=;
        b=GgeT2KTHyRGE5UGaccyQn5lsdHLbqVcnDr4VLIeEDsBho6U8+B/+UBJN0Y8tVUTH6I
         2e9omFEj/RKp6ewd/zoLOGO3BmN2qrJbo8tNra570xh8sI2t12UAb0dCRzmBMniJpcYF
         BhngUS6HMMTuaSfokudf7udJpEApEvTRNjrzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qo3jKj2TlYH3YqUl34KzJeMJH4fTcTcBHRWbQNMVHbQ=;
        b=nY0pjyaE/qjST4OR8KVjf/mQXwrKjDEjvy1c86rJ6L1lVBbsBUvis94KgBfy+xseXR
         E4fJWcYidA/8LRsv7fwIMc1Hd2bclOYAkQoKNmksvBl/nlq19bbrsAP2UQm5W1sOUzHy
         twKz8DMvZLsfmAMpgOqkEM8wgsxMI8psU6dTo8FNXO6v4DTq7GDUyQBdQ7FzDH/5Tfz/
         9nZIgulynRXIDEknGVQeUrpzzS3bwRu5tU040NlyoaDeJCNtl90isiu5cNzlPb+jJNgH
         AxcxYaOdz+mb1u1N03EZ6+aCwVnd76UK6QoTxpoeUhjx74g2NIP92qkA2o+gU0xq1X6D
         BzIg==
X-Gm-Message-State: AOAM533G3FKHoLCWISzB1dioJQhXlhoIyK0RnDnvEI++fZocV1XwCUJ9
        GFtACTSPv3N5LMdWaRF1TbUyI7A2BVnBL5jdzlVTJw==
X-Google-Smtp-Source: ABdhPJw5JAalLlhabnI4NthFk/ReyQjVVTos9S4ZL6EYuL3a7iHEh/deWGwXVbjUHBGhO4S2Zp5kZV1VGpQscP592RI=
X-Received: by 2002:a17:906:e115:: with SMTP id gj21mr6795315ejb.528.1591860078482;
 Thu, 11 Jun 2020 00:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200610090748.45908-1-pihsun@chromium.org> <20200610090748.45908-3-pihsun@chromium.org>
 <3776237e-a6d5-ccda-79e4-39545b818e34@collabora.com>
In-Reply-To: <3776237e-a6d5-ccda-79e4-39545b818e34@collabora.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Thu, 11 Jun 2020 15:20:42 +0800
Message-ID: <CANdKZ0cwcTaXM+y3scooJyrH_DVdF8=jS2QN96CyoPrH8RmbTg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] regulator: Add driver for cros-ec-regulator
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Yicheng Li <yichengli@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review, would address most of them in v4. An inline
reply as below:

On Thu, Jun 11, 2020 at 12:47 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Pi-Hsun,
>
> Thank you for your patch.
>
> On 10/6/20 11:07, Pi-Hsun Shih wrote:
> > +/*****************************************************************************/
> > +/* Voltage regulator controls */
> > +
> > +/*
> > + * Get basic info of voltage regulator for given index.
> > + *
> > + * Returns the regulator name and supported voltage list in mV.
> > + */
> > +#define EC_CMD_REGULATOR_GET_INFO 0x012B
>
> This introduces a new EC command, while you are here, please also add the
> command in drivers/platform/chrome/cros_ec_trace.c, so we can trace properly the
> command. Also can you point me to the commit that introduces this command in the
> EC firmware?

The commit that introduces this in EC firmware is at https://crrev.com/c/2100327
