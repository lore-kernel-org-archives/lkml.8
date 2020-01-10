Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD40BC33CA1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 00:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B98D2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 00:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578615096;
	bh=HnztBjmskstand/RfAIgiAHl0q2mo/wn6eRKdeRgq3E=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=hhatzSIz/013cPijbErjjcZPyHuHS9tsTkiV5pQOW5thk+IySwb7kZEswJGfvakpO
	 HH8QdA357n59BdL5kU7gEQE1LHI5Q8TRdywIR/h1YiNhUJltmVFecDc23Z7Qs3oLPr
	 5nWtFcPbxlCfHgXJBkoVgYCcFUeh5/NRTr0sASS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgAJALf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 19:11:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbgAJALe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 19:11:34 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34F7D2080D;
        Fri, 10 Jan 2020 00:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578615094;
        bh=HnztBjmskstand/RfAIgiAHl0q2mo/wn6eRKdeRgq3E=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=CfqgDIvcWpmD48zb7YuFygpJ1LbtVHkw8K0ytYoO1+DBGtO6HBpFFcJDwsgqsVKB1
         zHnQQjwtNi/5+tHLvTR2WMH01eqFptb31zwKB86JTlO+HBViY8anCa+Jkaafia6CLV
         ZnZBbrH9gdDh/kR+ndqdfR+gz807H4UYm+AFodKI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1578557121-423-2-git-send-email-sricharan@codeaurora.org>
References: <1578557121-423-1-git-send-email-sricharan@codeaurora.org> <1578557121-423-2-git-send-email-sricharan@codeaurora.org>
Cc:     Anusha Canchi Ramachandra Rao <anusharao@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: Re: [PATCH V2 1/2] clk: qcom: Add DT bindings for ipq6018 gcc clock controller
To:     agross@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, robh+dt@kernel.org,
        sivaprak@codeaurora.org, sricharan@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 09 Jan 2020 16:11:33 -0800
Message-Id: <20200110001134.34F7D2080D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sricharan R (2020-01-09 00:05:20)
> Add the compatible strings and the include file for ipq6018
> gcc clock controller.
>=20
> Co-developed-by: Anusha Canchi Ramachandra Rao <anusharao@codeaurora.org>
> Signed-off-by: Anusha Canchi Ramachandra Rao <anusharao@codeaurora.org>
> Co-developed-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> Co-developed-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---

Applied to clk-next

