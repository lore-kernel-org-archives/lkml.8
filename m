Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AA5C43635
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 16:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6ABA20702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 16:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgGLQn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 12:43:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:25486 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgGLQny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 12:43:54 -0400
IronPort-SDR: W/uVagDg6QODjyUKwjwOTuYALFu6fdxpVClUmTtGylNqlMopOsBYyDRxqe43EBG9r4UwoT231V
 762eT/2dM5xA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="233371314"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="233371314"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:53 -0700
IronPort-SDR: 6TzdCRE2fzwUtJmRD/9EfCFIElciJvmPqXsWPc0c8rNKEeKxhxcSvMuVYcR8Bq7fJeQlwMajAd
 GEvT4hAHTm6g==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="325264264"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:53 -0700
Subject: [PATCH v2 17/22] drivers/base: Make device_find_child_by_name()
 compatible with sysfs inputs
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        hch@lst.de, joao.m.martins@oracle.com
Date:   Sun, 12 Jul 2020 09:27:37 -0700
Message-ID: <159457125753.754248.6000936585361264069.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysfs_streq() in device_find_child_by_name() to allow it to use a
sysfs input string that might contain a trailing newline.

The other "device by name" interfaces,
{bus,driver,class}_find_device_by_name(), already account for sysfs
strings.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67d39a90b45c..5d31b962c898 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3078,7 +3078,7 @@ struct device *device_find_child_by_name(struct device *parent,
 
 	klist_iter_init(&parent->p->klist_children, &i);
 	while ((child = next_device(&i)))
-		if (!strcmp(dev_name(child), name) && get_device(child))
+		if (sysfs_streq(dev_name(child), name) && get_device(child))
 			break;
 	klist_iter_exit(&i);
 	return child;

