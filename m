Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34833C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CA420735
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k4J2N/j3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406286AbgDNHD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406216AbgDNHCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:02:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6417DC0A3BE2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=77D1XXRWkuxqD9EgsqFvBl2GVjPwcFnlwZ4H5QeKf8g=; b=k4J2N/j3r3k8rtX6J9OJVuyI/B
        Y/lP14ZAwAwAT+sXF6iSJZ7ASkdNoGavrhLf4SxqyRpa2OOaUsmOzNdSgpuMsZdrrc4HvhlAEFo6b
        CCobuvFapWEVgmmPConT4NvC8iJNZsDtt7TmeAFbHEiIFxc4pOViS5uJuA9eKcZ1YLFo8rU1xATNc
        7jiVWmya/Lqbc2aONf6lZe3mQgKP2ol+a2aOWYinwhbJfGu2Bup5vo1BCn4zkThGhmyTPMs2dpbgm
        OUtUWfHYOwAT2kAEC0lHtnGO8aIpQsX1LeXu1KBN5ExPzd35dPommBeIn41XPgbKi10y5lDc0DARp
        aeCnc9Hw==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOFZo-0005Xi-T4; Tue, 14 Apr 2020 07:01:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove set_fs calls from the exec and coredump code v2
Date:   Tue, 14 Apr 2020 09:01:34 +0200
Message-Id: <20200414070142.288696-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series gets rid of playing with the address limit in the exec and
coredump code.  Most of this was fairly trivial, the biggest changes are
those to the spufs coredump code.

Changes since v1:
 - properly spell NUL
 - properly handle the compat siginfo case in ELF coredumps
