Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2351C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF812071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594860595;
	bh=xtI9o2lqHt5Ccrnbi17Hnwy+IYNicxUrMPOA/qoreVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GxAc1AZ7HXf+HJ3Yg/0+uapJJilpZA2OPoJHP6jbASp1FIpnCDY2ahOStssfXw1Ci
	 JHtBA8A6tgxJR8/cTYMc0SgKoBcu73UISOAfcKIi9blonl8koyxqwiU01ktuCUzcpj
	 5ZsiZ1FOEIm2Nhhn6IwAEf8sPHu9wxo3vb6cpVlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgGPAty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPAty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:49:54 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 995B320714;
        Thu, 16 Jul 2020 00:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594860593;
        bh=xtI9o2lqHt5Ccrnbi17Hnwy+IYNicxUrMPOA/qoreVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AfMKIgbJ+kGK6ru9hOKz+UxF9xVNm3URi6D128F+AlNu8jGMrG6Nghy7/+obPEoiM
         +F52eXereqYeNgk+c3CEKCWQNC0Va0u/gGTcR9AdDgWPP3R9Ou0P2Wic5fWa8jRhkq
         NwpgE2PFzoO4HzYzupQ4dupVdmFpngyse61td1P8=
Date:   Wed, 15 Jul 2020 17:49:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, davem@davemloft.net,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: annotate 'the_virtio_vsock' RCU pointer
Message-ID: <20200715174951.0c4e5bca@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200715143446.kfl3zb4vwkk4ic4r@steredhat>
References: <20200710121243.120096-1-sgarzare@redhat.com>
        <20200713065423-mutt-send-email-mst@kernel.org>
        <20200715143446.kfl3zb4vwkk4ic4r@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 16:34:46 +0200 Stefano Garzarella wrote:
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > who's merging this? Dave?  
> 
> I think so, but I forgot the 'net' tag :-(
> 
> I'll wait to see if Dave will queue this, otherwise I'll resend with
> the 'net' tag.

Applied to net now, thanks!
