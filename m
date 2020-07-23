Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7C9C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B9820792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595543754;
	bh=FXS3WNs034HEwKFaTlLZA6ilyGyWGmu5EJNCgAeeSZo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Txl0guTVCTLGPuo3aipSsPtKaSgD0GNDhRlHuh+0TmPcAUljlZTB4jeI0uOWRieoQ
	 3emxYzF/GUENtQpFDnT8hnG+yFuvgiWwcdWH1kYnWq9MXUTVWFNBqxexW8MPCBaXbp
	 uwF2x1S/ylfihEWUhHpeEhN4p181oA1nQIaMfn04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgGWWfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgGWWfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:35:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED924206E3;
        Thu, 23 Jul 2020 22:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595543753;
        bh=FXS3WNs034HEwKFaTlLZA6ilyGyWGmu5EJNCgAeeSZo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hEaizzbp/KyCXnnaUhUvCrZ/qqgyLLVZvKfB236oW3Qis2tfho6m2H4U0mOP4QnBz
         zvDxTHcOnuTl8wPwqDDjZbMCp+bRzKcSpJvAEKJOusQMDS8TRNOeXSa/mlLiQ+88Mj
         BpxQ3Subjx70yTrPgFqwsD5cvHag9QlQZca6Lx+0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
Subject: Re: [PATCH v2 0/3] clk: zynqmp: Add firmware specific clock flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        linux-clk@vger.kernel.org, m.tretter@pengutronix.de,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        mturquette@baylibre.com, sboyd@codeaurora.org
Date:   Thu, 23 Jul 2020 15:35:52 -0700
Message-ID: <159554375224.3847286.3288318925600777669@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Sunil Dhamne (2020-07-21 23:55:29)
> This series adds supports for firmware specific flags. These include
> - Common Flags
> - Divider Flags
> - Mux Flags
>=20
> The intent is to remove firmware's dependency on CCF flag values by having
> firmware specific flags with independent values.
>=20
> Currently firmware is maintaining CCF specific flags and provides to
> CCF as it is. But CCF flag numbers may change and that shouldn't mean
> that the firmware needs to change. The firmware should have its own
> 'flag number space' that is distinct from the common clk framework's
> 'flag number space'. So use firmware specific clock flags in ZynqMP
> clock driver instead of CCF flags.
>=20

Thanks for doing this work. Please resend with fixes.
