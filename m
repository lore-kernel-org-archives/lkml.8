Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E36C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F3B2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V738y8eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgHCWn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:43:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42978 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgHCWn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:43:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073MfwF3108620;
        Mon, 3 Aug 2020 22:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=mC2og9jJt01t5P+bwo5sGxOK0bt77D2MZf0z/aMJfeM=;
 b=V738y8eBqzvfGdrNGs9Thele81Ilfcuw+m5JX/PWW1/slf+dmjnJ/q7ofZ4TZ89wViai
 Irc5RR/NFJJKuEh9seRKI580duN9jX/O/CCYlB3K9QcFpRxoTFbcfF21FMJme+Y+oZ9k
 LODXZG9fYe1ZKd6tVLcmZ2/P+kkr4m4Bi9POV2q2nHtwQM7+PjNVaRmCcZMXPhqhhffA
 oSInpemtJfm8n8W6GFyY4rt2NzPPcYNAaDIAz3I14O6p6QRoZVRtgbzln8sCa+RXUJ5Z
 UdEcSAMs6QGxlCOlAW9d0SEMcAYuHoE4CMGXhWv0u9/GdXd6sY4cSgJDc5sUnmDdNL0Z HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32n11n13gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 22:43:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073Mcnpf063231;
        Mon, 3 Aug 2020 22:41:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32pdnp07d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 22:41:51 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 073Mfp8r008317;
        Mon, 3 Aug 2020 22:41:51 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 15:41:50 -0700
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, jmoyer@redhat.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Cc:     jane.chu@oracle.com
Subject: [PATCH v2 2/3] libnvdimm/security: the 'security' attr never show 'overwrite' state
Date:   Mon,  3 Aug 2020 16:41:38 -0600
Message-Id: <1596494499-9852-2-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
References: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=847
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=839 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'security' attribute displays the security state of an nvdimm.
During normal operation, the nvdimm state maybe one of 'disabled',
'unlocked' or 'locked'.  When an admin issues
  # ndctl sanitize-dimm nmem0 --overwrite
the attribute is expected to change to 'overwrite' until the overwrite
operation completes.

But tests on our systems show that 'overwrite' is never shown during
the overwrite operation. i.e.
  # cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/nmem0/security
  unlocked
the attribute remain 'unlocked' through out the operation, consequently
"ndctl wait-overwrite nmem0" command doesn't wait at all.

The driver tracks the state in 'nvdimm->sec.flags': when the operation
starts, it adds an overwrite bit to the flags; and when the operation
completes, it removes the bit. Hence security_show() should check the
'overwrite' bit first, in order to indicate the actual state when multiple
bits are set in the flags.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/nvdimm/dimm_devs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index b7b77e8..5d72026 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -363,14 +363,14 @@ __weak ssize_t security_show(struct device *dev,
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
+	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
+		return sprintf(buf, "overwrite\n");
 	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
 		return sprintf(buf, "disabled\n");
 	if (test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.flags))
 		return sprintf(buf, "unlocked\n");
 	if (test_bit(NVDIMM_SECURITY_LOCKED, &nvdimm->sec.flags))
 		return sprintf(buf, "locked\n");
-	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
-		return sprintf(buf, "overwrite\n");
 	return -ENOTTY;
 }
 
-- 
1.8.3.1

