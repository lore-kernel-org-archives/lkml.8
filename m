Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896C0C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B2520768
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592878046;
	bh=Topq0nSm+ZfDtevszrQfQbKpVKHMXRgDg1d6bvqIr3s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=GOwVx7cPwmLDnMS/Mi9lCsG79OrhViSKsARoIo1GQca3yOalnT+IsFRGUw9IvDXYP
	 Mj0aHwqtI7TzFd3hwVFASQSuObiuCplt3VsJrOciLxxPO7cmk7O7cLjM0CYmekITGL
	 rnDZP2fNOZAg04+s1Aro7qpzfIgbExinty5tmLpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbgFWCHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730845AbgFWCHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:07:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79DE720720;
        Tue, 23 Jun 2020 02:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592878041;
        bh=Topq0nSm+ZfDtevszrQfQbKpVKHMXRgDg1d6bvqIr3s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Y8N5TSdUoRz9m6kgkHZgU+mMeGyxqHV1cEeKdCKbteuClhEtY2PNFqCNNoyB8yejK
         p4EmS+5lP5Uk+H0r7g+Qh9HNrakOWND8HemhOaH6MSVsUbIhNyW+rUEFmDNuIvWCiE
         04M/ZLTHx9dgmLyalf7EmwsGrobV2wDmldGj3N4Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200603154329.31579-2-aford173@gmail.com>
References: <20200603154329.31579-1-aford173@gmail.com> <20200603154329.31579-2-aford173@gmail.com>
Subject: Re: [PATCH V3 2/3] dt: Add additional option bindings for IDT VersaClock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Date:   Mon, 22 Jun 2020 19:07:20 -0700
Message-ID: <159287804088.62212.12096173329418216527@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Ford (2020-06-03 08:43:28)
> The VersaClock driver now supports some additional bindings to support
> child nodes which can configure optional settings like mode, voltage
> and slew.
>=20
> This patch updates the binding document to describe what is available
> in the driver.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
