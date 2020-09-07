Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1BCC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3757221556
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599511131;
	bh=CQ2rh3UwBAj+NLRlOiFRdPT2kD9jlx5l+PaStBfsA0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=I4uNv/OCG5ue87t7igFtBUGLn9TzKwOORRKJ/0Ii8e63iWIRzxrfWwQl/9cqeWCLo
	 GPHuR0O2RK4dLP1mqAXnRo2NIhCJKVFfvxBys9YoMXH8Vz+Kdc0W3c3hTM+8eBlWuH
	 wd/bMX8BJr7OqZpGLmyxytZBYPvMG596BPByppTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgIGUit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgIGUir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:38:47 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2174021556;
        Mon,  7 Sep 2020 20:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599511124;
        bh=CQ2rh3UwBAj+NLRlOiFRdPT2kD9jlx5l+PaStBfsA0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RfxVjjIrzFib8T0Z9FhjEKtsLm0Eq4R8jD2XMofu79VCZKIi63SprE71AOmM9fnfF
         BmQrO9WQ6kJGBdRJ8Z7KSIqymjVoprp2SG1amAK5AuFiH6hzWctTlU84UaUUboblfR
         wJ27mrCoRIPoX37YYDSRqHc9pbr5nMKfWo+APmSg=
Date:   Mon, 7 Sep 2020 13:38:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
        <joabreu@synopsys.com>, <davem@davemloft.net>,
        <mcoquelin.stm32@gmail.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ethernet: dwmac: remove redundant null
 check before clk_disable_unprepare()
Message-ID: <20200907133842.762cb362@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1599482814-42552-1-git-send-email-zhangchangzhong@huawei.com>
References: <1599482814-42552-1-git-send-email-zhangchangzhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 20:46:54 +0800 Zhang Changzhong wrote:
> Because clk_prepare_enable() and clk_disable_unprepare() already checked
> NULL clock parameter, so the additional checks are unnecessary, just
> remove them.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

Applied.
