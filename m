Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F27C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C35207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597815913;
	bh=eVtrxuXADlL5Xym0lAYGOL7VWEWqBRHeMGfJMlcARAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y22UYEZdOU3yyUvT01v8kTu+2LgkPCohv730IQAttmIzZUQSDZtqouUlQcnANaTcU
	 dx0tK4wOiYkqwJg9QuX9+8cPO0ELJPzv5GIXhgCHo2JAwLWc503j+GKgZh2pOehXZH
	 VGVklwPnp0/ZZbcm3bC9D8Wr74FfRFmbe8yH1QuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHSFpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 01:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgHSFpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 01:45:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C726620772;
        Wed, 19 Aug 2020 05:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597815911;
        bh=eVtrxuXADlL5Xym0lAYGOL7VWEWqBRHeMGfJMlcARAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLWXsam6cHBNNFOqFLQQPC4nPoRdhdlMtJNDorAxuzdnSE8VaBGjUtOZ+ZBdCkhuO
         4bowmFnb5r3YkJvc/Xyxaf3TgkeysZbL7C3UFRt9HOi+R3jQPi0GkmVRTMPseYBGU0
         NJLVKUVUTWiPVYysPuBjj7E4hjySJ19rGvDo/0xI=
Date:   Wed, 19 Aug 2020 07:45:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 073/168] media: firewire: Using uninitialized values
 in node_probe()
Message-ID: <20200819054534.GA846396@kroah.com>
References: <20200817143733.692105228@linuxfoundation.org>
 <20200817143737.355562192@linuxfoundation.org>
 <20200818213453.GB25182@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818213453.GB25182@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:34:53PM +0200, Pavel Machek wrote:
> Hi!
> 
> > From: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > [ Upstream commit 2505a210fc126599013aec2be741df20aaacc490 ]
> > 
> > If fw_csr_string() returns -ENOENT, then "name" is uninitialized.  So
> > then the "strlen(model_names[i]) <= name_len" is true because strlen()
> > is unsigned and -ENOENT is type promoted to a very high positive value.
> > Then the "strncmp(name, model_names[i], name_len)" uses uninitialized
> > data because "name" is uninitialized.
> 
> This causes memory leak, AFAICT.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

Again, this is not how to submit patches, and you know this.

You are one more email-like-this away from my circular-file filter...

greg k-h
