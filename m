Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D475C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A25520857
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593017948;
	bh=+QLzWa9R9qN9FxhHozL3Pq3dhOGQ4gOItfeEArrS5+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IYFz7oTRe1N9cijbPZoLICBDBhQPe0JNbAFnfDMyCWe35Ehv7+WixID1SH73P0U0d
	 zwJF7vIndaVh0UMdfLB7/O/9XhA9a4HrYa/q3HOrDJBvIJjCsG1ZxUWhQwSvkcD9OV
	 Oj1bZPVhBd3xQ+SpQHehqUN+Ke90uhckZ0fUupRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405323AbgFXQ7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404796AbgFXQ7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:59:06 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E35520738;
        Wed, 24 Jun 2020 16:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593017945;
        bh=+QLzWa9R9qN9FxhHozL3Pq3dhOGQ4gOItfeEArrS5+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M7EO0Oa2tAuWUQQ4HrLCHt1tVRMpWu9sENgmQJkgSRpaR1MNvt8hmBJyXdLGu/v/q
         Q+TzpCdAF29Jxrl23coDDJ5vKHRN4tq3DgTaU39b/WLtbYXq7U73e1eRAVoy9kMTpr
         vI14CzqT1kRyQw7M9DJXAdVGSSUMxZmFVONa93fQ=
Date:   Wed, 24 Jun 2020 09:59:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Christian Benvenuti (benve)" <benve@cisco.com>
Cc:     Kaige Li <likaige@loongson.cn>, David Miller <davem@davemloft.net>,
        "_govind@gmx.com" <_govind@gmx.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lixuefeng@loongson.cn" <lixuefeng@loongson.cn>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>
Subject: Re: [PATCH RESEND] net/cisco: Fix a sleep-in-atomic-context bug in
 enic_init_affinity_hint()
Message-ID: <20200624095903.71a01271@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <BYAPR11MB37994715A3DD8259DF16A34DBA950@BYAPR11MB3799.namprd11.prod.outlook.com>
References: <20200623.143311.995885759487352025.davem@davemloft.net>
        <20200623.152626.2206118203643133195.davem@davemloft.net>
        <7533075e-0e8e-2fde-c8fa-72e2ea222176@loongson.cn>
        <20200623.202324.442008830004872069.davem@davemloft.net>
        <70519029-1cfa-5fce-52f3-cfb13bf00f7d@loongson.cn>
        <BYAPR11MB37994715A3DD8259DF16A34DBA950@BYAPR11MB3799.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 06:32:36 +0000 Christian Benvenuti (benve) wrote:
> We/Cisco will also look into it, hopefully a small code reorg will be sufficient.

Make sure you enable CONFIG_DEBUG_ATOMIC_SLEEP when you test.
