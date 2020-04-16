Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F6C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A077B214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050230;
	bh=auqJTuhnImmvDb6H+sMUIzlvMxOs3HGqAdeRAdKYAU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yzow0o2Rry/ONrxcqTGUlr7UTuHUDUhHpI0roDzU4rbjf8xKuJALZZ5UrezuoEMN+
	 ld1fhwEiLMa/IxRfuQgpH9QwEvN4s3iNCV4LdjOxKKzBwLb+OxekRRtkgpIvlmyZCS
	 f7Q1ntDaSldsJwxA95TviVBk93w8saj1Vlc5cBwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441726AbgDPPRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898810AbgDPNtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:49:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18EB120732;
        Thu, 16 Apr 2020 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044943;
        bh=auqJTuhnImmvDb6H+sMUIzlvMxOs3HGqAdeRAdKYAU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmwCnnChByk15E/xLhyDfiC/99mAvwYknOHsQ/6G8xuDSDsIlbJLmmf6xg2gAlIDA
         E9IBfbyVnyPskJHXmb4FEqGJjWPmYpo8heDaVM5OkvP6Qw6V/BJbaEW0Zq6SoGwRO6
         n26ZUKdXnbc83W6yCXqYS1CXjHIid45ELkwSII+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikos Tsironis <ntsironis@arrikto.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 164/232] dm clone: Add overflow check for number of regions
Date:   Thu, 16 Apr 2020 15:24:18 +0200
Message-Id: <20200416131335.527671917@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikos Tsironis <ntsironis@arrikto.com>

commit cd481c12269b4d276f1a52eda0ebd419079bfe3a upstream.

Add overflow check for clone->nr_regions variable, which holds the
number of regions of the target.

The overflow can occur with sufficiently large devices, if BITS_PER_LONG
== 32. E.g., if the region size is 8 sectors (4K), the overflow would
occur for device sizes > 34359738360 sectors (~16TB).

This could result in multiple device sectors wrongly mapping to the same
region number, due to the truncation from 64 bits to 32 bits, which
would lead to data corruption.

Fixes: 7431b7835f55 ("dm: add clone target")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-clone-target.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -1775,6 +1775,7 @@ error:
 static int clone_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 {
 	int r;
+	sector_t nr_regions;
 	struct clone *clone;
 	struct dm_arg_set as;
 
@@ -1816,7 +1817,16 @@ static int clone_ctr(struct dm_target *t
 		goto out_with_source_dev;
 
 	clone->region_shift = __ffs(clone->region_size);
-	clone->nr_regions = dm_sector_div_up(ti->len, clone->region_size);
+	nr_regions = dm_sector_div_up(ti->len, clone->region_size);
+
+	/* Check for overflow */
+	if (nr_regions != (unsigned long)nr_regions) {
+		ti->error = "Too many regions. Consider increasing the region size";
+		r = -EOVERFLOW;
+		goto out_with_source_dev;
+	}
+
+	clone->nr_regions = nr_regions;
 
 	r = validate_nr_regions(clone->nr_regions, &ti->error);
 	if (r)


