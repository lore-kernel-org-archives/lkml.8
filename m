Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432B9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D24D22B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596226336;
	bh=EhrrdpqzRlMqderwCUpQuhd4442YcoK1M2tYDp0DwME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sD5Y7x9ArZS4FPZT+zciYjKsJn+hXlxVK4vh0rVnE/LVf+t/B615J/oNrL5/pITp5
	 RFfNAIzu/76xaPzAWLHQWhQ03QpLlQGUHslQI8MP9THfvTFUxDkEgFgvIJFP78HuEV
	 ZWTTDy0H3PY1vB6REKqLSzY+qRyRcptJ//BatbvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgGaUMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgGaUMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:12:14 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02350208E4;
        Fri, 31 Jul 2020 20:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596226334;
        bh=EhrrdpqzRlMqderwCUpQuhd4442YcoK1M2tYDp0DwME=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dpffQQNN21UiGm7BEMDF2pyFH//ffzU+6Btr9NmTXB7As7Wbw26U8Xz2Amtgliamf
         P2wDJLPq2m2dDvbWcNavZ10r7cdwh/HNzVtCHaXYUHDN0S7wXqlr14UDLwr17Ut+Ew
         4HbgWHSF3Ffa2RTsO7kt6d90+t1Oqium/O04kSYg=
Date:   Fri, 31 Jul 2020 13:12:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Florinel Iordache <florinel.iordache@nxp.com>
Cc:     madalin.bucur@nxp.com, davem@davemloft.net, netdev@vger.kernel.org,
        Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 5/5] fsl/fman: fix eth hash table allocation
Message-ID: <20200731131212.16a7d2dc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1596192562-7629-6-git-send-email-florinel.iordache@nxp.com>
References: <1596192562-7629-1-git-send-email-florinel.iordache@nxp.com>
        <1596192562-7629-6-git-send-email-florinel.iordache@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 13:49:22 +0300 Florinel Iordache wrote:
> Fixes: 57ba4c9b56d8 ("fsl/fman: Add FMan MAC support")
> 
> Signed-off-by: Florinel Iordache <florinel.iordache@nxp.com>

Please repost without the empty lines between these tags.
