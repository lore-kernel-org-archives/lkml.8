Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2DAC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7B1214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iaX6O7by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgEKL7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727873AbgEKL7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:59:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94920C061A0C;
        Mon, 11 May 2020 04:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=SBf0hRimtjxfXg/+tqPJXUmTdL9VMuETwuhGn4tAjtU=; b=iaX6O7byLSGdYyJk5tbIBXbMNQ
        Rt+NTuGeGsefJxapCgRt7waNJ+IACfm5dF2d7mt9pP3tfSGI/cD/TZ3CjT232IgxS9D3UPMvcYOKL
        kYoisqChBoxs9bvzICHKYh0pwZHeo3Xz3eyJ0LJyvJ1zypRLL8wrZsnnCqpT6oAwkGWT+8QhEzX3q
        Mbd09MY6x8OnP+Q0oVol4jLdF+O9ic39eIkKegsgXM77NHGfc93ktGBP97WKBpLCzrS1c38s+J5th
        hFSfWah9MAv/5vEav/bPh1TNizl+o2h13QQAKzAsFGgp3mOwFg8ql5B5KxcShsWUYRfaH4djmTMWx
        DknqhEtQ==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY75Y-0007Sx-0o; Mon, 11 May 2020 11:59:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: improve msg_control kernel vs user pointer handling
Date:   Mon, 11 May 2020 13:59:10 +0200
Message-Id: <20200511115913.1420836-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

this series replace the msg_control in the kernel msghdr structure
with an anonymous union and separate fields for kernel vs user
pointers.  In addition to helping a bit with type safety and reducing
sparse warnings, this also allows to remove the set_fs() in
kernel_recvmsg, helping with an eventual entire removal of set_fs().
