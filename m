Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4ADC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1823420759
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599601290;
	bh=yqVXwTfivLiGaQNirAdsTNu0RrcFPS4TRluVtIzQWlI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=kJ4DijbGgQVcuMa1/wx2g8SdrPECYdpEuQd/5nZo0kezGCY2cM7TObYMukX5A98h0
	 HB81Bwr9ziM1ngaz2+DNxSENF9oaWCkRHra/MMWm73HgCYYpkG4zSL1nn76IXlBvpN
	 OknAu8NO70WLean3jYzN7FcIPAqYvNJKEmeC5W+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgIHVl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgIHVl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:41:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B66620759;
        Tue,  8 Sep 2020 21:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599601287;
        bh=yqVXwTfivLiGaQNirAdsTNu0RrcFPS4TRluVtIzQWlI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cIc2Y5rhPerVJiX8+oMEoSaPRWckEKKETETUBg9tlWzgKIbls/dfOM/H9fBaS7oF7
         5/m92B9F46BE/2cYyP59+iCZqbUyxfAR8rmzCiE6W0hRrr9hRpQ8l4KW0JJb8CLLYP
         U3PxBwsTg5Iqa9avLvIy3XmJDchr0UaXaOC9HHWU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1599584848-15530-1-git-send-email-tdas@codeaurora.org>
References: <1599584848-15530-1-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v1 0/3] Add Camera clock controller driver for SC7180
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Tue, 08 Sep 2020 14:41:26 -0700
Message-ID: <159960128642.454335.17145528250119232852@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2020-09-08 10:07:25)
> [v1]
>  * Add support for Agera PLL which is used in the camera clock controller.
>=20
>  * Add driver support for camera clock controller for SC7180 and also
>    update device tree bindings for the various clocks supported in the
>    clock controller.

I got duplicate patches in my inbox. Is something broken on the
codeaurora server?
