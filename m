Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17420C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66E920780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592877584;
	bh=aclJpifwCB+SOaC8bKBEjlmHV5cHiAR0Ph4IBBeICTE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=C0fD+XHisfgTXOLYoDRpg7+yKBWBkoeJ0z9qVYU2i2Bp0bNu3An4rsG8lFG35fZf7
	 cc0KhFnIYbgTON1gW9H2lQVr5dBxyZHgDWUub8oSZHfRcInxVRPYuRPeiCdmFLOztg
	 thu5JqqCPtXvpIO2/5NxkhtAUnNeG470mT4sBlqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbgFWB7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732069AbgFWB7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:59:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E622075A;
        Tue, 23 Jun 2020 01:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592877557;
        bh=aclJpifwCB+SOaC8bKBEjlmHV5cHiAR0Ph4IBBeICTE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FUJEgBHEzMyUUT4fhXvOKgPLRUGJE7cAo7PdAr+TsVqgzFtLkT/RZD0g5wGTkixNu
         VCKcbfwALk/YbRO5NW7iZm1sIyPMA10GFpBZ/YVMrmBgZ7tyK4pO3mzjeIHbwYrgqL
         fdytbyV3XibJEOA90ia3uEhuJVgztLGqoFRq7T6M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200622090252.36568-1-konradybcio@gmail.com>
References: <20200622090252.36568-1-konradybcio@gmail.com>
Subject: Re: [PATCH v3 1/1] clk: qcom: smd: Add support for SDM660 rpm clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konradybcio@gmail.com>, skrzynka@konradybcio.pl
Date:   Mon, 22 Jun 2020 18:59:16 -0700
Message-ID: <159287755633.62212.14680448845942613971@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2020-06-22 02:02:52)
> Add rpm smd clocks, PMIC and bus clocks which are required on
> SDM630/660 (and APQ variants) for clients to vote on.
>=20
> changes since v2:
> - separate from SDM630 enablement series
> - fix indentation in Docs
> - sort compatible strings alphabetically
> - drop an accidental newline
>=20
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---

Applied to clk-next
