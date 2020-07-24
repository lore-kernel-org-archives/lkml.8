Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A2AC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F1F20748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595580868;
	bh=/fGW0+JU15vhNIXUrvegCqIk2PWvLtJXsj5+AUanRxs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=zsELTJINX+Regy2PlChMegOBWNlNrX4TxS+Yhpv2plhn5+GQ6XmCIVFGQR68ROLKo
	 R4psUsxZ4/u76rXldeEfJAdTVFNvdVINuZrwdnz+2JCW42+U+q+ZjpT+LL0QBbGtps
	 RkDV0U0KLYP4LLDTBHgjLyWhIaSRpwxiDPnc4AAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGXIy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgGXIyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:54:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C71F206EB;
        Fri, 24 Jul 2020 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595580865;
        bh=/fGW0+JU15vhNIXUrvegCqIk2PWvLtJXsj5+AUanRxs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NGattO6LHvbIPVFFrOfMgjO+rKge8MglszLaaDZ2pwcn8diJl7HV9UgPuZl2ExstL
         ugM9iGiyk1DgBe+BhXkPCbjmdbRg+OktCSWFq9C2OmQu+haZHCrebg4e7TrmCZhBpu
         ceQ/MqXFe61CGmDhCfhxULA3h1Pja+sEL8UQbdBQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200612225212.124301-1-ray.jui@broadcom.com>
References: <20200612225212.124301-1-ray.jui@broadcom.com>
Subject: Re: [PATCH] clk: iproc: round clock rate to the closest
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Lori Hikichi <lhikichi@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <ray.jui@broadcom.com>
Date:   Fri, 24 Jul 2020 01:54:24 -0700
Message-ID: <159558086444.3847286.2352480301185397253@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ray Jui (2020-06-12 15:52:12)
> From: Lori Hikichi <lhikichi@broadcom.com>
>=20
> Change from 'DIV_ROUND_UP' to 'DIV_ROUND_CLOSEST' when calculating the
> clock divisor in the iProc ASIU clock driver to allow to get to the
> closest clock rate.
>=20
> Fixes: 5fe225c105fd ("clk: iproc: add initial common clock support")
> Signed-off-by: Lori Hikichi <lhikichi@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---

Applied to clk-next
