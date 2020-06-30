Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE29C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B07320675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593529390;
	bh=ceHbzSs/83Q0ypQpLthZOqO3wxthaDHFWyXQesdsgMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KSN7qIU/SZroZHaI7GKkbX/f58SaCCT0fxc7fAiZrEUv+oefZLVarkUJr0OHlct7V
	 RiN/wZPG0mRC/Alx+AxMYzevz+SKCexrGC5zRkejqRndtzGqJvCSeZ1s0NAYkXDhqG
	 YwNmdD8TQpVXscONNa063O9sHoe23TnsHVKbhmkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbgF3PDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgF3PDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:03:07 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA4420760;
        Tue, 30 Jun 2020 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593529387;
        bh=ceHbzSs/83Q0ypQpLthZOqO3wxthaDHFWyXQesdsgMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vSZCwLsH+iMDz+MY2ZIRHPYWOElmC9SiQwdulXDlcnREmiBTNzfVhBttXdzuzKWBg
         7u7Xuk1mZ+UqHwT+a8LNyz6TxCXbq9vXQqqi71gFAPGzzrMlZChGXmGQq9K61VNI0e
         LIaUhSTF7+YBSX+O4ncc3LvKdw/VsOeIuz+tuBfQ=
Received: by mail-ot1-f41.google.com with SMTP id w17so10784678otl.4;
        Tue, 30 Jun 2020 08:03:07 -0700 (PDT)
X-Gm-Message-State: AOAM530yQ0P2b59zthZ5SVz4xZSr1yBRt0gu0kqYNOx8ILX0CVU+2eIR
        4RmLO0WjVT/sed4Le8zurVKf9xAYsUM6TfK+tQ==
X-Google-Smtp-Source: ABdhPJyHn4l+/NwndAftXaakjpZXbV5I8NVV011dKEXXnSASflFpNbhUdHbUP5sgV9PUY1KbAY0JtpII44wCyclZ4uk=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr18421643ots.192.1593529386559;
 Tue, 30 Jun 2020 08:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200630121804.27887-1-festevam@gmail.com> <20200630144130.GA572716@bogus>
In-Reply-To: <20200630144130.GA572716@bogus>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 30 Jun 2020 09:02:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJq7rBcCsrTTpeFHpbHZm2Z1TRB3vYcR5iqSj7E9=dtig@mail.gmail.com>
Message-ID: <CAL_JsqJq7rBcCsrTTpeFHpbHZm2Z1TRB3vYcR5iqSj7E9=dtig@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: Remove soc unit address
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 8:41 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 30 Jun 2020 09:18:04 -0300, Fabio Estevam wrote:
> > Remove the soc unit address to fix the following warning seen with
> > 'make dt_binding_check':
> >
> > Documentation/devicetree/bindings/thermal/thermal-sensor.example.dts:22.20-49.11: Warning (unit_address_vs_reg): /example-0/soc@0: node has a unit name, but no reg or ranges property
> >
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/thermal/thermal-sensor.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Applied, thanks!

thermal-zones.yaml had the same warning, so I added a fix for it to this.

Rob
