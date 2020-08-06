Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C40C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56526206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735917;
	bh=h9yr92Fex5ltfMP+qZOHpzmYyhnDbgztEcO9IPRg14o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q7n/B6Z9z/n6PcS72iXn9fyv3Q5MEj9tlSNiRkBFMMJGKC/ZuYAZTfdCJ2jZl09Lg
	 ipKycoSh8VEtxGRGkNNNmyDHT/Qp8zI2ohdzpKdoHDi61RNX/UWqODB0BJz2jo+FLY
	 nvPYz3YnwuR/uIPtu9+juBvsp+dXhpBqEqF7Hi+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgHFRpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbgHFRbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:31:16 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1461623128;
        Thu,  6 Aug 2020 14:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596723354;
        bh=h9yr92Fex5ltfMP+qZOHpzmYyhnDbgztEcO9IPRg14o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SQDMiQDH41Bduy8zoYbVAfI1ioXwch+Hw8pNUzKqCX2MjAD2ryIr5Gl8Ixh5iSDGF
         hzbKHCaBI82bn+gUycQq5cVNgIHMjRL/jLOD/6Nvabu7cFfTYtBxRAlfrvBst0NzEr
         TdnUI0Ffg11czHV29VkAyY6GqIDi43LPD7H3JqL8=
Received: by mail-oi1-f181.google.com with SMTP id a24so22463317oia.6;
        Thu, 06 Aug 2020 07:15:53 -0700 (PDT)
X-Gm-Message-State: AOAM532lI08zG8zLUVbGfN/KshGLOClfA9MXa/abph4tWBHvPgwfFX/5
        W9MeNwKUGtJpgILszFJKKDCUUEH/FeIYiv788Q==
X-Google-Smtp-Source: ABdhPJxA2Sjm3IZPFJP0zjMdosn8kZNNtfiDvPae0/2S8FhdH5gX0PWIZLExsEmKzhoQ6UqOVM42ZrqnCy1Ja5rnJmA=
X-Received: by 2002:aca:c3d8:: with SMTP id t207mr7387578oif.152.1596723353187;
 Thu, 06 Aug 2020 07:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200805110052.2655487-1-daniel@0x0f.com> <20200805110052.2655487-2-daniel@0x0f.com>
In-Reply-To: <20200805110052.2655487-2-daniel@0x0f.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 6 Aug 2020 08:15:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5YWe71HU+bSMG2uNZOgFN85x4zatuiS-fkUYKXHDs-w@mail.gmail.com>
Message-ID: <CAL_JsqK5YWe71HU+bSMG2uNZOgFN85x4zatuiS-fkUYKXHDs-w@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt: bindings: interrupt-controller: Add binding
 description for msc313-intc
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 5:01 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Adds a YAML description of the binding for the msc313-intc.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  .../mstar,msc313-intc.yaml                    | 79 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mstar,msc313-intc.yaml

Why are you sending another version? You ignored the errors and my
questions on the RFC.

Rob
