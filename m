Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A00C4345C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1962A2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595580767;
	bh=a3/DWCpH16BgRgmfSbq0YYuwUHCL7wFOBB29bWbEJIM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=HAqCO9o+81pw8olJpOUr0E3wi27LcWTW9HINAD3WyNxShpRo6SQyXxVXvZ3ZQlGNC
	 BFETmTY4ZCF+Ud4x70RE31MiXsmVGS1oJzxzFkjr1gRSCGJR+IysllBJE68XAVMqIj
	 SfLiZ+95HcFD2JzEbECr/wLyNa+qPg1h06Yb/riQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgGXIwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgGXIwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:52:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77111206EB;
        Fri, 24 Jul 2020 08:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595580762;
        bh=a3/DWCpH16BgRgmfSbq0YYuwUHCL7wFOBB29bWbEJIM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=2n9zayygvXgznRjo4PkR4n+tmvM4A2DMD8GSlFos0NDiPFhkQqXrShSxOkVrOv+SR
         NMAe22MdgDPRZts912yUDlO8Yg9JTV6uKeExNy92vIjO2ApIYDAtSkaEYoEBvHbO9E
         D3rhcJOCrrwkNFAuN1EbN2uOuGvqIW2fpWQURA+E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200709135251.643-10-jonathan@marek.ca>
References: <20200709135251.643-1-jonathan@marek.ca> <20200709135251.643-10-jonathan@marek.ca>
Subject: Re: [PATCH v3 09/14] clk: qcom: add common gdsc_gx_do_nothing_enable for gpucc drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Date:   Fri, 24 Jul 2020 01:52:41 -0700
Message-ID: <159558076183.3847286.7546727654493572761@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Marek (2020-07-09 06:52:40)
> All gpucc drivers need this, so move it to common code instead of
> duplicating it in every gpucc driver.
>=20
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---

Applied to clk-next
