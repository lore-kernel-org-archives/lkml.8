Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B98C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D55206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586952557;
	bh=3+L4fxJLbv98ehgTJOSIpgebtP/UReaKte4GAfHvuh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qYZqdayOBiuRsiKsJ/H7UPe4QROMKtzHb0MA1MlEDhI4C9aSX2grf1G6K86FvNmcv
	 V4I2HVTzjmrleoMjkWnieNnV+qvSkye/WxFsJKuCaPVBFkW8k6zBEo1lWQU9SvwPvo
	 2Wb1ugJ+lHwOgGyPPCVoMXfQV/EDV1WC9hL6jstc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368475AbgDOMJO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409358AbgDOLrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:47:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E4021707;
        Wed, 15 Apr 2020 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951254;
        bh=3+L4fxJLbv98ehgTJOSIpgebtP/UReaKte4GAfHvuh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcIqMIkDWgCvtXP2IZS0jgvXpSKC509Y5XcFuYIDxjbczeySasSQqkSMPjGTrhg66
         LCVban3BpwzPT2+iZBy5X9nWlyMAYlzuteNSb5fS6hTNP/Gm59XMKU4+yiRy3sVhea
         Fue6uFGeFkEV3hnaM93c+0b82SonaMqijyrFC3M0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 19/30] KVM: s390: vsie: Fix possible race when shadowing region 3 tables
Date:   Wed, 15 Apr 2020 07:47:00 -0400
Message-Id: <20200415114711.15381-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114711.15381-1-sashal@kernel.org>
References: <20200415114711.15381-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 1493e0f944f3c319d11e067c185c904d01c17ae5 ]

We have to properly retry again by returning -EINVAL immediately in case
somebody else instantiated the table concurrently. We missed to add the
goto in this function only. The code now matches the other, similar
shadowing functions.

We are overwriting an existing region 2 table entry. All allocated pages
are added to the crst_list to be freed later, so they are not lost
forever. However, when unshadowing the region 2 table, we wouldn't trigger
unshadowing of the original shadowed region 3 table that we replaced. It
would get unshadowed when the original region 3 table is modified. As it's
not connected to the page table hierarchy anymore, it's not going to get
used anymore. However, for a limited time, this page table will stick
around, so it's in some sense a temporary memory leak.

Identified by manual code inspection. I don't think this classifies as
stable material.

Fixes: 998f637cc4b9 ("s390/mm: avoid races on region/segment/page table shadowing")
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20200403153050.20569-4-david@redhat.com
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/gmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index ec9292917d3f2..3efe99f760063 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1683,6 +1683,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 		goto out_free;
 	} else if (*table & _REGION_ENTRY_ORIGIN) {
 		rc = -EAGAIN;		/* Race with shadow */
+		goto out_free;
 	}
 	crst_table_init(s_r3t, _REGION3_ENTRY_EMPTY);
 	/* mark as invalid as long as the parent table is not protected */
-- 
2.20.1

