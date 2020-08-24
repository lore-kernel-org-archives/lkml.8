Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC260C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DDEC2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHA8P/9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHXHWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHXHWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:22:09 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E4AC061573;
        Mon, 24 Aug 2020 00:22:09 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s1so7614525iot.10;
        Mon, 24 Aug 2020 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wURU5CfyuxeoiAiYavrkiUF7W5jzEOVatHlGY5b9gAQ=;
        b=KHA8P/9ihR89353Mtkzi/vVjvBcx53K3IXfueYKDlkg/QsU4ejz37+W1Qkr21BTuQO
         uarEanWspS+m4mrc29EEHBFYViYwC5LcntKr+HX+TIxj8zSJTTZUooZQAmzo2OkULEkF
         HaT4zLagzVpbGGTGXsNK2hyJKh4tIQVaQlxbJiojEhP5LTVoygt34t2J/bv1ZUap4Ijd
         isKG8e8XNwf5bStU8wTnS5FwC5rE+1twCqB7acg5rSvMgHM/Et+m7INu/s4GpmVhqJpK
         7nO57UAhsUlXHiYbXd57ywY6/Ag0kzdytffxOH6dFjqWG9McB95EfT7JBk9fcKXcvimQ
         aK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wURU5CfyuxeoiAiYavrkiUF7W5jzEOVatHlGY5b9gAQ=;
        b=JIXaAqKOlM6i68JdqsTQIpNhUvBvmX6qRr2bclETeMJp+hD9TKTPwRAqvHDjCYl47Z
         lNFSh3qQrZNOGWhI9iMcx15Z/4iP2H3YcPxIJH6d0Z/W67goJOtsQHP1x5V/AtQFcKfe
         BIkcDqqntYFMGdckLVqpYTsBb7NMZ6l8jakaHqbERzk+VYm1CdyE28J/ID3Cv0JOk/+B
         wiOPbHNTisRoywTNh1nQgH5vPpqaMqXtHxOX+UAZJGuJ2xf778EsxNS9GaG/q7DO2zL6
         VDxHPNBOT0nfhPZpIo30pM8xCk3sjY+p4KEyV/FXVxML1TOMfyDz0Ej2lVH5uQAMSJBj
         Qn/A==
X-Gm-Message-State: AOAM531ePh/WZV+Az08nVICzVsOjFHHhMIdQH5kCs45s0npTEqvsIMfp
        Ty0zg4y3XLEHDoAfuCRA9AZQzS4ZEVOtj1ibAoM=
X-Google-Smtp-Source: ABdhPJyIuC2hH0bMEkHUPoarTiWp84gpsTAg9EGOmVfRzmTGMZ8A+G1fLCxwQ3GK4nI52FU0ZMjkUMBCMELoFMhkp5k=
X-Received: by 2002:a05:6638:1489:: with SMTP id j9mr4514597jak.22.1598253728521;
 Mon, 24 Aug 2020 00:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597910022-22617-3-git-send-email-gene.chen.richtek@gmail.com> <20200820113015.GB5854@sirena.org.uk>
In-Reply-To: <20200820113015.GB5854@sirena.org.uk>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 24 Aug 2020 15:21:57 +0800
Message-ID: <CAE+NS36C0AwbrFJdYGY6_n_g3DVitp_e1GfZUxjMbKu1bJ_t4w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] regulator: mt6360: Add DT binding documentation
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Gene Chen <gene_chen@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=8A=95

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8820=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:30=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Aug 20, 2020 at 03:53:42PM +0800, Gene Chen wrote:
>
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6360-regulator
> > +
> > +  LDO_VIN3-supply:
> > +    description: Input supply phandle(s) for LDO3
> > +
>
> Only LDO3 needs a supply?

LDO_VIN1/LDO_VIN2 is real MT6360 pin supply from VSYS to LDO1/2/3/5
LDO_VIN3 is also real pin supply from BUCK2 to LDO6/7
