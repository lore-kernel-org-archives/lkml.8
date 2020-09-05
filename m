Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907DEC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 04:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F70520FC3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 04:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599281158;
	bh=P71JIuBpNVAWVRxC3rdyBsjfpwWdabCDxHnWCmuOKB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mHMGSNOGS16OcXRYqi9y5YlFSx0mUSG4AUdYguNGfTahfm1IUNI1xXtZh2H7S6GFT
	 Qsx3WxI0ZgeJvV2uozvgovll0Xe93B65UBgOT8P/VK2LaPUXbgf+8VXg7V/LAFeULG
	 h38ap+8/QrWtRFmnMydJ1GGiUQCltAAYmzR5k3ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIEEpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 00:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgIEEps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 00:45:48 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADB342078E;
        Sat,  5 Sep 2020 04:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599281148;
        bh=P71JIuBpNVAWVRxC3rdyBsjfpwWdabCDxHnWCmuOKB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HpjOFV/aclMHzR0gTmYgRpMkAitMEWm1lV0GizFJcWb+UiVNEv0U/LbsnjUlaazNL
         SdNFurXR33mcJ3H4wiqFIMXqsq+6PAxWuCmrZFnBl0ac5sABee0raZtLvtD+kuQNss
         j6zPbTfdh3fxhG0uDHt6omM4ZDv+PNpQgHWCDiLc=
Date:   Fri, 4 Sep 2020 21:45:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     <3chas3@gmail.com>, <davem@davemloft.net>,
        <linux-atm-general@lists.sourceforge.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] atm: eni: fix the missed pci_disable_device() for
 eni_init_one()
Message-ID: <20200904214545.58b4815c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200904025103.39405-1-jingxiangfeng@huawei.com>
References: <20200904025103.39405-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 10:51:03 +0800 Jing Xiangfeng wrote:
> eni_init_one() misses to call pci_disable_device() in an error path.
> Jump to err_disable to fix it.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Please make sure you add appropriate fixes tags, here:

Fixes: ede58ef28e10 ("atm: remove deprecated use of pci api")

Thank you.

Applied.
