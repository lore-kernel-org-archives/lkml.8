Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B95EC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0939B20870
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584632812;
	bh=YXtJWeRR6Vovu/W2MX39oIxMBSo5ZQ0F3zeEfbi6qaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZauDTbzu7s9crC45e3SwKTOQZJnnb2RnhNWsmLrloOlg94pDuQO460zXXEzjk+o1x
	 8lVgGH5cJfWAqnR1NGK8BzIeGLeKyNsV75oucsDi4Ezg3JeudVw8nFM/YnIn2x5s76
	 C7VDq4/89Z3GDPSHgKmm3MoxiDlwQzebWyEkv+Ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgCSPqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727619AbgCSPqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:46:50 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39D021924;
        Thu, 19 Mar 2020 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584632809;
        bh=YXtJWeRR6Vovu/W2MX39oIxMBSo5ZQ0F3zeEfbi6qaQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HEarTHnydTLvUXh7rMgmQSRm893OK/5bu3axioBkVGQ3M5vQ53iN6GRVsJrq/FmhA
         pZeIT4HEpRKPw2pdkBguEaDcSWoAl2Gq5MRNmUJLb382GPvqY9eLxFSaLtN92mv9H8
         WyNfgRKQuCKKgT80y5zGaKRmGJ5cqwmE/JqyIyak=
Received: by mail-yb1-f169.google.com with SMTP id l17so519072ybq.10;
        Thu, 19 Mar 2020 08:46:49 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1X6rGc7qE3EkarjedFDUrvlHIMgMRf+noMyUofsVoUq43/moBT
        LuopU06mReqoJBzLR3Cx6yXDPkRh1bK+Lwqmbw==
X-Google-Smtp-Source: ADFU+vtd+SPJ7TSQgni57vrZn7xEo4wgYma5Cj6dlM0fP50Nbgkx5pq2oThg9Le7uMFlq2bBxqeOEDl7QeYH0eoLYKk=
X-Received: by 2002:a25:f08:: with SMTP id 8mr5301607ybp.377.1584632808916;
 Thu, 19 Mar 2020 08:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWqDJ7AccvoxjKfQJ3GytJ-+u56Bk3rEn0sSYv-zCuBe1brAg@mail.gmail.com>
In-Reply-To: <CAGWqDJ7AccvoxjKfQJ3GytJ-+u56Bk3rEn0sSYv-zCuBe1brAg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Mar 2020 09:46:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLz-0myc-PSSaCQWDFXQx+=X9nBSXWsJaGCVqTFn0d5kw@mail.gmail.com>
Message-ID: <CAL_JsqLz-0myc-PSSaCQWDFXQx+=X9nBSXWsJaGCVqTFn0d5kw@mail.gmail.com>
Subject: Re: graph connection to node is not bidirectional kernel-5.6.0-rc6
To:     Vinay Simha B N <simhavcs@gmail.com>
Cc:     "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 1:31 AM Vinay Simha B N <simhavcs@gmail.com> wrote:
>
> hi,
>
> I am getting the endpoint' is not bidirectional(d2l_in, dsi0_out)
> warning in compilation, built boot image works on qcom apq8016-ifc6309
> board with the dsi->bridge->lvds panel.
> Because of this warning i cannot create a .yaml documentation examples.
> Please suggest.
>
> tc_bridge: bridge@f {

             ^^^^^^^^

> arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi:253.28-255.9: Warning
> (graph_endpoint): /soc/i2c@78b8000/bridge@39/ports/port@0/endpoint:

                                     ^^^^^^^^^

Looks like you have 2 different bridges.

Rob
