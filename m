Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891FBC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AC821655
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588973774;
	bh=K5R9WT/9E/N7mkbhsm6BFk5bbnSyq6jNBK74D+vDTHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fhy91DHv8E5yMsyn2hQdzdyniTJEVNJrBl7H6irEwU0jVRvZ84O4ckVkV8KsbeyoV
	 XrdLQ3zuKssDIqOrdjsF/aJ1NxDoPnCptj4kxf1PTQE8lN0iJvSe4h61prUPYzXdS7
	 YuYd/usvHJknuoQ7kyaCmlDXLUZwZJ2+GfN07gyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgEHVgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbgEHVgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:36:13 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 604C12051A;
        Fri,  8 May 2020 21:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588973772;
        bh=K5R9WT/9E/N7mkbhsm6BFk5bbnSyq6jNBK74D+vDTHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ot9kgaai/yY4qvM3le5pw9nnNB2U+J6+4fjKa+eGE8dsRhIDVCHHNiMpm5RqaEjqP
         74Ct77lwNuDnrGgvZD45RsNtONzSB1K0oDFN9XNjeajyGbXFC81EwFqoEX36vqiCzP
         qRWoMNY+DA2ndQVeP7UVpDbtgMZfxXOx6gzkGkuQ=
Date:   Fri, 8 May 2020 14:36:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
Subject: Re: [PATCH net-next v1] hinic: add three net_device_ops of vf
Message-ID: <20200508143606.65767cc5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200507182119.20494-1-luobin9@huawei.com>
References: <20200507182119.20494-1-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 18:21:19 +0000 Luo bin wrote:
> +	return hinic_msg_to_mgmt(&pfhwdev->pf_to_mgmt, HINIC_MOD_COMM,
> +				 HINIC_COMM_CMD_HWCTXT_SET,
> +				 &hw_ioctxt, sizeof(hw_ioctxt), NULL,
> +				 NULL, HINIC_MGMT_MSG_SYNC);
> +
> +	return 0;

Oh, well, I think there will be a v2 :)
