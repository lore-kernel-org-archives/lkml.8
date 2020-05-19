Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC49C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE43B20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q3xaH0fI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgESNEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgESNEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:04:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1F0C08C5C1;
        Tue, 19 May 2020 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xyUUBMDp/yPzpjXP9Mh1OqRXlTKNbtsFB+Ht8CJXThk=; b=q3xaH0fIap3G7Vh4kCuzxaUFxJ
        DgHuQiPuQbHFd2EpZXA3VLQsoE+STa2V3vAq06JH1dPoYQ5Ew0iimEYOXrX+/ixEJBWvaF5sNMZDN
        obxQ+GjJGyjwhv1gQOei9MsEmhRzIyfkQ+DLcrYczOj9vjJBUXfnX5Id8fRf7ofBMZzGiBnrNzFOD
        VJ7xUXpbGCpmoxgtqumIvqXmZ93bswbCHFoYz1jIr2FRMGq3EXu5cWW5YDcBcLdWTBrvSHp9i9Y3w
        J1it2pfoOt8sEFicXkcqkHDjAU+wVGnthh528zXrSSnaqfrNOL/079ezeylw+ucttrAXQAu/VKtsv
        hLg8L2kA==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb1tx-0003ts-JX; Tue, 19 May 2020 13:03:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: add a new ->ndo_tunnel_ctl method to avoid a few set_fs calls v2
Date:   Tue, 19 May 2020 15:03:10 +0200
Message-Id: <20200519130319.1464195-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

both the ipv4 and ipv6 code have an ioctl each that can be used to create
a tunnel using code that doesn't live in the core kernel or ipv6 module.
Currently they call ioctls on the tunnel devices to create these, for
which the code needs to override the address limit, which is a "feature"
I plan to get rid of.

Instead this patchset adds a new ->ndo_tunnel_ctl that can be used for
the tunnel configuration using struct ip_tunnel_parm.  The method is
either invoked from a helper that does the uaccess and can be wired up
as ndo_do_ioctl method, or directly from the magic IPV4/6 ioctls that
create tunnels with kernel space arguments.

Changes since v2:
 - properly propagate errors in ipip6_tunnel_prl_ctl
