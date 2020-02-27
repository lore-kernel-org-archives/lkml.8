Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0894C3F370
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AED20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812816;
	bh=BB3EQz5ds2kVFQlWAdweL64uZIpe+5Yq2WWqihSQq/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j1Kc9kv4HLvV7tByZ5BlHXeH1bwL23JqjZGg90cC7nr2kV2fUi+6CiA8LMNvWKoxx
	 AOhqec59j9Gfhakd2IVlBb3cuSZo15Q4VDmEH/8cM+1Uvmzn6g0hgh7u7lIHgakERe
	 RRXsdOuKvcaMHlpUwDlWNXfVaAQOgCZPVQNkEHQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbgB0ONe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:13:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388978AbgB0ONa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:13:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A76020578;
        Thu, 27 Feb 2020 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812809;
        bh=BB3EQz5ds2kVFQlWAdweL64uZIpe+5Yq2WWqihSQq/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18tq+d5y5p/75GtuRSVPoQiPVa/0DJDbYL4wxJZnjRHpljDKT7TmvU2q57vOCmSYX
         mXuNTKGBgBhLNSujeG8+dII1M7g11MSFnB7PF1DN02lv4t+XrfeXwwtSWd5skpGYhb
         YIQP1ds+CsmpgGrNP15JzJQel+s3mJPVATO014nM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerry Snitselaar <jsnitsel@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.5 006/150] iommu/vt-d: Simplify check in identity_mapping()
Date:   Thu, 27 Feb 2020 14:35:43 +0100
Message-Id: <20200227132233.680392585@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

commit 1ddb32da4a629fa7f87873d0b6836c2e1feb7518 upstream.

The function only has one call-site and there it is never called with
dummy or deferred devices. Simplify the check in the function to
account for that.

Fixes: 1ee0186b9a12 ("iommu/vt-d: Refactor find_domain() helper")
Cc: stable@vger.kernel.org # v5.5
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2799,7 +2799,7 @@ static int identity_mapping(struct devic
 	struct device_domain_info *info;
 
 	info = dev->archdata.iommu;
-	if (info && info != DUMMY_DEVICE_DOMAIN_INFO && info != DEFER_DEVICE_DOMAIN_INFO)
+	if (info)
 		return (info->domain == si_domain);
 
 	return 0;


