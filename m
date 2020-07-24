Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B5C433F8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D814F206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595621635;
	bh=PHKX/i3f4k8ffb/xXTAsj0LwmA1zrJM8g6gKwkKjYzw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=emdxfoGKTxPgFbLGNyRiTj96fxOGD19mlFzTvQEfvJjPoRXximkr9RUTQQ+sbMJpA
	 /rzUOnUUxTNGqcvB1FICjBb0tbqpk1ywur/PfhtF27f7FX30vlwTsILq+u7E5IMXS5
	 Q4E5JSPBaC04bXqqRrVQvzgonMWjo/GhmtPL91ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgGXUNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgGXUNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:13:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C012207DA;
        Fri, 24 Jul 2020 20:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595621632;
        bh=PHKX/i3f4k8ffb/xXTAsj0LwmA1zrJM8g6gKwkKjYzw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W/DCvo3vRyzl7lwOjeLl+FpFpmr89kQTfjzhvQEbltPnRXQf+4xjeMvI9c+YNmRbX
         +g9AkgmVVUtlagpa169VJ0v2IX+GJ6AXI7f6Zk6mObEMQ+HgV0UwP9qMM6ypahW7oo
         ousB+uJk1N3K95nWd1zBtEa4p9PxoVIVsa+Iercs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595606878-2664-5-git-send-email-tdas@codeaurora.org>
References: <1595606878-2664-1-git-send-email-tdas@codeaurora.org> <1595606878-2664-5-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v5 4/4] clk: qcom: lpass: Add support for LPASS clock controller for SC7180
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
Date:   Fri, 24 Jul 2020 13:13:51 -0700
Message-ID: <159562163196.3847286.2212028423369293010@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2020-07-24 09:07:58)
> The Low Power Audio subsystem clocks are required for Audio client
> to be able to request for the clocks and power domains.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next
