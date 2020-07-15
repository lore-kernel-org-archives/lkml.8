Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C29EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565E02065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594828096;
	bh=DytEPzCFC0cofVJ96OBN2N2dqiXbOIjH5qes3BR/x78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tWXhv/5ttBJuO2EXkrYy4SyOk6/f7rvhjHTm1gDtwALv1dmUTKoXp3U/fEOv5VWyD
	 /NSUYuUaz9oeR+NUgiDqybS+ZlBtViDjrFrIpId3G6Tvo1C1uZN+epE+DfD/GTKdSb
	 EZcilOIbqXfgDtzCPO91YxuerLZbKEKzezkfcYRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGOPsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgGOPsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:48:13 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7469A2065E;
        Wed, 15 Jul 2020 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594828093;
        bh=DytEPzCFC0cofVJ96OBN2N2dqiXbOIjH5qes3BR/x78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TvvkQqp+WWVi2SH86ripOr7Pjwm4HvK1l0VFU4l6GUmjKhv+M50eUovxzBu3NEWSo
         iLTSkAxVw2TWQRHPNiVmVKF4/vrJrVjJf+IvYG3sVhKNc70g5mJm8vmnouKjEiyfoQ
         GifCWMpVqLumO+6z0tVgnFuRX4R86X95eds6DTIw=
Date:   Wed, 15 Jul 2020 08:48:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        johannes@sipsolutions.net
Subject: Re: [PATCH 01/13 net-next] net: nl80211.h: drop duplicate words in
 comments
Message-ID: <20200715084811.01ba7ffd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200715025914.28091-1-rdunlap@infradead.org>
References: <20200715025914.28091-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 19:59:02 -0700 Randy Dunlap wrote:
> Drop doubled words in several comments.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org

Hi Randy, the WiFi stuff goes through Johannes's mac80211 tree.

Would you mind splitting those 5 patches out to a separate series and
sending to him?
