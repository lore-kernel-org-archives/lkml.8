Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6016AC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351EB205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1UzqDi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgCQGzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:55:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44904 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCQGzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:55:54 -0400
Received: by mail-io1-f66.google.com with SMTP id v3so9702442iot.11;
        Mon, 16 Mar 2020 23:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWR9GR9zXt7FMFLwHnM9DNzADB3xyA+rYdWNj2AqhMs=;
        b=I1UzqDi1CI7BgLIIpE9p97OJKAijExbglYmN6z+rzZ+aGvdTYh1gw27m8JTkITzPxT
         Rilz8tMl3pOmagIK5plERd6lxmTFAtxgBRCz41ZDo/k0lfz/7mO6m6k/4hYhut0HhyXd
         cDIA4BqZ+8+i3tYMVWtC8e7WgWFF2/7IPXft4JrXPm+SFW8cPUe2NSkyIwAPd0u0UZZs
         FTRYP2iMLHSLfQEAn+MqzefPVG7v4E+zNbzK6HlRzc1Qw9o/YnazXDt/JNuyO3jlPOWk
         RipUqhWIyVOhokA39kwlbbAcfJXbAuAtFEpF6dgFz8Q0irkAJoR/ui8mXoLWqo7me+7S
         +vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWR9GR9zXt7FMFLwHnM9DNzADB3xyA+rYdWNj2AqhMs=;
        b=Wh9ObjqheFVYDUIpoqszLPsdNQ7K1/Nly9V2TcCi/90WVYcSWHKkmtfbfln2D66RpC
         eftU35bOkIAgKhvERHzGW2d5ot5+fMf5+OvekUS+YGSDHRoLh17f7N6UMNxMxj1i/0zF
         uMOEDuqiqspccmC8uVBpRlOMR9kLhKRd2EefWKnTkMPvl3QerBCN1UhcZckmrWQFF5V0
         FhwUFUMTGu5TqNm+VQxvoRwe6NdPd89oaJuJ8EySPTm1tnYwwNSWcq7fijzJorDxc6+x
         Q4fccUsOf2lbLCDEx5CvracPm6vMOwm5lMY6VGblPSA/OkgM0fjKaWD9FhgG1DqPPVnH
         RIhQ==
X-Gm-Message-State: ANhLgQ03+GPy7rqmDwVuRcPx60bN1kQbTEWGfoM25/eSTRYmHorxIisM
        HBQ5Zl66HZVqORLYR/zF6bBI9o+uN0Ol0Aun00Q=
X-Google-Smtp-Source: ADFU+vsXQb/pFKtMWJ3JxvgCpZZOO72lwsnc1rP4K5qxjjSEXrdkUflkKDvQQlk2khti5gYEuUfJLY5cws3XT4bGDto=
X-Received: by 2002:a05:6638:f01:: with SMTP id h1mr3578763jas.36.1584428153800;
 Mon, 16 Mar 2020 23:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <1583920112-2680-1-git-send-email-simhavcs@gmail.com>
 <20200312151752.GA7490@bogus> <CAGWqDJ7DP3DuR7EWT6Ni8YxN3Adg3RgJZut6+AtpAak_HB=QCQ@mail.gmail.com>
In-Reply-To: <CAGWqDJ7DP3DuR7EWT6Ni8YxN3Adg3RgJZut6+AtpAak_HB=QCQ@mail.gmail.com>
From:   Vinay Simha B N <simhavcs@gmail.com>
Date:   Tue, 17 Mar 2020 12:25:42 +0530
Message-ID: <CAGWqDJ4cAU98_xMk6f-bsT5LF5cD2JJk8_JCykwM=cd6CCfWtw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-binding: Add DSI/LVDS tc358775 bridge bindings
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sam,

i need some inputs on the below  error. I had created this file
Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml
by using vim editor. Do we have any tool to create yaml file?

i do not get the error when running 'make dt_binding_check' in my
build environment
Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml

is there any tool available similar to  scripts/checkpatch.pl -f
<file> , for yaml files?

On Sun, Mar 15, 2020 at 8:54 PM Vinay Simha B N <simhavcs@gmail.com> wrote:
>
> rob,
>
> i do not get the error when running 'make dt_binding_check' in my
> build environment
> Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml
>
> is there any tool available similar to  scripts/checkpatch.pl -f
> <file> , for yaml files?
>
> On Thu, Mar 12, 2020 at 8:47 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, 11 Mar 2020 15:18:24 +0530, Vinay Simha BN wrote:
> > > Add yaml documentation for DSI/LVDS tc358775 bridge
> > >
> > > Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
> > >
> > > ---
> > > v1:
> > >  Initial version
> > > ---
> > >  .../bindings/display/bridge/toshiba-tc358775.yaml  | 174 +++++++++++++++++++++
> > >  1 file changed, 174 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml:  while scanning for the next token
> > found character that cannot start any token
> >   in "<unicode string>", line 11, column 1
> > Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.example.dts' failed
> > make[1]: *** [Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.example.dts] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > warning: no schema found in file: Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml: ignoring, error parsing file
> > Makefile:1262: recipe for target 'dt_binding_check' failed
> > make: *** [dt_binding_check] Error 2
> >
> > See https://patchwork.ozlabs.org/patch/1252753
> > Please check and re-submit.
>
>
>
> --
> regards,
> vinaysimha



-- 
regards,
vinaysimha
