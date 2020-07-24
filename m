Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269A4C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EEF206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595621624;
	bh=QdW716oqd4ZZMAuzDOfgUPJ3O7hhaN+UsitTZAlDNbA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=dlPyDSLw/Z4uHeB+F3mhBukYZxUAlz0FptGi6Msp59w88b+KuQrMEs2Lkc/X2BcFB
	 MnZFvXO+OuDX1m1bUn+KJ+b+BueNq6su5PP1bzxWBCAJxi3v4f6tu0tE/R2ANh0qM5
	 zg1BANSUA/KcbS7/OQqKpGHL7S7MW2xQnXCEVEgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgGXUNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgGXUNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:13:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C24206D7;
        Fri, 24 Jul 2020 20:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595621621;
        bh=QdW716oqd4ZZMAuzDOfgUPJ3O7hhaN+UsitTZAlDNbA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=niDmBN2Svthaa6mrmDqFyuu9MQCsCsL6rPOzmpAX7amOO57cCmCha7HCMcmsPzD5D
         sSeyw/gq0Q4qx9yPM062qp/MLCHhGckIVt+wW9qpqfxp6UcnJ5aMhkWhOCTxtG6L8L
         4udaLR69xuYVGYB8uxaMYRyu9+S+ZD5xgQCAn+zA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595606878-2664-2-git-send-email-tdas@codeaurora.org>
References: <1595606878-2664-1-git-send-email-tdas@codeaurora.org> <1595606878-2664-2-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v5 1/4] clk: qcom: gdsc: Add support to enable retention of GSDCR
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
Date:   Fri, 24 Jul 2020 13:13:40 -0700
Message-ID: <159562162063.3847286.2084727376544285288@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2020-07-24 09:07:55)
> Add support for the RETAIN_FF_ENABLE feature which enables the
> usage of retention registers. These registers maintain their
> state after disabling and re-enabling a GDSC.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next
