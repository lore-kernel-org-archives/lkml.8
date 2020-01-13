Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDECEC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAA720661
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578923203;
	bh=AIlrTSnZ1J1BYZeDE/zgmZ4IXahNEVbk9lgMh1AEQ7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yZq5W5q51BBKK7/9iAi49+kqRxJvrTeKdfIAAzk3IO/V+H5Au7Nymn48dZKv/ib8X
	 T4cXAJPyhtHQO5hJrCdXTpXQ/EwNDRShydbYgKOz8ZLThzPnd+SNKPv5s+F9oSYCvY
	 qkQSRLDT+E7av0OwxGbmHcQ372GhLT0O2czowjSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgAMNqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:46:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAMNqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:46:42 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C3D21556;
        Mon, 13 Jan 2020 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578923202;
        bh=AIlrTSnZ1J1BYZeDE/zgmZ4IXahNEVbk9lgMh1AEQ7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iuAnG+CuflajR1/NGCyzA+4OgWdGpK3JBRoW8i3KxcgXNDqf9Araj+ScJo6ZeOjjT
         ToxoD9QgrlII2z7n3Hm7SMXMKF36MPInnWtwtpDLa2NsPpMtB1H9dT9mt/EKuNq5Z+
         kUI3gsWP6kXyJfteOQcIJNHfn36dpPu35Nr5/ljs=
Received: by mail-qv1-f42.google.com with SMTP id n8so3978800qvg.11;
        Mon, 13 Jan 2020 05:46:41 -0800 (PST)
X-Gm-Message-State: APjAAAV7DtlWb1lfK2/kPKNLyY5PFq0LGhIoWZspvrEIaYZOLh57gCe2
        qIhs+iVySQHVCFDzCBiIygIBwx7BQEvIdZiQBA==
X-Google-Smtp-Source: APXvYqyIYYc2t9K2miXG3KyEWH3O5mjcXutnn4DUpikq6B35lTbFFyOCnIJ1ccg69kvCPXEd2zULH+m1JMCJtqyImI8=
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr15327544qvo.20.1578923201111;
 Mon, 13 Jan 2020 05:46:41 -0800 (PST)
MIME-Version: 1.0
References: <20191230090419.137141-1-enric.balletbo@collabora.com> <20191230090419.137141-2-enric.balletbo@collabora.com>
In-Reply-To: <20191230090419.137141-2-enric.balletbo@collabora.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Jan 2020 07:46:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLHWa9n167xn+aPFVDvcFLNZpNvWVkrJ15v1WnTtYBLWg@mail.gmail.com>
Message-ID: <CAL_JsqLHWa9n167xn+aPFVDvcFLNZpNvWVkrJ15v1WnTtYBLWg@mail.gmail.com>
Subject: Re: [PATCH v24 1/2] Documentation: bridge: Add documentation for
 ps8640 DT properties
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ulrich Hecht <uli@fpond.eu>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 3:04 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> From: Jitao Shi <jitao.shi@mediatek.com>
>
> Add documentation for DT properties supported by
> ps8640 DSI-eDP converter.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Ulrich Hecht <uli@fpond.eu>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> I maintained the ack from Rob Herring and the review from Philipp
> because in essence the only thing I did is migrate to YAML format and
> check that no errors are reported via dtbs_check. Just let me know if
> you're not agree.

Reviewed-by: Rob Herring <robh@kernel.org>
