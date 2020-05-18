Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C76C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B054420756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozieOzdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgEROnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgEROnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:43:50 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD13C061A0C;
        Mon, 18 May 2020 07:43:50 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x27so8161961lfg.9;
        Mon, 18 May 2020 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyWQUbdQsaHneMIkUnV+0Uk+0v8VHubO0aOYCQH2OTE=;
        b=ozieOzdt8X9dRrNZ2ZBFb/NJ0RGMHbQ3G0pKcrAI4K8deYDIHTwEHkizIvfUP2PJf3
         0jgF4HQmgdaYp1xOhtyN3xLe0Ntm40NsHOIxwe56JxpTa30T4cZvOVlwDhOFBXDOGate
         Wpenob7UAHBnLuJQ/4BT8tbW1BTo9qk//+WZ1zsA50SUULGQ7H9xeU9IKiQfCwOB+6jq
         qWuBcMqRn9aVcwpJRUSyfmr2db/NuDRbd1ElsaN/e8NsTaPFme/pjzrcBfrmW0ZESFoh
         ia6R8Yrf92SS6WwoRdKM+mBeNbDJFizblaBIIi/dWxeEZbpJHHWknoLXa7chPAl+QRsr
         o9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyWQUbdQsaHneMIkUnV+0Uk+0v8VHubO0aOYCQH2OTE=;
        b=K1bCv8TT+DcDU1dW1O0p0zlW9xQrwxoVt2cJSoKL3p+ntW1YrMYPQIRvVj3bxZrgWO
         7TLr/7PIXWulpFMqJF0P3aKmDY5NnH+9yQCOENkm5Qw5XYQmf+BQXXmnVLq6sFFVywBr
         KrSOyp4UGTP63Ohh/32Q+11WmL4iLVIcrY296b0DZicGw0e19ueJ4x2x2ssRy+4x40Im
         3Zzh/zKs7URhjOPxsGdjvVVDyKeY6xZQ0nc7pPMtXHO77A/V42R6Sk3lcaXNqbB4AdSA
         DVNxWhtPFbV7tzwMPkrQAesMWXJarviyOlRN6rdn1P6zIFbUujPuRvdH4nOZU/876XTU
         yVig==
X-Gm-Message-State: AOAM532wEhQisodktmxy2MNsOFPJkskDQ4IGm8ZBnlmBqCdzdzE4jY3i
        qrPYz05m0bf6dT8bXzX5WzD2k+9LhBNW8CKV7MHrzlqV
X-Google-Smtp-Source: ABdhPJzqZ8nVo/dLSyrZUSSg9UbXrWgh7ZRtGhpGbCTSwOmErjkT5zwNhl9/wuvY2EmNrcCww0AbHYRzQN6W515PhCs=
X-Received: by 2002:a19:c6c2:: with SMTP id w185mr10282694lff.69.1589813028498;
 Mon, 18 May 2020 07:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <1589810819-19851-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589810819-19851-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 May 2020 11:45:07 -0300
Message-ID: <CAOMZO5BeBcvmAwEJTUhHSn=_chx7OVkkxj2oB+50hGH-7H7SfA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: Convert i.MX7D clock to json-schema
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Frank Li <Frank.Li@freescale.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:16 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> +maintainers:
> +  - Frank Li <Frank.Li@freescale.com>

The freescale.com e-mail domain is no longer valid for quite some time :-)
