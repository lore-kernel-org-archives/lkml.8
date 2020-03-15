Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAB5C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7518520578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsMP5ZfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgCOPZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 11:25:11 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41555 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgCOPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:25:11 -0400
Received: by mail-il1-f194.google.com with SMTP id l14so13945871ilj.8;
        Sun, 15 Mar 2020 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oElHQLKFLOVtRHqu7xiZ6PSJACuRnWmCrjsIOT03/4=;
        b=RsMP5ZfF9Kle+rjBS3Bso6AHBFITrbE13HUp2ObAa4PaLpubX0IyO20urbKNQZ8QzO
         zyawLivUZMOXmEf4KS1gockamB5ifWcK8RDanr4T91XtPkH5uqz3rQkJuTN29cfWqPbo
         UetMtw8CUEnybaWElSX6cG1rLsDBv9M8fdTLj8NPJFE16pwbaVq9cVWA4uz7b76daa0o
         JOFelYtJ96GsHGmlh0CnSFIMH+ubQ4nER8Nckilais8GLUoMFOPtDNa0hT5zBIWZUkDE
         7TeitOReluipDTZmFIWdjKp9FiDr+lWqjIq0utvdsGanqMtRlVOq6xPtcmqtTp0FDcdD
         QTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oElHQLKFLOVtRHqu7xiZ6PSJACuRnWmCrjsIOT03/4=;
        b=Swtw7IwfnYlS0YRdoyUeCqZ1PTZJmek7FEIwdGAE21fviXzdZArH0txierQFwuYMRc
         60wE6RINAZN8FtsRaDWtD6gkdBv2e03CyomAnYzguw0shbqwzmvHuGs3QMQuBtJhQCIz
         RK1oSrvYZQaykzlY+s14ihhLppK11rSLbBUzhjEricvR27NIciv3XjORce7st9g18sp3
         uLIXIP6FZZr3niuhVLrfIVHzqAJN1uosuk2XYT8xPxaqvvKtH2flxNvznMfPtfZrsrma
         /ZBm5XtSA/OgxEFhg3Oxz5owAeLt1omQQCALioYSDpwxlBORGEfA97uKujTpXSeabvc5
         ZB2w==
X-Gm-Message-State: ANhLgQ0g5/RWH/41UwHrwom49gGvxpyv0jOkE1pGeQwR/f9/wLdggqW9
        ir7IjnPqemwKdB6wAl5l2EEZGkNRwEfzFj4oAcA=
X-Google-Smtp-Source: ADFU+vt9/0tLT5TMHQJuvt7jSFZQO9BbU2DRVErpzh0iupQQjp//EFou6F5rBpQO/z0gYMAYYRnt+hMR7/PR6UXiFmE=
X-Received: by 2002:a92:8f53:: with SMTP id j80mr17379957ild.171.1584285909944;
 Sun, 15 Mar 2020 08:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <1583920112-2680-1-git-send-email-simhavcs@gmail.com> <20200312151752.GA7490@bogus>
In-Reply-To: <20200312151752.GA7490@bogus>
From:   Vinay Simha B N <simhavcs@gmail.com>
Date:   Sun, 15 Mar 2020 20:54:58 +0530
Message-ID: <CAGWqDJ7DP3DuR7EWT6Ni8YxN3Adg3RgJZut6+AtpAak_HB=QCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-binding: Add DSI/LVDS tc358775 bridge bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rob,

i do not get the error when running 'make dt_binding_check' in my
build environment
Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml

is there any tool available similar to  scripts/checkpatch.pl -f
<file> , for yaml files?

On Thu, Mar 12, 2020 at 8:47 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 11 Mar 2020 15:18:24 +0530, Vinay Simha BN wrote:
> > Add yaml documentation for DSI/LVDS tc358775 bridge
> >
> > Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
> >
> > ---
> > v1:
> >  Initial version
> > ---
> >  .../bindings/display/bridge/toshiba-tc358775.yaml  | 174 +++++++++++++++++++++
> >  1 file changed, 174 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml:  while scanning for the next token
> found character that cannot start any token
>   in "<unicode string>", line 11, column 1
> Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> warning: no schema found in file: Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml: ignoring, error parsing file
> Makefile:1262: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> See https://patchwork.ozlabs.org/patch/1252753
> Please check and re-submit.



-- 
regards,
vinaysimha
