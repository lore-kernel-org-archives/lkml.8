Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6E7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B905420734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lqL7UlTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbgFIRKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgFIRKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:10:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED61C05BD1E;
        Tue,  9 Jun 2020 10:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=A1K/cxGGsTS842CwLaEcetTi7toHGKjgenADvZJMNHc=; b=lqL7UlTQLMvR6Y5lKy2n6whoBV
        j2eaKSKvpPc1ThpI1nkn0AmPXkUk1plyqGmLqZCDoK0xt0G0dASoScelwhYXAelNPDDFXBYTulE0n
        nG0cHlWJmHBPn972+yaFwy2hZvxKJPE8TVtlpnXZDX2WtkGZoS0YfWWiqdYWHlS5JDajq0hZG7H3z
        RnsGk9RkRDW1kztsy+BspP59wvndVGNrCJvx1B0kXTc/U/L4jiis/MaCQiCxrDZhyNsdCr7vxloJ/
        sqgUvuYTfBjC/6uyZFPgA4Mdt0MdluChEG+5XfmgiyNy3QMTepbD1SeG4dWuC3fG7E8e3hOUApbKi
        GjDBkZCg==;
Received: from 213-225-38-56.nat.highway.a1.net ([213.225.38.56] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jihlg-0006yp-8v; Tue, 09 Jun 2020 17:10:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: two more fixes for sysctl
Date:   Tue,  9 Jun 2020 19:08:17 +0200
Message-Id: <20200609170819.52353-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

two more fixes for the kernel pointers in the sysctl handlers.
