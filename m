Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC49C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6F220737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585848726;
	bh=/ULy5ar2cTvaQzVZ9mkMZGqqqqrzbfEKuoSL4EMK0vc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XCaag+AkUtFj41wGzNOCHzs1TyDAsWFyK+TTRY4mZ+1Le3BY8M2Et4Q3Z2hL4aMiO
	 dDLWeUQJIXoZPkKyQD69tyxKCE/j0A6yiKe8oNtNCMnS4dH6wFag85wNDTDcUjbz5L
	 hm5c18i4JXpEs7Px0jyE3h+ERocmZhA4ZubMPSWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389791AbgDBRcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388875AbgDBRcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:32:05 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7931720737;
        Thu,  2 Apr 2020 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585848724;
        bh=/ULy5ar2cTvaQzVZ9mkMZGqqqqrzbfEKuoSL4EMK0vc=;
        h=From:To:Cc:Subject:Date:From;
        b=RSdid3gEyiwuqS7t2sRGWaIebCMKJVx2sJubR08i5Ve9tJ4edncBHXzsGGcWq+XlF
         A/hq8V7SkZkyHbquy2rHN2l+CWOKOVfT/wzPmT1UIDWvIPeqoap2+w+pfRO8eARXb5
         Jl2UKkg0pSy+mEp4EBzC6eH2EGHNdSGTZIB057OM=
From:   Will Deacon <will@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, g.nault@alphalink.fr,
        Will Deacon <will@kernel.org>
Subject: [PATCH 0/2] [backports] l2tp use-after-free fixes for 4.9 stable
Date:   Thu,  2 Apr 2020 18:31:56 +0100
Message-Id: <20200402173158.7798-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Syzbot has been complaining about KASAN splats due to use-after-free
issues in the l2tp code on 4.9 Android kernels (although I reproduced
with latest 4.9 stable on my laptop):

https://syzkaller.appspot.com/bug?id=3c27eae7bdba97293b68e79c9700ac110f977eed

These have been fixed upstream, but for some reason didn't get picked up
for stable. This series applies to 4.9.y and I'll send patches for 4.4.y
separately as there are a few dependencies to deal with over there.

Thanks,

Will

--->8

Guillaume Nault (2):
  l2tp: ensure sessions are freed after their PPPOL2TP socket
  l2tp: fix race between l2tp_session_delete() and
    l2tp_tunnel_closeall()

 net/l2tp/l2tp_core.c | 6 ++++++
 net/l2tp/l2tp_core.h | 1 +
 net/l2tp/l2tp_ppp.c  | 8 ++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.26.0.rc2.310.g2932bb562d-goog

