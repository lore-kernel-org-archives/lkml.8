Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A92C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71223206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t9i98UIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEFEXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 00:23:02 -0400
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:6116
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgEFEXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 00:23:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrTBdxhEcgk9jhmk3shrJD2s0V4W+5fEOgjjEVWi0YrL4Vto5+7RfsBy/22Zihwg8Com2GpdNy4pIc748kRN+KHE0tI7Xhkys2e0zik8uK9MnyETCIbRnV1pgAbCV/AvPg5f1CW4ysQrSiwRoiRAskXhrcYDdEiWp3vRqH4c+smFuxiL8FSP0YkJ1sPZsxhxbyP7wQmFUorSUYheEM43K25fSAt+JRjwPvtMeHtC4ZJVhHamR/Iz2BDu8W0pogYyH00UMg7Qex/VBnkPdv5UN6BJqImsN15miOXY++IKH5k/xPU8cdUrhKCs+eriYuOiB33ElAit614+73iKC8heQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n00zdWDFWbDv/3iaLNdZKLLmsOS+DWJVWgvHoNcbMk=;
 b=W0IGNVXaIIeuMPnfNBNAk9HYPLRahy+g+thF7LcNUf9wCfo09MaEdfEsqfUUfagkebE9SQBVyFEktuV7VSJ8zw8Z9BLOOobf/axONc91PIl74Sz+hC9orjStT0d15ygWG0kiTm3RvdImAslSfAKRqooQt1RoCSNjxSRf88e50OpOOAekU5FWUdDBJEOn0fd04zt7mk6kdDFzwCN3gj3Q8Y2DPdgukQDE7PMSGtG4UJiON+04Fb1f3I6uh/rh13My0JAT68X8CkblVIvXi6uD7tvfQbfSQRfZHlohz9RwPixOO/hXfL5b1kXo0fC8Q0DlAR+PlfI5uuHvQWTEaY2WAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n00zdWDFWbDv/3iaLNdZKLLmsOS+DWJVWgvHoNcbMk=;
 b=t9i98UIZTYrsmn0+2GxKDtx0tDFf36kE1102zkBOKCwErPz+MqeH0H9Qzere/9H4op14j9TD5umSwTRY2JM7xgRhz2wYIWUnjl1XTJb5JcUAyBjdQuUcMvpo+dHFAkC5+Ng2WF0Hd1seqTIu7cTyv1XLkG16kIxrcv4vrjfWyaQ=
Authentication-Results: kudzu.us; dkim=none (message not signed)
 header.d=none;kudzu.us; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28; Wed, 6 May 2020 04:22:59 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0%6]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 04:22:59 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v3 5/5] ntb_perf: avoid false dma unmap of destination address
Date:   Tue,  5 May 2020 23:21:52 -0500
Message-Id: <1588738912-24827-6-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
References: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::21) To DM6PR12MB3420.namprd12.prod.outlook.com
 (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 04:22:56 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc385fb0-cefc-46ef-76f6-08d7f17528d3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4092:|DM6PR12MB4092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4092AD5754DBAD0F49A72853E5A40@DM6PR12MB4092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwyqhVv19j54pC/wpzHNj5c/k48YVWjQ5QRJcXZ/ZNkRlUnBcNPckmMWk8f/tC9OsiGWtNiKCjew52xCBfkPbVyM3cjGcDpHplALc3Qan88A+aqWmqmGxDXhZL4TTKSY2v+f45MxUakz7b+NAl431Jqju6VGUW0cfxP3w1UIJASDJ8ow7RXb+L8M8YBJuvA8e6OURJqLrqURe6IqghwfFvt8pr+62bX2RPPBGcOCaXWrhJBoC6qN6BLCpT9UDPvJssYSyMXIMSjmiQTb4tAwW0SZvYt5swdp5eNdXt1Yi5N739r63sWbuyj1ixo1OT2DoalayjlfDXMwM6kxtdvoJYkEFjUoyCqihrJp4ACfpL5k234vht7VOCbFRceok0W1n2Dsp3lmiZkbBAxKkvgr4OASxhUwWtf0IWOqdJl8LR36vLKSkvkgPyYOPcbnOC/ME5M10BQgatvdjV6kkQN5hIpfjxNyNCVHT6Is0t4dXL8S2945Goi8+lrxro40/IprrspzV2XsMQYYBVMZmdoo2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(33430700001)(4326008)(33440700001)(956004)(2616005)(478600001)(5660300002)(2906002)(8936002)(36756003)(316002)(6636002)(66556008)(66476007)(6486002)(7696005)(66946007)(52116002)(26005)(8676002)(86362001)(6666004)(16526019)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UyTYFEcgM7h3/E3QwKJXnlJrxW0O4h3QPdkB5itxNj4dmMgxqguOGNvzBVDe9v7NO8D9PCdRQ1EA+vBvGIr4YuuFYmxC4LkvE8oLsROPrYp3och31iyO+sSDXbIyC7Z8RE9j7kIsJ/6zjc7Gj9QACrtXCGEspgJ2jf88Vs9DRzEtcBXtloyV4o7r0nUXv1zxybfv01cC7WvvNV9sfjeHh+upnhp/memKX/a6zAPgAf2sdOEO/myJebxhzbGlRmjVlI03Bil4gaV7hbdvn/GbDpIyjO6bQWnjDn6b41X6p42Ol8hPGbEpw2r42qEjBhzPiaMKy0GnhnPwYpLj71jepsdmCtqBYsGi5GTh2a16y0K/XV0IMF3cY+EfstE8JKt7/ZZ2/3n6/fltiYjACixkxlQbS49ESbB4JLOA7D3dXSmrmb60FKMEl52kxehK21rL2PdCXrmEeDkRpffWVYkiJCHXQ9rjFAA6abbA05WFpEkR49KMLpaaL8XBM4pGhNrMwGXCX2ifV+nA3VlvO9UlqbWI5KIjgU/ioTvjRTi/ajgXUnxeKDUgd7a5ab2ZmDa2C6I9wlukD1Zfnk9dz+lOi7AFHdpZrQ4t5cje7zjATta6Cra81hF34hvr2KjJtkvcNZgr46x15IltOoz72QJ6ZkbQxqJ/d3ddLIWtsS0khyydC9SMt1RudJ92bu/3+Aakqp5HdykNRVM214gp2x5HmTmcDSDfAwpGAa48oh8psHQoA41NfTe5KMVm+zzlK68y5iWIjVgYGGg5rIA00se7Y3ZL2V4o5UvI3jje8e5QIYQUn9+4LDOKqUXuBaIFDTVb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc385fb0-cefc-46ef-76f6-08d7f17528d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 04:22:59.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1GbMMbePl/ste9PTewMqCBf2OzrwX8F9SlE5KsnsX4KnSMYoYWhKRB4N8ua4gq9IsIOStIRgTOUpErb9pcgUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA map and unmap of destination address is already being
done in perf_init_test() and perf_clear_test() functions.
Hence avoiding it by making necessary changes in perf_copy_chunk()
function.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index dbcfdaa..95a0853 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -804,7 +804,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	dst_vaddr = dst;
 	dst_dma_addr = peer->dma_dst_addr + (dst_vaddr - vbase);
 
-	unmap = dmaengine_get_unmap_data(dma_dev, 2, GFP_NOWAIT);
+	unmap = dmaengine_get_unmap_data(dma_dev, 1, GFP_NOWAIT);
 	if (!unmap)
 		return -ENOMEM;
 
@@ -817,15 +817,8 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	}
 	unmap->to_cnt = 1;
 
-	unmap->addr[1] = dst_dma_addr;
-	if (dma_mapping_error(dma_dev, unmap->addr[1])) {
-		ret = -EIO;
-		goto err_free_resource;
-	}
-	unmap->from_cnt = 1;
-
 	do {
-		tx = dmaengine_prep_dma_memcpy(pthr->dma_chan, unmap->addr[1],
+		tx = dmaengine_prep_dma_memcpy(pthr->dma_chan, dst_dma_addr,
 			unmap->addr[0], len, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!tx)
 			msleep(DMA_MDELAY);
-- 
2.7.4

