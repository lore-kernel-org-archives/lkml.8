Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B2CC18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628F824654
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583792472;
	bh=fB+OB5JMO91xNFO2ErYSLu7hsT/WKGFiqmNUM9GBC9g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=MWwWCjFHmbs2u4uY6e15GA88MV44ybeqnbnU1PGWP0ob3VHcNXfeBwJpLtl8E23y7
	 HjvzutEJUlTfm6kJby1s/TIoL6SDAFp+Sdy2hLE8MydEWmasBu/luLxw0zrTEQ9Xdf
	 yLSqgUH5FuQQZ7hfvAjYIWBLhadauCB2tP20S6ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgCIWVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgCIWVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:21:10 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9DE924654;
        Mon,  9 Mar 2020 22:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583792470;
        bh=fB+OB5JMO91xNFO2ErYSLu7hsT/WKGFiqmNUM9GBC9g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=1F8ignM+0ogiKJqtZtlfHfkkLn3Y43FZJYXmvxRV2iOjpcFQNflNtHa5wJlS8PCcD
         +A33b8WvDt8F/4N0dz0nU4ybNmPu4YLApxyKDcXwpZpRsMdBdGjULezWiHCLGR549O
         CSB/Hu0fvDXKScQFIWhcY8B/PHRqf/2uthshHTWU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200224045003.3783838-4-vkoul@kernel.org>
References: <20200224045003.3783838-1-vkoul@kernel.org> <20200224045003.3783838-4-vkoul@kernel.org>
Subject: Re: [PATCH v4 3/5] clk: qcom: clk-alpha-pll: Add support for controlling Lucid PLLs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        jshriram@codeaurora.org, vnkgutta@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Date:   Mon, 09 Mar 2020 15:21:09 -0700
Message-ID: <158379246921.66766.10563302645797643035@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2020-02-23 20:50:01)
> From: Taniya Das <tdas@codeaurora.org>
>=20
> Add programming sequence support for managing the Lucid PLLs.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Applied to clk-next
