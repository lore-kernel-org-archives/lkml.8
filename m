Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ABCC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E8F2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339996;
	bh=hyCUUI8joFIvHEQJsxnmkQakhTurpsrLw3aw+EtS1Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RVjOtUGYbLiBMMVSmQeyL1hah4fARznKjl1yPqAOTMvIwQqZpW4IzSs5XuZVkX/Bx
	 4WjCAsYOj19YZci/oUL1dA+Lg93gEPTrIPitd6XmGZ8KiYxCGm9yk/OihOCMSTAVpK
	 HKud2up6HoH7KbkQykoJeknuf+DhEMQem4w9tXfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbgBJNGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:06:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbgBJMjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:53 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D8B2467D;
        Mon, 10 Feb 2020 12:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338393;
        bh=hyCUUI8joFIvHEQJsxnmkQakhTurpsrLw3aw+EtS1Ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6Fn7kPD+UnOyVZRvh3qXiDkdznx+b1SwvsVQy3WbiDP7C8NRd6J5GYn4SsVpk0V/
         ZkNmzlIOfKIEDTI4nc2BNLPq1Vj9GkKXCej8lcMFO1p5BLjehKpN4mrvtp8kEFP8ms
         D2/Ja3d+qxzXoBXz1D6/CEKxtD7yId4IPaCs9DJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.5 086/367] powerpc/pseries: Advance pfn if section is not present in lmb_is_removable()
Date:   Mon, 10 Feb 2020 04:29:59 -0800
Message-Id: <20200210122432.297488666@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pingfan Liu <kernelfans@gmail.com>

commit fbee6ba2dca30d302efe6bddb3a886f5e964a257 upstream.

In lmb_is_removable(), if a section is not present, it should continue
to test the rest of the sections in the block. But the current code
fails to do so.

Fixes: 51925fb3c5c9 ("powerpc/pseries: Implement memory hotplug remove in the kernel")
Cc: stable@vger.kernel.org # v4.1+
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1578632042-12415-1-git-send-email-kernelfans@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/hotplug-memory.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -360,8 +360,10 @@ static bool lmb_is_removable(struct drme
 
 	for (i = 0; i < scns_per_block; i++) {
 		pfn = PFN_DOWN(phys_addr);
-		if (!pfn_present(pfn))
+		if (!pfn_present(pfn)) {
+			phys_addr += MIN_MEMORY_BLOCK_SIZE;
 			continue;
+		}
 
 		rc = rc && is_mem_section_removable(pfn, PAGES_PER_SECTION);
 		phys_addr += MIN_MEMORY_BLOCK_SIZE;


