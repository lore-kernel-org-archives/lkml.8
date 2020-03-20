Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106BEC43333
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99D120752
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584747230;
	bh=Dg5xxHZhZvwd4PpSo/Az4o/X+gBJlPIXP/xpvh9yBAg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=JrWiM93C1sZcPggFPYLuDYevnDYRfi4UM6iB8xGtNDXZew9dpjLrEa53Pew6EL04e
	 9jtba79oHhqz3KjZhIDCNgEYroxHIORnwp0patfFDnXWjz82ZHxQ1/w5mrC/MlGwxR
	 XXFgxnvqTQWmPUqzKSx6kdRtfDWXZ14DPL71qSKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgCTXdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTXdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:33:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2411920714;
        Fri, 20 Mar 2020 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584747229;
        bh=Dg5xxHZhZvwd4PpSo/Az4o/X+gBJlPIXP/xpvh9yBAg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UBt1+4JI0dQfs6NJK9LAZ/EeW4nDhqnMJ/X70zgWaBRx9Q4c5m/06LeoVmjT+WIGd
         mev9V/HdZz5SoB3XiN6/kOJtSUFCYC9mIUqidFZESO3L7E9QhPWl/jkbOa5SugnOrz
         CuwNb/tPQxhZoBmGYmerqsI1fd25QBprIiQ1B0wI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584478412-7798-2-git-send-email-wcheng@codeaurora.org>
References: <1584478412-7798-1-git-send-email-wcheng@codeaurora.org> <1584478412-7798-2-git-send-email-wcheng@codeaurora.org>
Subject: Re: [PATCH v2 1/2] clk: qcom: gcc: Add USB3 PIPE clock and GDSC for SM8150
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Wesley Cheng <wcheng@codeaurora.org>
To:     Wesley Cheng <wcheng@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Fri, 20 Mar 2020 16:33:48 -0700
Message-ID: <158474722840.125146.9426954203327777812@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wesley Cheng (2020-03-17 13:53:31)
> This adds the USB3 PIPE clock and GDSC structures, so
> that the USB driver can vote for these resources to be
> enabled/disabled when required.  Both are needed for SS
> and HS USB paths to operate properly.  The GDSC will
> allow the USB system to be brought out of reset, while
> the PIPE clock is needed for data transactions between
> the PHY and controller.
>=20
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
