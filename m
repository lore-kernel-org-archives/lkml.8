Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5E4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831E1207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590548624;
	bh=m7G8bVXPasOMaR++DJe7lZii49I9nD8Tb7YpUdfuhJI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=p/sSDvKKEYnAF+N644ccAOxk/026DLPKxMrnm9uXtuSFPzUhUYikaJQ7XxDTqbqi/
	 +hGi1h8SWC/7BPO1xTig6rEKQecjBg6YUZegPQbF6T3JPIlzi2paz2PsK+/dpj5tZi
	 51GLZitLoRQoEigMSa0xRt4yfcalNlmJthCCQSh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgE0DDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgE0DDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:03:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E84FC2075F;
        Wed, 27 May 2020 03:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590548623;
        bh=m7G8bVXPasOMaR++DJe7lZii49I9nD8Tb7YpUdfuhJI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oI/iQpeZGHI2zMqqxOvFK1+97dhtZX3g0tJZoVNEY/83dGBY3y4xmqOA5hujBoDFY
         zoVEdWRYQzD7NM7FY6igMstuFT2jMKbqgrcmAw7JUoGCrQpOliQZkgtEBtfp6PYcjN
         VewcAlvwSbqLGiD9lKY9DqG+9a67LRJ8uCJAsAuM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200512224522.GA13463@bogus>
References: <20200501223232.275800-1-konradybcio@gmail.com> <20200501223232.275800-5-konradybcio@gmail.com> <20200512224522.GA13463@bogus>
Subject: Re: [PATCH 4/4] dt-bindings: soc: qcom: Document MSM8936 SMD RPM compatible
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
To:     Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh@kernel.org>
Date:   Tue, 26 May 2020 20:03:42 -0700
Message-ID: <159054862230.88029.9004999082945050815@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2020-05-12 15:45:22)
> On Sat,  2 May 2020 00:32:32 +0200, Konrad Dybcio wrote:
> > From: Vincent Knecht <vincent.knecht@mailoo.org>
> >=20
> > Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> > ---
> >  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
>=20
> Acked-by: Rob Herring <robh@kernel.org>

I picked these ones up actually, not the other ones, but my MUA totally
failed to open anything because the patches weren't sent To: anyone. O
well!
