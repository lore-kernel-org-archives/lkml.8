Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9B1C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 06:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7CD2078E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 06:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588658545;
	bh=mHW4r+z5ME9GbpfaANcBlWQb58VId3ZnpjQEFfElIFg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=gzj0HzMjRcHOU0TFI0rd0Y7xv9Be+wRN32aAXlMjCGvnaMz/Q6mzZ2EX1b5w8b65B
	 +RjhywNxh1XOuTJnAuidzSg1NDxIV1ejD62vAdzlmM1QFAyVsf0OMUvGwwKLpXU8eM
	 NV69lSVNphwqGBonmpGsFaTgQ++bkgsMwlZJ5a84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgEEGCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 02:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEGCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 02:02:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58487206A5;
        Tue,  5 May 2020 06:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588658544;
        bh=mHW4r+z5ME9GbpfaANcBlWQb58VId3ZnpjQEFfElIFg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FghUYy6fUEIwgKHVbNHFOiA7hCEUKjIjjUXNrNlafI8cCJnIk4MFDcURZJX8hcCmO
         1NMiizk7XVf9MdOGIwffoFRX4Rz3jn73rhCvqdMptqtrsYAz8LA6szT9R7aoK/L1e2
         ISeI0cOFzr3XSVlSEaJkblShi8Nam/lMYxsU7Us4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1588207921-20604-1-git-send-email-Anson.Huang@nxp.com>
References: <1588207921-20604-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V4 1/5] dt-bindings: clock: Convert i.MX6Q clock to json-schema
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Mon, 04 May 2020 23:02:23 -0700
Message-ID: <158865854354.11125.10611865219975766594@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-04-29 17:51:57)
> Convert the i.MX6Q clock binding to DT schema format using json-schema.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Please send a cover letter next time. Who is going to apply these
patches? I hope Rob? If you need an acked-by feel free to have mine!

Acked-by: Stephen Boyd <sboyd@kernel.org>
