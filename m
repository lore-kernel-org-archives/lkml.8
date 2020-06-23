Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB12C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C390B20771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592877712;
	bh=YzDKYDIlil3ExhFuDnietiwBuRbbsWjAWVordl67v6k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=sC/Rp1kNiFVZ/7tP90v6tP7SEJrX8Ot+aBrDGuDrtDFLmJNNU+h4xDBQfbh1dt/+k
	 uGa4o9tIaipchauDPb+/DyZKfv/UW+nhCANuOE84NB9PxeLuW/SAba3puyevZAfTFO
	 bJAkhTYSKEgobdJef2Zjs4lito4QtWrbwZRaNEyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgFWCBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgFWCBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:01:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38F422075A;
        Tue, 23 Jun 2020 02:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592877708;
        bh=YzDKYDIlil3ExhFuDnietiwBuRbbsWjAWVordl67v6k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cQmaa5tqrk4d2OeYSRQw6nTIUBssJWNRSnsfqjqptds2eAcv9T0ndOC4CSNNMfL4i
         YVBd/KfSiRxVgGnNw5NmjJeSv5Q9/1hOSVGwKoTttrVhkPXBSeySY/vYVvvhRcZRue
         Fg5tYlScxu2oDVAlaY66nfluX9JUoWNYJzI2eP2U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200613072745.1249003-3-vincent.knecht@mailoo.org>
References: <20200613072745.1249003-1-vincent.knecht@mailoo.org> <20200613072745.1249003-3-vincent.knecht@mailoo.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: clock: rpmcc: Document MSM8936 compatible
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     konradybcio@gmail.com, Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Date:   Mon, 22 Jun 2020 19:01:47 -0700
Message-ID: <159287770758.62212.605826105750963168@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vincent Knecht (2020-06-13 00:27:43)
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---

Applied to clk-next
