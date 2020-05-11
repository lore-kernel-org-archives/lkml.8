Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EFAC38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265C92184D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589165229;
	bh=FDKtUnOQ3qIeGS0KtMK0l6lFpy1aHBPs2Ihinmou1Ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wcfpCMDIr8WowSxm7D8JLOj2nTWjYFlEAgTykAjesgwMYSjSmEOdg0U9SJIoAebXO
	 fWO16AdHlGqDTXBNycGES+uvtfJ7jaVj42HjecV/ZKD6jmGQnkFk37KWaiPHfDwKdG
	 D4K55h4/raTyFEOhDbgBwgskfXuxbyL7qm52tcgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgEKCrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 22:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgEKCrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:47:08 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (c-67-180-217-166.hsd1.ca.comcast.net [67.180.217.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6434B2137B;
        Mon, 11 May 2020 02:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589165227;
        bh=FDKtUnOQ3qIeGS0KtMK0l6lFpy1aHBPs2Ihinmou1Ak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wKP/0Hpi1SXbKWsvBIudbmbNfb2BoLIYPl0qlQICVmmlTalOfyCVLY0F/d2rqVMmr
         PdFooKWT90ikdzAPx5dneEc3vRUc7WpQVxVFRHkUltO0Ki08HJ9AMXA5Y6upU4T7oT
         /7g+gxPHvIi1unXv8TWmC67WvAaKovZ3kXdzbPOM=
Date:   Sun, 10 May 2020 19:47:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     tanhuazhong <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH net-next 3/5] net: hns3: provide .get_cmdq_stat
 interface for the client
Message-ID: <20200510194705.0082267b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1b76cac7-b1cc-cbab-cef4-cefeaa25ac62@huawei.com>
References: <1589016461-10130-1-git-send-email-tanhuazhong@huawei.com>
        <1589016461-10130-4-git-send-email-tanhuazhong@huawei.com>
        <20200509134816.534860ab@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <1b76cac7-b1cc-cbab-cef4-cefeaa25ac62@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 08:13:06 +0800 tanhuazhong wrote:
> On 2020/5/10 4:48, Jakub Kicinski wrote:
> > On Sat, 9 May 2020 17:27:39 +0800 Huazhong Tan wrote:  
> >> diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> >> index 5602bf2..7506cab 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> >> +++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> >> @@ -552,6 +552,7 @@ struct hnae3_ae_ops {
> >>   	int (*set_vf_mac)(struct hnae3_handle *handle, int vf, u8 *p);
> >>   	int (*get_module_eeprom)(struct hnae3_handle *handle, u32 offset,
> >>   				 u32 len, u8 *data);
> >> +	bool (*get_cmdq_stat)(struct hnae3_handle *handle);
> >>   };  
> > 
> > I don't see anything in this series using this new interface, why is it
> > added now?
> 
> This interface is needed by the roce client, whose patch will be
> upstreamed to the rdma tree, it is other branch. So we provide this 
> interface previously, then the rdma guy will upstream their patch later,
> maybe linux-5.8-rc*.

Understood. Please make sure to include this kind of information in the
cover letter in the future.
