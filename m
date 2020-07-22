Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB23C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259322071A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595452190;
	bh=7LxwAvjr8ykq8ESG6suR3QKwh18PwBgx8Y7xnBV7/hs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sUHvqAhkp0Xl+JlrNjpgWd5uVGwpEppCzuF9ljym1iBMcmJodHftM+nc1s4hVtkdz
	 nZJq0Uk2KuLUFuLhSdX3PZo844zJb1PhPV/4Qy5fLYnoR9H3ovD+eVC+JGgLV049QD
	 JkDNjoHGsTw1uvFZEOF/GVjjiV4o6ypMHmRO2ZLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgGVVJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgGVVJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:09:46 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54BDF2086A;
        Wed, 22 Jul 2020 21:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595452186;
        bh=7LxwAvjr8ykq8ESG6suR3QKwh18PwBgx8Y7xnBV7/hs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=suNn+PZj5fXe3Gk34BuYQFeHTRZ9KNKGknllkaDzFoQLSIDuX9kY6bE0q1+Dw/O4O
         gwlmDyngGssu26cfWbrzqXY1o1qdyjK9Jj1sdEB+ReZq9VpuJiIRgjocIZShgvFegn
         AYKg/4f63L9J1VFuM3mdtfActYYdVGvL7iF1w7IY=
Received: by mail-oi1-f180.google.com with SMTP id t198so3101832oie.7;
        Wed, 22 Jul 2020 14:09:46 -0700 (PDT)
X-Gm-Message-State: AOAM533ekqIKxxBTR//ouHXb11CCJWndc+khyFdSMtOFFrlLsT3DPZ4c
        86AIuc2/duBOis833/P+n868w5BeO7btIy8wQQ==
X-Google-Smtp-Source: ABdhPJwfp+YAPCsJA3I/xtWn07xTJ1BfmZsmccfovGvP27cA7yRNxB3h+jbY64ZV41q+fYrIU+sxvx1jQhqudMqqZYo=
X-Received: by 2002:a05:6808:3d8:: with SMTP id o24mr1316793oie.69.1595452185706;
 Wed, 22 Jul 2020 14:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200722201313.754671-1-saravanak@google.com> <20200722201313.754671-2-saravanak@google.com>
In-Reply-To: <20200722201313.754671-2-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 22 Jul 2020 15:09:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJvhpghE=LR=ng-gL5ek-7LOC1CGfOx6Vr-iACu-TX_fQ@mail.gmail.com>
Message-ID: <CAL_JsqJvhpghE=LR=ng-gL5ek-7LOC1CGfOx6Vr-iACu-TX_fQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] of: property: Add device link support for
 pinctrl-0 through pinctrl-8
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 2:13 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Add support for pinctrl-0 through pinctrl-8 explicitly instead of trying
> to add support for pinctrl-%d properties.
>
> Of all the pinctrl-* properties in dts files (20322), only 47% (9531)
> are pinctrl-%d properties. Of all the pinctrl-%d properties, 99.5%
> (9486) are made up of pinctrl-[0-2].
>
> Trying to parse all pinctrl-* properties and checking for pinctrl-%d is
> unnecessarily complicated. So, just add support for pinctrl-[0-8] for
> now. In the unlikely event we ever exceed pinctrl-8, we can come back
> and improve this.

It wasn't immediately clear from this that pinctrl-8 is the current
max you found vs. a should be enough for a while.

Pinctrl is also a bit special in that we have 100s of child nodes and
only 1 to a few actual dependencies (the pinctrl node). I assume in
the end here, it's just the pin controller node that's the dependency
rather than creating lot's of dependencies?

Rob
