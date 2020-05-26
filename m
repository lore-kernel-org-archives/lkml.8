Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08E5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF34207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GMeZ+WNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgEZE27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 00:28:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43364 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgEZE27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 00:28:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04Q4STAA134806;
        Tue, 26 May 2020 04:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=LEC5BMJyMpqnL+4zEPOD2chl5tT/X4c/Dejm+NTrDL8=;
 b=GMeZ+WNp82wO+CvShHc2K3V1Shdhsy/qipiI+rqTixdRx76kP4ptR2IH/fvfLZLG/kgG
 GJRQ4uRiw8Hxr5moU0mXC0D5TqsFty5HuvVyKN87UjA8bdlBmQMaBNBbQRDWMurpvX8V
 7kK0xJAlW7b1oW/jnp4lHwa7VhRWqWU6oS6ZZOGsKcURhYxjII64QeUh2LzeHDYs9ikn
 ToQdZt2kNOElJg8wkKd1JnhjaEuLJwoInAFEtPT0n+WYrS4jrnqWdRSrIiSYoTt1uQ3/
 /EmPpVOtPPuCMCMouDBJsjMcb4YoYEgY7NO6ixMSM4g4m7i8zvz/SdCBRBvx0ZSPxlz5 OA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 316uskqe7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 04:28:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04Q4IvpM145515;
        Tue, 26 May 2020 04:28:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 317ddn7g5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 04:28:28 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04Q4SOrw008176;
        Tue, 26 May 2020 04:28:26 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 May 2020 21:28:24 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-nvme@lists.infradead.org
Cc:     james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] nvme-fcloop: verify wwnn and wwpn format
Date:   Mon, 25 May 2020 21:21:18 -0700
Message-Id: <20200526042118.17836-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9632 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=3 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9632 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 lowpriorityscore=0
 suspectscore=3 spamscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 cotscore=-2147483648 adultscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvme host and target verify the wwnn and wwpn format via
nvme_fc_parse_traddr(). For instance, it is required that the length of
wwnn to be either 21 ("nn-0x") or 19 (nn-).

Add this verification to nvme-fcloop so that the input should always be in
hex and the length of input should always be 18.

Otherwise, the user may use e.g. 0x2 to create fcloop local port, while
0x0000000000000002 is required for nvme host and target. This makes the
requirement of format confusing.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/nvme/target/fcloop.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index f69ce66e2d44..14124e6d4bf2 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -43,6 +43,17 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_ERR,		NULL		}
 };
 
+static int fcloop_verify_addr(substring_t *s)
+{
+	size_t blen = s->to - s->from + 1;
+
+	if (strnlen(s->from, blen) != NVME_FC_TRADDR_HEXNAMELEN + 2 ||
+	    strncmp(s->from, "0x", 2))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int
 fcloop_parse_options(struct fcloop_ctrl_options *opts,
 		const char *buf)
@@ -64,14 +75,16 @@ fcloop_parse_options(struct fcloop_ctrl_options *opts,
 		opts->mask |= token;
 		switch (token) {
 		case NVMF_OPT_WWNN:
-			if (match_u64(args, &token64)) {
+			if (fcloop_verify_addr(args) ||
+			    match_u64(args, &token64)) {
 				ret = -EINVAL;
 				goto out_free_options;
 			}
 			opts->wwnn = token64;
 			break;
 		case NVMF_OPT_WWPN:
-			if (match_u64(args, &token64)) {
+			if (fcloop_verify_addr(args) ||
+			    match_u64(args, &token64)) {
 				ret = -EINVAL;
 				goto out_free_options;
 			}
@@ -92,14 +105,16 @@ fcloop_parse_options(struct fcloop_ctrl_options *opts,
 			opts->fcaddr = token;
 			break;
 		case NVMF_OPT_LPWWNN:
-			if (match_u64(args, &token64)) {
+			if (fcloop_verify_addr(args) ||
+			    match_u64(args, &token64)) {
 				ret = -EINVAL;
 				goto out_free_options;
 			}
 			opts->lpwwnn = token64;
 			break;
 		case NVMF_OPT_LPWWPN:
-			if (match_u64(args, &token64)) {
+			if (fcloop_verify_addr(args) ||
+			    match_u64(args, &token64)) {
 				ret = -EINVAL;
 				goto out_free_options;
 			}
@@ -141,14 +156,16 @@ fcloop_parse_nm_options(struct device *dev, u64 *nname, u64 *pname,
 		token = match_token(p, opt_tokens, args);
 		switch (token) {
 		case NVMF_OPT_WWNN:
-			if (match_u64(args, &token64)) {
+			if (fcloop_verify_addr(args) ||
+			    match_u64(args, &token64)) {
 				ret = -EINVAL;
 				goto out_free_options;
 			}
 			*nname = token64;
 			break;
 		case NVMF_OPT_WWPN:
-			if (match_u64(args, &token64)) {
+			if (fcloop_verify_addr(args) ||
+			    match_u64(args, &token64)) {
 				ret = -EINVAL;
 				goto out_free_options;
 			}
-- 
2.17.1

