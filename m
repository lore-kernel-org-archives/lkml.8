Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAD4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2792067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="E3FpMLtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgFCUNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:13:51 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:2575
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbgFCUNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:13:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqGtEZUotHwvImq6gQMI3bB586y0d8XYDAoWHH5j9iuGiI4yKNllKbIzDlMJ3wYfANfh9J5ChldxpEs2dkcq7a2TZYGerUhuDEBdDaGdIFOJQBKm4jey3PqQ3tjafiFopkwXHP5YAG51ZupTkb6SehgqCi4z3Awga7YaJC5Tq1ZE5d/OhCQClUq3DsMkNoofcsoSMs3RaBUSnwsrIfisFkQEQlsYEXeJ20KaHG5Dc7Itc1m8/JLYtKcke/tIMtHs+BBGSK/efP/Zxsbdxg4IaWPXA1oEm1sGqqhvZnolKIvxKPL54gbMuvixg0AuIB5QvHcbpZ33jZrARRZ8+Of71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHcRcr+afO3Qs4zkkCgV2ucA9xp7mBMigCKrn5AqN6o=;
 b=O2+zSbkbIjR1CKIHPp0oI/W2sCJl1R8ZP+G9zjtE1hJk+RBuQfpJ+ASOlpOW1DIg+VuWXjsTFI/5kcCbOHfYm3cp+oGvOfPFHzW5rphVqlFTmjMopCbX93DCvi7l2DRkOBCK7oi2wCbGhojsEsoty+YhPWZIDorgOCZp/syKYCEUgSatbGP6pVypHt20HQMj9d1IwNRm7/kzcM9/ChZeMtfu4R4WYLEMZnqpCNCjSdhsJAh98kmoiwNYLcd0Uce0fqSWCG77BhlXHEnpOB2mICQz7Y/goeisaCKuhKdf9N6oxZxxQMIpw48kSOCSV97JberlGYTBYFzZdijJe3gr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHcRcr+afO3Qs4zkkCgV2ucA9xp7mBMigCKrn5AqN6o=;
 b=E3FpMLtUev+f/kmt5loMM0plKCCsHXTI9j1Hex4VL2qlgEggRj0vQIL6apZDlXL7o34oRY0PRkye5kwVSB8FQFzPi2Wp3/qGejrR04BBh1Abe1AQF23sPIDDXx5zfT28uuYfjDhZarNX6DvugQYMXqIu2AdSpmcUdaYeCMU7shA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4461.eurprd05.prod.outlook.com (2603:10a6:803:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 3 Jun
 2020 20:13:46 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 20:13:45 +0000
Date:   Wed, 3 Jun 2020 17:13:37 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dave Airlie <airlied@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [git pull] drm for 5.8-rc1
Message-ID: <20200603201337.GA225528@ziepe.ca>
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR15CA0053.namprd15.prod.outlook.com
 (2603:10b6:208:237::22) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR15CA0053.namprd15.prod.outlook.com (2603:10b6:208:237::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 20:13:45 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jgZlZ-000wuT-6Q; Wed, 03 Jun 2020 17:13:37 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f854f429-4ea0-4ca5-cc45-08d807fa9e55
X-MS-TrafficTypeDiagnostic: VI1PR05MB4461:
X-Microsoft-Antispam-PRVS: <VI1PR05MB44610C9D5D320520E5B5FBFBCF880@VI1PR05MB4461.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7dphUCF79o5P+QCoLjy8doT0f0iiQy1x2gNSgGeD3z0AfJw+uOvlFDJy2dewrV/1+cRlsJhU1aafVmtohsv2+MkiJR/SYwlBR0vmk9sKytRCqQP+aw+qsqNUo6CViq4cY82wGOM92cPz2sxIulNI2Q8rmpbG0/tPJOxIvngG2CjDytB/3k1JfxO3fdampgVxjF8C/MgeWrNG114baeCGh9YsimvPbm+Z6k1Fw3fHyDQYugPq/93dT0oEiYGFjf1PQudYpgp/Tqr1V2oaACVMVKPZbt9s+ET0YxLRiPXWK6dirXb+nlcB2OC6+jt18GkodgCe7GEal8DzSEwvfTN5tVoFJoGrCjwx8zdgsQTD+FsiAHZCMsmYOswH+Pbc43lbkL6zISNElzrscmaoion1e5oRUbnUzcLaxcB5VjM2iGjoBN9gKp5tat6upsyPTaQ9jT+0ljLx1lxRJLv2iZI0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(2906002)(8936002)(316002)(33656002)(426003)(86362001)(8676002)(4326008)(9686003)(26005)(66574014)(186003)(36756003)(9746002)(9786002)(66476007)(110136005)(478600001)(54906003)(83380400001)(1076003)(66556008)(66946007)(966005)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: W3awLMfh4boklwVoIALszg/zdG91lmylg4OehcXuP6cc2zocxUaLNUMpv44KDEe4PxJfFJGgHC+6CSbteicxWG+xWc50eNDNEoeJc0gCerUXslsHxT9cVO9rUWCfobQfKECP2zbgifoXpfstn8Hb9EPYf/wZnydBEaNgUBjyexoG2Up75Eb0NY318pgi46LtmRMKLdaKx53QfWMriFSEiktJGdMndg8DVGnlDD5eCRbw3ZEyHjXLhl4gSEHcZ5yXMGHM0decYH1Wx0xW/IAoCPUc0hQwShWdJjEFhM/HGk/wK6YgnxJ+I8HtuoUZqc15sJDQk65n9hihb1wmnYcKt/gvUxjC35ILhDmZXYBuvrECmamDHuJtScJInRidjgUlZbG1SzUthPH1dbKjokd1ahC8og9atxpIW1JQL0gjqoL15uQF8QYW3ggEgo0jZa/9sLJGZqvLWs+oP6XlUZ6HaEf77z97r015QKmq3WmtujFufdZ7h7MSYajgg3lt5mpz
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f854f429-4ea0-4ca5-cc45-08d807fa9e55
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 20:13:45.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUv08PUESsfMQo9YK2C7zLjPWDkGYJHYLLE9MFM3/ZeLOLOrMt5m0VI4dsjM9WR2e8RcdCBs4mKW3ltjp2K/nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:06:32PM +1000, Dave Airlie wrote:
> Hi Linus,
> 
> This is the main drm pull request for 5.8-rc1.
> 
> Highlights:
> Core DRM had a lot of refactoring around managed drm resources to make
> drivers simpler.
> Intel Tigerlake support is on by default
> amdgpu now support p2p PCI buffer sharing and encrypted GPU memory

Christoph Hellwig basically NAK'd this approach, why is it getting
merged all of a sudden??

https://lore.kernel.org/intel-gfx/20200311152838.GA24280@infradead.org/

Are we now OK with this same approach open coded in a driver?

This wasn't Cc'd to the usual people doing work in this PCI P2P area??

See

commit f44ffd677fb3562ac0a1ff9c8ae52672be741f00
Author: Christian König <christian.koenig@amd.com>
Date:   Fri Mar 23 16:56:37 2018 +0100

    drm/amdgpu: add support for exporting VRAM using DMA-buf v3
    
    We should be able to do this now after checking all the prerequisites.
    
    v2: fix entrie count in the sgt
    v3: manually construct the sg
    
    Signed-off-by: Christian König <christian.koenig@amd.com>
    Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
    Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
    Link: https://patchwork.freedesktop.org/patch/359295

[..]

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 82a3299e53c042..128a667ed8fa0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -22,6 +22,7 @@
  * Authors: Christian König
  */
 
+#include <linux/dma-mapping.h>
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_atomfirmware.h"
@@ -458,6 +459,104 @@ static void amdgpu_vram_mgr_del(struct ttm_mem_type_manager *man,
 	mem->mm_node = NULL;
 }
 
+/**
+ * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
+ *
+ * @adev: amdgpu device pointer
+ * @mem: TTM memory object
+ * @dev: the other device
+ * @dir: dma direction
+ * @sgt: resulting sg table
+ *
+ * Allocate and fill a sg table from a VRAM allocation.
+ */
+int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
+			      struct ttm_mem_reg *mem,
+			      struct device *dev,
+			      enum dma_data_direction dir,
+			      struct sg_table **sgt)
+{
+	struct drm_mm_node *node;
+	struct scatterlist *sg;
+	int num_entries = 0;
+	unsigned int pages;
+	int i, r;
+
+	*sgt = kmalloc(sizeof(*sg), GFP_KERNEL);
+	if (!*sgt)
+		return -ENOMEM;
+
+	for (pages = mem->num_pages, node = mem->mm_node;
+	     pages; pages -= node->size, ++node)
+		++num_entries;
+
+	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
+	if (r)
+		goto error_free;
+
+	for_each_sg((*sgt)->sgl, sg, num_entries, i)
+		sg->length = 0;
+
+	node = mem->mm_node;
+	for_each_sg((*sgt)->sgl, sg, num_entries, i) {
+		phys_addr_t phys = (node->start << PAGE_SHIFT) +
+			adev->gmc.aper_base;
+		size_t size = node->size << PAGE_SHIFT;
+		dma_addr_t addr;
+
+		++node;
+		addr = dma_map_resource(dev, phys, size, dir,
+					DMA_ATTR_SKIP_CPU_SYNC);
+		r = dma_mapping_error(dev, addr);
+		if (r)
+			goto error_unmap;
+
+		sg_set_page(sg, NULL, size, 0);
+		sg_dma_address(sg) = addr;
+		sg_dma_len(sg) = size;
                ^^^^^^^^^^^^^^
  
Jason
