Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3308DC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 23:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12325215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 23:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587770609;
	bh=RjkafEpEUlQYwXmiRYMLYyVW1y9J3/I8SnW+sAOLIww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y2oiKo6Ffuf5YFaOESlxTv+0jy2oeRHXJHlTgLkNqPADt0OCFon614jBLZcYeifIP
	 OcRpfBPGIhA7N3crAx5BgEICU+gRQHHJsJy+JJD+SR1yUrQ3i5TEwewwx116WA3foH
	 kPF3/BADISCxRNimqvQS+GIT59mpOEBZqHWP9hqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDXXX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 19:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDXXX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 19:23:27 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31F0A214AF;
        Fri, 24 Apr 2020 23:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587770607;
        bh=RjkafEpEUlQYwXmiRYMLYyVW1y9J3/I8SnW+sAOLIww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HV8jmH/SAcHEHgDgQ60/GA2j/puMEj3tRbY/nBniFWjKcxufSx8NbpB7kOUd8Q80A
         i9w7c0QTzGN5M7+vTOFOfz+uEvLkPc0zCFXC/lRaw8+/zpC7/3+C2g7++l5tAecg7A
         owDeZ7Z1dveUZF4X/UAmHjUdDpDmxuqy30YW7WvY=
Date:   Fri, 24 Apr 2020 16:23:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH net-next 0/8] net: hns3: refactor for MAC table
Message-ID: <20200424162325.4547ce9c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1587694993-25183-1-git-send-email-tanhuazhong@huawei.com>
References: <1587694993-25183-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 10:23:05 +0800 Huazhong Tan wrote:
> This patchset refactors the MAC table management, configure
> the MAC address asynchronously, instead of synchronously.
> Base on this change, it also refines the handle of promisc
> mode and filter table entries restoring after reset.

Looks like in patch 2 you could also remove the check if allocated_size
is NULL if there is only once caller ;) But that's a nit, series seems
okay:

Acked-by: Jakub Kicinski <kuba@kernel.org>
