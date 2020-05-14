Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BB2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE3F207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589421027;
	bh=BpNNBdk7gNLybbEEWzgw5zIGbVURf44ZrdrXwXHHVe4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=etoQFPvwI3ufWPGe63XEUMvf/ljYDHE6ptWiVL0w9ORrcMrzQmBPNpj4ZhnCBmbGy
	 MvsdMy0w95C+BYvWecdPWDKSGKQFNIs0GSKv0EkuvJSErz2J2zPU+HWr+TqTrKBpWK
	 cT6JafV8IENMEqudSSV4RLIuCWcrwmFR7fgTOZ5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgENBu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENBu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:50:26 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAD220575;
        Thu, 14 May 2020 01:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589421026;
        bh=BpNNBdk7gNLybbEEWzgw5zIGbVURf44ZrdrXwXHHVe4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dcLcIQw8bFXeEItlckcT41rvhg9OEIyjgQSun1P5JibqqkvGD8pYAwu9TnJmttHsb
         jmVg13G131/qM0u9tndfhaPu08Xdpfou+hYJy3VtJMhMkBBe2IdtLCPNIXR1Garj9Y
         ZL+9Rioj/fIcawNIurMeMPft0u/NFUFsPyx6y6UQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1588863647-17240-3-git-send-email-akashast@codeaurora.org>
References: <1588863647-17240-1-git-send-email-akashast@codeaurora.org> <1588863647-17240-3-git-send-email-akashast@codeaurora.org>
Subject: Re: [PATCH V6 2/3] dt-bindings: geni-se: Add interconnect binding for GENI QUP
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        rojay@codeaurora.org, skakit@codeaurora.org, mka@chromium.org,
        Akash Asthana <akashast@codeaurora.org>
To:     Akash Asthana <akashast@codeaurora.org>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Date:   Wed, 13 May 2020 18:50:25 -0700
Message-ID: <158942102514.215346.10346039963897349342@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akash Asthana (2020-05-07 08:00:46)
> Add documentation for the interconnect and interconnect-names properties
> for the GENI QUP.
>=20
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
